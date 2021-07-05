<%
	'Application("CASTLE_ASP_VERSION_BASE_DIR")="/lib/castle"
	'Server.Execute(Application("CASTLE_ASP_VERSION_BASE_DIR") &"/castle_referee.asp")
%>
<!-- #include virtual="/2017/lib/cls/DBHelper.asp" -->
<!-- #include virtual="/2017/lib/cls/LibCls.asp" -->
<!-- #include virtual="/2017/lib/cls/EncodeDecodeCls.asp" -->
<%
	'변수 선언
	Dim clsLib

	'전달값 받기

	'객체 생성
	Set clsLib = new LibCls
%>
<%
	'기본 폴더위치
	Dim strDefaultDir
	strDefaultDir = "/2017"

	'사이트 URL
	Dim sURL
	sURL =  "https://" & Request.ServerVariables("HTTP_HOST")
	'관리자 기본 위치
	Dim strAdminDir
	strAdminDir = strDefaultDir & "/99_admin"

	'관리자 기본 타이틀
	Dim strAdminTitle
	'strAdminTitle = "KB국민카드 Wish Together 관리자"

	'파일 업로드 기본 경로
	Dim fileUploadDir

	fileUploadDir = strDefaultDir & "/upload"

	'메세지 보이고 history.back()
	Sub showMsg(ByVal strMsg)

		Response.Write "<script>"
		Response.Write "alert('" & strMsg & "');"
		Response.Write "history.back();"
		Response.Write "</script>"

	End Sub

	'메시지 보이고 특정 url로 이동
	Sub showMsgGoUrl(ByVal strMsg, ByVal strGoUrl)

		Response.Write "<script>"
		Response.Write "alert('" & strMsg & "');"
		Response.Write "location.href='" & strGoUrl & "';"
		Response.Write "</script>"

	End Sub

	'메시지 보이고 특정 함수 호출 이동
	Sub showMsgCallFunc(ByVal strMsg, ByVal strFunc)

		Response.Write "<script>"
		Response.Write "alert('" & strMsg & "');"
		Response.Write strFunc & ";"
		Response.Write "</script>"

	End Sub

	'특정 url로 이동
	Sub goUrl(ByVal strGoUrl)

		Response.Write "<script>"
		Response.Write "location.href='" & strGoUrl & "';"
		Response.Write "</script>"

	End Sub

	'특정 함수 호출
	Sub callFunc(ByVal strFunc)

		Response.Write "<script>"
		Response.Write strFunc & ";"
		Response.Write "</script>"

	End Sub

	'고유파일명 구하기
	Function getUniFilename(ByVal fs, ByVal filepath, ByVal objFile)

		Dim strImageName, strImageTempName, cur_date, i

		strImageName = objFile.SafeFileName

		i = 1

		strImageTempName = strImageName

		Do While fs.FileExists(Server.MapPath(filepath) & "\" & strImageTempName)

			cur_date = Replace(Date(), "-", "")
			strImageTempName = cur_date & "_" & i & "_" & strImageName
			i = i + 1

		Loop

		objFile.Save filepath & "/" & strImageTempName

		getUniFilename = filepath & "/" & strImageTempName

	End Function

	'고유파일명 구하기
	Function getUniFilename2(ByVal fs, ByVal filepath, ByVal fileFullName)

		Dim fexist, count, fileExistsName, fileName, fileExt

		fexist = True

		count = 0

		fileName		= mid(fileFullName, 1, instrrev(fileFullName,".") - 1)
		fileExt			= mid(fileFullName, instrrev(fileFullName,".") + 1)

		fileExistsName = filepath & fileFullName

		do while fexist
			if(fs.fileexists(fileExistsName)) then
				count = count + 1
				fileFullName = fileName & "-" & count & "." & fileExt
				fileExistsName = filepath & "\" & fileFullName
			else
				fexist=false
			end if
		Loop

		getUniFilename2 = fileFullName

	End Function

	'파일명 추출
	Function getFilename(ByVal strFilename)

		Dim alFname, fName

		alFname = split(strFilename,"/")

		fName = alFname(UBound(alFname))

		getFilename = fName

	End Function

	'기본값 세팅
	Function setDefaultStr(ByVal strParam, ByVal strDefault)

		Dim strReturn

		If strParam = "" Or IsNull(strParam) Then
			strReturn = strDefault
		Else
			strReturn = strParam
		End If

		setDefaultStr = strReturn

	End Function

	Function cut_str(ByVal str, ByVal intLimit, ByVal tail)

		Dim strReturn

		If Len(str) > intLimit Then
			strReturn = Left(str, intLimit) & tail
		Else
			strReturn = str
		End If

		cut_str = strReturn
	End Function

	Function toDBReplace(ByVal str)
		Dim strReturn

		strReturn = Replace(str, "'", "''")

		toDBReplace = strReturn
	End Function

	'페이징 처리
	Function Paging( ByVal intTotalPage, ByVal intCurPage, ByVal intPageCnt, ByVal strCallFunc )

		Dim i, intStartPage, intEndPage, strShowPage, strClassLast

		If intTotalPage > 0 Then

			intStartPage = (Ceil(intCurPage, intPageCnt) - 1 ) * intPageCnt + 1
			intEndPage = intStartPage + intPageCnt - 1

			If intEndPage > intTotalPage Then
				intEndPage = intTotalPage
			End If

			If CInt(intCurPage) > 1 Then
				strShowPage = "<a href='#' onclick='" & strCallFunc & "(" & (intCurPage - 1) & ")'><img src=""/2013/img/share/btn_prev.png"" alt=""이전"" /></a>"
			Else
				strShowPage = "<a href='#'><img src=""/2013/img/share/btn_prev.png"" alt=""이전"" /></a>"
			End If

			For i = intStartPage To intEndPage

				If i = CInt(intCurPage) Then
					strShowPage = strShowPage & "<strong>" & i & "</strong>"
				Else

					strShowPage = strShowPage & "<a href='#' onclick='" & strCallFunc & "(" & i & ")' " & strClassLast & ">" & i & "</a>"

				End If
			Next

			If CInt(intCurPage) < CInt(intTotalPage) Then
				strShowPage = strShowPage & "<a href='#' onclick='" & strCallFunc & "(" & (intCurPage + 1) & ")'><img src=""/2013/img/share/btn_next.png"" alt=""다음"" /></a>"
			Else
				strShowPage = strShowPage & "<a href='#'><img src=""/2013/img/share/btn_next.png"" alt=""다음"" /></a>"
			End If
		Else

			strShowPage = "&nbsp;"

		End If

		Paging = strShowPage

	End Function

	'관리자 페이지 페이징
	Function adminPaging( ByVal intTotalPage, ByVal intCurPage, ByVal intPageCnt, ByVal strCallFunc )

		Dim i, intStartPage, intEndPage, strShowPage

		If intTotalPage > 0 Then

			intStartPage = (Ceil(intCurPage, intPageCnt) - 1 ) * intPageCnt + 1
			intEndPage = intStartPage + intPageCnt - 1

			If intEndPage > intTotalPage Then
				intEndPage = intTotalPage
			End If

			If intCurPage > 1 Then
				strShowPage = "<a href=""#"" onclick=""" & strCallFunc & "(" & (intCurPage - 1) & ")"" alt=""이전 페이지""><<</a> "
			Else
				strShowPage = "<a href=""#"" alt=""이전 페이지""><<</a> "
			End If

			For i = intStartPage To intEndPage
				If i = CInt(intCurPage) Then
					strShowPage = strShowPage & "<a href=""#""><b>" & i & "</b></a> "
				Else

					strShowPage = strShowPage & "<a href=""#"" onclick=""" & strCallFunc & "(" & i & ")"">" & i & "</a> "

				End If
			Next

			If intEndPage < intTotalPage Then
				strShowPage = strShowPage & "<a href=""#"" onclick=""" & strCallFunc & "(" & (intEndPage + 1) & ")"" alt=""다음 페이지"">>></a>"
			Else
				strShowPage = strShowPage & "<a href=""#"" alt=""다음 페이지"">>></a>"
			End If
		Else

			strShowPage = "&nbsp;"

		End If

		adminPaging = strShowPage

	End Function

	'zero 채우기
	Function putZero(obj)

		If CInt(obj) < 10 Then
			putZero = "0" & obj
		Else
			putZero = obj
		End if

	End Function

	'올림함수
	Function Ceil(Val, Div)
		Dim result, modVal

		result = Int(Val/Div)
		modVal = Val Mod Div
		If modVal > 0 Then
			result = result + 1
		End If

		Ceil = result
	End Function

	'배열에서 해당 row 구하기
	Function getArrayRow(ByVal arrArray, ByVal arrSeq, ByVal strFindKey)

		Dim i,j
		Dim rtnRow

		If IsArray(arrArray) Then
			For i = 0 To UBound(arrArray, 2)
				If arrArray(arrSeq, i) = strFindKey Then
					ReDim rtnRow(UBound(arrArray,1))

					For j = 0 To UBound(arrArray,1)
						rtnRow(j) = arrArray(j, i)
					Next

					Exit For
				End If
			Next
		End If

		getArrayRow = rtnRow

	End Function

	'폴더 생성
	Function chkDir(ByVal strDir)
		Dim fso

		Set fso = Server.CreateObject("Scripting.FileSystemObject")

		If Not fso.FolderExists(strDir) Then
			Fso.CreateFolder(strDir) '폴더를 생성
		End If
	End Function

	'파일 확장자 구하기
	Function getFileExt(ByVal strFileName)
		Dim strFileExt

		If strFileName = "" Then
			strFileExt = ""
		Else
			strFileExt = Mid(strFileName, InStrRev(strFileName, ".") + 1)
		End If

		getFileExt = strFileExt

	End Function

	'파일 확장자에 따른 이미지
	Function getExtImg(ByVal strFileExt)
		Dim strImageName

		If strFileExt = "" Then
			strImageName = ""
		Else
			Select Case LCase(strFileExt)
				Case "pdf"
					strImageName = "bu_pdf.gif"
				Case Else
					strImageName = "bu_disk.gif"
			End Select
		End If

		getExtImg = strImageName
	End Function

	Public Function URLDecode(str)
		Dim strTemp
		Dim strChar
		Dim strHex
		Dim strHex1
		Dim strDec
		Dim strDec1
		Dim lngCurrent
		Dim nAsciiVal
		Dim bDone
		lngCurrent=1

		While Not bDone

			If Mid(str, lngCurrent, 1) = "%" Then

				strHex = Mid(str, lngCurrent + 1, 2)

				If strHex <> "" Then
					If CInt("&H" & strHex) > 127 Then
						lngCurrent = lngCurrent + 3
						strHex1 = Mid(str, lngCurrent + 1, 2)
						strDec = Chr(CInt("&H" & strHex & strHex1))
						strTemp = strTemp & strDec
						lngCurrent = lngCurrent + 3
					Else
						strDec = Chr(CInt("&H" & strHex))
						strTemp = strTemp & strDec
						lngCurrent = lngCurrent + 3
					End If
				End If

			Else

				strTemp = strTemp & Mid(str, lngCurrent, 1)
				lngCurrent = lngCurrent + 1

			End If

			If lngCurrent > Len(str) Then
				bDone = True
			End If

		Wend

		URLDecode = strTemp

	End Function

	Function toDBStr(ByVal str)
		Dim strChg

		strChg = Replace(str, "'", "''")

		toDBStr = strChg
	End Function

	Function fromDBStr(ByVal str)
		Dim strChg

		strChg = Replace(str, "''", "'")

		fromDBStr = strChg
	End Function

	'게시물 날짜 이미지 변환
	Function dateToImg(ByVal strDate)

		Dim arDate
		Dim strImgDate

		If strDate = "" Or IsNull(strDate) Then
			strImgDate = ""
		Else
			arDate = Split(strDate, "-")

			strImgDate = "<img src='/img/02_media/list_n" & arDate(1) & ".gif' alt=''>" & "<img src='/img/02_media/list_slash.gif' alt=''>" & "<img src='/img/02_media/list_n" & arDate(2) & ".gif' alt=''>"
		End If

		dateToImg = strImgDate

	End Function

	Function nl2br(ByVal strText)
		strText = Replace(strText, VbNewLine, "<br/>")
		strText = Replace(strText, VbCrLf, "<br/>")
		strText = Replace(strText, VbCr, "<br/>")
		strText = Replace(strText, VbLf, "<br/>")

		nl2br = strText
	End Function

	'현재 시분초와 날자 비교
	Function chkDateTime(ByVal strDateTime)
		If CDate(strDateTime) > now() Then
			chkDateTime = false
		Else
			chkDateTime = true
		End If
	End Function

  Function getDateTime(ByVal dateFormat)

    getDateTime = getDateTime3(dateFormat, now)

  End Function

  Function getDateTime2(ByVal dateTime)

    getDateTime2 = getDateTime3("", dateTime)

  End Function

  Function getDateTime3(ByVal dateFormat, ByVal dateTime)
    Dim reValue
    If dateFormat = "" Then
      dateFormat = "YYYY-mm-dd HH:MM:ss"
    End If

    If isDate(dateTime) = false Then
      dateTime = now
    End If

    reValue = Replace(dateFormat, "YYYY", Year(dateTime))
    reValue = Replace(reValue, "mm", Right("0" & Month(dateTime), 2))
    reValue = Replace(reValue, "dd", Right("0" & Day(dateTime), 2))
    reValue = Replace(reValue, "HH", Right("0" & Hour(dateTime), 2))
    reValue = Replace(reValue, "MM", Right("0" & Minute(dateTime), 2))
    reValue = Replace(reValue, "ss", Right("0" & Second(dateTime), 2))

    getDateTime3 = reValue

  End Function

  '파일업로드 객체
  Dim oUpload

  Function UploadForm(ByVal Param)
	Dim sUpTmp
	If ( Not IsObject(oUpload) ) Then
		Set oUpload = Server.CreateObject("DEXT.FileUpload")
		oUpload.CodePage = 65001				'// 다국어 지원
		'Set oUpload = Server.CreateObject("DEXT.FileUpload")
		oUpload.DefaultPath = Server.MapPath("/webzine/upload/temp")
	End If
	sUpTmp = oUpload(Cstr(Trim(Param)))
	UploadForm = Replace(sUpTmp, "'", "''")
  End Function

  	function SectName(g)
		select case g
			case "home":
				SectName="홈페이지"
			case "goods":
				SectName="제품"
			case "recruit":
				SectName="채용"
			case "adver":
				SectName="광고"
			case "set":
				SectName="동서선물세트"
			case "disc":
				SectName="제품 불편사항"
			case "etc":
				SectName="기타"
			case "idea":
				SectName="제품아이디어"
			case "maxwell":
				SectName="웹진삶의향기"
		end select
  	end function

	'SQL Server Query String을 위한 작은 따옴표를 ''로 변경
	Function Replace_squoto(s)
		Dim t
		If not IsNull(s) Then
			t = Replace(s,"'","''")
		End If
		Replace_squoto = t
	End Function

	'년도 Select List 출력
	Function writeDatelist(n,s,d) 'select 박스 이름, 시간 단위, 디폴트 값
		Dim iStart, iEnd, strList, i

		strList = "<select name=""" & n & """>" & Chr(10)

		If d = "0" Then
			strList = strList & "<option value='' >선택</option>" & Chr(10)
		End If

		Select Case s
			Case "Y"
				iStart = 2007
				iEnd = 2020
			Case "M"
				iStart = 1
				iEnd = 12
			Case "D"
				iStart = 1
				iEnd = 31
			Case "H"
				iStart = 0
				iEnd = 23
			Case "T"
				iStart = 0
				iEnd = 59
		End Select

		For	i = iStart to iEnd
			If CInt(d) = CInt(i) Then

				strList = strList & "<option value=""" & i & """ selected>" & i & "</option>" & Chr(10)
			Else
				strList = strList & "<option value=""" & i & """>" & i & "</option>" & Chr(10)
			End If
		Next
		writeDatelist = strList & "</select>" & Chr(10)
	End Function

	'오류찾기 이벤트 오류종류
	function getEvent170919Kind(g)
		select case g
			case "1":
				getEvent170919Kind="오탈자"
			case "2":
				getEvent170919Kind="설명글 오류"
			case "3":
				getEvent170919Kind="이미지 오류"
			case "4":
				getEvent170919Kind="미등록 제품 신고"
			case "5":
				getEvent170919Kind="기타"
		end select
  	end function
%>
