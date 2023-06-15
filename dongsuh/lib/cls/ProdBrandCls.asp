<%
	Class ProdBrandCls

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
			intPageListCnt	= dicParam.Item("page_list_cnt")
			is_show 			= dicParam.Item("is_show")
			searchStr			= dicParam.Item("searchStr")

			query = "select ceiling(cast(count(*) as float)/" & intPageListCnt & "), count(*) from T_PROD_BRAND "
			query = query & " WHERE 1=1 "
			
			If is_show = "Y" Then 
				query = query & " and is_show = 'Y' "
			End If 
			
			if searchStr <> "" then 
				query = query & " and ( BRAND_NAME like '%" & searchStr & "%' or SLOGAN like '%" & searchStr & "%' or EXPLAIN like '%" & searchStr & "%' ) "
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
			is_show		= dicParam.Item("is_show")
			searchStr		= dicParam.Item("searchStr")

			startRnum = (intCurPage - 1) * intPageListCnt
			endRnum = startRnum + intPageListCnt

			select_fields = " idx, brand_name, slogan, explain, explain_html, thumb_img, slogan_img, is_show, orderby, reg_id, reg_date, edit_id, edit_date, hm_thumb_img, hm_slogan_img, background_id "

			query = " select " & select_fields & " from T_PROD_BRAND where 1=1 "

			if is_show <> "" then 
                query = query & " and is_show = '" & is_show & "' " 			
			end if
			
			if searchStr <> "" then 
				query = query & " and ( BRAND_NAME like '%" & searchStr & "%' or SLOGAN like '%" & searchStr & "%' or EXPLAIN like '%" & searchStr & "%' ) "
			end if 
			
			query = query & " order by orderby "

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
		
		'리스트 구하기
		Public Function getSearchList(  ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intPageListCnt, intCurPage, strSearchKey, strSearchText, is_show, kind
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList
			Dim startRnum , endRnum

			'변수값 세팅
			intPageListCnt	=  dicParam.Item("page_list_cnt")
			intCurPage			=  dicParam.Item("page")
			is_show			= dicParam.Item("is_show")
			searchStr			= dicParam.Item("searchStr")

			startRnum = (intCurPage - 1) * intPageListCnt
			endRnum = startRnum + intPageListCnt

			select_fields = " idx, brand_name, slogan, explain, explain_html, thumb_img, slogan_img, is_show, orderby, reg_id, reg_date, edit_id, edit_date "

			query = " select top " & intPageListCnt & " " & select_fields & " from T_PROD_BRAND "
			
			query = query & " where idx not in ( "
			query = query & "		select top " & ((intCurPage - 1) * intPageListCnt) & " IDX from T_PROD_BRAND where 1=1 "
			
			if is_show <> "" then 
                query = query & " and is_show = '" & is_show & "' " 			
			end if
			
			if searchStr <> "" then 
				query = query & " and ( BRAND_NAME like '%" & searchStr & "%' or SLOGAN like '%" & searchStr & "%' or EXPLAIN like '%" & searchStr & "%' ) "
			end if 
			
			query = query & " order by orderby "

			query = query & "	) "
			
			if is_show <> "" then 
                query = query & " and is_show = '" & is_show & "' " 			
			end if
			
			if searchStr <> "" then 
				query = query & " and ( BRAND_NAME like '%" & searchStr & "%' or SLOGAN like '%" & searchStr & "%' or EXPLAIN like '%" & searchStr & "%' ) "
			end if 
			
			query = query & " order by orderby "

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getSearchList = arrayList

		End Function 

		'정보 보기
		Public Function getInfo(  ByVal DBHelper, ByVal dicParam )
			
			'변수 선언
			Dim intIdx 
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			intIdx	=  dicParam.Item("idx")

			select_fields = " idx, brand_name, slogan, explain, explain_html, thumb_img, slogan_img, is_show, orderby, reg_id, reg_date, edit_id, edit_date, hm_thumb_img, hm_slogan_img, background_id "

			query = "select " & select_fields & " from T_PROD_BRAND where idx = ? "

			arrParams = Array( _
					DBHelper.MakeParam("@idx", adInteger, adParamInput, 4, dicParam.item("idx")) _
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
		
		'입력
		Public Function insertInfo(ByVal DBHelper, ByVal dicParam)
			
			'변수 선언
			Dim query, arrParams
			
			query =			" insert into T_PROD_BRAND ( "
            query = query & "	 brand_name, slogan, explain, explain_html, thumb_img, slogan_img, is_show, orderby, reg_date, reg_id, hm_thumb_img, hm_slogan_img, background_id "
            query = query & " ) values ( "
    		query = query & "	?, ?, ?, ?, ?, ?, ?, ?, getdate(), ?, ?, ?, ? "
	       	query = query & " ) "

	       	arrParams = Array( _
	       		DBHelper.MakeParam("@brand_name", adVarChar, adParamInput, 200, dicParam.item("brand_name")), _
	       		DBHelper.MakeParam("@slogan", adVarChar, adParamInput, 200, dicParam.item("slogan")), _
	       		DBHelper.MakeParam("@explain", adVarChar, adParamInput, 2147483647, dicParam.item("explain")), _
	       		DBHelper.MakeParam("@explain_html", adVarChar, adParamInput, 2147483647, dicParam.item("explain_html")), _
	       		DBHelper.MakeParam("@thumb_img", adVarChar, adParamInput, 100, dicParam.item("thumb_img")), _
                DBHelper.MakeParam("@slogan_img", adVarChar, adParamInput, 100, dicParam.item("slogan_img")), _
	       		DBHelper.MakeParam("@is_show", adChar, adParamInput, 1, dicParam.item("is_show")), _
	       		DBHelper.MakeParam("@orderby", adInteger, adParamInput, 4, dicParam.item("orderby")), _
	       		DBHelper.MakeParam("@reg_id", adVarChar, adParamInput, 20, dicParam.item("reg_id")), _
	       		DBHelper.MakeParam("@hm_thumb_img", adVarChar, adParamInput, 100, dicParam.item("hm_thumb_img")), _
                DBHelper.MakeParam("@hm_slogan_img", adVarChar, adParamInput, 100, dicParam.item("hm_slogan_img")), _
                DBHelper.MakeParam("@background_id", adVarChar, adParamInput, 50, dicParam.item("background_id")) _
	       	)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'수정
		Public Function editInfo(ByVal DBHelper, ByVal dicParam)
			
			'변수 선언
			Dim query, arrParams

			query = " update T_PROD_BRAND set "
			query = query & " brand_name = ?, "
			query = query & " slogan = ?, "
			query = query & " explain = ?, "
			query = query & " explain_html = ?, "
			query = query & " thumb_img = ?, "
			query = query & " slogan_img = ?, "
          	query = query & " is_show = ?, "
          	query = query & " orderby = ?, "
          	query = query & " hm_thumb_img = ?, "
			query = query & " hm_slogan_img = ?, "
			query = query & " background_id = ?, "
			query = query & " edit_id = ?, "
          	query = query & " edit_date= getdate() "
			query = query & " where idx = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@brand_name", adVarChar, adParamInput, 200, dicParam.item("brand_name")), _
				DBHelper.MakeParam("@slogan", adVarChar, adParamInput, 200, dicParam.item("slogan")), _
	       		DBHelper.MakeParam("@explain", adVarChar, adParamInput, 2147483647, dicParam.item("explain")), _
	       		DBHelper.MakeParam("@explain_html", adVarChar, adParamInput, 2147483647, dicParam.item("explain_html")), _
	       		DBHelper.MakeParam("@thumb_img", adVarChar, adParamInput, 100, dicParam.item("thumb_img")), _
          		DBHelper.MakeParam("@slogan_img", adVarChar, adParamInput, 100, dicParam.item("slogan_img")), _
	       		DBHelper.MakeParam("@is_show", adChar, adParamInput, 1, dicParam.item("is_show")), _
	       		DBHelper.MakeParam("@orderby", adInteger, adParamInput, 4, dicParam.item("orderby")), _
	       		DBHelper.MakeParam("@hm_thumb_img", adVarChar, adParamInput, 100, dicParam.item("hm_thumb_img")), _
                DBHelper.MakeParam("@hm_slogan_img", adVarChar, adParamInput, 100, dicParam.item("hm_slogan_img")), _
                DBHelper.MakeParam("@background_id", adVarChar, adParamInput, 50, dicParam.item("background_id")), _
				DBHelper.MakeParam("@edit_id", adVarChar, adParamInput, 20, dicParam.item("edit_id")), _
				DBHelper.MakeParam("@idx", adInteger, adParamInput, 4, dicParam.item("idx")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'삭제
		Public Function deleteInfo( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim query, arrParams

			'게시판 삭제
			query = " delete from T_PROD_BRAND "
			query = query & " where idx = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@idx", adInteger, adParamInput, 4, dicParam.item("idx")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

	End Class
%>
