<%
	Class EncodeDecodeCls

		private sBASE_64_CHARACTER
		private sBASE_64_CHARACTERSansi

		'/////////////////////////////////////////////////////////////////////////////////////////////////
		'/// 이 부분부터는 쿠키 암호화를 위한 부분입니다.
		'/////////////////////////////////////////////////////////////////////////////////////////////////
		private BASE_64_MAP_INIT_FOR_COOKIE
		private nl
		' zero based arrays
		private Base64EncMap(63)
		private Base64DecMap(127)

		private encodingData

		private sub Class_Initialize()
			'클래스 초기화 시 해야할 작업

			'private sBASE_64_CHARACTERS, sBASE_64_CHARACTERSansi
			sBASE_64_CHARACTERS  = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
			sBASE_64_CHARACTERSansi	   = strUnicode2Ansi(sBASE_64_CHARACTERS)

			BASE_64_MAP_INIT_FOR_COOKIE = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

		End Sub





		'/////////////////////////////////////////////////
		'/// 암복호화를 위한 키 설정
		'/////////////////////////////////////////////////
		Function setEncodingData( ByVal data )

			encodingData = data

		end Function

		'/////////////////////////////////////////////////
		'/// must be called before using anything else
		'/// 다른 작업이전에 먼저 호출해야하는 함수입니다.
		'/////////////////////////////////////////////////
		SUB initCodecs()

			' init vars
			nl = "<P>" & chr(13) & chr(10)
			' setup base 64
			dim max, idx
			max = len(BASE_64_MAP_INIT_FOR_COOKIE)

			for idx = 0 to max - 1
				' one based string
				Base64EncMap(idx) = mid(BASE_64_MAP_INIT_FOR_COOKIE, idx + 1, 1)
			next
			for idx = 0 to max - 1
				Base64DecMap(ASC(Base64EncMap(idx))) = idx
			next

		END SUB


		'/////////////////////////////////////////////////
		'/// encode base 64 encoded string
		'/// Base64로 인코딩하는 함수입니다.
		'/////////////////////////////////////////////////
		FUNCTION CookieBase64Encoder(plain)

			if len(plain) = 0 then
				CookieBase64Encoder = ""
				exit function
			end if

			dim ret, ndx, by3, first, second, third
			by3 = (len(plain) \ 3) * 3
			ndx = 1
			do while ndx <= by3
				first  = asc(mid(plain, ndx+0, 1))
				second = asc(mid(plain, ndx+1, 1))
				third  = asc(mid(plain, ndx+2, 1))
				ret = ret & Base64EncMap(  (first \ 4) AND 63 )
				ret = ret & Base64EncMap( ((first * 16) AND 48) + ((second \ 16) AND 15 ) )
				ret = ret & Base64EncMap( ((second * 4) AND 60) + ((third \ 64) AND 3 ) )
				ret = ret & Base64EncMap( third AND 63)
				ndx = ndx + 3
			loop
			' check for stragglers
			if by3 < len(plain) then
				first  = asc(mid(plain, ndx+0, 1))
				ret = ret & Base64EncMap(  (first \ 4) AND 63 )
				if (len(plain) MOD 3 ) = 2 then
					second = asc(mid(plain, ndx+1, 1))
					ret = ret & Base64EncMap( ((first * 16) AND 48) + ((second \ 16) AND 15 ) )
					ret = ret & Base64EncMap( ((second * 4) AND 60) )
				else
					ret = ret & Base64EncMap( (first * 16) AND 48)
					ret = ret & "="
				end if
				ret = ret & "="
			end if

			CookieBase64Encoder = ret
		END FUNCTION

		'/////////////////////////////////////////////////
		'/// decode base 64 encoded string
		'/// Base64로 디코딩하는 함수 입니다.
		'/////////////////////////////////////////////////
		FUNCTION CookieBase64Decoder(scrambled)

		  if len(scrambled) = 0 then
		              CookieBase64Decoder = ""
		              exit function
		  end if

		  ' ignore padding
		  dim realLen
		  realLen = len(scrambled)
		  do while mid(scrambled, realLen, 1) = "="
		              realLen = realLen - 1
		  loop
		  dim ret, ndx, by4, first, second, third, fourth
		  ret = ""
		  by4 = (realLen \ 4) * 4
		  ndx = 1
		  do while ndx <= by4
			  first  = Base64DecMap(asc(mid(scrambled, ndx+0, 1)))
			  second = Base64DecMap(asc(mid(scrambled, ndx+1, 1)))
			  third  = Base64DecMap(asc(mid(scrambled, ndx+2, 1)))
			  fourth = Base64DecMap(asc(mid(scrambled, ndx+3, 1)))
			  ret = ret & chr( ((first * 4) AND 255) +  ((second \ 16) AND 3))
			  ret = ret & chr( ((second * 16) AND 255) + ((third \ 4) AND 15) )
			  ret = ret & chr( ((third * 64) AND 255) +  (fourth AND 63) )
			  ndx = ndx + 4
		  loop
		  ' check for stragglers, will be 2 or 3 characters
		  if ndx < realLen then

				first  = Base64DecMap(asc(mid(scrambled, ndx+0, 1)))
				second = Base64DecMap(asc(mid(scrambled, ndx+1, 1)))
				ret = ret & chr( ((first * 4) AND 255) +  ((second \ 16) AND 3))

				if realLen MOD 4 = 3 then
					third = Base64DecMap(asc(mid(scrambled,ndx+2,1)))
					ret = ret & chr( ((second * 16) AND 255) + ((third \ 4) AND 15) )
				end if

		  end if

		  CookieBase64Decoder = ret

		END FUNCTION

		Function CookieEncoding(strTxt)

				call initCodecs

				Dim dtRtnDocs
				Dim strID, strKeyWord, strRtnWord, strPos, intI

				'dtRtnDocs = osecMain.getEncodingData()

				If IsArray(encodingData) Then
					strKeyWord = encodingData(1, 0)
					strPos = encodingData(2, 0)
				Else
					strKeyWord = "makefalutsmakefalutsmakefalutsmakefalutsmakefaluts"
					strPos = 1
				End If

				If strPos = "1" Then
					'1일때는 키워드 먼저
					For intI = 0 To Len(strTxt) - 1
						strRtnWord = strRtnWord + Mid(strKeyWord, intI + 1, 1)
						strRtnWord = strRtnWord + Mid(strTxt, intI + 1, 1)
					Next
				Else
					'2일때는 넘어온 단어 먼저
					For intI = 0 To Len(strTxt) - 1
						strRtnWord = strRtnWord + Mid(strTxt, intI + 1, 1)
						strRtnWord = strRtnWord + Mid(strKeyWord, intI + 1, 1)

						'Response.Write("step=" & strRtnWord & "<br>")
					Next
				End If

				'Response.Write("step=" & strRtnWord & "<br>")

				strRtnWord = CookieBase64Encoder(strRtnWord)

				CookieEncoding = strRtnWord

		End Function

		Function CookieDecoding(strTxt)

				call initCodecs

				Dim dtRtnDocs
				Dim strKeyWord, strPos, strRtnWord, intI, strTmpWord

				'dtRtnDocs = osecMain.getEncodingData()

				If IsArray(encodingData) Then

					strKeyWord = encodingData(1, 0)
					strPos = encodingData(2, 0)

					strTmpWord = CookieBase64Decoder(strTxt)

					'Response.Write("step=" & strTmpWord & "<br>")

					If strPos = "1" Then
						For intI = 0 To Len(strTmpWord) - 1
							if intI Mod 2 = 1 Then
								strRtnWord = strRtnWord + Mid(strTmpWord, intI + 1, 1)
							End If
						Next
					Else
						For intI = 0 To Len(strTmpWord) - 1
							if intI Mod 2 = 0 Then
								strRtnWord = strRtnWord + Mid(strTmpWord, intI + 1, 1)
							End If
						Next
					End If

				Else

					strRtnWord = ""

				End If

				CookieDecoding = strRtnWord

		End Function
		'/////////////////////////////////////////////////////////////////////////////////////////////////
		'/// 이 부분까지는 쿠키 암호화를 위한 부분입니다.
		'/////////////////////////////////////////////////////////////////////////////////////////////////


		Function strUnicodeLen(asContents)
			Dim asContents1	   : asContents1 ="a"	   & asContents
			Dim Len1	   	   : Len1=Len(asContents1)
			Dim K	   	   : K=0
			Dim I, Asc1

			For I=1 To Len1
				Asc1	   = asc(mid(asContents1,I,1))
				IF Asc1 < 0 Then Asc1	   = 65536 + Asc1
				IF Asc1 > 255 Then
					K	   = K + 2
				ELSE
					K	   = K + 1
					End IF
			Next

			   strUnicodeLen = K - 1
		End Function

		Function strUnicode2Ansi(asContents)
			   Dim Len1	   	   	   : Len1 = Len(asContents)
			   Dim I, VarCHAR, VarASC, VarHEX, VarLOW, VarHIGH

			   strUnicode2Ansi	   = ""

			   For I = 1 to Len1
			   	   VarCHAR	   = Mid(asContents,I,1)
			   	   VarASC	   = Asc(VarCHAR)
			   	   IF VarASC < 0 Then VarASC = VarASC + 65536
			   	   IF VarASC > 255 Then
			   	   	   VarHEX	   	   = Hex(VarASC)
			   	   	   VarLOW	   	   = Left(VarHEX,2)
			   	   	   VarHIGH	   	   = Right(VarHEX,2)
			   	   	   strUnicode2Ansi	   = strUnicode2Ansi & ChrB("&H" & VarLOW ) & ChrB("&H" & VarHIGH )
			   	   Else
			   	   	   strUnicode2Ansi	   = strUnicode2Ansi & ChrB(VarASC)
			   	   End IF
			   Next
		End Function



		Function strAnsi2Unicode(asContents)
			   Dim Len1	   	   	   : Len1	   	   = LenB(asContents)
			   Dim VarCHAR, VarASC, I

			   strAnsi2Unicode	   = ""

			   IF Len1=0 Then	   Exit Function

			   For I=1 To Len1
			   	   VarCHAR	   = MidB(asContents,I,1)
			   	   VarASC	   = AscB(VarCHAR)
			   	   IF VarASC > 127 Then
			   	   	   strAnsi2Unicode	   = strAnsi2Unicode & Chr(AscW(MidB(asContents, I+1,1) & VarCHAR))
			   	   	   I	   	   = I + 1
			   	   Else
			   	   	   strAnsi2Unicode	   = strAnsi2Unicode & Chr(VarASC)
			   	   End IF
			   Next

		End function

		Function Base64encode(asContents)
			   Dim lnPosition
			   Dim lsResult
			   Dim Char1
			   Dim Char2
			   Dim Char3
			   Dim Char4
			   Dim Byte1
			   Dim Byte2
			   Dim Byte3
			   Dim SaveBits1
			   Dim SaveBits2
			   Dim lsGroupBinary
			   Dim lsGroup64
			   Dim M3, M4, Len1, Len2

			   Len1	   	   	   =LenB(asContents)

			   IF Len1 < 1 Then
			   	   Base64encode	   = ""
			   	   Exit Function
			   End IF

			   M3=Len1 Mod 3

			   IF M3 > 0 Then asContents = asContents & String(3 - M3, ChrB(0))

			   IF m3 > 0 Then
			   	   Len1	   = Len1 + (3 - M3)
			   	   Len2	   = Len1 - 3
			   Else
			   	   Len2	   = Len1
			   End IF

			   lsResult	   = ""

			   For lnPosition = 1 To Len2 Step 3
			   	   lsGroup64	   = ""
			   	   lsGroupBinary	   = MidB(asContents, lnPosition, 3)

			   	   Byte1	   	   = AscB(MidB(lsGroupBinary, 1, 1))	   : SaveBits1	   = Byte1 And 3
			   	   Byte2	   	   = AscB(MidB(lsGroupBinary, 2, 1))	   : SaveBits2	   = Byte2 And 15
			   	   Byte3	   	   = AscB(MidB(lsGroupBinary, 3, 1))

			   	   Char1	   	   = MidB(sBASE_64_CHARACTERSansi, ((Byte1 And 252) \ 4) + 1, 1)
			   	   Char2	   	   = MidB(sBASE_64_CHARACTERSansi, (((Byte2 And 240) \ 16) Or (SaveBits1 * 16) And &HFF) + 1, 1)
			   	   Char3	   	   = MidB(sBASE_64_CHARACTERSansi, (((Byte3 And 192) \ 64) Or (SaveBits2 * 4) And &HFF) + 1, 1)
			   	   Char4	   	   = MidB(sBASE_64_CHARACTERSansi, (Byte3 And 63) + 1, 1)
				   lsGroup64	   = Char1 & Char2 & Char3 & Char4

			   	   lsResult	   	   = lsResult & lsGroup64
			   Next

			   IF M3 > 0 Then
			   	   lsGroup64	   = ""
			   	   lsGroupBinary	   = MidB(asContents, Len2 + 1, 3)

			   	   Byte1	   	   = AscB(MidB(lsGroupBinary, 1, 1))	   : SaveBits1	   = Byte1 And 3
			   	   Byte2	   	   = AscB(MidB(lsGroupBinary, 2, 1))	   : SaveBits2	   = Byte2 And 15
			   	   Byte3	   	   = AscB(MidB(lsGroupBinary, 3, 1))

			   	   Char1	   	   = MidB(sBASE_64_CHARACTERSansi, ((Byte1 And 252) \ 4) + 1, 1)
			   	   Char2	   	   = MidB(sBASE_64_CHARACTERSansi, (((Byte2 And 240) \ 16) Or (SaveBits1 * 16) And &HFF) + 1, 1)
			   	   Char3	   	   = MidB(sBASE_64_CHARACTERSansi, (((Byte3 And 192) \ 64) Or (SaveBits2 * 4) And &HFF) + 1, 1)

			   	   IF M3=1 Then
			   	   	   lsGroup64	   = Char1 & Char2 & ChrB(61) & ChrB(61)
			   	   Else
			   	   	   lsGroup64	   = Char1 & Char2 & Char3 & ChrB(61)
			   	   End IF

			   	   lsResult	   	   = lsResult & lsGroup64
			   End IF

			   Base64encode = lsResult
		End Function

		Function Base64decode(asContents)
			   Dim lsResult
			   Dim lnPosition
			   Dim lsGroup64, lsGroupBinary
			   Dim Char1, Char2, Char3, Char4
			   Dim Byte1, Byte2, Byte3
			   Dim M4, Len1, Len2

			   Len1	   = LenB(asContents)
			   M4	   = Len1 Mod 4

			   IF Len1 < 1 Or M4 > 0 Then
			   	   Base64decode = ""
			   	   Exit Function
			   End IF

			   IF MidB(asContents, Len1, 1) = ChrB(61) Then	   M4 = 3
			   IF MidB(asContents, Len1-1, 1) = ChrB(61) Then	   M4 = 2

			   IF M4 = 0 Then
			   	   Len2	   = Len1
			   Else
			   	   Len2	   = Len1 - 4
			   End IF

			   For lnPosition = 1 To Len2 Step 4
			   	   lsGroupBinary	   = ""
			   	   lsGroup64	   = MidB(asContents, lnPosition, 4)

			   	   Char1	   	   = InStrB(sBASE_64_CHARACTERSansi, MidB(lsGroup64, 1, 1)) - 1
			   	   Char2	   	   = InStrB(sBASE_64_CHARACTERSansi, MidB(lsGroup64, 2, 1)) - 1
			   	   Char3	   	   = InStrB(sBASE_64_CHARACTERSansi, MidB(lsGroup64, 3, 1)) - 1
			   	   Char4	   	   = InStrB(sBASE_64_CHARACTERSansi, MidB(lsGroup64, 4, 1)) - 1

			   	   Byte1	   	   = ChrB(((Char2 And 48) \ 16) Or (Char1 * 4) And &HFF)
			   	   Byte2	   	   = lsGroupBinary & ChrB(((Char3 And 60) \ 4) Or (Char2 * 16) And &HFF)
			   	   Byte3	   	   = ChrB((((Char3 And 3) * 64) And &HFF) Or (Char4 And 63))
			   	   lsGroupBinary	   = Byte1 & Byte2 & Byte3

			   	   lsResult	   	   = lsResult & lsGroupBinary
			   Next

			   IF M4 > 0 Then
			   	   lsGroupBinary	   = ""
			   	   lsGroup64	   = MidB(asContents, Len2 + 1, M4) & ChrB(65)
			   	   IF M4=2 Then
			   	   	   lsGroup64	   = lsGroup64 & chrB(65)
			   	   End IF
			   	   Char1	   = InStrB(sBASE_64_CHARACTERSansi, MidB(lsGroup64, 1, 1)) - 1
			   	   Char2	   = InStrB(sBASE_64_CHARACTERSansi, MidB(lsGroup64, 2, 1)) - 1
			   	   Char3	   = InStrB(sBASE_64_CHARACTERSansi, MidB(lsGroup64, 3, 1)) - 1
			   	   Char4	   = InStrB(sBASE_64_CHARACTERSansi, MidB(lsGroup64, 4, 1)) - 1

			   	   Byte1	   = ChrB(((Char2 And 48) \ 16) Or (Char1 * 4) And &HFF)
			   	   Byte2	   = lsGroupBinary & ChrB(((Char3 And 60) \ 4) Or (Char2 * 16) And &HFF)
			   	   Byte3	   = ChrB((((Char3 And 3) * 64) And &HFF) Or (Char4 And 63))

			   	   IF M4=2 Then
			   	   	   lsGroupBinary	   = Byte1
			   	   elseIF M4=3 Then
			   	   	   lsGroupBinary	   = Byte1 & Byte2
			   	   end IF

			   	   lsResult	   	   	   = lsResult & lsGroupBinary
			   End IF

			   Base64decode	   	   	   = lsResult
		End Function

	End Class
%>
