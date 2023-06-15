<%
	Class MaxwellCls

		private sub Class_Initialize()
			'클래스 초기화 시 해야할 작업
		End Sub

		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'관리자
		' 맥스웰 향기 발행호차 상세보기
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		PUblic function getMaxwellDateView( ByVal DBHelper )

			'변수 선언
			Dim intIdx
			Dim strSql, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅

			strSql = ""
			strSql = strSql & " SELECT  top 1 SubSeq, subject, imgurl, notice_yn, CONVERT(VARCHAR(10),wdate,121) AS wdate "
			strSql = strSql & " FROM  dongsuh.board_maxwell_date WHERE 1 = 1 "
			strSql = strSql & " order by SubSeq desc "

			set objRs = DBHelper.ExecSQLReturnRS(strSql, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getMaxwellDateView = arrayList

		End function

		PUblic function getMaxwellMainContent( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intIdx
			Dim strSql, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			intSubSeq	= dicParam.Item("intSubSeq")
			intTop		= dicParam.Item("intTop")
			intCategory	= dicParam.Item("intCategory")

			strSql = ""
			strSql = strSql & " SELECT  TOP " & intTop & " srl, subject, contents, wdate, hit, isHtml, id, writer, fileName, fileType, fileSize, notice, notice_date, category, url, fileName3 "
			strSql = strSql & " FROM dongsuh.board_maxwell "
			strSql = strSql & " WHERE category = ? AND notice='Y' AND SubSeq = ? "
			strSql = strSql & " ORDER BY WDATE DESC "

			arrParams = Array( _
				DBHelper.MakeParam("@category", adInteger, adParamInput, 4, intCategory), _
				DBHelper.MakeParam("@SubSeq", adInteger, adParamInput, 4, intSubSeq) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(strSql, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getMaxwellMainContent = arrayList

		End function

		Public function getFrontDoc(iCategory, strTableName)
			Dim db, strSql, rs, doc

			Set db = CreateObject("DAL.DBHelper")

			' 해당 글 데이타 가져오기
			strSql = "SELECT TOP 1 srl, subject, contents, wdate, hit, isHtml, id, writer, fileName, fileType, fileSize, notice, notice_date, category, url, fileName3  "
			strSql = strSql & " FROM  dongsuh.board_maxwell_date WHERE category = " & iCategory &" AND notice='Y' ORDER BY WDATE DESC "
		'response.write strSql&"<br>"
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

			getFrontDoc = doc

		End function

		'Public Function getFrontDocs(iPage, iPageSize, strQueryWord, strTableName, intCategory,getDate)
		Public Function getFrontDocs( ByVal DBHelper, ByVal dicParam )
			Dim db, strSql, strSubSql, rs, doc

			strQueryWord = Replace(strQueryWord,"'","''")

			strSubSql =  " AND subject LIKE '%" & strQueryWord & "%' AND del = 'N' AND notice='Y' "

			'빈칸이 아닐때 검색 시작
			if getDate <> "" then
				strSubSql = strSubSql & " AND ISNULL(SubSeq,'') =  '" & getDate & "' "
			End If
			'빈칸이 아닐때 검색 끝

			If Trim(intCategory) <> "" then

				strSubSql = strSubSql&" AND category = "&intCategory

			End If

			Set db = CreateObject("DAL.DBHelper")

			strSql = "SELECT COUNT(*) FROM " &  strTableName & " WHERE 1=1 " & strSubSql
			Set rs = db.RunSQLReturnRs(strSql,"",db.GetConnStr(Const_DBConn))
			count = rs(0)
			rs.Close

			strSql = "SELECT TOP " & iPageSize & " srl, category, subject, contents, wdate, hit, fileName, txt_contents "
			strSql = strSql & " FROM  " &strTableName& " WHERE srl NOT IN "
			strSql = strSql & " (SELECT TOP " & (iPage -1) * iPageSize & " srl FROM " &strTableName& " WHERE 1=1 "
			strSql = strSql & " " &strSubSql& " ORDER BY srl DESC)  "
			strSql = strSql & " " &strSubSql& " ORDER BY srl DESC "

			Set rs = db.RunSQLReturnRs(strSql,"",db.GetConnStr(Const_DBConn))

			If rs.EOF OR rs.BOF then
				doc = false
			Else
				doc = rs.getRows()
			End if

			rs.Close
			Set rs = Nothing
			Set db = Nothing

			getFrontDocs = doc
		End function

		'회차 리스트 구하기
		Public function getSelectCount( ByVal DBHelper )

			'변수 선언
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			query = " SELECT SubSeq, subject FROM dongsuh.board_maxwell_date where notice_Yn ='Y' ORDER BY SubSeq DESC "

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getSelectCount = arrayList

		End function

    	'갯수 구하기
		Public Function getTotalCnt( ByVal DBHelper, ByVal dicParam )
			'변수 선언
			Dim intPageListCnt, strSearchKey, strSearchText, is_show, kind, gubun
			Dim query, objRs, arrParams, subQuery
			Dim arrayList

			'변수값 세팅
			intPageListCnt	= dicParam.Item("page_list_cnt")
			is_show 		= dicParam.Item("is_show")
			searchStr		= dicParam.Item("strQueryWord")
			getDate			= dicParam.Item("getDate")
			intCategory		= dicParam.Item("intCategory")

			subQuery = subQuery & " AND del = 'N' AND notice='Y' "

			strQueryWord = Replace(strQueryWord,"'","''")

			if searchStr <> "" then
				subQuery = subQuery & " AND subject LIKE '%" & searchStr & "%' "
			end if

			If Trim(intCategory) <> "" then
				subQuery = subQuery & " AND category = " & intCategory
			End If

			if getDate <> "" then
				subQuery = subQuery & " AND ISNULL(SubSeq,'') =  '" & getDate & "' "
			End If

			query = "select ceiling(cast(count(*) as float)/" & intPageListCnt & "), count(*) from dongsuh.board_maxwell "
			query = query & " WHERE 1=1 " & subQuery

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getTotalCnt = arrayList

		End Function

		'리스트 구하기
		Public Function getList(  ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intPageListCnt, intCurPage, strSearchKey, strSearchText, is_show, kind
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList
			Dim startRnum , endRnum

			'변수값 세팅
			intPageListCnt	= dicParam.Item("page_list_cnt")
			intCurPage		= dicParam.Item("page")
			is_show			= dicParam.Item("is_show")
			searchStr		= dicParam.Item("strQueryWord")
			getDate			= dicParam.Item("getDate")
			intCategory		= dicParam.Item("intCategory")

			subQuery = subQuery & " AND del = 'N' AND notice='Y' "

			strQueryWord = Replace(strQueryWord,"'","''")

			if searchStr <> "" then
				subQuery = subQuery & " AND subject LIKE '%" & searchStr & "%' "
			end if

			If Trim(intCategory) <> "" then
				subQuery = subQuery & " AND category = " & intCategory
			End If

			if getDate <> "" then
				subQuery = subQuery & " AND ISNULL(SubSeq,'') =  '" & getDate & "' "
			End If

			select_fields = " srl, category, subject, contents, wdate, hit, fileName, txt_contents "

			query = " select top " & intPageListCnt & " " & select_fields & " from dongsuh.board_maxwell "

			query = query & " where srl not in ( "
			query = query & "		select top " & ((intCurPage - 1) * intPageListCnt) & " srl from dongsuh.board_maxwell where 1=1 " & subQuery & " order by srl desc "

			query = query & "	) " & subQuery

			query = query & " order by srl desc "

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getList = arrayList

		End Function

		'정보 보기
		'function getFrontViewDoc(idx, strTableName)
		Public function getInfo( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intIdx
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			intIdx	=  dicParam.Item("idx")

			query = " SELECT "
			query = query & "	srl, subject, contents, wdate, hit, isHtml, id, writer, fileName, fileType, fileSize, notice, notice_date, category, url  "
			query = query & " FROM  dongsuh.board_maxwell "
			query = query & " WHERE srl = ? AND del='N'"

			arrParams = Array( _
				DBHelper.MakeParam("@srl", adInteger, adParamInput, 4, intIdx) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getInfo = arrayList

		End function

		'이전 정보 보기
		Public Function getPrevInfo(  ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intIdx, is_show
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			intIdx		=  dicParam.Item("idx")
			iCategory	=  dicParam.Item("category")

			If Trim(iCategory) <> "" Then
				strSubSql = " AND category = "& iCategory
			End If

			query = " SELECT "
			query = query & " TOP 1 srl, subject, wdate "
			query = query & " FROM dongsuh.board_maxwell "
			query = query & " WHERE srl > ? AND del = 'N' " & strSubSql
			query = query & " ORDER BY srl ASC"

			arrParams = Array( _
				DBHelper.MakeParam("@srl", adInteger, adParamInput, 4, intIdx) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getPrevInfo = arrayList

		End Function

		'다음 정보 보기
		Public Function getNextInfo(  ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intSeq, is_show
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			intIdx		=  dicParam.Item("idx")
			iCategory	=  dicParam.Item("category")


			query = " SELECT "
			query = query & " TOP 1 srl, subject, wdate "
			query = query & " FROM dongsuh.board_maxwell "
			query = query & " WHERE srl < ? AND del = 'N' " & strSubSql
			query = query & " ORDER BY srl DESC"

			arrParams = Array( _
				DBHelper.MakeParam("@srl", adInteger, adParamInput, 4, intIdx) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getNextInfo = arrayList

		End Function

		'입력
		Public Function insertInfo(ByVal DBHelper, ByVal dicParam)

			'변수 선언
			Dim query, arrParams

			query =			" insert into T_NEWS ( "
			query = query & "	 TITLE, CONTENTS, CONTENTS_HTML, SHOW_DATE, VIEW_CNT, IS_SHOW, REG_DATE, REG_ID, THUMB_IMG "
			query = query & " ) values ( "
			query = query & "	?, ?, ?, ?, 0, ?, getdate(), ?, ? "
			query = query & " ) "

			arrParams = Array( _
				DBHelper.MakeParam("@TITLE", adVarChar, adParamInput, 200, dicParam.item("TITLE")), _
				DBHelper.MakeParam("@CONTENTS", adVarChar, adParamInput, 2147483647, dicParam.item("CONTENTS")), _
				DBHelper.MakeParam("@CONTENTS_HTML", adVarChar, adParamInput, 2147483647, dicParam.item("CONTENTS_HTML")), _
				DBHelper.MakeParam("@SHOW_DATE", adVarChar, adParamInput, 10, dicParam.item("SHOW_DATE")), _
				DBHelper.MakeParam("@IS_SHOW", adVarChar, adParamInput, 1, dicParam.item("IS_SHOW")), _
				DBHelper.MakeParam("@REG_ID", adVarChar, adParamInput, 20, dicParam.item("REG_ID")), _
				DBHelper.MakeParam("@THUMB_IMG", adVarChar, adParamInput, 100, dicParam.item("thumb_img")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'수정
		Public Function editInfo(ByVal DBHelper, ByVal dicParam)

			'변수 선언
			Dim query, arrParams

			query = " update T_NEWS set "
			query = query & " TITLE = ?, "
			query = query & " CONTENTS = ?, "
			query = query & " CONTENTS_HTML = ?, "
			query = query & " THUMB_IMG = ?, "
			query = query & " SHOW_DATE = ?, "
			query = query & " IS_SHOW = ?, "
			query = query & " EDIT_DATE = getdate(), "
			query = query & " EDIT_ID = ? "
			query = query & " where IDX = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@TITLE", adVarChar, adParamInput, 200, dicParam.item("TITLE")), _
				DBHelper.MakeParam("@CONTENTS", adVarChar, adParamInput, 2147483647, dicParam.item("CONTENTS")), _
				DBHelper.MakeParam("@CONTENTS_HTML", adVarChar, adParamInput, 2147483647, dicParam.item("CONTENTS_HTML")), _
				DBHelper.MakeParam("@THUMB_IMG", adVarChar, adParamInput, 100, dicParam.item("THUMB_IMG")), _
				DBHelper.MakeParam("@SHOW_DATE", adVarChar, adParamInput, 10, dicParam.item("SHOW_DATE")), _
				DBHelper.MakeParam("@IS_SHOW", adVarChar, adParamInput, 1, dicParam.item("IS_SHOW")), _
				DBHelper.MakeParam("@REG_ID", adVarChar, adParamInput, 20, dicParam.item("REG_ID")), _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("IDX")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'삭제
		Public Function deleteInfo( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim query, arrParams

			'게시판 삭제
			query = " delete from T_NEWS "
			query = query & " where IDX = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("IDX")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'조회수 올리기
		Public Function upViewCntInfo( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim query, arrParams, intIdx

			intIdx	=  dicParam.Item("idx")

			query = " update dongsuh.board_maxwell set "
			query = query & " hit = hit + 1 "
			query = query & " where srl = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@srl", adInteger, adParamInput, 4, intIdx) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function


	End Class
%>
