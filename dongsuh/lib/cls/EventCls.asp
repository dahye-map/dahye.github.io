<%
	Class EventCls

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
			gubun 				= dicParam.Item("gubun")
			is_ing 			= dicParam.Item("is_ing")
			searchStr			= dicParam.Item("searchStr")

			query = "select ceiling(cast(count(*) as float)/" & intPageListCnt & "), count(*) from T_EVENT "
			query = query & " WHERE 1=1 "

			If gubun <> "" Then
				query = query & " and gubun = '" & gubun & "' "
			End If

			If is_show = "Y" Then
				query = query & " and is_show = 'Y' "
			End If

			If is_ing = "Y" Then
				query = query & " and is_ing = 'Y' and start_date <= CONVERT(varchar(10), getdate(), 23) and end_date >= CONVERT(varchar(10), getdate(), 23) "
			End If

			if searchStr <> "" then
				query = query & " and ( TITLE like '%" & searchStr & "%' or PLACE like '%" & searchStr & "%' or GOODS like '%" & searchStr & "%' ) "
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
			is_show		  	= dicParam.Item("is_show")
			m_is_show		  	= dicParam.Item("m_is_show")
			gubun           	= dicParam.Item("gubun")
			is_ing 			= dicParam.Item("is_ing")
			searchStr			= dicParam.Item("searchStr")

			startRnum = (intCurPage - 1) * intPageListCnt
			endRnum = startRnum + intPageListCnt

			select_fields = " idx, title, start_date, end_date, is_ing, place, period, goods, contents, contents_html, show_date, view_cnt, is_show, banner_img, reg_date, reg_id, edit_date, edit_id, thumb_img, m_is_show, link_url, m_link_url, m_contents, m_contents_html, link_target, m_link_target "

			query = " select top " & intPageListCnt & " " & select_fields & " from T_EVENT "

			query = query & " where idx not in ( "
			query = query & "		select top " & ((intCurPage - 1) * intPageListCnt) & " idx from T_EVENT where 1=1"

            If gubun <> "" Then
				query = query & " and gubun = '" & gubun & "' "
			End If

			if is_show = "Y" then
				query = query & "		and is_show = 'Y' "
			end if

			if m_is_show = "Y" then
				query = query & "		and m_is_show = 'Y' "
			end if

			If is_ing = "Y" Then
				query = query & " and is_ing = 'Y' and start_date <= CONVERT(varchar(10), getdate(), 23) and end_date >= CONVERT(varchar(10), getdate(), 23) "
			End If

			if searchStr <> "" then
				query = query & " and ( TITLE like '%" & searchStr & "%' or PLACE like '%" & searchStr & "%' or GOODS like '%" & searchStr & "%' ) "
			end if

			query = query & "		order by idx desc "

			query = query & "	) "

			If gubun <> "" Then
				query = query & " and gubun = '" & gubun & "' "
			End If

			if is_show = "Y" then
				query = query & "	and is_show = 'Y' "
			end if

			if m_is_show = "Y" then
				query = query & "		and m_is_show = 'Y' "
			end if

			If is_ing = "Y" Then
				query = query & " and is_ing = 'Y' and start_date <= CONVERT(varchar(10), getdate(), 23) and end_date >= CONVERT(varchar(10), getdate(), 23) "
			End If

			if searchStr <> "" then
				query = query & " and ( TITLE like '%" & searchStr & "%' or PLACE like '%" & searchStr & "%' or GOODS like '%" & searchStr & "%' ) "
			end if

			query = query & " order by idx desc "

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

		Public Function getRelationList(  ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intPageListCnt, intCurPage, strSearchKey, strSearchText, is_show, kind
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList
			Dim startRnum , endRnum

			'변수값 세팅
			relation_idx	=  dicParam.Item("relation_idx")

			select_fields = " idx, title, start_date, end_date, is_ing, place, period, goods, contents, contents_html, show_date, view_cnt, is_show, banner_img, reg_date, reg_id, edit_date, edit_id "

			query = " select " & select_fields & " from T_EVENT a inner join T_PROD_RELATION b on (b.GUBUN = 'EVENT' and a.IDX = b.RELATION_IDX) "
			query = query & " where a.IS_SHOW = 'Y' and b.PRODUCT_IDX = ? "
			query = query & " order by IDX desc"

			arrParams = Array( _
				DBHelper.MakeParam("@PRODUCT_IDX", adInteger, adParamInput, 4, dicParam.item("product_idx")) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getRelationList = arrayList

		end Function

		'정보 보기
		Public Function getInfo(  ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intSeq
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			intIdx	=  dicParam.Item("idx")

			select_fields = " idx, title, start_date, end_date, is_ing, place, period, goods, contents, contents_html, show_date, view_cnt, is_show, banner_img, reg_date, reg_id, edit_date, edit_id, thumb_img, m_is_show, link_url, m_link_url, m_contents, m_contents_html, link_target, m_link_target "

			query = "select " & select_fields & " from T_EVENT  where idx = ? "

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

		'이전 정보 보기
		Public Function getPrevInfo(  ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intIdx, is_show
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			intIdx		=  dicParam.Item("idx")
			is_show	=  dicParam.Item("is_show")
			is_ing 			= dicParam.Item("is_ing")

			select_fields = " idx, title, start_date, end_date, is_ing, place, period, goods, contents, contents_html, show_date, view_cnt, is_show, banner_img, reg_date, reg_id, edit_date, edit_id "

			query =         	" select top 1 " & select_fields & " from "
			query = query & 	" ( "
			query = query & 	" 	select * from T_EVENT where show_date > (select show_date from T_EVENT where idx = ?) "
			if is_show = "Y" then
				query = query & "		and is_show = 'Y' "
			end if
			If is_ing = "Y" Then
				query = query & " and is_ing = 'Y' and start_date <= CONVERT(varchar(10), getdate(), 23) and end_date >= CONVERT(varchar(10), getdate(), 23) "
			End If
			query = query & 	" 	union all "
			query = query & 	" 	select * from T_EVENT where show_date = (select show_date from T_EVENT where idx = ?) and idx > ? "
			if is_show = "Y" then
				query = query & "		and is_show = 'Y' "
			end if
			If is_ing = "Y" Then
				query = query & " and is_ing = 'Y' and start_date <= CONVERT(varchar(10), getdate(), 23) and end_date >= CONVERT(varchar(10), getdate(), 23) "
			End If
			query = query & 	" ) t "

			arrParams = Array( _
				DBHelper.MakeParam("@idx", adInteger, adParamInput, 4, dicParam.item("idx")), _
				DBHelper.MakeParam("@idx", adInteger, adParamInput, 4, dicParam.item("idx")), _
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
			is_show	=  dicParam.Item("is_show")
			is_ing 			= dicParam.Item("is_ing")

			select_fields = " idx, title, start_date, end_date, is_ing, place, period, goods, contents, contents_html, show_date, view_cnt, is_show, banner_img, reg_date, reg_id, edit_date, edit_id "

			query =         	" select top 1 " & select_fields & " from "
			query = query & 	" ( "
			query = query & 	" 	select * from T_EVENT where show_date < (select show_date from T_EVENT where idx = ?) "
			if is_show = "Y" then
				query = query & "		and is_show = 'Y' "
			end if
			If is_ing = "Y" Then
				query = query & " and is_ing = 'Y' and start_date <= CONVERT(varchar(10), getdate(), 23) and end_date >= CONVERT(varchar(10), getdate(), 23) "
			End If
			query = query & 	" 	union all "
			query = query & 	" 	select * from T_EVENT where show_date = (select show_date from T_EVENT where idx = ?) and idx < ? "
			if is_show = "Y" then
				query = query & "		and is_show = 'Y' "
			end if
			If is_ing = "Y" Then
				query = query & " and is_ing = 'Y' and start_date <= CONVERT(varchar(10), getdate(), 23) and end_date >= CONVERT(varchar(10), getdate(), 23) "
			End If
			query = query & 	" ) t "

			arrParams = Array( _
				DBHelper.MakeParam("@idx", adInteger, adParamInput, 4, dicParam.item("idx")), _
				DBHelper.MakeParam("@idx", adInteger, adParamInput, 4, dicParam.item("idx")), _
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

			getNextInfo = arrayList

		End Function

		'입력
		Public Function insertInfo(ByVal DBHelper, ByVal dicParam)

			'변수 선언
			Dim query, arrParams

			query =			" insert into T_EVENT ( "
			query = query & "	 title, start_date, end_date, is_ing, place, period, goods, contents, contents_html, banner_img, show_date, view_cnt, is_show, reg_date, reg_id, thumb_img, m_is_show, link_url, m_link_url, m_contents, m_contents_html, link_target, m_link_target "
			query = query & " ) values ( "
			query = query & "	?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,  0, ?, getdate(), ?, ?, ?, ?, ?, ?, ?, ?, ? "
			query = query & " ) "

			arrParams = Array( _
				DBHelper.MakeParam("@title", adVarChar, adParamInput, 200, dicParam.item("title")), _
				DBHelper.MakeParam("@start_date", adVarChar, adParamInput, 10, dicParam.item("start_date")), _
				DBHelper.MakeParam("@end_date", adVarChar, adParamInput, 10, dicParam.item("end_date")), _
				DBHelper.MakeParam("@is_ing", adChar, adParamInput, 1, dicParam.item("is_ing")), _
				DBHelper.MakeParam("@place", adVarChar, adParamInput, 200, dicParam.item("place")), _
				DBHelper.MakeParam("@period", adVarChar, adParamInput, 200, dicParam.item("period")), _
				DBHelper.MakeParam("@goods", adVarChar, adParamInput, 200, dicParam.item("goods")), _
				DBHelper.MakeParam("@contents", adVarChar, adParamInput, 2147483647, dicParam.item("contents")), _
				DBHelper.MakeParam("@contents_html", adVarChar, adParamInput, 2147483647, dicParam.item("contents_html")), _
				DBHelper.MakeParam("@banner_img", adVarChar, adParamInput, 200, dicParam.item("banner_img")), _
				DBHelper.MakeParam("@show_date", adVarChar, adParamInput, 10, dicParam.item("show_date")), _
				DBHelper.MakeParam("@is_show", adChar, adParamInput, 1, dicParam.item("is_show")), _
				DBHelper.MakeParam("@reg_id", adVarChar, adParamInput, 20, dicParam.item("reg_id")), _
				DBHelper.MakeParam("@thumb_img", adVarChar, adParamInput, 100, dicParam.item("thumb_img")), _
				DBHelper.MakeParam("@m_is_show", adVarChar, adParamInput, 1, dicParam.item("m_is_show")), _
				DBHelper.MakeParam("@link_url", adVarChar, adParamInput, 200, dicParam.item("link_url")), _
				DBHelper.MakeParam("@m_link_url", adVarChar, adParamInput, 200, dicParam.item("m_link_url")), _
				DBHelper.MakeParam("@contents_html", adVarChar, adParamInput, 2147483647, dicParam.item("contents_html")), _
				DBHelper.MakeParam("@m_contents_html", adVarChar, adParamInput, 2147483647, dicParam.item("m_contents_html")), _
				DBHelper.MakeParam("@link_target", adVarChar, adParamInput, 20, dicParam.item("link_target")), _
				DBHelper.MakeParam("@m_link_target", adVarChar, adParamInput, 20, dicParam.item("m_link_target")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'수정
		Public Function editInfo(ByVal DBHelper, ByVal dicParam)

			'변수 선언
			Dim query, arrParams

			query = " update T_EVENT set "
            query = query & " title = ?, "
            query = query & " start_date = ?, "
            query = query & " end_date = ?, "
            query = query & " is_ing = ?, "
            query = query & " place = ?, "
            query = query & " period = ?, "
            query = query & " goods = ?, "
			query = query & " contents = ?, "
			query = query & " contents_html = ?, "
			query = query & " banner_img = ?, "
			query = query & " thumb_img = ?, "
			query = query & " is_show = ?, "
			query = query & " edit_id = ?, "
			query = query & " edit_date = getdate(), "

			query = query & " m_is_show = ?, "
			query = query & " link_url = ?, "
			query = query & " m_link_url = ?, "
			query = query & " m_contents = ?, "
			query = query & " m_contents_html = ?, "
			query = query & " link_target = ?, "
			query = query & " m_link_target = ? "

			query = query & " where idx = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@title", adVarChar, adParamInput, 200, dicParam.item("title")), _
				DBHelper.MakeParam("@start_date", adVarChar, adParamInput, 10, dicParam.item("start_date")), _
				DBHelper.MakeParam("@end_date", adVarChar, adParamInput, 10, dicParam.item("end_date")), _
				DBHelper.MakeParam("@is_ing", adChar, adParamInput, 1, dicParam.item("is_ing")), _
				DBHelper.MakeParam("@place", adVarChar, adParamInput, 200, dicParam.item("place")), _
				DBHelper.MakeParam("@period", adVarChar, adParamInput, 200, dicParam.item("period")), _
				DBHelper.MakeParam("@goods", adVarChar, adParamInput, 200, dicParam.item("goods")), _
				DBHelper.MakeParam("@contents", adVarChar, adParamInput, 2147483647, dicParam.item("contents")), _
				DBHelper.MakeParam("@contents_html", adVarChar, adParamInput, 2147483647, dicParam.item("contents_html")), _
                DBHelper.MakeParam("@banner_img", adVarChar, adParamInput, 200, dicParam.item("banner_img")), _
                DBHelper.MakeParam("@thumb_img", adVarChar, adParamInput, 200, dicParam.item("thumb_img")), _
				DBHelper.MakeParam("@is_show", adChar, adParamInput, 1, dicParam.item("is_show")), _
				DBHelper.MakeParam("@edit_id", adVarChar, adParamInput, 20, dicParam.item("edit_id")), _
				DBHelper.MakeParam("@m_is_show", adVarChar, adParamInput, 1, dicParam.item("m_is_show")), _
				DBHelper.MakeParam("@link_url", adVarChar, adParamInput, 200, dicParam.item("link_url")), _
				DBHelper.MakeParam("@m_link_url", adVarChar, adParamInput, 200, dicParam.item("m_link_url")), _
				DBHelper.MakeParam("@m_contents", adVarChar, adParamInput, 2147483647, dicParam.item("m_contents")), _
				DBHelper.MakeParam("@m_contents_html", adVarChar, adParamInput, 2147483647, dicParam.item("m_contents_html")), _
				DBHelper.MakeParam("@link_target", adVarChar, adParamInput, 20, dicParam.item("link_target")), _
				DBHelper.MakeParam("@m_link_target", adVarChar, adParamInput, 20, dicParam.item("m_link_target")), _
				DBHelper.MakeParam("@idx", adInteger, adParamInput, 4, dicParam.item("idx")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'삭제
		Public Function deleteInfo( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim query, arrParams

			'게시판 삭제
			query = " delete from T_EVENT "
			query = query & " where idx = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@idx", adInteger, adParamInput, 4, dicParam.item("idx")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'조회수 올리기
		Public Function upViewCntInfo( ByVal DBHelper, ByVal dicParam )


			'변수 선언
			Dim query, arrParams

			query = " update T_EVENT set "
			query = query & " view_cnt = view_cnt + 1 "
			query = query & " where idx = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@idx", adInteger, adParamInput, 4, dicParam.item("idx")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'Product_View 이벤트 리스트 구하기
		Public Function getProDEventList(  ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intPageListCnt, intCurPage, strSearchKey, strSearchText, is_show, kind
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList
			Dim startRnum , endRnum

			'변수값 세팅
			intPageListCnt	= dicParam.Item("page_list_cnt")

			select_fields = "  IDX, TITLE, PERIOD, THUMB_IMG, IS_ING    "

			query = " SELECT TOP "& intPageListCnt &" "& select_fields & " From T_EVENT "
			query = query & "WHERE IDX IN ( "
			query = query & "SELECT DISTINCT RELATION_IDX FROM T_PROD_RELATION "
			query = query & "WHERE PRODUCT_IDX = ? and GUBUN = ? "
			query = query & " ) and IS_SHOW = 'Y' "
			query = query & " ORDER BY REG_DATE DESC "

 			arrParams = Array( _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("idx")), _
				DBHelper.MakeParam("@GUBUN", adVarChar, adParamInput, 50, dicParam.item("gubun")) _
			)

 			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getProDEventList = arrayList

		End Function

		'오픈이벤트 리스트
		'갯수 구하기
		Public Function getEvent170919TotalCnt( ByVal DBHelper, ByVal dicParam )
			'변수 선언
			Dim intPageListCnt, strSearchKey, strSearchText, is_show, kind, gubun
			Dim query, objRs, arrParams
			Dim arrayList

			'변수값 세팅
			intPageListCnt	=  dicParam.Item("page_list_cnt")
			is_show 		= dicParam.Item("is_show")

			query = "select ceiling(cast(count(*) as float)/" & intPageListCnt & "), count(*) from dongsuh.event_170919 "
			'query = query & " WHERE 1=1 "

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getEvent170919TotalCnt = arrayList

		End Function

		'리스트 구하기
		Public Function getEvent170919List(  ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intPageListCnt, intCurPage, strSearchKey, strSearchText, is_show, kind
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList
			Dim startRnum , endRnum

			'변수값 세팅
			intPageListCnt	=  dicParam.Item("page_list_cnt")
			intCurPage		=  dicParam.Item("page")
			'is_show		=  dicParam.Item("is_show")

			startRnum = (intCurPage - 1) * intPageListCnt
			endRnum = startRnum + intPageListCnt

			select_fields = " idx, dept, name, sabun, kind, cnt, title, reg_date, reg_ip "

			query = " select top " & intPageListCnt & " " & select_fields & " from dongsuh.event_170919 "

			query = query & " where idx not in ( "
			query = query & "		select top " & ((intCurPage - 1) * intPageListCnt) & " idx from dongsuh.event_170919 "

			query = query & "		order by idx desc "

			query = query & "	) "

			query = query & " order by idx desc "

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getEvent170919List = arrayList

		End Function

		'오픈이벤트 등록
		Public Function insertEvent170919Info(ByVal DBHelper, ByVal dicParam)

			'변수 선언
			Dim query, arrParams

			query =			" insert into dongsuh.event_170919 ( "
			query = query & "	 dept, name, sabun, kind, cnt, title, contents, reg_date, reg_ip "
			query = query & " ) values ( "
			query = query & "	?, ?, ?, ?, ?, ?, ?, getdate(), ? "
			query = query & " ) "

			arrParams = Array( _
				DBHelper.MakeParam("@dept", adVarChar, adParamInput, 100, dicParam.item("dept")), _
				DBHelper.MakeParam("@name", adVarChar, adParamInput, 100, dicParam.item("name")), _
				DBHelper.MakeParam("@sabun", adVarChar, adParamInput, 20, dicParam.item("sabun")), _
				DBHelper.MakeParam("@kind", adInteger, adParamInput, 4, dicParam.item("kind")), _
				DBHelper.MakeParam("@cnt", adInteger, adParamInput, 4, dicParam.item("cnt")), _
				DBHelper.MakeParam("@title", adVarChar, adParamInput, 200, dicParam.item("title")), _
				DBHelper.MakeParam("@contents", adVarChar, adParamInput, 2147483647, dicParam.item("contents")), _
				DBHelper.MakeParam("@reg_ip", adVarChar, adParamInput, 20, dicParam.item("reg_ip")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'오픈 이벤트 내용 보기
		Public Function getEvent170919Info(  ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intSeq
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			intSeq	=  dicParam.Item("seq")

			select_fields = " idx, dept, name, sabun, kind, cnt, title, contents, reg_date, reg_ip "

			query = "select " & select_fields & " from dongsuh.event_170919 where idx = ? "

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

			getEvent170919Info = arrayList

		End Function

		'오픈 이벤트 수정
		Public Function editEvent170919Info(ByVal DBHelper, ByVal dicParam)

			'변수 선언
			Dim query, arrParams

			query = " update dongsuh.event_170919 set "
			query = query & " dept = ?, "
			query = query & " name = ?, "
			query = query & " sabun = ?, "
			query = query & " kind = ?, "
			query = query & " cnt = ?, "
			query = query & " title = ?, "
			query = query & " contents = ?, "
			query = query & " reg_ip = ? "

			query = query & " where idx = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@dept", adVarChar, adParamInput, 100, dicParam.item("dept")), _
				DBHelper.MakeParam("@name", adVarChar, adParamInput, 100, dicParam.item("name")), _
				DBHelper.MakeParam("@sabun", adVarChar, adParamInput, 20, dicParam.item("sabun")), _
				DBHelper.MakeParam("@kind", adInteger, adParamInput, 4, dicParam.item("kind")), _
				DBHelper.MakeParam("@cnt", adInteger, adParamInput, 4, dicParam.item("cnt")), _
				DBHelper.MakeParam("@title", adVarChar, adParamInput, 200, dicParam.item("title")), _
				DBHelper.MakeParam("@contents", adVarChar, adParamInput, 2147483647, dicParam.item("contents")), _
				DBHelper.MakeParam("@reg_ip", adVarChar, adParamInput, 20, dicParam.item("reg_ip")), _
				DBHelper.MakeParam("@idx", adInteger, adParamInput, 4, dicParam.item("idx")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'오픈 이벤트 삭제
		Public Function deleteEvent170919Info( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim query, arrParams

			'게시판 삭제
			query = " delete from dongsuh.event_170919 "
			query = query & " where idx = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@idx", adInteger, adParamInput, 4, dicParam.item("idx")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

	End Class
%>
