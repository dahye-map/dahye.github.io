<%
	Class MemberCls

		private sub Class_Initialize()
			'클래스 초기화 시 해야할 작업
		End Sub

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 아이디 체크 (이미 가입된 회원인지 여부 확인)
		' 2013.03.22 추가
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function getIdCheck (strUserId)
		function getIdCheck ( ByVal DBHelper, ByVal dicParam )
			'변수 선언
			dim strUserId
			Dim intResultCd, strResultCd, strSql, db, rs, j, count

			'변수값 세팅
			strUserId	=  dicParam.Item("userId")

			strSql = ""
			strSql = strSql & " SELECT id FROM dongsuh.member"
			strSql = strSql & " WHERE id = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@id", adVarChar, adParamInput, 20, strUserId) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(strSql, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getIdCheck = arrayList

		End function


		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 구독자 회원인지 아닌지 체크
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function MaxwellCheck(userid)
		Public function MaxwellCheck( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intIdx
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			memberid	=  dicParam.Item("memberid")

			query = " select reader_no from dbo.member_maxwell where memberid = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@memberid", adVarChar, adParamInput, 50, memberid) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arList = objRs.getRows
				arrayList = arList(0, 0)
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			MaxwellCheck = arrayList

		end function

		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function eventSeq()
			Dim db, strSql, rs, doc


			Set db = CreateObject("DAL.DBHelper")

			strSql = ""
			strSql = strSql & " SELECT MAX(register_idx) +1 "
			strSql = strSql & " FROM  dongsuh.maxevent_register "

					 query =  strSql

			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))

			doc = rs(0)

			rs.Close
			Set rs = Nothing
			Set db = Nothing
			eventSeq = doc
		end function


		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 맥스웰 향기 주소 가져오기 (코드가져와서 처리)
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function getAddr(strSido,strGugun,strDong)
		Public function getAddr( ByVal DBHelper, ByVal dicParam )
			'변수 선언
			Dim intIdx
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			strSido		=  dicParam.Item("sido")
			strGugun	=  dicParam.Item("gugun")
			strDong		=  dicParam.Item("dong")

			query = " select SIDO + GUGUN +replace(dong,' ','') AS Addr from dbo.zipcd where sidocd = ? and guguncd = ? and dongcd = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@sidocd", adVarChar, adParamInput, 100, strSido), _
				DBHelper.MakeParam("@guguncd", adVarChar, adParamInput, 100, strGugun), _
				DBHelper.MakeParam("@dongcd", adVarChar, adParamInput, 100, strDong) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getAddr = arrayList

		end function

		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function setMemberInsert(memberNo, memberName, strId,strSeq)
			Dim db, strSql, rs, doc, post, postdetail, address, userName,gender

			memberNo = Replace(memberNo,"'","''")
			memberName = Replace(memberName,"'","''")
			strId = Replace(strId,"'","''")

			Set db = CreateObject("DAL.DBHelper")

			strSql = ""
			strSql = strSql & "EXEC dbo.SSP_OPENKEY "
			strSql = strSql & "select address1 , CONVERT(VARCHAR(MAX),DECRYPTBYKEY(address2))AS address2, "
			strSql = strSql & " zip, name_han, CONVERT(VARCHAR(MAX),DECRYPTBYKEY(hp))AS hp,gender,email from dongsuh.member where id='"&strId&"'"
			strSql = strSql & " EXEC dbo.SSP_CLOSEKEY"

			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))

			'address = rs(0)&" "&rs(1)
			 post = rs(2)&" "&rs(3)
			'post		=	left(rs(2),3)
			'postdetail = replace(rs(2),"-","")
			userName = Trim(Replace(rs(3), "'", "''"))
			if rs(5) = 2 then
				gender = "F"
			else
				gender = "M"
			end if

			strSql =""
			strSql = " insert into dbo.member_maxwell (seq,reader_no, memberid, user_name,addr1,addr2,zipcd,gender,mobile,email,reg_date) " & _
							 " values( '"&strSeq&"','"&memberNo&"','"&strId&"','"&memberName&"','"&rs(0)&"','"&rs(1)&"','"&rs(2)&"','"&gender&"','"&rs(4)&"','"&rs(6)&"',getdate()) "
					 'response.write strSql
					 'response.end

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))
		query = strSql
			setMemberInsert = true
			Set db = Nothing
		end function

		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'프론트 최대(seq)값에 1 더한 값 가져오기
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function getNumberSeq( ByVal DBHelper )
			'변수 선언
			Dim intIdx
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅

			query = " SELECT Max(seq) +1 FROm dbo.member_maxwell "

			set objRs = DBHelper.ExecSQLReturnRS(query, nothing, nothing)

			if (not objRs.EOF) then
				arList = objRs.getRows

				arrayList = arList(0, 0)
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getNumberSeq = arrayList

		end function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 구독번호가 있는지 확인
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function member_RederNo01(intSeq)
			Dim db, strSql, rs, doc


			Set db = CreateObject("DAL.DBHelper")

			strSql = ""
			strSql = strSql & " SELECT reader_no FROM dbo.member_maxwell "
			strSql = strSql & " WHERE email = '" & intSeq & "'  "

			Set rs = db.RunSQLReturnRs(strSql,"",db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF then
				doc = false
			Else
				doc = rs.getRows()
			End if

			rs.Close
			Set rs = Nothing
			Set db = Nothing
			member_RederNo01 = doc

		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 이메일의 정보를 가져온다.
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function member_RederNo(memberNo)
			Dim db, strSql, rs, doc, intSeq


			Set db = CreateObject("DAL.DBHelper")

			strSql = ""
			strSql = strSql & "SELECT EMAIL "
			strSql = strSql & " FROM dongsuh.member WHERE id = '" & memberNo & "' "
		 query = strSql
			Set rs = db.RunSQLReturnRs(strSql,"",db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF then
				doc = false
			Else
				doc = rs.getRows()
			End if

			rs.Close
			Set rs = Nothing
			Set db = Nothing

			member_RederNo = doc
		End function


		'function deleteMember3(memberNo)
		Public function deleteMember3( ByVal DBHelper, ByVal dicParm )

			'변수 선언
			Dim query, arrParams

			reader_no =  dicParam.Item("reader_no")

			query =	" update dbo.member_maxwell set stop_yn = 'Y', reg_date =  '', mod_date =  getdate()  where reader_no = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@reader_no", adVarChar, adParamInput, 50, reader_no) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

			deleteMember3 = true

		end function

		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'관리자 맥스웰 향기 구독회원 조회
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function getMember2(memberNo)
			Dim db, strSql, rs, doc, seq,memberid,reader_no,user_name, zipcd,addr1,addr2,gender,age,mobile,email,reg_date,mod_date, stop_yn

			memberNo = Replace(memberNo,"'","''")

			Set db = CreateObject("DAL.DBHelper")

			strSql = "SELECT seq,memberid,reader_no,user_name, zipcd,addr1,addr2,gender,age,mobile,email,reg_date,mod_date, stop_yn" & _
					 " FROM dbo.member_maxwell WHERE reader_no='"&memberNo&"'"


					 query= strSql

			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF Then
				doc = false
			Else
				doc = rs.getRows()
			End If

			rs.Close
			Set rs = Nothing
			Set db = Nothing
			getMember2 = doc
		end function

		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'관리자 맥스웰 향기 구독신청 등록하기
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function setMemberSub2 (strId, strReaderNo, userName, strZip, strAddr1, strAddr2, strGender, strAge, strMobile, strEmail)
			Dim db, strSql, rs, doc,iMax

			'memberNo = Replace(memberNo,"'","''")
			strZip = Replace(strZip,"'","''")

			Set db = CreateObject("DAL.DBHelper")

			strSql =""
			strSql = strSql & " SELECT MAX(seq) + 1 FROM dbo.member_maxwell "
			query = strSql
			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))

			iMax = rs(0)

			strSql =""
			strSql = strSql & " insert into dbo.member_maxwell (seq,memberid,reader_no,user_name,zipcd,addr1,addr2,gender,age,mobile,email,reg_date,mod_date,stop_yn)  "
			strSql = strSql & " values('" & iMax & "','" & strId & "','" & strReaderNo & "','" & userName & "','" & strZip & "','" & strAddr1 & "','" & strAddr2 & "','" & strGender & "','" & strAge & "','" & strMobile & "', "
			strSql = strSql & " '" & strEmail & "',getdate(),'','N') "

			query = strSql

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))
			setMemberSub2 = strSql
			Set db = Nothing
		end function


		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'관리자. 맥스웰 향기 구독신청 수정
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function updateAdminMember(strid,memberNo, strZip, strAddr1, strAddr2, memberName, strGender, strAge, strEamil, strMobile, strModDate)
			Dim db, strSql, rs, doc

			memberNo = Replace(memberNo,"'","''")


			Set db = CreateObject("DAL.DBHelper")

			strSql = " update dbo.member_maxwell set " &_
							 " memberid = '"&strid&"' " &_
							 " ,user_name = '"&memberName&"' " &_
							 " ,zipcd = '"&strZip&"' " &_
							 " ,addr1 = '"&strAddr1&"' " &_
							 " ,addr2 = '"&strAddr2&"' " &_
							 " ,gender = '"&strGender&"' " &_
							 " ,age = '"&strAge&"' " &_
							 " ,email = '"&strEamil&"' " &_
							 " ,mobile = '"&strMobile&"' " &_
							 " ,reg_date = '' " &_
							 " ,mod_date = getdate() " &_
							 " ,stop_yn = 'N'" &_
							 " where reader_no = '" & memberNo & "'"

					 query =  strSql
					 'response.end

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))
			updateAdminMember = strSql
			Set db = Nothing
		end function

		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'관리자. 맥스웰 향기 구독신청 수정
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function updateMember2(memberNo, strZip, strAddr1, strAddr2, memberName, strGender, strAge, strEamil, strMobile, strModDate)
			Dim db, strSql, rs, doc

			memberNo = Replace(memberNo,"'","''")


			Set db = CreateObject("DAL.DBHelper")

			strSql = " update dbo.member_maxwell set " &_
							 " user_name = '"&memberName&"' " &_
							 " ,zipcd = '"&strZip&"' " &_
							 " ,addr1 = '"&strAddr1&"' " &_
							 " ,addr2 = '"&strAddr2&"' " &_
							 " ,gender = '"&strGender&"' " &_
							 " ,age = '"&strAge&"' " &_
							 " ,email = '"&strEamil&"' " &_
							 " ,mobile = '"&strMobile&"' " &_
							 " ,reg_date = '' " &_
							 " ,mod_date = getdate() " &_
							 " where reader_no = '" & memberNo & "'"


					 query =  strSql
					 'response.end

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))
			updateMember2 = strSql
			Set db = Nothing
		end function

		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'관리자 맥스웰 향기 구독회원 삭제
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function deleteMember(memberNo)
			Dim db, strSql, rs, doc

			memberNo = Replace(memberNo,"'","''")

			Set db = CreateObject("DAL.DBHelper")

			strSql = " delete dbo.member_maxwell where reader_no = '" & memberNo & "' "

			strSql = ""
			strSql = " update dbo.member_maxwell set stop_yn = 'Y', mod_date =  getdate()  where reader_no = '" & memberNo & "' "

					 query =  strSql
					 'response.end

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))
			deleteMember = true
			Set db = Nothing
		end function

		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'관리자 맥스웰 향기 구독회원 삭제
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function deleteMember4(memberNo)
			Dim db, strSql, rs, doc

			memberNo = Replace(memberNo,"'","''")

			Set db = CreateObject("DAL.DBHelper")

			strSql = " delete dbo.member_maxwell where memberid = '" & memberNo & "' "

			strSql = ""
			strSql = " update dbo.member_maxwell set stop_yn = 'Y', mod_date =  getdate()  where memberid = '" & memberNo & "' "

					 query =  strSql
					 'response.end

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))
			deleteMember4 = true
			Set db = Nothing
		end function
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'관리자.맥스웰 향기 구독회원 DB에서도 데이터 삭제
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function deleteMember2(memberNo)
			Dim db, strSql, rs, doc

			memberNo = Replace(memberNo,"'","''")

			Set db = CreateObject("DAL.DBHelper")

			strSql = " delete dbo.member_maxwell where reader_no = '" & memberNo & "' "

					 query =  strSql
					 'response.end

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))
			deleteMember2 = true
			Set db = Nothing
		end function


		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'새로운 맥스웰 구독자회원에 값 넣기
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function setMember6(intSeq,memberNo, userName, strId, strZipCd, strAddr1, strAddr2, strGender, strAge, strMobile, strEmail)
		Public function setMember6( ByVal DBHelper, ByVal dicParam )
			'변수 선언
			Dim query, arrParams
			Dim seq, memberid, reader_no, user_name, zipcd, addr1, addr2, gender, age, mobile, email, reg_date, mod_date, stop_yn

			'변수값 세팅
			seq			= dicParam.Item("seq")
			memberid	= dicParam.Item("memberid")
			reader_no	= dicParam.Item("reader_no")
			user_name	= dicParam.Item("user_name")
			zipcd		= dicParam.Item("zipcd")
			addr1		= dicParam.Item("addr1")
			addr2		= dicParam.Item("addr2")
			gender		= dicParam.Item("gender")
			age			= dicParam.Item("age")
			mobile		= dicParam.Item("mobile")
			email		= dicParam.Item("email")

			query =			" insert into dbo.member_maxwell ( "
			query = query & "	 seq, memberid, reader_no, user_name, zipcd, addr1, addr2, gender, age, mobile, email, reg_date, mod_date, stop_yn "
			query = query & " ) values ( "
			query = query & "	?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, getdate(), '','N' "
			query = query & " ) "

			arrParams = Array( _
				DBHelper.MakeParam("@seq", adInteger, adParamInput, 4, seq), _
				DBHelper.MakeParam("@memberid", adVarChar, adParamInput, 20, memberid), _
				DBHelper.MakeParam("@reader_no", adVarChar, adParamInput, 10, reader_no), _
				DBHelper.MakeParam("@user_name", adVarChar, adParamInput, 10, user_name), _
				DBHelper.MakeParam("@zipcd", adVarChar, adParamInput, 20, zipcd), _
				DBHelper.MakeParam("@addr1", adVarChar, adParamInput, 255, addr1), _
				DBHelper.MakeParam("@addr2", adVarChar, adParamInput, 255, addr2), _
				DBHelper.MakeParam("@gender", adVarChar, adParamInput, 255, gender), _
				DBHelper.MakeParam("@age", adVarChar, adParamInput, 255, age), _
				DBHelper.MakeParam("@mobile", adVarChar, adParamInput, 255, mobile), _
				DBHelper.MakeParam("@email", adVarChar, adParamInput, 255, email) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

			setMember6 = true

		end function

		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 구독자 회원인지 아닌지 체크
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function checkNo(memberNo)
		Public function checkNo( ByVal DBHelper, ByVal dicParam )
			'변수 선언
			Dim intIdx
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			reader_no	=  dicParam.Item("reader_no")

			query = "select reader_no from dbo.member_maxwell where reader_no = ? and stop_yn='N' "

			arrParams = Array( _
				DBHelper.MakeParam("@reader_no", adVarChar, adParamInput, 10, reader_no) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = true
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			checkNo = arrayList

		end function

			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			'관리자 -- 맥스웰 향기 재등록 이벤트 참여 count : 엑셀용
			'tsDate : 시작날짜
			'teDate : 종료날짜
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			function getExcelCountRegisterEvent(tsDate, teDate)
				Dim db, strSql, rs, doc, strSubQ

				Set db = CreateObject("DAL.DBHelper")

				If tsDate <> "" Then
					strSubQ = " convert(varchar(10), reg_date, 112) BETWEEN  '"& tsDate &"' and '"& teDate &"' "
				Else
					strSubQ = " 1=1 "
				End If

				strSql = "SELECT "&_
						 "	count(*) "&_
						 "FROM dongsuh.maxevent_register WHERE "
				strSql = strSql & strSubQ

				Set rs = db.RunSQLReturnRs(strSql, "", db.GetConnStr(Const_DBConn))

				If rs.EOF OR rs.BOF then
					count = 0
				Else
					count = rs(0)
				End if
				rs.Close
				Set rs = Nothing
				Set db = Nothing

				getExcelCountRegisterEvent = count

			end function

			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			'관리자 -- 맥스웰 향기 재등록 이벤트 참여 현황 : 엑셀용
			'tsDate : 시작날짜
			'teDate : 종료날짜
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			function getExcelListRegisterEvent(tsDate, teDate)
				Dim db, strSql, rs, doc, strSubQ

				Set db = CreateObject("DAL.DBHelper")

				If tsDate <> "" Then
					strSubQ = " convert(varchar(10), reg_date, 112) BETWEEN  '"& tsDate &"' and '"& teDate &"' "
				Else
					strSubQ = " 1=1 "
				End If

				strSql = "SELECT "&_
						 "	user_name, zip_code, addr1, addr2, sex, age, mobile_no, email, reader_no, "&_
						 "  convert(varchar(10), reg_date, 112) as reg_date "&_
						 "FROM dongsuh.maxevent_register WHERE "
				strSql = strSql & strSubQ & " ORDER BY reg_date ASC "

				Set rs = db.RunSQLReturnRs(strSql, "", db.GetConnStr(Const_DBConn))

				If rs.EOF OR rs.BOF then
					doc = false
				Else
					doc = rs.getRows()
				End if
				rs.Close
				Set rs = Nothing
				Set db = Nothing

				getExcelListRegisterEvent = doc

			end function

			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			'맥스웰 향기 재등록 이벤트 참여자 정보 수정
			'reader_no : strReaderNo
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			function updateRegisterEvent2(ByVal strZipCode, ByVal strAddr1, ByVal strAddr2, ByVal strMobileNo, ByVal strEmail)

				Dim db, strSql, strSubSql, rs, doc, strCols

				strZipCode = Replace(strZipCode, "'", "''")
				strAddr1 = Replace(strAddr1, "'", "''")
				strAddr2 = Replace(strAddr2, "'", "''")
				strMobileNo = Replace(strMobileNo, "'", "''")
				strEmail = Replace(strEmail, "'", "''")

				Set db = CreateObject("DAL.DBHelper")

				strSql = " UPDATE dongsuh.maxevent_register "&_
						 " SET zip_code = '"& strZipCode &"', "&_
						 "	   addr1 = '"& strAddr1 &"', "&_
						 "	   addr2 = '"& strAddr2 &"', "&_
						 "     mobile_no = '"& strMobileNo &"', "&_
						 " WHERE email = '"& strEmail &"' "

				Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))
				updateRegisterEvent2 = strSql
				Set db = Nothing

			end function

		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function setMember3(memberNo, memberName, company, memberDept, memberGrade, strZip, strAddr)
			Dim db, strSql, rs, doc

			memberNo = Replace(memberNo,"'","''")
			memberName = Replace(memberName,"'","''")
			company = Replace(company,"'","''")
			memberDept = Replace(memberDept,"'","''")
			memberGrade = Replace(memberGrade,"'","''")
			strZip = Replace(strZip,"'","''")
			strAddr = Replace(strAddr,"'","''")

			Set db = CreateObject("DAL.DBHelper")

			strSql = " insert into dongsuh.member_unity (memberno, membername, new_old, company, memberdept, membergrade, post, post_detail, memberAddress) " & _
							 " values('"&memberNo&"','"&memberName&"','NEW','"&company&"','"&memberdept&"','"&membergrade&"','"&left(strZip,3)&"','"&strZip&"','"&strAddr&"') "
					 'response.write strSql
					 'response.end

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))
			setMember3 = strSql
			Set db = Nothing
		end function

		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function updateMemberUnity(memberNo, company, memberDept, memberGrade, strZip, strAddr, memberName)
			Dim db, strSql, rs, doc

			memberNo = Replace(memberNo,"'","''")
			company = Replace(company,"'","''")
			memberDept = Replace(memberDept,"'","''")
			memberGrade = Replace(memberGrade,"'","''")
			strZip = Replace(strZip,"'","''")
			strAddr = Replace(strAddr,"'","''")

			Set db = CreateObject("DAL.DBHelper")

			strSql = " update dongsuh.member_unity set " &_
							 " memberName = '"&memberName&"' " &_
							 " ,company = '"&company&"' " &_
							 " ,memberDept = '"&memberDept&"' " &_
							 " ,memberGrade = '"&memberGrade&"' " &_
							 " ,post = '"&left(strZip,3)&"' " &_
							 " ,post_detail = '"&strZip&"' " &_
							 " ,memberAddress = '"&strAddr&"' " &_
							 " where memberNo = '" & memberNo & "'"

					 'response.write strSql
					 'response.end

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))
			updateMemberUnity = strSql
			Set db = Nothing
		end function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 맥스웰 향기 회원정보 가져오기 (주소 수정용)
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function getMemberId(memberId)
			Dim db, strSql, rs, doc

			memberId = Replace(memberId,"'","''")

			Set db = CreateObject("DAL.DBHelper")

			strSql = "SELECT Top 1 post, post_detail, memberAddress " & _
					 " FROM dongsuh.member_unity WHERE memberId='"&memberId&"'"

			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF Then
				doc = false
			Else
				doc = rs.getRows()
			End If

			rs.Close
			Set rs = Nothing
			Set db = Nothing
			getMemberId = doc
		end function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 맥스웰 향기 구독신청 삭제
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function deleteMemberUnity(memberId)
			Dim db, strSql, rs, doc

			memberId = Replace(memberId,"'","''")

			Set db = CreateObject("DAL.DBHelper")

			strSql = " delete dongsuh.member_unity " &_
							 " where memberid = '" & memberId & "'"

					 'response.write strSql
					 'response.end

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))

			deleteMemberUnity = true
			Set db = Nothing
		end function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 맥스웰 향기 아이디로 구독번호 가져오기
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function getNumberId(memberId)
		Public function getNumberId( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intIdx
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			memberid	=  dicParam.Item("memberid")

			query = " select reader_no from  dbo.member_maxwell where memberid = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@memberid", adVarChar, adParamInput, 50, memberid) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getNumberId = arrayList

		end function


		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 맥스웰 향기 주소로 해당회원 가져오기 (동 부분)
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function getZipDong(strSido,strGugun)
			Dim db, strSql, rs, doc

			strSido = Replace(strSido,"'","''")
			strGugun = Replace(strGugun,"'","''")

			Set db = CreateObject("DAL.DBHelper")

			strSql = "select distinct(dong) from zip where sido='"&strSido&"' and gugun='"&strGugun&"'"

			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF Then
				doc = false
			Else
				doc = rs.getRows()
			End If

			rs.Close
			Set rs = Nothing
			Set db = Nothing
			getZipDong = doc
		end function


		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 맥스웰 향기 주소로 해당회원 가져오기 (동 부분)
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function getZipDongCd(strSido,strGugun)
		Public function getZipDongCd( ByVal DBHelper, ByVal dicParam )
			'변수 선언
			Dim intIdx
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			strSido		=  dicParam.Item("sido")
			strGugun	=  dicParam.Item("gugun")

			query = " select distinct dong,dongcd from dbo.zipcd where sidocd = ? and guguncd = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@sidocd", adVarChar, adParamInput, 50, strSido), _
				DBHelper.MakeParam("@guguncd", adVarChar, adParamInput, 50, strGugun) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getZipDongCd = arrayList

		end function

		function setMember2(memberNo, memberName, strId)
			Dim db, strSql, rs, doc, post, postdetail, address, userName

			memberNo = Replace(memberNo,"'","''")
			memberName = Replace(memberName,"'","''")
			strId = Replace(strId,"'","''")

			Set db = CreateObject("DAL.DBHelper")

			strSql = ""
			strSql = strSql & "EXEC dbo.SSP_OPENKEY "
			strSql = strSql & "select address1 , CONVERT(VARCHAR(MAX),DECRYPTBYKEY(address2))AS address2, "
			strSql = strSql & " zip, name_han from dongsuh.member where id='"&strId&"'"
			strSql = strSql & " EXEC dbo.SSP_CLOSEKEY"

			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))

			address = rs(0)&" "&rs(1)
			post		=	left(rs(2),3)
			postdetail = replace(rs(2),"-","")
			userName = Trim(Replace(rs(3), "'", "''"))

			strSql =""
			strSql = " insert into dongsuh.member_unity (memberno, memberid, membername,new_old,memberAddress,post,post_detail) " & _
							 " values('"&memberNo&"','"&strId&"','"&userName&"','NEW','"&address&"','"&post&"','"&postdetail&"') "
					 'response.write strSql
					 'response.end

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))
		'query = strSql
			setMember2 = true
			Set db = Nothing
		end function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 맥스웰 향기 주소 변경(동시에 사이트 회원인 구독회원 with memberId)
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function updateAddress(memberId, strZip, strAddr1, strAddr2, strMobile, strEmail, maxwell)
		Public function updateAddress( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intIdx
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			memberid	=  dicParam.Item("userId")
			strZip		=  dicParam.Item("zip")
			strAddr1	=  dicParam.Item("address1")
			strAddr2	=  dicParam.Item("address2")
			strMobile	=  dicParam.Item("hp")
			strEmail	=  dicParam.Item("email")
			maxwell		=  dicParam.Item("maxwell")

			query = ""
			query = query & "UPDATE  dbo.member_maxwell"
			query = query & "   SET  zipcd = ? "
			query = query & "       ,addr1 = ? "
			query = query & "       ,addr2 = ? "
			query = query & "       ,mobile = ? "
			query = query & "       ,email = ? "
			query = query & "       ,reg_date = '' "
			query = query & "       ,mod_date = getdate() "
			query = query & " WHERE reader_no = ? "
			query = query & "   AND memberid = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@zipcd", adVarChar, adParamInput, 10, strZip), _
				DBHelper.MakeParam("@addr1", adVarChar, adParamInput, 100, strAddr1), _
				DBHelper.MakeParam("@addr2", adVarChar, adParamInput, 100, strAddr2), _
				DBHelper.MakeParam("@mobile", adVarChar, adParamInput, 20, strMobile), _
				DBHelper.MakeParam("@email", adVarChar, adParamInput, 100, strEmail), _
				DBHelper.MakeParam("@reader_no", adVarChar, adParamInput, 20, maxwell), _
				DBHelper.MakeParam("@memberid", adVarChar, adParamInput, 20, memberid) _
			)
'response.write "[" & strZip & "][" & strAddr1 & "][" & strAddr2 & "][" & strMobile & "][" & strEmail & "][" & maxwell & "][" & memberID & "]"
			Call DBHelper.ExecSQL(query, arrParams, nothing)

			updateAddress = true

		end function

		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function getMember(memberNo, memberName)
			Dim db, strSql, rs, doc

			memberNo = Replace(memberNo,"'","''")
			memberName = Replace(memberName,"'","''")

			Set db = CreateObject("DAL.DBHelper")

			strSql = "SELECT reader_no, user_name, memberid " & _
					 " FROM dbo.member_maxwell WHERE reader_no='"&memberNo&"' and user_name = '"&memberName&"' "

			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF Then
				doc = false
			Else
				doc = rs.getRows()
			End If

			rs.Close
			Set rs = Nothing
			Set db = Nothing
			getMember = doc
		end function



		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 맥스웰 향기 이름과 주소로 구독번호 가져오기
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function getNumber(strName,strAddress)
		Public function getNumber( ByVal DBHelper, ByVal dicParam)
			'변수 선언
			Dim intIdx
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			intIdx	=  dicParam.Item("IDX")

			strName		=  dicParam.Item("memberName")
			strAddress	=  dicParam.Item("strAddress")

			select_fields = "IDX, TITLE, CONTENTS, CONTENTS_HTML, SHOW_DATE, VIEW_CNT, IS_SHOW, REG_DATE, REG_ID, EDIT_DATE, EDIT_ID, THUMB_IMG "

			query = " select reader_no from dbo.member_maxwell where user_name = ? and replace(addr1 + addr2,' ','') like '%"&strAddress&"%' "

			arrParams = Array( _
				DBHelper.MakeParam("@user_name", adVarchar, adParamInput, 100, strName) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getNumber = arrayList

		end function

		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function member_yn(user_id)
		Public function member_yn( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intIdx
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			user_id	=  dicParam.Item("userid")

			query = query & " SELECT count(*) "
			query = query & " FROM dbo.member_maxwell WHERE memberid = ? and stop_yn='N' "

			arrParams = Array( _
				DBHelper.MakeParam("@memberid", adVarChar, adParamInput, 20, user_id) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arList = objRs.getRows
				arrayList = arList(0, 0)
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			member_yn = arrayList

		end function

		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function member_yn2(user_id)
		Public function member_yn2( ByVal DBHelper, ByVal dicParam )
			'변수 선언
			Dim intIdx
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			memberid	=  dicParam.Item("memberid")

			query = query & " SELECT count(*) "
			query = query & " FROM dbo.member_maxwell WHERE memberid = ? "
			query = query & " AND stop_yn = 'N' "

			arrParams = Array( _
				DBHelper.MakeParam("@memberid", adVarChar, adParamInput, 50, memberid) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arList = objRs.getRows
				arrayList = arList(0, 0)
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			member_yn2 = arrayList

		end function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function getMemberNo(year)
		Public function getmemberNo( ByVal DBHelper, ByVal dicParam )
			'변수 선언
			Dim intIdx
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			years	=  dicParam.Item("years")

			query = " select top 1 reader_no from dbo.member_maxwell where left(reader_no,3) = 'N"&years&"' order by reader_no desc "

			set objRs = DBHelper.ExecSQLReturnRS(query, nothing, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getmemberNo = arrayList

		end function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 맥스웰 향기 구독회원 정보 변경(with memberNo)
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function updateUnityInfo2(memberNo, strZip, strAddr, strMobile, strEmail)
			Dim db, strSql, rs, doc

			memberNo = Replace(memberNo,"'","''")
			strZip = Replace(strZip,"'","''")
			strAddr = Replace(strAddr,"'","''")
			strMobile = Replace(strMobile,"'","''")
			strEmail = Replace(strEmail,"'","''")

			Set db = CreateObject("DAL.DBHelper")

			strSql = "update dongsuh.member_unity set " & _
					 " post = '"&left(strZip,3)&"', " & _
					 " post_detail = '"&strZip&"', " & _
					 " memberAddress = '"&strAddr&"', " & _
					 " memberMobile = '"&strMobile&"', " & _
					 " memberEmail = '"&strEmail&"', " & _
					 " update_date = getdate() " &_
					 " WHERE memberNo = '"& memberNo &"'"

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))
			query = strSql
			updateUnityInfo2 = true
			Set db = Nothing
		end function

			''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			' 동서식품 - 맥스웰 향기 재등록 이벤트
			'
			' 2012-05-01 ~ 2012-12-31
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			function insertRegisterEvent( strReader_no,strUser_name, intAge, strSex, intZip_code, strAddr1, strAddr2, intMobile_no, strEmail, strTableName)
				Dim db, strSql, rs, doc, strSql1,register_idx

				Set db = CreateObject("DAL.DBHelper")

				strSql = ""
				strSql = "INSERT INTO "& strTableName &"("&_
									"user_name, "&_
									"zip_code, "&_
									"sex, "&_
									"age, "&_
									"addr1, "&_
									"addr2, "&_
									"mobile_no, "&_
									"email, "&_
									"reader_no, "&_
									"reg_date) "&_
							"VALUES ("&_
								"'"& strUser_name &"', "&_
								"'"& intZip_code &"', "&_
								"'"& strSex &"', "&_
								"'"& intAge &"', "&_
								"'"& strAddr1 &"', "&_
								"'"& strAddr2 &"', "&_
								"'"& intMobile_no &"',"&_
								"'"& strEmail &"',"&_
								"'"& strReader_no &"',"&_
								"    getdate()  )"
		query = strSql
				Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))

				strSql1 = ""
				strSql1 = strSql1 & " INSERT INTO dongsuh.maxwell_newsletter (email, joinYn, reg_date) "
				strSql1 = strSql1 & " VALUES( "
				strSql1 = strSql1 & " '"& strEmail &"', 'Y', getdate()) "

				Call db.RunSQL(strSql1,"", db.GetConnStr(Const_DBConn))
				insertRegisterEvent = strSql
				Set db = Nothing
			End function
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			'맥스웰 향기 재등록 이벤트 참여자 정보 가져오기 : 중복 참여 여부
			'reader_no : strReaderNo
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			function getCountRegisterEvent(ByVal strReaderNo)

				Dim db, strSql, strSubSql, rs, doc, strCols

				strReaderNo = Replace(strReaderNo, "'", "''")

				Set db = CreateObject("DAL.DBHelper")

				strSql = " SELECT count(*) FROM dongsuh.maxevent_register WHERE reader_no = '"& strReaderNo &"'"

				Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))
				doc = rs(0)

				rs.Close
				Set rs = Nothing
				Set db = Nothing
				getCountRegisterEvent = doc

			end function
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			'맥스웰 향기 재등록 이벤트 참여자 정보 수정
			'reader_no : strReaderNo
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			function updateRegisterEvent(ByVal strZipCode, ByVal strAddr1, ByVal strAddr2, ByVal strMobileNo, ByVal strEmail, ByVal strReaderNo)

				Dim db, strSql, strSubSql, rs, doc, strCols

				strZipCode = Replace(strZipCode, "'", "''")
				strAddr1 = Replace(strAddr1, "'", "''")
				strAddr2 = Replace(strAddr2, "'", "''")
				strMobileNo = Replace(strMobileNo, "'", "''")
				strEmail = Replace(strEmail, "'", "''")
				strReaderNo = Replace(strReaderNo, "'", "''")

				Set db = CreateObject("DAL.DBHelper")

				strSql = " UPDATE dongsuh.maxevent_register "&_
						 " SET zip_code = '"& strZipCode &"', "&_
						 "	   addr1 = '"& strAddr1 &"', "&_
						 "	   addr2 = '"& strAddr2 &"', "&_
						 "     mobile_no = '"& strMobileNo &"', "&_
						 "	   email = '"& strEmail &"' "&_
						 " WHERE reader_no = '"& strReaderNo &"'"

				Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))
				updateRegisterEvent = strSql
				Set db = Nothing

			end function

			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			'맥스웰 향기 재등록 이벤트 참여자 정보 가져오기 : 참여 정보 확인
			'reader_no : strReaderNo
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			function getInfoRegisterEvent(ByVal strReaderNo)

				Dim db, strSql, strSubSql, rs, doc, strCols

				strReaderNo = Replace(strReaderNo, "'", "''")

				Set db = CreateObject("DAL.DBHelper")

				strSql = " SELECT reader_no, zip_code, addr1, addr2, mobile_no, email "&_
						 " FROM dongsuh.maxevent_register WHERE reader_no = '"& strReaderNo &"'"

				Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))

				If rs.EOF OR rs.BOF Then
					doc = false
				Else
					doc = rs.getRows()
				End If
				rs.Close
				Set rs = Nothing
				Set db = Nothing
				getInfoRegisterEvent = doc

			end function

			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			'관리자 -- 맥스웰 향기 재등록 이벤트 일별 참여자
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			function getDailyRegisterEvent(strDate)
				Dim db, strSql, rs, doc

				Set db = CreateObject("DAL.DBHelper")

				strSql = "SELECT count(*) FROM ("
				strSql = strSql &" SELECT distinct(register_idx) FROM dongsuh.maxevent_register "
				strSql = strSql &" WHERE convert(varchar(10), reg_date, 112) = '"& strDate &"'"
				strSql = strSql &") a"

				query = strSql

				Set rs = db.RunSQLReturnRs(strSql, "", db.GetConnStr(Const_DBConn))

				If rs.EOF OR rs.BOF then
					doc = false
				Else
					doc = rs(0)
				End if

				rs.Close
				Set rs = Nothing
				Set db = Nothing

				getDailyRegisterEvent = doc
			end function

			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			'관리자 -- 맥스웰 향기 재등록 이벤트 참여 현황 - 날짜 (날짜 조회)
			'tsDate : 시작날짜
			'teDate : 종료날짜
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			function getDateListRegisterEvent(tsDate, teDate)
				Dim db, strSql, rs, doc, strSubQ

				Set db = CreateObject("DAL.DBHelper")

				If tsDate <> "" Then
					strSubQ = " convert(varchar(10), reg_date, 112) BETWEEN  '"& tsDate &"' and '"& teDate &"' "
				Else
					strSubQ = " 1=1 "
				End If

				strSql = "SELECT distinct convert(varchar(10), reg_date, 112) as reg_date from dongsuh.maxevent_register WHERE "
				strSql = strSql & strSubQ & " ORDER BY reg_date ASC "

				Set rs = db.RunSQLReturnRs(strSql, "", db.GetConnStr(Const_DBConn))

				If rs.EOF OR rs.BOF then
					doc = false
				Else
					doc = rs.getRows()
				End if
				rs.Close
				Set rs = Nothing
				Set db = Nothing

				getDateListRegisterEvent = doc

			end function


		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 맥스웰 향기 주소로 해당회원 가져오기 (구,군 부분)
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function getZipGu(strSido)

			Dim db, strSql, rs, doc

			strSido = Replace(strSido,"'","''")

			Set db = CreateObject("DAL.DBHelper")

			strSql = "select distinct(gugun) from zip where sido='"&strSido&"'"


			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF Then
				doc = false
			Else
				doc = rs.getRows()
			End If

			rs.Close
			Set rs = Nothing
			Set db = Nothing
			getZipGu = doc
		end function


		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 맥스웰 향기 주소로 해당회원 가져오기 (구,군 부분)
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function getZipGuCd(strSido)
		Public function getZipGuCd( ByVal DBHelper, ByVal dicParam )
			'변수 선언
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			strSido = dicParam.item("sido")

			query = "select distinct gugun,guguncd from dbo.zipcd where sidocd = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@sidocd", adVarChar, adParamInput, 10, strSido) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getZipGuCd = arrayList

		end function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 맥스웰 향기 주소로 해당회원 가져오기 (시,도 부분)
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function getZipSi()
			Dim db, strSql, rs, doc

			Set db = CreateObject("DAL.DBHelper")

			strSql = "select distinct(sido) from dongsuh.zip order by sido "

		query = strSql
			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF Then
				doc = false
			Else
				doc = rs.getRows()
			End If

			rs.Close
			Set rs = Nothing
			Set db = Nothing
			getZipSi = doc
		end function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 맥스웰 향기 주소로 해당회원 가져오기 (시,도 부분)
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		Public function getZipSiCd( ByVal DBHelper )
			'변수 선언
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅

			query = "select distinct sido, sidocd from dbo.zipcd order by sidocd "

			set objRs = DBHelper.ExecSQLReturnRS(query, nothing, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getZipSiCd = arrayList

		end function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 맥스웰 향기 구독회원 정보 변경(with memberNo)
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function updateUnityInfo(memberNo, strZip, strAddr1, strAddr2, strMobile, strEmail)
			Dim db, strSql, rs, doc

			strEmail = Replace(strEmail,"'","''")

			Set db = CreateObject("DAL.DBHelper")

			strSql = "update dongsuh.concours_data " & _
				 " SET	  zipcode = '"& strZip &"', "&_
				 "	address1  = '"& strAddr1 &"', "&_
				 "	address2  = '"& strAddr2 &"', "&_
				 "	     tel = '"& strMobile &"' "&_
				 " WHERE email = '"& strEmail &"' "

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))

			updateUnityInfo = true
			Set db = Nothing
		end function

				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			'맥스웰 향기 재등록 이벤트 참여자 정보 가져오기 : 중복 참여 여부
			'reader_no : strReaderNo
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			function getCountRegisterEvent2(ByVal strEmail)

				Dim db, strSql, strSubSql, rs, doc, strCols

				Set db = CreateObject("DAL.DBHelper")

				'strSql = " SELECT count(*) FROM dongsuh.maxevent_register WHERE email = '"& strEmail &"'"
				strSql = ""
				strSql = strSql & " SELECT count(*) FROM dongsuh.maxevent_register as A "
				strSql = strSql & " inner join dongsuh.maxwell_newsletter as B on B.email = A.email "
				strSql = strSql & " WHERE ISNULL (joinYn,'') = 'Y' "
				strSql = strSql & " AND A.email = '"& strEmail &"' "

		query = strSql
				Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))

				doc = rs(0)

				rs.Close
				Set rs = Nothing
				Set db = Nothing
				getCountRegisterEvent2 = doc

			end function



			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			'맥스웰 향기 재등록 이벤트 참여자 정보 가져오기 : 참여 정보 확인
			'reader_no : strReaderNo
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			function getRegisterEvent2(ByVal strEmail)

				Dim db, strSql, rs, doc

				Set db = CreateObject("DAL.DBHelper")

				'strSql = " SELECT top 1 reader_no, user_name, age, sex, zip_code, addr1, addr2, mobile_no, email FROM dongsuh.concours_data WHERE email = '"& strEmail &"'"
				strSql = strSql & "SELECT top 1 ISNULL(B.reader_no, '') as reader_no, ISNULL(A.kornm,'') as kornm, ISNULL(B.age,'') as age, "
				strSql = strSql & " ISNULL(B.sex,'') as sex, ISNULL(B.zip_code,'') as zip_code, ISNULL(B.addr1,'') as addr1, ISNULL(B.addr2,'') as addr2, "
				strSql = strSql & " ISNULL(B.mobile_no,'') as mobile_no, ISNULL(A.email,'') as email "
				strSql = strSql & " FROM dongsuh.dongsuh.concours_data as A "
				strSql = strSql & " left outer join dongsuh.MAXEVENT_REGISTER as B ON ISNULL(B.email,'') = ISNULL(A.email,'') "
				strSql = strSql & " where ISNULL(A.email,'')='" & strEmail & "'"

				Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))

				query = strSql

				If rs.EOF OR rs.BOF Then
					doc = false
				Else
					doc = rs.getRows()
				End If
				rs.Close
				Set rs = Nothing
				Set db = Nothing
				getRegisterEvent2 = doc

			end function

		''''''''''''''''''''''''''''''''
		'Ipin으로 전환
		''''''''''''''''''''''''''''''''
		Function changeToIpin(ByVal strIpinKey, ByVal strBirth, ByVal strUserID)
			Dim db, strSql

			If strIpinKey = "" Or strUserID = "" Then
				changeToIpin = False
				Exit Function
			End If

			strIpinKey		= Trim(Replace(strIpinKey,"'","''"))
			strBirth		= Trim(Replace(strBirth,"'","''"))
			strUserID		= Trim(Replace(strUserID,"'","''"))

			strSql = "UPDATE member SET "&_
					 "ipin_key = '" & strIpinKey & "', "&_
					 "ipin_yn = 'Y', "&_
					 "ipin_birth = '" & strBirth & "', "&_
					 "ipin_date = getdate() "&_
					 "WHERE ID = '" & strUserID & "'"

			query = strSql
			Set db = CreateObject("DAL.DBHelper")
			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))
			Set db = Nothing
			changeToIpin = True
		End Function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 회원정보 수정시 비밀번호 확인
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function checkUserPwd(strUserId, strPwd, strEnUserPwd)

			Dim db, strSql, rs, doc, strSql0, strAuthe

			Set db = CreateObject("DAL.DBHelper")

			strSql0 = "SELECT ISNULL(authe_chg_yn,'N') FROM  member WHERE id = '"&strUserId&"' AND member_yn = 'Y' "

			Set rs = db.RunSQLReturnRs(strSql0,"",db.GetConnStr(Const_DBConn))
			strAuthe = rs(0)
			rs.Close

		'	if strAuthe = "Y" then
				strSql = "SELECT id FROM member WHERE id = '" & strUserId & "' AND passwd = '"&strEnUserPwd&"' AND member_yn = 'Y' "
		'	else
		'		strSql = "SELECT id FROM member WHERE id = '" & strUserId & "' AND passwd = '" & strPwd & "'"
		'		strSql = strSql &" AND member_yn = 'Y' "
		'	end if

			'response.write strSql
			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF Then
				doc = False
			Else
				doc = True
			End If

			rs.Close
			Set rs = Nothing
			Set db = Nothing

			checkUserPwd = doc
		End function
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 회원정보 수정시 비밀번호 확인
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function checkUserPwd2(strUserId, strPwd)
		Public function checkUserPwd2( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			strUserId	=  dicParam.Item("userid")
			strPwd		=  dicParam.Item("passwd")

			query = " SELECT id FROM dongsuh.member WHERE id = ? AND passwd in( master.dbo.sha2( ?), ?)  AND member_yn = 'Y' "

			arrParams = Array( _
				DBHelper.MakeParam("@id", adVarChar, adParamInput, 20, strUserId), _
				DBHelper.MakeParam("@passwd", adVarChar, adParamInput, 100, strPwd), _
				DBHelper.MakeParam("@passwd", adVarChar, adParamInput, 100, strPwd) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = true
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			checkUserPwd2 = arrayList

		End function
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 탈퇴 요청한 회원의 정보를 삭제한다
		' 동서식품 전체 사이트에 대한 탈퇴일 경우에만 회원정보 삭제(delete)
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function deleteUserWithdrawInfo(strUserId)
		Public function deleteUserWithdrawInfo( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim query, arrParams

			userId = dicParam.Item("userId")

			query = " DELETE FROM dongsuh.member WHERE id = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@id", adVarChar, adParamInput, 20, userId) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

			deleteUserWithdrawInfo = true
		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 로그인시 회원정보 가져온다
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function getLoginInfo(ByVal strUserId, ByVal strUserPwd, ByVal strUserEncodePwd)
			dim db, strSql, rs, doc , strSql0, strSite, strAuthe

			Set db = CreateObject("DAL.DBHelper")

			strSql0 = "SELECT ISNULL(authe_chg_yn,'N') FROM  dongsuh.member WHERE id = '" & strUserId & "' AND member_yn = 'Y' "

			Set rs = db.RunSQLReturnRs(strSql0,"",db.GetConnStr(Const_DBConn))
			If rs.EOF OR rs.BOF then
				strAuthe = ""
			else
				strAuthe = rs(0)
			end if
			rs.Close

			strSql = " SELECT id, name_han, maxwall_yn, partner, email, site, authe_chg_yn FROM  dongsuh.member WHERE id = '" & strUserId & "' AND passwd in('" & strUserEncodePwd & "', '" & strUserPwd & "') AND member_yn = 'Y' "

			Set rs = db.RunSQLReturnRs(strSql,"",db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF then
				doc = "false"
			Else
				' 대소문자 구분이 안되므로 아이디를 직접 비교
				if trim(rs(0)) = trim(strUserId) then
					doc = rs.getRows()
				else
					doc = "false"
				end if
			End if

			rs.Close
			Set rs = Nothing
			Set db = Nothing

			getLoginInfo = doc

		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 로그인시 암호화적용된 로그인
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function getLoginInfo2(ByVal strUserId, ByVal strUserPwd)
		function getLoginInfo2( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim strUserId, strUserPwdEnc
			Dim strSql, arrayList, strAuthe, doc

			'변수값 세팅
			strUserId		=  dicParam.Item("userId")
			strUserPwdEnc	=  dicParam.Item("userPwdEnc")

			strSql = "SELECT ISNULL(authe_chg_yn,'N') FROM  dongsuh.member WHERE id = ? AND member_yn = 'Y' "

			arrParams = Array( _
				DBHelper.MakeParam("@id", adVarChar, adParamInput, 20, strUserId) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(strSql, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
				strAuthe = arrayList(0, 0)
			Else
				strAuthe = false
			end if

			objRs.close

			strSql = ""
			strSql = " SELECT id, name_han, maxwall_yn, partner, email, site, authe_chg_yn FROM  dongsuh.member WHERE id = ? AND passwd = master.dbo.sha2( ? ) AND member_yn = 'Y' "

			arrParams = Array( _
				DBHelper.MakeParam("@id", adVarChar, adParamInput, 20, strUserId), _
				DBHelper.MakeParam("@passwd", adVarChar, adParamInput, 150, strUserPwdEnc) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(strSql, arrParams, nothing)

			if (not objRs.EOF) then
				doc = objRs.getRows
			Else
				doc = false
			end if

			objRs.close
			set objRs = nothing

			getLoginInfo2 = doc

		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 회원정보를 가져온다
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function getMemberInfo(memberNo)
			Dim db, strSql, rs, doc


			Set db = CreateObject("DAL.DBHelper")

			strSql = ""
			strSql = strSql & "SELECT memberid,reader_no,user_name, zipcd,addr1,addr2,gender,age,mobile,email,reg_date,mod_date, stop_yn "
			strSql = strSql & " FROM dbo.member_maxwell WHERE reader_no <> '' and memberid = '" & memberNo & "' "

			query = strSql
			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF Then
				doc = false
			Else
				doc = rs.getRows()
			End If


			rs.Close
			Set rs = Nothing
			Set db = Nothing
			getMemberInfo = doc
		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 회원정보를 가져온다
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function getMemberInfo3(memberNo)
		Public function getMemberInfo3( ByVal DBHelper, ByVal dicParam )
			'변수 선언
			Dim intIdx
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			memberid	=  dicParam.Item("memberid")

			query = ""
			query = query & "SELECT memberid,reader_no,user_name, zipcd,addr1,addr2,gender,age,mobile,email,reg_date,mod_date, stop_yn "
			query = query & " FROM dbo.member_maxwell WHERE reader_no <> '' and memberid = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@memberid", adVarChar, adParamInput, 50, memberid) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getMemberInfo3 = arrayList

		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 복호화된 회원정보를 가져온다.
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function getMemberInfo2(strUserId)
		function getMemberInfo2( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim strUserId
			Dim query, objRs, arrParams
			Dim arrayList

			'변수값 세팅
			strUserId	=  dicParam.Item("userId")

			strSql = ""
			strSql = strSql & " EXEC dbo.SSP_OPENKEY "
			strSql = strSql & " SELECT id, passwd, name_han, name_eng, birth, bkubun, zip, address1, ISNULL (CONVERT(VARCHAR(MAX),DECRYPTBYKEY(address2)),'') AS address2, "
			strSql = strSql & " ISNULL (CONVERT(VARCHAR(MAX),DECRYPTBYKEY(hphone)),'') AS hphone, ISNULL (CONVERT(VARCHAR(MAX),DECRYPTBYKEY(sphone)),'') AS sphone, ISNULL (CONVERT(VARCHAR(MAX),DECRYPTBYKEY(hp)),'') AS hp, job, gcode, email, "
			strSql = strSql & " marry, mdate, mail_yn, maxwall_yn, member_yn, jdate, edate, partner, brand, site, (select TOP 1 reader_no from dbo.member_maxwell where dongsuh.member.id = dbo.member_maxwell.memberid) as reader_no, gender, lunar, authe_chg_yn "
			strSql = strSql & " FROM dongsuh.member WHERE id = ? AND  member_yn = 'Y' "
			strSql = strSql & " EXEC dbo.SSP_CLOSEKEY "

			arrParams = Array( _
				DBHelper.MakeParam("@id", adVarChar, adParamInput, 20, strUserId) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(strSql, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			getMemberInfo2 = arrayList
		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 우편번호 검색
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function getZip(strQueryWord)
			Dim db, strSql, rs, doc

			strQueryWord = Replace(strQueryWord,"'","''")

			Set db = CreateObject("DAL.DBHelper")
			strSql = "SELECT zipcode, sido, gugun, dong, bunji FROM dongsuh.zip WHERE dong like '" & strQueryWord & "%' ORDER BY dong"

			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))
			If rs.EOF OR rs.BOF Then
				doc = false
			Else
				doc = rs.getRows()
			End If
			rs.Close
			Set rs = Nothing
			Set db = Nothing
			getZip = doc
		end function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 우편번호 검색
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function getZipCode(strZipCode)
			Dim db, strSql, rs, doc

			strZipCode = Replace(strZipCode,"'","''")

			Set db = CreateObject("DAL.DBHelper")
			strSql = "SELECT sido, gugun, dong, bunji FROM zip WHERE zipcode = '" & strZipCode & "'"


			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))
			If rs.EOF OR rs.BOF Then
				doc = false
			Else
				doc = rs.getRows()
			End If
			rs.Close
			Set rs = Nothing
			Set db = Nothing
			getZipCode = doc
		end function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 검색형게시판 리스트 가져오기 :관리자 페이지/FRONT 전체글 검색
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		Function getMemberList(strQueryWord, strQueryType, iPage, iPageSize)
			Dim db, strSql, strSubSql, rs, doc

			strQueryType = Replace(strQueryType,"'","''")
			strQueryWord = Replace(strQueryWord,"'","''")

			If Trim(strQueryWord) = "" then
				strSubSql = ""
			Else
				strSubSql =  " AND " & strQueryType & " LIKE '%" & strQueryWord & "%' "
				'iPage = 1 ' 검색시 페이지 디폴트로 설정   '2010-05-11 주석처리
			End If

			Set db = CreateObject("DAL.DBHelper")

			strSql = "SELECT COUNT(*) FROM dongsuh.member WHERE member_yn = 'Y' " & strSubSql
			Set rs = db.RunSQLReturnRs(strSql,"",db.GetConnStr(Const_DBConn))
			count = rs(0)
			rs.Close

			strSql = ""
			strSql = strSql & " EXEC dbo.SSP_OPENKEY "
			strSql = strSql & "SELECT TOP " & iPageSize & "  id,passwd,ISNULL (name_han,'') AS name_han, isnull (name_eng,'') AS name_eng, "
			strSql = strSql & " birth,bkubun,zip,address1,"
			strSql = strSql & " ISNULL (CONVERT(VARCHAR(MAX),DECRYPTBYKEY(address2)),'') AS address2, ISNULL (CONVERT(VARCHAR(MAX),DECRYPTBYKEY(hphone)),'') AS hphone,ISNULL ( CONVERT(VARCHAR(MAX),DECRYPTBYKEY(sphone)),'') AS sphone,ISNULL ( CONVERT(VARCHAR(MAX),DECRYPTBYKEY(hp)),'') AS hp,job,"
			strSql = strSql & " gcode,email, marry,mdate,mail_yn,"
			strSql = strSql & " maxwall_yn,member_yn,jdate,edate,partner, "
			strSql = strSql & " gender, isnull (site, '' ) AS site "
			strSql = strSql & " FROM dongsuh.member WHERE member_yn = 'Y' and id NOT IN "
			strSql = strSql & " (SELECT TOP " & (iPage -1) * iPageSize & " id FROM dongsuh.member WHERE member_yn = 'Y' "
			strSql = strSql & " " &strSubSql& " ORDER BY jdate DESC)  "
			strSql = strSql & " " &strSubSql& "ORDER BY jdate DESC "
			strSql = strSql & " EXEC dbo.SSP_CLOSEKEY "

			'response.write strSql

			Set rs = db.RunSQLReturnRs(strSql,"",db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF then
				doc = false
			Else
				doc = rs.getRows()
			End if

			rs.Close
			Set rs = Nothing
			Set db = Nothing

			getMemberList = doc
		End function



		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 검색형게시판 리스트 가져오기 :페이징 기능 없음
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		Function getMemberListNoPaging()
			Dim db, strSql, strSubSql, rs, doc

			Set db = CreateObject("DAL.DBHelper")

			strSql = "SELECT id, name_han, name_eng, birth, zip,address1,address2,hphone,sphone,hp,job, email, marry,mdate,mail_yn,maxwall_yn,member_yn,jdate, gender, site  "
			strSql = strSql & " FROM dongsuh.member ORDER BY jdate DESC "

			Set rs = db.RunSQLReturnRs(strSql,"",db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF then
				doc = false
			Else
				doc = rs.getRows()
			End if

			rs.Close
			Set rs = Nothing
			Set db = Nothing

			getMemberListNoPaging = doc
		End function


		'===================================================================
		' 1) 로그인 체크 시, 아이디가 존재하는지 체크
		' 2) index페이지에서 아이디가 있을 경우, 어떤 사이트에 가입했는지 체크한다.
		' create day : 2010-02-11
		'===================================================================
		'Function getCheckId(strUserId)
		Function getCheckId ( ByVal DBHelper, ByVal dicParam )
			'변수 선언
			Dim strUserId
			Dim db, strSql, rs, doc

			'변수값 세팅
			strUserId		=  dicParam.Item("userId")

			strSql = "SELECT id, site , authe_chg_yn, passwd "
			strSql = strSql & " FROM dongsuh.member WHERE id = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@id", adVarchar, adParamInput, 20, strUserId) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(strSql, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getCheckId = arrayList

		End Function


		'===================================================================
		' 1) 로그인 체크 시, 아이디가 존재하는지 체크
		' 2) index페이지에서 아이디가 있을 경우, 어떤 사이트에 가입했는지 체크한다.
		' create day : 2010-02-11
		'===================================================================
		'Function getCheckId2(strUserId,strUserPwd)
		Function getCheckId2 ( ByVal DBHelper, ByVal dicParam )
			'변수 선언
			Dim strUserId, strUserPwd
			Dim db, strSql, rs, doc

			'변수값 세팅
			strUserId		=  dicParam.Item("userId")
			strUserPwd		=  dicParam.Item("userPwdEnc")

			strSql= ""
			strSql = "SELECT id, site , authe_chg_yn, passwd "
			strSql = strSql & " FROM dongsuh.member WHERE id = ? and passwd in (master.dbo.sha2('" & strUserPwd & "'), '" & strUserPwd & "')"

			arrParams = Array( _
				DBHelper.MakeParam("@id", adVarchar, adParamInput, 20, strUserId) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(strSql, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getCheckId2 = arrayList

		End Function


		'===================================================================
		' 1) 암호화 된 패스워드 불러오기
		' create day : 2012-11-16
		'===================================================================
		Function getCheckPwd(strUserPwd)
			Dim db, strSql, rs, doc

			Set db = CreateObject("DAL.DBHelper")

			strSql = "SELECT [master].dbo.sha2('passwd') "
			strSql = strSql & " FROM dongsuh.member WHERE id ='"&strUserPwd&"'"

			Set rs = db.RunSQLReturnRs(strSql,"",db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF then
				doc = false
			Else
				doc = rs.getrows()
			End if

			rs.Close
			Set rs = Nothing
			Set db = Nothing

			getCheckPwd = doc
		End Function

		function getAuthAdmin(strUserId, strPasswd)

			Dim db, strSql, rs, doc

			strUserId = Replace(strUserId,"'","''")
			strPasswd = Replace(strPasswd,"'","''")

			Set db = CreateObject("DAL.DBHelper")

			strSql = "select admin_id, admin_pw, admin_name, tel, hp, email, group_seq, join_date from DONGSUH_ADMIN_MEMBER " _
					& " where admin_id = '" & strUserId & "' and admin_pw = '" & strPasswd & "'"

			'response.write strSql


			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))
			If rs.EOF OR rs.BOF Then
				doc = false
			Else
				doc = rs.getRows()
			End If
			rs.Close
			Set rs = Nothing
			Set db = Nothing
			getAuthAdmin = doc

		end function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 메일발송대상자 csv
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function getMemberemailYlist()
			Dim db, strSql, rs, doc



			Set db = CreateObject("DAL.DBHelper")

			strSql = "SELECT  id, name_han, email, jdate, CONVERT (DATETIME, edate)  FROM dongsuh.member WHERE  mail_yn = 'Y' "

			query = strSql
			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))
			If rs.EOF OR rs.BOF Then
				doc = false
			Else
				doc = rs.getRows()
			End If
			rs.Close
			Set rs = Nothing
			Set db = Nothing
			getMemberemailYlist = doc
		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 비밀번호 변경 처리
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function getCheckDuration(ByVal strUserId)
		function getCheckDuration( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim strUserId
			Dim strSql, arrayList, strAuthe

			'변수값 세팅
			strUserId	=  dicParam.Item("userId")

			strSql = strSql & "SELECT CASE WHEN TAG = 'S' THEN CASE WHEN GETDATE() > DATEADD(MONTH,6,MODIFYDATE) THEN 'N'"
			strSql = strSql & "                                     ELSE 'Y' END"
			strSql = strSql & "            ELSE CASE WHEN GETDATE() > DATEADD(MONTH,1,MODIFYDATE) THEN 'N'"
			strSql = strSql & "                      ELSE 'Y' END"
			strSql = strSql & "            END"
			strSql = strSql & "  from dbo.PWDHistory"
			strSql = strSql & " where 1 = 1  "
			strSql = strSql & "   and ID = ? "
			strSql = strSql & "   and IDSEQ = ( SELECT  MAX(IDSEQ)"
			strSql = strSql & "                   FROM  dbo.PWDHistory"
			strSql = strSql & "                  WHERE  1 = 1"
			strSql = strSql & "                    AND  ID = ? "
			strSql = strSql & "                )"

			arrParams = Array( _
				DBHelper.MakeParam("@id", adVarChar, adParamInput, 20, strUserId), _
				DBHelper.MakeParam("@id", adVarChar, adParamInput, 20, strUserId) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(strSql, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
				strAuthe = arrayList(0, 0)
			Else
				strAuthe = false
			end if

			objRs.close
			set objRs = nothing

			getCheckDuration = strAuthe

		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 아이디 중북 여부 체크
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function IsMember(strUserId)
		Public function IsMember( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim strUserId
			Dim strSql, arrayList, strAuthe

			'변수값 세팅
			strUserId	=  dicParam.Item("userId")

			strSql = "SELECT id FROM dongsuh.member WHERE id = ? AND member_yn = 'Y' "

			arrParams = Array( _
				DBHelper.MakeParam("@id", adVarChar, adParamInput, 20, strUserId) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(strSql, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = true
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			IsMember = arrayList

		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 이름과 주민번호로 기존회원 여부 체크
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function IsRegistMember(strUserNm, strNo)
			Dim db, strSql, rs, doc

			strUserNm = Replace(strUserNm,"'","''")

			Set db = CreateObject("DAL.DBHelper")

			strSql = "SELECT id FROM dongsuh.member WHERE name_han = '" & strUserNm & "' AND jno = '"&strNo&"' AND member_yn = 'Y' "

			query = strSql

			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF Then
				doc = False
			Else
				doc = True
			End If

			rs.Close
			Set rs = Nothing
			Set db = Nothing

			IsRegistMember = doc
		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 탈퇴 테이블에 탈퇴 회원정보 등록한다
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function insertUserWithdraw(strUserId, strUserName, strReason, strSite)
		Public function insertUserWithdraw( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intIdx
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			strUserId	=  dicParam.Item("userId")
			strUserName	=  dicParam.Item("userName")
			strReason	=  dicParam.Item("reason")
			strSite		=  dicParam.Item("site")

			query = " INSERT INTO member_withdraw(id ,name_han  ,reason  ,withdraw_site  ,withdraw_date) "
			query = query & " SELECT id, name_han, ?, ?, getdate() FROM dongsuh.member where id = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@reason", adVarChar, adParamInput, 1, strReason), _
				DBHelper.MakeParam("@withdraw_site", adVarChar, adParamInput, 50, strSite), _
				DBHelper.MakeParam("@id", adVarChar, adParamInput, 16, strUserId) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

			insertUserWithdraw = true
		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 회원정보 등록
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function insertMember(strUserId, strPwd, strUserName, strJno, strBirth, strLunar, strZip, strAddress1, strAddress2, strHpone, strSphone, strHp, strJob, strSchool, strEmail, strMarryYn, strMarryDate, strMailYn, strMaxwell, strMemberYn, strPartner, strAuthe,  strGender, strSite )
			Dim db, strSql,  rs, doc, errCount

			Set db = CreateObject("DAL.DBHelper")

			strSql = " INSERT INTO dongsuh.member "
			strSql = strSql & " (ID,PASSWD ,NAME_HAN, NAME_ENG, JNO ,BIRTH, BKUBUN ,ZIP "
			strSql = strSql & " ,ADDRESS1,ADDRESS2 ,HPHONE ,SPHONE,HP,JOB, GCODE ,EMAIL,MARRY "
			strSql = strSql & " ,MDATE,MAIL_YN,MAXWALL_YN,MEMBER_YN,jdate , partner, "
			strSql = strSql & "  authe_chg_yn ,gender,site) "
			strSql = strSql & " VALUES "
			strSql = strSql & " ('"&strUserId&"', '" & strPwd & "', '"&strUserName&"','' , '" & strJno & "', '"&strBirth&"', '"&strLunar&"', '"&strZip&"',  "
			strSql = strSql & " '"&strAddress1&"', '"&strAddress2&"', '"&strHpone&"', '"&strSphone&"', '"&strHp&"', '"&strJob&"', '"&strSchool&"', '"&strEmail&"',   "
			strSql = strSql & " '"&strMarryYn&"', '"&strMarryDate&"', '"&strMailYn&"', '"&strMaxwell&"', '"&strMemberYn&"', getdate(),  '"&strPartner&"',  "
			strSql = strSql & " '"&strAuthe&"','"&strGender&"', '"&strSite&"') "

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))

			Set db = Nothing

			insertMember = true
		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 아이디 찾기
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function id_find(strUserName, strNo, strEncodeNo)
		function id_find( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim query, objRs, arrParams
			Dim strUserName, strNo, strEncodeNo

			'변수값 세팅
			strUserName	= dicParam.item("userName")
			strNo		= dicParam.item("jno")
			strEncodeNo	= dicParam.item("encodeNo")

			if strNo = "" then
				strAuthe = false
			else
				strAuthe = "N"
			end if

			if strAuthe = "N" then

				strSql = "SELECT id, name_han FROM  member WHERE name_han = ? and JNO_DECODE = ? "

				arrParams = Array( _
					DBHelper.MakeParam("@name_han", adVarChar, adParamInput, 20, strUserName), _
					DBHelper.MakeParam("@jno_decode", adVarChar, adParamInput, 20, strUserName) _
				)

				set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			end if


			dim db, strSql, rs, doc , strSql0, strAuthe
			Set db = CreateObject("DAL.DBHelper")

			' 실명인증인 완료된 회원인지 체크
			' 실명인증된 회원은 주민번호가 암호화되어있음


			if strNo = "" then
				strAuthe = false
			else
				strAuthe = "N"
			end if

			if strAuthe = "N" then

				strSql = "SELECT id, name_han FROM  member WHERE name_han='"& strUserName &"' and JNO_DECODE='"& strNo  &"' "
			end if

		query = strSql
			Set rs = db.RunSQLReturnRs(strSql,"",db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF then
				doc = false
			Else
				doc = rs.getRows()
			End if

			rs.Close
			Set rs = Nothing
			Set db = Nothing

			id_find = doc

		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 회원정보 등록 - ipin 적용
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function insertMemberIpin(strUserId, strPwd, strUserName, strJno, strBirth, strLunar, strZip, strAddress1, strAddress2, strHpone, strSphone, strHp, strJob, strSchool, strEmail, strMarryYn, strMarryDate, strMailYn, strMaxwell, strMemberYn, strPartner, strAuthe,  strGender, strSite, strIpinKey)
			Dim db, strSql,  rs, doc, errCount

			Set db = CreateObject("DAL.DBHelper")

			strSql = " INSERT INTO member "
			strSql = strSql & " (ID,PASSWD ,NAME_HAN, NAME_ENG, JNO ,BIRTH, BKUBUN ,ZIP "
			strSql = strSql & " ,ADDRESS1,ADDRESS2 ,HPHONE ,SPHONE,HP,JOB, GCODE ,EMAIL,MARRY "
			strSql = strSql & " ,MDATE,MAIL_YN,MAXWALL_YN,MEMBER_YN,jdate , partner, "
			strSql = strSql & "  authe_chg_yn, gender, site, ipin_key, ipin_yn, ipin_date) "
			strSql = strSql & " VALUES "
			strSql = strSql & " ('"&strUserId&"', '" & strPwd & "', '"&strUserName&"','' , '" & strJno & "', '"&strBirth&"', '"&strLunar&"', '"&strZip&"',  "
			strSql = strSql & " '"&strAddress1&"', '"&strAddress2&"', '"&strHpone&"', '"&strSphone&"', '"&strHp&"', '"&strJob&"', '"&strSchool&"', '"&strEmail&"',   "
			strSql = strSql & " '"&strMarryYn&"', '"&strMarryDate&"', '"&strMailYn&"', '"&strMaxwell&"', '"&strMemberYn&"', getdate(),  '"&strPartner&"',  "
			strSql = strSql & " '"&strAuthe&"','"&strGender&"', 'D|S|C|B|' , '"&strIpinKey&"', 'Y', getdate()) "

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))

			Set db = Nothing

			insertMemberIpin = true
		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 회원정보 등록 - ipin 적용
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function insertMemberIpin2(strUserId, strPwd, strUserName, strJno, strBirth, strLunar, strZip, strAddress1, strAddress2, strHpone, strSphone, strHp, strJob, strSchool, strEmail, strMarryYn, strMarryDate, strMailYn, strMaxwell, strMemberYn, strPartner, strAuthe,  strGender, strSite, strIpinKey, strIpinBirth)
			Dim db, strSql,  rs, doc, errCount

			Set db = CreateObject("DAL.DBHelper")

			strSql = " INSERT INTO member "
			strSql = strSql & " (ID,PASSWD ,NAME_HAN, NAME_ENG, JNO ,BIRTH, BKUBUN ,ZIP "
			strSql = strSql & " ,ADDRESS1,ADDRESS2 ,HPHONE ,SPHONE,HP,JOB, GCODE ,EMAIL,MARRY "
			strSql = strSql & " ,MDATE,MAIL_YN,MAXWALL_YN,MEMBER_YN,jdate , partner, "
			strSql = strSql & "  authe_chg_yn, gender, site, ipin_key, ipin_yn, ipin_date, ipin_birth) "
			strSql = strSql & " VALUES "
			strSql = strSql & " ('"&strUserId&"', '" & strPwd & "', '"&strUserName&"','' , '" & strJno & "', '"&strBirth&"', '"&strLunar&"', '"&strZip&"',  "
			strSql = strSql & " '"&strAddress1&"', '"&strAddress2&"', '"&strHpone&"', '"&strSphone&"', '"&strHp&"', '"&strJob&"', '"&strSchool&"', '"&strEmail&"',   "
			strSql = strSql & " '"&strMarryYn&"', '"&strMarryDate&"', '"&strMailYn&"', '"&strMaxwell&"', '"&strMemberYn&"', getdate(),  '"&strPartner&"',  "
			strSql = strSql & " '"&strAuthe&"','"&strGender&"', '"&strSite&"' , '"&strIpinKey&"', 'Y', getdate() , '"&strIpinBirth&"') "

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))

			Set db = Nothing

			insertMemberIpin2 = true
		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 회원정보 등록 - ipin 적용
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function insertMemberIpinTest2(strUserId, strPwd, strUserName, strJno, strBirth, strLunar, strZip, strAddress1, strAddress2, strHpone, strSphone, strHp, strJob, strSchool, strEmail, strMarryYn, strMarryDate, strMailYn, strMaxwell, strMemberYn, strPartner, strAuthe,  strGender, strSite, strIpinKey)
		Public function insertMemberIpinTest2( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim query, arrParams

			'변수값 세팅
			strUserId		= dicParam.Item("userId")
			strPwd			= dicParam.Item("passWd")
			strEnPwd		= dicParam.Item("enPassWd")
			strUserName		= dicParam.Item("userName")
			strBirth		= dicParam.Item("birth")
			strLunar		= dicParam.Item("lunar")
			strZip			= dicParam.Item("zip")
			strAddress1		= dicParam.Item("address1")
			strAddress2		= dicParam.Item("address2")
			strHp			= dicParam.Item("hp")
			strJob			= dicParam.Item("job")
			strSchool		= dicParam.Item("school")
			strEmail		= dicParam.Item("email")
			strMarryYn		= dicParam.Item("marryYn")
			strMaxwell		= dicParam.Item("maxwell")
			strMemberYn		= dicParam.Item("memberYn")
			strPartner		= dicParam.Item("partner")
			strAuthe		= dicParam.Item("authe")
			strGender		= dicParam.Item("gender")
			strSite			= dicParam.Item("site")
			strIpinKey		= dicParam.Item("ipinKey")

			query = ""
			query = query & "EXEC dbo.SSP_OPENKEY "
			query = query & " INSERT INTO dongsuh.member "
			query = query & " (ID, PASSWD, NAME_HAN, NAME_ENG,"
			query = query & "  BIRTH, BKUBUN ,ZIP ,ADDRESS1,ADDRESS2,"
			query = query & "  HPHONE, SPHONE,HP,JOB, GCODE,"
			query = query & "  EMAIL,MARRY, MDATE, MAIL_YN, MAXWALL_YN,"
			query = query & "  MEMBER_YN, jdate, partner, authe_chg_yn, gender, "
			query = query & "  site, ipin_key, ipin_yn, ipin_date) "
			query = query & " VALUES "
			query = query & " (?, master.dbo.sha2(?), ?,'',?,"
			query = query & " ?, ?, ?, EncryptByKey(Key_GUID('Dongsuh_K'), ?), EncryptByKey(Key_GUID('Dongsuh_K'),''),"
			query = query & " EncryptByKey(Key_GUID('Dongsuh_K'),''), EncryptByKey(Key_GUID('Dongsuh_K'), ?), ?, ?, ?,   "
			query = query & " '', '', ?, ?, ?, getdate(),  ?,  "
			'query = query & " ?, ?, 'D|S|C|B|' , ?, 'Y', getdate()) "
			query = query & " ?, ?, ?, ?, 'Y', getdate()) "
			query = query & "EXEC dbo.SSP_CLOSEKEY "

			query = ""
			query = query & "	EXEC dbo.SSP_OPENKEY "
			query = query & " 	INSERT INTO dongsuh.member ("
			query = query & " 		ID, PASSWD, NAME_HAN, NAME_ENG, BIRTH, "
			query = query & "  		BKUBUN ,ZIP ,ADDRESS1,ADDRESS2, HPHONE, "
			query = query & "  		SPHONE,HP,JOB, GCODE, EMAIL, "
			query = query & "  		MARRY, MDATE, MAIL_YN, MAXWALL_YN, MEMBER_YN, "
			query = query & "  		jdate, partner, authe_chg_yn, gender, lunar, site, "
			query = query & "  		ipin_key, ipin_yn, ipin_date"
			query = query & " 	) VALUES ("

			query = query & "		?, master.dbo.sha2(?), ?,'', ?, "
			query = query & "		?, ?, ?, EncryptByKey(Key_GUID('Dongsuh_K'),?), EncryptByKey(Key_GUID('Dongsuh_K'),''), "
			query = query & "		EncryptByKey(Key_GUID('Dongsuh_K'),''), EncryptByKey(Key_GUID('Dongsuh_K'),?), ?, ?, ?, "
			query = query & "		'', '', ?, ?, ?, "
			query = query & "		getdate(), ?, ?, ?, ?, ?, "
			query = query & "		?, 'Y', getdate() "
			query = query & "	) "
			query = query & 	"EXEC dbo.SSP_CLOSEKEY "


			arrParams = Array( _
				DBHelper.MakeParam("@id", adVarChar, adParamInput, 20, strUserId), _
				DBHelper.MakeParam("@passwd", adVarChar, adParamInput, 150, strEnPwd), _
				DBHelper.MakeParam("@name_han", adVarChar, adParamInput, 20, strUserName), _
				DBHelper.MakeParam("@birth", adVarChar, adParamInput, 10, strBirth), _
				DBHelper.MakeParam("@bkubun", adVarChar, adParamInput, 10, strLunar), _
				DBHelper.MakeParam("@zip", adVarChar, adParamInput, 7, strZip), _
				DBHelper.MakeParam("@address1", adVarChar, adParamInput, 150, strAddress1), _
				DBHelper.MakeParam("@address2", adVarChar, adParamInput, 140, strAddress2), _
				DBHelper.MakeParam("@hp", adVarChar, adParamInput, 70, strHp), _
				DBHelper.MakeParam("@job", adVarChar, adParamInput, 2, strJob), _
				DBHelper.MakeParam("@gcode", adVarChar, adParamInput, 5, strSchool), _
				DBHelper.MakeParam("@email", adVarChar, adParamInput, 40, strEmail), _
				DBHelper.MakeParam("@mail_yn", adVarChar, adParamInput, 1, strMailYn), _
				DBHelper.MakeParam("@maxwall_yn", adVarChar, adParamInput, 1, strMaxwell), _
				DBHelper.MakeParam("@member_yn", adVarChar, adParamInput, 1, strMemberYn), _
				DBHelper.MakeParam("@partner", adVarChar, adParamInput, 1, strPartner), _
				DBHelper.MakeParam("@authe_chg_yn", adVarChar, adParamInput, 1, strAuthe), _
				DBHelper.MakeParam("@gender", adVarChar, adParamInput, 1, strGender), _
				DBHelper.MakeParam("@lunar", adVarChar, adParamInput, 1, strLunar), _
				DBHelper.MakeParam("@site", adVarChar, adParamInput, 10, strSite), _
				DBHelper.MakeParam("@ipin_key", adVarChar, adParamInput, 88, strIpinKey) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

			insertMemberIpinTest2 = true

		End function


		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 회원정보 등록 -pwdhistory 등록
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function insertPwd(strUserId)
		Public function insertPwd( ByVal DBHelper, ByVal dicParam )
			'변수 선언
			Dim query, arrParams

			'변수값 세팅
			strUserId		=  dicParam.Item("userId")

			query = ""
			query = query & "INSERT  INTO dbo.PWDHistory "
			query = query & "SELECT  ID"
			query = query & "       ,'S'"
			query = query & "       ,passwd"
			query = query & "       ,GETDATE()"
			query = query & "  FROM  dongsuh.member"
			query = query & " WHERE  1 = 1"
			query = query & "   AND  ID = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@ID", adVarChar, adParamInput, 20, strUserId) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

			insertPwd = true
		End function


		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 이름과 주민번호로 기존회원 여부 체크
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function IsRegistMemberBirth(strUserNm, strBirth)
		Public function IsRegistMemberBirth( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim strUserName, strBirth
			Dim strSql, objRs, arrParams

			'변수값 세팅
			strUserName	= dicParam.Item("userName")
			strBirth	= dicParam.Item("birth")

			strSql = " SELECT id FROM  dongsuh.member WHERE name_han = ? and birth = ? and member_yn = 'Y' "

			arrParams = Array( _
				DBHelper.MakeParam("@name_han", adVarChar, adParamInput, 20, strUserName), _
				DBHelper.MakeParam("@birth", adVarChar, adParamInput, 10, strBirth) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(strSql, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = true
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			IsRegistMemberBirth = arrayList

		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 아이디 찾기 - ipin
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function id_find_ipin(strUserName, strBirth)
		function id_find_ipin( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim strUserName, strBirth
			Dim strSql, objRs, arrParams

			'변수값 세팅
			strUserName	= dicParam.Item("userName")
			strBirth	= dicParam.Item("birth")

			strSql = "SELECT id, name_han FROM  dongsuh.member WHERE name_han = ? and birth = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@name_han", adVarChar, adParamInput, 20, strUserName), _
				DBHelper.MakeParam("@birth", adVarChar, adParamInput, 10, strBirth) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(strSql, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			id_find_ipin = arrayList

		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 비밀번호 찾기
		' strNo : 주민번호
		' strEncodeNo : 암호화된 주민번호
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function pw_find(strUserId, strUserName, strNo, strEncodeNo)

			dim db, strSql, rs, doc ,strSql0, strAuthe
			Set db = CreateObject("DAL.DBHelper")

			' 실명인증인 완료된 회원인지 체크
			' 실명인증된 회원은 주민번호가 암호화되어있음
			strSql0 = "SELECT ISNULL(authe_chg_yn,'N') FROM  dongsuh.member WHERE id = '"&strUserId&"' AND name_han = '"&strUserName&"' AND  member_yn = 'Y' "

			Set rs = db.RunSQLReturnRs(strSql0,"",db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF then
				strAuthe = ""
			else
				strAuthe = rs(0)
			end if
			rs.Close

			if strAuthe = "N" then
				strSql = "SELECT id, name_han, email FROM  member WHERE id = '"& strUserId &"' and name_han ='"& strUserName &"' and jno = '"& strNo &"' "

			elseif strAuthe = "Y" then
				strSql = "SELECT id, name_han, email FROM  member WHERE id = '"& strUserId &"' and name_han ='"& strUserName &"' and jno = '"& strEncodeNo &"' "
			else
				strSql = "SELECT id, name_han, email FROM  member WHERE id = '"& strUserId &"' and name_han ='"& strUserName &"' and jno = '"& strNo &"' "
			end if

			Set rs = db.RunSQLReturnRs(strSql,"",db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF then
				doc = "false"
			Else
				doc = rs.getRows()
			End if

			rs.Close
			Set rs = Nothing
			Set db = Nothing

			pw_find = doc

		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 비밀번호 찾기
		' strNo : 주민번호
		' strEncodeNo : 암호화된 주민번호
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function pw_find2(strUserId, strUserName)

			dim db, strSql, rs, doc ,strSql0, strAuthe
			Set db = CreateObject("DAL.DBHelper")

			' 실명인증인 완료된 회원인지 체크
			' 실명인증된 회원은 주민번호가 암호화되어있음
			strSql0 = "SELECT ISNULL(authe_chg_yn,'N') FROM  dongsuh.member WHERE id = '"&strUserId&"' AND name_han = '"&strUserName&"' AND  member_yn = 'Y' "

			Set rs = db.RunSQLReturnRs(strSql0,"",db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF then
				strAuthe = ""
			else
				strAuthe = rs(0)
			end if
			rs.Close

			if strAuthe = "N" then
				strSql = "SELECT id, name_han, email FROM  dongsuh.member WHERE id = '"& strUserId &"' and name_han ='"& strUserName &"' "

			elseif strAuthe = "Y" then
				strSql = "SELECT id, name_han, email FROM  dongsuh.member WHERE id = '"& strUserId &"' and name_han ='"& strUserName &"' "
			else
				strSql = "SELECT id, name_han, email FROM  dongsuh.member WHERE id = '"& strUserId &"' and name_han ='"& strUserName &"' "
			end if

			Set rs = db.RunSQLReturnRs(strSql,"",db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF then
				doc = "false"
			Else
				doc = rs.getRows()
			End if

			rs.Close
			Set rs = Nothing
			Set db = Nothing

			pw_find2 = doc

		End function


		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 비밀번호 찾기 회원 비밀번호 수정
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function pw_update(passwd, strUserId)
			Dim db, strSql, rs, doc

			Set db = CreateObject("DAL.DBHelper")

			strSql = " UPDATE member SET passwd = '"& passwd &"' where id = '"& strUserId &"' "

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))

			Set db = Nothing

			pw_update = true
		End function


		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 비밀번호 찾기 회원 비밀번호 수정
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function pw_update2(passwd, strUserId)
		function pw_update2( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim passwd, strUserId
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			strUserId	=  dicParam.Item("userId")
			passwd		=  dicParam.Item("passWd")

			strSql = " UPDATE dongsuh.member SET passwd = master.dbo.sha2( ? ) where id = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@passwd", adVarChar, adParamInput, 150, passwd), _
				DBHelper.MakeParam("@id", adVarChar, adParamInput, 20, strUserId) _
			)

			call DBHelper.ExecSQL(strSql, arrParams, nothing)

			strSql1 = ""
			strSql1 = strSql1 & " INSERT INTO PWDHistory "
			strSql1 = strSql1 & " VALUES ( ?, 'S',  master.dbo.sha2( ? ),GETDATE() ) "

			arrParams = Array( _
				DBHelper.MakeParam("@id", adVarChar, adParamInput, 20, strUserId), _
				DBHelper.MakeParam("@passwd", adVarChar, adParamInput, 150, passwd) _
			)

			call DBHelper.ExecSQL(strSql1, arrParams, nothing)

			pw_update2 = true

		End function


		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 비밀번호 찾기 회원 비밀번호 수정
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function pw_update3(strUserId)
			Dim db, strSql, rs, doc, strSql1

			Set db = CreateObject("DAL.DBHelper")

			strSql1 = ""
			strSql1 = strSql1 & "INSERT  INTO dbo.PWDHistory "
			strSql1 = strSql1 & "SELECT  ID"
			strSql1 = strSql1 & "       ,'O'"
			strSql1 = strSql1 & "       ,passwd"
			strSql1 = strSql1 & "       ,GETDATE()"
			strSql1 = strSql1 & "  FROM  dongsuh.member"
			strSql1 = strSql1 & " WHERE  1 = 1"
			strSql1 = strSql1 & "   AND  ID = '"& strUserId &"' "

			Call db.RunSQL(strSql1,"", db.GetConnStr(Const_DBConn))

			Set db = Nothing

			pw_update3 = true
		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 비밀번호 찾기
		' strNo : 주민번호
		' strEncodeNo : 암호화된 주민번호
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function pw_find_ipin(strUserId, strNiceNm, strBirth)
		function pw_find_ipin( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim strUserId, strNiceNm, strBirth
			Dim strSql, objRs, arrParams
			Dim arrayList

			'변수값 세팅
			strUserId	= dicParam.Item("userId")
			strNiceNm	= dicParam.Item("niceNm")
			strBirth	= dicParam.Item("birth")

			strSql = "SELECT id, name_han, email FROM  member WHERE id = ? and name_han = ? and birth = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@id", adVarChar, adParamInput, 20, strUserId), _
				DBHelper.MakeParam("@name_han", adVarChar, adParamInput, 20, strNiceNm), _
				DBHelper.MakeParam("@birth", adVarChar, adParamInput, 10, strBirth) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(strSql, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			pw_find_ipin = arrayList

		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 암호변경 조건 체크
		' 2012.11.22 추가
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function ProcPwdChek (strUserId, strPwd,strEnPwd, intMinLen, intMaxLevel, intMaxReuse)
		function ProcPwdChek ( ByVal DBHelper, ByVal dicParam )
			'변수 선언
			Dim strUserId, strPwd, strEnPwd, intMinLen, intMaxLevel, intMaxReuse, intResultCode
			Dim strDecodePW
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			strUserId	= dicParam.item("userId")
			strPwd		= dicParam.item("passWd")
			strEnPwd	= dicParam.item("enPassWd")
			intMinLen	= dicParam.item("minLen")
			intMixLevel	= dicParam.item("mixLevel")
			intMaxReuse	= dicParam.item("maxReuse")

			strDecodePW = ""

			For j=1 To Len(strPwd)

				If Asc(mid(strPwd, j, 1)) = 0 Then
					count = count + 1
				else
					strDecodePW = strDecodePW  + mid(strPwd, j, 1)

				End If
			Next

			strDecodePW = replace (strDecodePW, "'","")

			arrParams = Array( _
				DBHelper.MakeParam("@ID", adVarChar, adParamInput, 100, strUserId), _
				DBHelper.MakeParam("@PWD", adVarChar, adParamInput, 100, strPwd), _
				DBHelper.MakeParam("@ENPWD", adVarChar, adParamInput, 100, strDecodePW), _
				DBHelper.MakeParam("@MINLEN", adInteger, adParamInput, 4, intMinLen), _
				DBHelper.MakeParam("@MIXLEVEL", adInteger, adParamInput, 4, intMixLevel), _
				DBHelper.MakeParam("@MAXREUSE", adInteger, adParamInput, 4, intMaxReuse), _
				DBHelper.MakeParam("@RESULTCODE", adInteger, adParamOutput, , 0) _
			)

			Call DBHelper.ExecSP("dbo.ProcPasswordChek", arrParams, nothing)

			intResultCode = DBHelper.GetValue(arrParams, "@RESULTCODE")

			ProcPwdChek = intResultCode

		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 암호변경 조건 체크 (재발급)
		' 2013.03.22 추가
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function ProcPwdReiChek (strUserId,strDecodePW, strEnPwd, intMinLen, intMaxLevel, intMaxReuse)

			Dim intResultCd, strResultCd, strSql, db, rs, j, count

			Set db = CreateObject("DAL.DBHelper")

			strSql = ""
			strSql = strSql & " DECLARE @intResultCd int"
			strSql = strSql & " EXEC dbo.ProcPasswordChek '" & strUserId & "','" & strDecodePW
			strSql = strSql & "', '" & strEnPwd & "'," & intMinLen & "," & intMaxLevel & "," & intMaxReuse & "," & "@intResultCd output"
			strSql = strSql & " SELECT @intResultCd"

		'response.write("strSq = " & strSql )
		'response.end

			Set rs = db.RunSQLReturnRs(strSql,"",db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF then
				strResultCd = ""
			else
				strResultCd = rs(0)
			end if

			ProcPwdReiChek = strResultCd

		End function


		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 탈퇴 요청한 회원의 정보를 수정한다
		' 동서식품 일부 사이트에 대한 탈퇴일 경우에는 회원정보 가입 사이트 정보만 수정(update)
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function updateUserWithdrawInfo(strUserId, strSite)
		Public function updateUserWithdrawInfo( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intIdx
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			strUserId	=  dicParam.Item("userId")
			strSite		=  dicParam.Item("site")

			query = " UPDATE member SET site = ? WHERE id = ?  "

			arrParams = Array( _
				DBHelper.MakeParam("@site", adVarChar, adParamInput, 10, strSite), _
				DBHelper.MakeParam("@id", adVarChar, adParamInput, 20, strUserId) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

			updateUserWithdrawInfo = true

		End function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 회원정보 수정
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		function updateMember(strUserId, strPwd, strBirth, strLunar, strZip, strAddress1, strAddress2, strHpone, strSphone, strHp, strJob, strSchool, strEmail, strMarryYn, strMarryDate, strMailYn, strSite )
			Dim db, strSql,  rs, doc, errCount

			Set db = CreateObject("DAL.DBHelper")

			strSql = " UPDATE member "
			strSql = strSql & " SET BIRTH = '"&strBirth&"' "
			strSql = strSql & " ,passwd = '"&strPwd&"' "
			strSql = strSql & " ,BKUBUN = '"&strLunar&"' "
			strSql = strSql & " ,ZIP =  '"&strZip&"' "
			strSql = strSql & " ,ADDRESS1 = '"&strAddress1&"'  "
			strSql = strSql & " ,ADDRESS2 = '"&strAddress2&"'  "
			strSql = strSql & " ,HPHONE = '"&strHpone&"' "
			strSql = strSql & " ,SPHONE = '"&strSphone&"' "
			strSql = strSql & " ,HP = '"&strHp&"' "
			strSql = strSql & " ,JOB = '"&strJob&"' "
			strSql = strSql & " ,GCODE = '"&strSchool&"' "
			strSql = strSql & " ,EMAIL = '"&strEmail&"' "
			strSql = strSql & " ,MARRY = '"&strMarryYn&"' "
			strSql = strSql & " ,MDATE = '"&strMarryDate&"' "
			strSql = strSql & " ,MAIL_YN = '"&strMailYn&"' "
			strSql = strSql & " ,edate = getdate() "
			strSql = strSql & " ,site =  '"&strSite&"' "
			strSql = strSql & "  WHERE ID = '"&strUserId&"' "

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))


			'##### 맥스웰 향기 구독 정보 있으면 주소도 업데이트 2010.09.07 - 재민 -


			Dim strSql_un
			strSql_un = " UPDATE dongsuh.member_unity "
			strSql_un = strSql_un & " SET memberAddress = '"&strAddress1&" "&strAddress2&"',post='"&left(strZip,3)&"',post_detail='"&replace(strZip,"-","")&"',update_date=getdate()"
			strSql_un = strSql_un & "  WHERE memberid = '"&strUserId&"' "
			'response.write strSql_un
			'response.end

			Call db.RunSQL(strSql_un,"", db.GetConnStr(Const_DBConn))



			Set db = Nothing

			updateMember = true
		End function


		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 회원 정보 수정: 맥스웰향기 구독 주소 변경시 같이 변경된 경우
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		Function updateMemberAddr(strZip, strAddr1, strAddr2, strTel, strHp, strEmail, strUserId)
			Dim db, strSql, rs, doc

			Set db = CreateObject("DAL.DBHelper")

			strSql = "EXEC dbo.SSP_OPENKEY "
			strSql = strSql & " UPDATE dongsuh.member SET ZIP = '"& strZip &"', "
			strSql = strSql & " ADDRESS1 = '"&strAddr1&"', "
			strSql = strSql & " address2 = EncryptByKey(Key_GUID('Dongsuh_K'),'" & strAddr2 & "') , "

			If strTel <> "" Then
				strSql = strSql & " hphone = EncryptByKey(Key_GUID('Dongsuh_K'),'" & strTel & "') , "
			End If

			strSql = strSql & " hp = EncryptByKey(Key_GUID('Dongsuh_K'), '" & strHp & "' , "
			strSql = strSql & " EMAIL = '" & strEmail & "' "
			strSql = strSql & " WHERE  ID = '" & strUserId &"'"
			strSql = " EXEC dbo.SSP_CLOSEKEY"


			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))

			Set db = Nothing

			updateMemberAddr = true

		End Function

		'===================================================================
		' 기존 회원인 경우, 메인 사이트의 구분자를 업데이트한다.
		' create day : 2010-02-16
		'===================================================================
		Function updateSiteGubun(strUserId, strUserPwdEnc)
			Dim db, strSql,  rs, doc

			Set db = CreateObject("DAL.DBHelper")

			strSql = " UPDATE member SET site = 'D|'"
			strSql = strSql &" , PASSWD = '"&strUserPwdEnc&"'"
			strSql = strSql &" WHERE id = '"&strUserId&"' "

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))

			Set db = Nothing

			updateSiteGubun = true

		end function


		'===================================================================
		' 기존 회원인 경우, 메인 사이트의 구분자를 업데이트한다.
		' create day : 2010-02-16
		'===================================================================
		'Function updateSiteGubun2(strUserId, strUserPwdEnc)
		Function updateSiteGubun2( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim strUserId, strUserPwdEnc
			Dim strSql

			'변수값 세팅
			strUserId		=  dicParam.Item("userId")
			strUserPwdEnc	=  dicParam.Item("userPwdEnc")

			strSql = ""
			strSql = strSql & " UPDATE dongsuh.member SET site = 'D|'"
			'strSql = strSql & " , passwd = master.dbo.sha2('" & strUserPwdEnc & "') "
			strSql = strSql & " , passwd = master.dbo.sha2( ? ) "
			strSql = strSql & " WHERE id = ? "
			strSql = strSql & " AND ISNULL (site,'' ) = '' "

			arrParams = Array( _
				DBHelper.MakeParam("@passwd", adVarChar, adParamInput, 150, strUserPwdEnc), _
				DBHelper.MakeParam("@id", adVarChar, adParamInput, 20, strUserId) _
			)

			Call DBHelper.ExecSQL(strSql, arrParams, nothing)

			updateSiteGubun2 = true

		end function

		'===================================================================
		' 관리자 페이지에서 회원정보 수정
		' create day : 2010-02-16
		'===================================================================
		Function updateAdminPasswordChange(strUserId, strUserPwdEnc)
			Dim db, strSql,  rs, doc

			Set db = CreateObject("DAL.DBHelper")

			strSql = " UPDATE dongsuh.member SET "
			strSql = strSql &" PASSWD = '"&strUserPwdEnc&"'"
			strSql = strSql &" WHERE id = '"&strUserId&"' "

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))

			Set db = Nothing

			updateAdminPasswordChange = true

		end function

		'===================================================================
		' 관리자 페이지에서 암호화 회원정보 수정
		' create day : 2012.11.22
		'===================================================================
		Function updateAdminPasswordChange2(strUserId, strUserPwdEnc)
			Dim db, strSql,  rs, doc

			Set db = CreateObject("DAL.DBHelper")

			strSql = " UPDATE dongsuh.member SET "
			strSql = strSql &" PASSWD = master.dbo.sha2('" & strUserPwdEnc & "')"
			strSql = strSql &" WHERE id = '"&strUserId&"' "

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))

			Set db = Nothing

			updateAdminPasswordChange2 = true

		end function
		'===================================================================
		' 관리자 페이지에서 회원정보 수정
		' create day : 2010-02-16
		'===================================================================
		Function updateAdminEmailChange(strUserId, strEmail)
			Dim db, strSql,  rs, doc

			Set db = CreateObject("DAL.DBHelper")

			strSql = " UPDATE dongsuh.member SET "
			strSql = strSql &" email = '"&strEmail&"'"
			strSql = strSql &" WHERE id = '"&strUserId&"' "

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))

			Set db = Nothing

			updateAdminEmailChange = true

		end function

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 회원정보 암호화수정 암호변경시 체크
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'function updateLastChek(strUserId, strPwd, strEnPwd,strBirth, strLunar, strZip, strAddress1, strAddress2, strHpone, strSphone, strHp, strJob, strSchool, strEmail, strMarryYn, strMarryDate, strMailYn, strSite, strTag )
		public function updateLastChek( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intSeq, is_show
			Dim query, arrParams

			'변수값 세팅
			strUserId		=  dicParam.Item("userId")
			strPwd			=  dicParam.Item("passWd")
			strEnPwd		=  dicParam.Item("enPassWd")
			strBirth		=  dicParam.Item("birth")
			strLunar		=  dicParam.Item("lunar")
			strZip			=  dicParam.Item("zip")
			strAddress1		=  dicParam.Item("address1")
			strAddress2		=  dicParam.Item("address2")
			strHpone		=  dicParam.Item("hpone")
			strSphone		=  dicParam.Item("sphone")
			strHp			=  dicParam.Item("hp")
			strJob			=  dicParam.Item("job")
			strSchool		=  dicParam.Item("school")
			strEmail		=  dicParam.Item("email")
			strMarryYn		=  dicParam.Item("marryYn")
			strMarryDate	=  dicParam.Item("marryDate")
			strMailYn		=  dicParam.Item("mailYn")
			strSite			=  dicParam.Item("site")
			strTag			=  dicParam.Item("tag")

			query = "SELECT CONVERT(varchar, Passwd) FROM dongsuh.Member WHERE ID = ? AND Passwd =  master.dbo.sha2( ? ) "

			arrParams = Array( _
				DBHelper.MakeParam("@ID", adVarChar, adParamInput, 20, strUserId), _
				DBHelper.MakeParam("@Passwd", adVarChar, adParamInput, 150, strEnPwd) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
				strOriPwd = arrayList(0, 0)
			Else
				strOriPwd = ""
			end if

			objRs.close
			set objRs = nothing

			IF  strOriPwd = "" Then

				strDecodePW = ""

				For j=1 To Len(strPwd)

					If Asc(mid(strPwd, j, 1)) = 0 Then
						count = count + 1
					else
						strDecodePW = strDecodePW  + mid(strPwd, j, 1)

					End If
				Next

				strDecodePW = replace (strDecodePW, "'","")

				arrParams = Array( _
					DBHelper.MakeParam("@ID", adVarChar, adParamInput, 100, strUserId), _
					DBHelper.MakeParam("@PWD", adVarChar, adParamInput, 100, strDecodePW), _
					DBHelper.MakeParam("@ENPWD", adVarChar, adParamInput, 100, strEnPwd), _
					DBHelper.MakeParam("@MINLEN", adInteger, adParamInput, 4, 8), _
					DBHelper.MakeParam("@MIXLEVEL", adInteger, adParamInput, 4, 3), _
					DBHelper.MakeParam("@MAXREUSE", adInteger, adParamInput, 4, 1), _
					DBHelper.MakeParam("@RESULTCODE", adInteger, adParamOutput, , 0) _
				)

				Call DBHelper.ExecSP("dbo.ProcPasswordChek", arrParams, nothing)

				strCheck = DBHelper.GetValue(arrParams, "@RESULTCODE")

				'리턴값을 strCheck 에 , 조건 ok
				if strCheck = 0 then

					strSql1 = ""
					strSql1 = strSql1 & " INSERT INTO PWDHistory "
					strSql1 = strSql1 & " VALUES ( ?, 'S',  master.dbo.sha2( ? ),GETDATE() ) "

					arrParams = Array( _
						DBHelper.MakeParam("@id", adVarChar, adParamInput, 20, strUserId), _
						DBHelper.MakeParam("@passwd", adVarChar, adParamInput, 150, strEnPwd) _
					)

					call DBHelper.ExecSQL(strSql1, arrParams, nothing)

					strSql0 = strSql0 & "EXEC dbo.SSP_OPENKEY "
					strSql0 = strSql0 & " UPDATE dongsuh.member "
					strSql0 = strSql0 & " SET BIRTH = ? "
					strSql0 = strSql0 & " ,passwd = master.dbo.sha2( ? ) "
					strSql0 = strSql0 & " ,BKUBUN = ? "
					strSql0 = strSql0 & " ,ZIP =  ? "
					strSql0 = strSql0 & " ,ADDRESS1 = ?  "
					strSql0 = strSql0 & " ,ADDRESS2 = EncryptByKey(Key_GUID('Dongsuh_K'), ?)  "
					strSql0 = strSql0 & " ,HPHONE = EncryptByKey(Key_GUID('Dongsuh_K'), ?) "
					strSql0 = strSql0 & " ,SPHONE = EncryptByKey(Key_GUID('Dongsuh_K'), ?) "
					strSql0 = strSql0 & " ,HP = EncryptByKey(Key_GUID('Dongsuh_K'), ?) "
					strSql0 = strSql0 & " ,JOB = ? "
					strSql0 = strSql0 & " ,GCODE = ? "
					strSql0 = strSql0 & " ,EMAIL = ? "
					strSql0 = strSql0 & " ,MARRY = ? "
					strSql0 = strSql0 & " ,MDATE = ? "
					strSql0 = strSql0 & " ,MAIL_YN = ? "
					strSql0 = strSql0 & " ,edate = getdate() "
					strSql0 = strSql0 & " ,site =  ? "
					strSql0 = strSql0 & "  WHERE ID = ? "
					strSql0 = strSql0 & "EXEC dbo.SSP_CLOSEKEY "

					arrParams = Array( _
						DBHelper.MakeParam("@birth", adVarChar, adParamInput, 10, strBirth), _
						DBHelper.MakeParam("@passwd", adVarChar, adParamInput, 150, strEnPwd), _
						DBHelper.MakeParam("@bkubun", adVarChar, adParamInput, 10, strLunar), _
						DBHelper.MakeParam("@zip", adVarChar, adParamInput, 7, strZip), _
						DBHelper.MakeParam("@address1", adVarChar, adParamInput, 150, strAddress1), _
						DBHelper.MakeParam("@address2", adVarChar, adParamInput, 140, strAddress2), _
						DBHelper.MakeParam("@hphone", adVarChar, adParamInput, 70, strHpone), _
						DBHelper.MakeParam("@sphone", adVarChar, adParamInput, 70, strSphone), _
						DBHelper.MakeParam("@hp", adVarChar, adParamInput, 70, strHp), _
						DBHelper.MakeParam("@job", adVarChar, adParamInput, 2, strJob), _
						DBHelper.MakeParam("@gcode", adVarChar, adParamInput, 5, strSchool), _
						DBHelper.MakeParam("@email", adVarChar, adParamInput, 40, strEmail), _
						DBHelper.MakeParam("@marry", adVarChar, adParamInput, 1, strMarryYn), _
						DBHelper.MakeParam("@mdate", adVarChar, adParamInput, 10, strMarryDate), _
						DBHelper.MakeParam("@mail_yn", adVarChar, adParamInput, 1, strMailYn), _
						DBHelper.MakeParam("@site", adVarChar, adParamInput, 10, strSite), _
						DBHelper.MakeParam("@id", adVarChar, adParamInput, 20, strUserId) _
					)

					call DBHelper.ExecSQL(strSql0, arrParams, nothing)

					'##### 맥스웰 향기 구독 정보 있으면 주소도 업데이트 2010.09.07 - 재민 -
					strSql_un = " UPDATE dbo.member_maxwell "
					strSql_un = strSql_un & " SET addr1 = ? , addr2 = ?, zipcd = ?, mod_date=getdate()"
					strSql_un = strSql_un & "  WHERE memberid = ? "

					arrParams = Array( _
						DBHelper.MakeParam("@address1", adVarChar, adParamInput, 150, strAddress1), _
						DBHelper.MakeParam("@address2", adVarChar, adParamInput, 140, strAddress2), _
						DBHelper.MakeParam("@zip", adVarChar, adParamInput, 7, strZip), _
						DBHelper.MakeParam("@memberid", adVarChar, adParamInput, 20, strUserId) _
					)

					call DBHelper.ExecSQL(strSql_un, arrParams, nothing)

					isOk = true
				else
					isOk = false
				end if
				'query = strsql0
				'query = strsql1
			'패스워드가 바뀌지 않는 경우
			else
				strSql0 = strSql0 & "EXEC dbo.SSP_OPENKEY "
				strSql0 = strSql0 & " UPDATE dongsuh.member "
				strSql0 = strSql0 & " SET BIRTH = ? "
				strSql0 = strSql0 & " ,passwd = master.dbo.sha2( ? ) "
				strSql0 = strSql0 & " ,BKUBUN = ? "
				strSql0 = strSql0 & " ,ZIP =  ? "
				strSql0 = strSql0 & " ,ADDRESS1 = ?  "
				strSql0 = strSql0 & " ,ADDRESS2 = EncryptByKey(Key_GUID('Dongsuh_K'), ?)  "
				strSql0 = strSql0 & " ,HPHONE = EncryptByKey(Key_GUID('Dongsuh_K'), ?) "
				strSql0 = strSql0 & " ,SPHONE = EncryptByKey(Key_GUID('Dongsuh_K'), ?) "
				strSql0 = strSql0 & " ,HP = EncryptByKey(Key_GUID('Dongsuh_K'), ?) "
				strSql0 = strSql0 & " ,JOB = ? "
				strSql0 = strSql0 & " ,GCODE = ? "
				strSql0 = strSql0 & " ,EMAIL = ? "
				strSql0 = strSql0 & " ,MARRY = ? "
				strSql0 = strSql0 & " ,MDATE = ? "
				strSql0 = strSql0 & " ,MAIL_YN = ? "
				strSql0 = strSql0 & " ,edate = getdate() "
				strSql0 = strSql0 & " ,site =  ? "
				strSql0 = strSql0 & "  WHERE ID = ? "
				strSql0 = strSql0 & "EXEC dbo.SSP_CLOSEKEY "

				arrParams = Array( _
					DBHelper.MakeParam("@birth", adVarChar, adParamInput, 10, strBirth), _
					DBHelper.MakeParam("@passwd", adVarChar, adParamInput, 150, strEnPwd), _
					DBHelper.MakeParam("@bkubun", adVarChar, adParamInput, 10, strLunar), _
					DBHelper.MakeParam("@zip", adVarChar, adParamInput, 7, strZip), _
					DBHelper.MakeParam("@address1", adVarChar, adParamInput, 150, strAddress1), _
					DBHelper.MakeParam("@address2", adVarChar, adParamInput, 140, strAddress2), _
					DBHelper.MakeParam("@hphone", adVarChar, adParamInput, 70, strHpone), _
					DBHelper.MakeParam("@sphone", adVarChar, adParamInput, 70, strSphone), _
					DBHelper.MakeParam("@hp", adVarChar, adParamInput, 70, strHp), _
					DBHelper.MakeParam("@job", adVarChar, adParamInput, 2, strJob), _
					DBHelper.MakeParam("@gcode", adVarChar, adParamInput, 5, strSchool), _
					DBHelper.MakeParam("@email", adVarChar, adParamInput, 40, strEmail), _
					DBHelper.MakeParam("@marry", adVarChar, adParamInput, 1, strMarryYn), _
					DBHelper.MakeParam("@mdate", adVarChar, adParamInput, 10, strMarryDate), _
					DBHelper.MakeParam("@mail_yn", adVarChar, adParamInput, 1, strMailYn), _
					DBHelper.MakeParam("@site", adVarChar, adParamInput, 10, strSite), _
					DBHelper.MakeParam("@id", adVarChar, adParamInput, 20, strUserId) _
				)

				call DBHelper.ExecSQL(strSql0, arrParams, nothing)

				'##### 맥스웰 향기 구독 정보 있으면 주소도 업데이트 2010.09.07 - 재민 -
				strSql_un = " UPDATE dbo.member_maxwell "
				strSql_un = strSql_un & " SET addr1 = ? , addr2 = ?, zipcd = ?, mod_date=getdate()"
				strSql_un = strSql_un & "  WHERE memberid = ? "

				arrParams = Array( _
					DBHelper.MakeParam("@address1", adVarChar, adParamInput, 150, strAddress1), _
					DBHelper.MakeParam("@address2", adVarChar, adParamInput, 140, strAddress2), _
					DBHelper.MakeParam("@zip", adVarChar, adParamInput, 7, strZip), _
					DBHelper.MakeParam("@memberid", adVarChar, adParamInput, 20, strUserId) _
				)

				call DBHelper.ExecSQL(strSql_un, arrParams, nothing)

				isOk = true
			end if

			updateLastChek = isOk
		End function


	End Class
%>
