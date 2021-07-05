<%
	Class CafeCls

		private sub Class_Initialize()
			'클래스 초기화 시 해야할 작업
		End Sub

		function getBoardInfo(byVal strTableName) '게시판의 소속과 권한 설정 정보를 가져온다.
			Dim db, strSql, rs, doc

			Set db = CreateObject("DAL.DBHelper")
			If Len(strTableName) > 4 Then 'board_ 식으로 순수 코드가 아니면

				strTableName = Mid(strTableName, 7)
			End If

			strSql = "SELECT mcode, mcodename, powner, pcafeid, pstep, pcafe, pother, isreply, isrecommend, " & _
					 "isboardtype, iscomment, iscategory, isattach, cdate, pagesize, setsize " & _
					 "FROM dongsuh.board WHERE mcode = " & strTableName

			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))
			If rs.EOF OR rs.BOF Then
				doc = false
			Else
				doc = rs.getRows()
			End If
			rs.Close
			Set rs = Nothing
			Set db = Nothing
			getBoardInfo = doc
		end function

		'해당 회원의 카페 가입 여부와 가입 정보를 가져온다.
		'function getCafeMember(strId, strCafeId)
		Function getCafeMember( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim strUserId, strCafeId
			Dim strSql

			'변수값 세팅
			strUserId	=  dicParam.Item("userId")
			strCafeId	=  dicParam.Item("cafeId")

			strSql = 			" SELECT "
			strSql = strSql & 	"	mcode, id, step, edate, security, nickname, birth, sex, region, job, msg, enter "
			strSql = strSql & 	" FROM  dongsuh.cafeEnter WHERE id = ? "

			'2011-04-18 수정
			If Trim(strCafeId) <> "" Then
				strSql = strSql & " AND mcode = " & strCafeId
			End If

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

			getCafeMember = arrayList

		end function

		function getCafeMembers(iPage, iPageSize, strQueryType, strQueryWord, strCafeId, strStep)
			Dim db, strSql, strSubSql, rs, doc, strTableName

			strQueryType = Replace(strQueryType,"'","''")
			strQueryWord = Replace(strQueryWord,"'","''")
			strTableName = "cafeEnter_full"

			strSubSql = " AND mcode = " & strCafeId & " "

			If Trim(strQueryWord) <> "" Then '검색 조건이 있으면
				strSubSql = strSubSql & " AND " & strQueryType & " LIKE '%" & strQueryWord & "%' "
			End If

			If Trim(strStep) <> "" Then '등급 검색 조건이 있으면
				If strStep = "ALL" Then
					strSubSql = strSubSql & " AND step <> 'master' "
				ElseIf strStep = "ADMIN" Then
					strSubSql = strSubSql & " AND step IN ('master','step') "
				Else
					strSubSql = strSubSql & " AND step = '" & strStep & "' "
				End If
			End If

			strSubSql = strSubSql & " AND enter = 'Y' "

			Set db = CreateObject("DAL.DBHelper")

			strSql = "SELECT COUNT(*) " & _
					 " FROM " & strTableName & " WHERE 1=1 " & strSubSql
			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))
			count = rs(0)
			rs.Close

			strSql = "SELECT TOP " & iPageSize & " mcode, id, step, edate, security, nickname, birth, sex, region, job, msg, enter, kornm = (SELECT name_han FROM dongsuh.member WHERE id = " & strTableName & ".id) " & _
					 " FROM " & strTableName & " WHERE id NOT IN (SELECT TOP " & (iPage - 1) * iPageSize & " id FROM " & strTableName & " WHERE 1=1 " & strSubSql & " ORDER BY eDate DESC)" & _
					 strSubSql & " ORDER BY eDate DESC"
			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF Then
				doc = false
			Else
				doc = rs.getRows()
			End If
			rs.Close
			Set rs = Nothing
			Set db = Nothing
			getCafeMembers = doc
		end Function

		'All - 2011-04-12
		function getCafeMembersAll( strCafeId, strStep)
			Dim db, strSql, strSubSql, rs, doc, strTableName

			strTableName = "cafeEnter_full"

			strSubSql = " AND mcode = " & strCafeId & " "

			If Trim(strStep) <> "" Then '등급 검색 조건이 있으면
				If strStep = "ALL" Then
					strSubSql = strSubSql & " AND step <> 'master' "
				ElseIf strStep = "ADMIN" Then
					strSubSql = strSubSql & " AND step IN ('master','step') "
				Else
					strSubSql = strSubSql & " AND step = '" & strStep & "' "
				End If
			End If

			strSubSql = strSubSql & " AND enter = 'Y' "

			Set db = CreateObject("DAL.DBHelper")

			strSql = "SELECT COUNT(*) " & _
					 " FROM " & strTableName & " WHERE 1=1 " & strSubSql
			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))
			count = rs(0)
			rs.Close

			strSql = "SELECT mcode, id, step, edate, security, nickname, birth, sex, region, job, msg, enter, kornm = (SELECT name_han FROM member WHERE id = " & strTableName & ".id) " & _
					 " FROM " & strTableName & " WHERE 1=1 " & _
					 strSubSql & " ORDER BY eDate DESC"
			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF Then
				doc = false
			Else
				doc = rs.getRows()
			End If
			rs.Close
			Set rs = Nothing
			Set db = Nothing
			getCafeMembersAll = doc
		end Function

		function getCafeMembersAllEmail(strCafeId)
			Dim db, strSql, rs, doc, strTableName

			strTableName = "cafeEnter"
			Set db = CreateObject("DAL.DBHelper")
			strSql = "SELECT email " & _
					 " FROM dongsuh.cafeEnter a JOIN dongsuh.member b ON (a.id = b.id) " & _
					 " WHERE a.mcode = 1 AND a.enter = 'Y' AND b.email <> ''"

			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))
			If rs.EOF OR rs.BOF Then
				doc = false
			Else
				doc = rs.getRows()
			End If
			rs.Close
			Set rs = Nothing
			Set db = Nothing
			getCafeMembersAllEmail = doc
		end function

		function getCafeInfo(strCafeId) '해당 카페의 정보를 가져온다.
			Dim db, strSql, rs, doc

			Set db = CreateObject("DAL.DBHelper")
			strSql = "SELECT mcode, redirect, cafename, cdate, creator, summary, image, imagetype, security, description, " & _
					 " number = (SELECT COUNT(*) FROM dongsuh.cafeEnter WHERE mcode = dongsuh.cafe.mcode) " & _
					 " FROM dongsuh.cafe WHERE mcode = " & strCafeId
		'	response.write strSql

			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))
			If rs.EOF OR rs.BOF Then
				doc = false
			Else
				doc = rs.getRows()
			End If
			rs.Close
			Set rs = Nothing
			Set db = Nothing
			getCafeInfo = doc
		end function

		function getCafeMenu(strCafeId) '해당 카페의 정보를 가져온다.
			Dim db, strSql, rs, doc

			Set db = CreateObject("DAL.DBHelper")
			strSql = "SELECT mcode, name, ccode, sort, url, del " & _
					 " FROM dongsuh.cafemenu WHERE mcode = " & strCafeId & " AND del = 'N' ORDER BY sort"
		'	response.write strSql
		'response.end
			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))
			If rs.EOF OR rs.BOF Then
				doc = false
			Else
				doc = rs.getRows()
			End If
			rs.Close
			Set rs = Nothing
			Set db = Nothing
			getCafeMenu = doc
		end Function

		'2011-04-11
		Function updateCafeMenu(ByVal intCcode, ByVal strName)
			Dim db, strSql

			intCcode = Replace(intCcode,"'" ,"''")
			strName = Replace(strName,"'" ,"''")

			strSql = "UPDATE cafemenu SET name = '"&strName&"' WHERE ccode = " & intCcode
			Set db = CreateObject("DAL.DBHelper")
			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))
			Set db = Nothing
			updateCafeMenu = true
		End Function

		function setCafeMember(strId, strCafeId, strStep, strSecurity, strNick, iBirth, strSex, strArea, strJob, strMessage) '해당 카페에 가입시킨다.
			Dim db, strSql

			strMessage = Replace(strMessage,"'" ,"''")

			Set db = CreateObject("DAL.DBHelper")
			strSql = "INSERT INTO dongsuh.cafeEnter(mcode, id, step, edate, security, nickname, birth, sex, region, job, msg, enter) " & _
					 "VALUES(" & strCafeId & ",'" & strId & "','" & strStep & "',GETDATE()," & strSecurity & ",'" & strNick & "','" & iBirth & "','" & strSex & _
					 "','" & strArea & "','" & strJob & "','" & strMessage & "', 'Y')"

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))
			Set db = Nothing
			setCafeMember = true
		end function

		function editCafeMember(strId, strCafeId, strStep, strSecurity, strNick, iBirth, strSex, strArea, strJob, strMessage)
			Dim db, strSql

			strMessage = Replace(strMessage,"'" ,"''")

			Set db = CreateObject("DAL.DBHelper")
			strSql = "UPDATE dongsuh.cafeEnter SET step = '" & strStep & "', security = " & strSecurity & ", nickname = '" & strNick & "', birth = '" & iBirth & _
					 "', sex = '" & strSex & "', region = '" & strArea & "', job = '" & strJob & "', msg = '" & strMessage & _
					 "' WHERE mcode = " & strCafeId & " AND id = '" & strId & "'"
			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))
			Set db = Nothing
			editCafeMember = true
		end function

		function delCafeMember(strId, strCafeId)
			Dim db, strSql

			Set db = CreateObject("DAL.DBHelper")
			'strSql = "UPDATE dongsuh.cafeEnter SET enter = 'N' " & _
			'		 " WHERE mcode = " & strCafeId & " AND id = '" & strId & "'"
			'기존에 update로 되어있었음 delete로 수정함
			strSql = "delete dongsuh.cafeEnter " & _
					 " WHERE mcode = " & strCafeId & " AND id = '" & strId & "'"

			'response.write strSql

			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))
			Set db = Nothing
			delCafeMember = true
		end function

		function editCafe(strCafeId, strInfo, strImageFile, strImageType, iSecurity, strDesc)
			Dim db, strSql

			strInfo = Replace(strInfo,"'","''")
			strImageFile = Replace(strImageFile,"'","''")
			strDesc = Replace(strDesc,"'","''")

			Set db = CreateObject("DAL.DBHelper")
			If Trim(strImageFile) = "" Then '기존 파일 그대로 유지
				strSql = "UPDATE cafe SET summary = '" & strInfo & "', imagetype = '" & strImageType & _
						 "', security = '" & iSecurity & "', description = '" & strDesc & "'" & _
					 	" WHERE mcode = " & strCafeId
			Else
				strSql = "UPDATE cafe SET summary = '" & strInfo & "', image = '" & strImageFile & "', imagetype = '" & strImageType & _
						 "', security = '" & iSecurity & "', description = '" & strDesc & "'" & _
					 	" WHERE mcode = " & strCafeId
			End If
			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))
			Set db = Nothing
			editCafe = true
		end function

		function getCafeBoard(strCafeId)
			Dim db, strSql, rs, doc

			Set db = CreateObject("DAL.DBHelper")
			strSql = "SELECT mcode, mcodename, powner, pcafeid, pstep, pcafe, pother, isreply, isrecommend, " & _
					 "isboardtype, iscomment, iscategory, isattach, cdate, pagesize, setsize " & _
					 "FROM board WHERE pCafeid = " & strCafeId & " AND pStep <> '--'"	'2011-04-11
			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))
			If rs.EOF OR rs.BOF Then
				doc = false
			Else
				doc = rs.getRows()
			End If
			rs.Close
			Set rs = Nothing
			Set db = Nothing
			getCafeBoard = doc
		end function

		function setCafeAdmin(strId, strStep, strCafeId)
			Dim db, strSql, rs, doc

			Set db = CreateObject("DAL.DBHelper")
			'먼저 해당 id가 카페의 회원인지 찾아 본다.
			strSql = "SELECT COUNT(*) " & _
					 "FROM dongsuh.cafeEnter WHERE mcode = " & strCafeId & " AND id = '" & strId & "'"
			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))

			If rs(0) < 0 Then
				rs.Close
				Set rs = Nothing
				Set db = Nothing
				setCafeAdmin = false
				Exit Function
			End If

			rs.Close
			Set rs = Nothing

			'업데이트 한다.
			strSql = "UPDATE dongsuh.cafeEnter SET step = '" & strStep & "' WHERE id = '" & strId & "' AND mcode = " & strCafeId
			Call db.RunSQL(strSql,"", db.GetConnStr(Const_DBConn))
			Set db = Nothing
			setCafeAdmin = true
		end function



		function getUser_info(strCafeId,strUserId)

			Dim db, strSql, strSubSql, rs, doc, strTableName

			Set db = CreateObject("DAL.DBHelper")
			strTableName = "cafeEnter_full"

			strSql = "SELECT  mcode, id, step, edate, security, nickname, birth, sex, region, job, msg, enter,kornm = (SELECT name_han FROM dongsuh.member WHERE id = '" & strUserId & "')" & _
					 " FROM " & strTableName & " WHERE mcode='"&strCafeId&"' and id='"&strUserId&"'"
			'response.write strSql
		'response.end

			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF Then
				doc = false
			Else
				doc = rs.getRows()
			End If
			rs.Close
			Set rs = Nothing
			Set db = Nothing
			getUser_info = doc
		end function

		'##################################################
		' 2010-05-11
		' 좌측메뉴에 todayDate로 신규글이 있을시, New표시
		'##################################################

		function getNew(strBoard, strDate)
			Dim db, strSql, rs, doc, strTableName

			Set db = CreateObject("DAL.DBHelper")
			strSql = "SELECT  COUNT(*) " & _
			         " FROM dongsuh." & strBoard & " WHERE 1 = 1 AND  DATEDIFF(DAY, wDate, '" & strDate & "') < 3"

		'	Response.Write strSql

			Set rs = db.RunSQLReturnRs(strSql,"", db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF Then
				doc = 0
			Else
				doc = rs(0)
			End If
			rs.Close

			Set rs = Nothing
			Set db = Nothing
			getNew = doc
		end function

	End Class
%>
