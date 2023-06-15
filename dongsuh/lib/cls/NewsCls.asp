<%
	Class NewsCls

		private sub Class_Initialize()
			'클래스 초기화 시 해야할 작업
		End Sub

    	'갯수 구하기
		Public Function getTotalCnt( ByVal DBHelper, ByVal dicParam )
			'변수 선언
			Dim intPageListCnt, strSearchKey, strSearchText, is_show, kind, gubun
			Dim query, objRs, arrParams
			Dim arrayList

			'변수값 세팅
			intPageListCnt	=  dicParam.Item("page_list_cnt")
			is_show 			= dicParam.Item("is_show")
			searchStr			= dicParam.Item("searchStr")

			query = "select ceiling(cast(count(*) as float)/" & intPageListCnt & "), count(*) from T_NEWS "
			query = query & " WHERE 1=1 "

			If is_show = "Y" Then
				query = query & " and is_show = 'Y' and thumb_img is not null "
			End If

			if searchStr <> "" then
				query = query & " and ( TITLE like '%" & searchStr & "%' or CONTENTS like '%" & searchStr & "%' ) "
			end if

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
			intCurPage			= dicParam.Item("page")
			is_show			= dicParam.Item("is_show")
			searchStr			= dicParam.Item("searchStr")

			startRnum = (intCurPage - 1) * intPageListCnt
			endRnum = startRnum + intPageListCnt

			select_fields = " IDX, TITLE, CONTENTS, CONTENTS_HTML, SHOW_DATE, VIEW_CNT, IS_SHOW, REG_DATE, REG_ID, EDIT_DATE, EDIT_ID, THUMB_IMG "

			query = " select top " & intPageListCnt & " " & select_fields & " from T_NEWS "

			query = query & " where IDX not in ( "
			query = query & "		select top " & ((intCurPage - 1) * intPageListCnt) & " IDX from T_NEWS "

			if is_show = "Y" then
				query = query & "		where is_show = 'Y' and thumb_img is not null "
			end if

			if searchStr <> "" then
				query = query & " and ( TITLE like '%" & searchStr & "%' or CONTENTS like '%" & searchStr & "%' ) "
			end if

			query = query & "		order by SHOW_DATE desc, IDX desc "

			query = query & "	) "

			if is_show = "Y" then
				query = query & "	and is_show = 'Y' and thumb_img is not null "
			end if

			if searchStr <> "" then
				query = query & " and ( TITLE like '%" & searchStr & "%' or CONTENTS like '%" & searchStr & "%' ) "
			end if

			query = query & " order by SHOW_DATE desc, IDX desc "

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
		Public Function getInfo( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intIdx
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			intIdx	=  dicParam.Item("IDX")

			select_fields = "IDX, TITLE, CONTENTS, CONTENTS_HTML, SHOW_DATE, VIEW_CNT, IS_SHOW, REG_DATE, REG_ID, EDIT_DATE, EDIT_ID, THUMB_IMG "

			query = "select " & select_fields & " from T_NEWS where IDX = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("IDX")) _
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

		End Function

		'이전 정보 보기
		Public Function getPrevInfo(  ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intIdx, is_show
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			intIdx		=  dicParam.Item("IDX")
			is_show	=  dicParam.Item("is_show")

			select_fields = "IDX, TITLE, CONTENTS, CONTENTS_HTML, SHOW_DATE, VIEW_CNT, IS_SHOW, REG_DATE, REG_ID, EDIT_DATE, EDIT_ID "

			query = "select " & select_fields & " from T_NEWS where IDX = ( "
			query = query & "	select min(IDX) from T_NEWS where IDX > ? "

			if is_show = "Y" then
				query = query & "		and is_show = 'Y' "
			end if

			query = query & " ) "

			if is_show = "Y" then
				query = query & "		and is_show = 'Y' "
			end if

			arrParams = Array( _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("IDX")) _
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
			intIdx		=  dicParam.Item("IDX")
			is_show	=  dicParam.Item("is_show")


			select_fields = "IDX, TITLE, CONTENTS, CONTENTS_HTML, SHOW_DATE, VIEW_CNT, IS_SHOW, REG_DATE, REG_ID, EDIT_DATE, EDIT_ID "

			query = "select " & select_fields & " from T_NEWS where IDX = ( "
			query = query & "	select max(IDX) from T_NEWS where IDX < ? "

			if is_show = "Y" then
				query = query & "		and is_show = 'Y' "
			end if

			query = query & " ) "

			if is_show = "Y" then
				query = query & "		and is_show = 'Y' "
			end if

			arrParams = Array( _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("IDX")) _
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
			Dim query, arrParams

			query = " update T_NEWS set "
			query = query & " VIEW_CNT = VIEW_CNT + 1 "
			query = query & " where IDX = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("IDX")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function


	End Class
%>
