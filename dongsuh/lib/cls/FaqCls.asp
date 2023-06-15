<%
	Class FaqCls

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
			searchStr			= dicParam.Item("searchStr")

			query = "select ceiling(cast(count(*) as float)/" & intPageListCnt & "), count(*) from V_FAQ "
			query = query & " WHERE 1=1 "

			If gubun <> "" Then
				query = query & " and gubun = '" & gubun & "' "
			End If

			If is_show = "Y" Then
				query = query & " and is_show = 'Y' "
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
			is_show		   	= dicParam.Item("is_show")
			gubun            	= dicParam.Item("gubun")
			searchStr			= dicParam.Item("searchStr")

			startRnum = (intCurPage - 1) * intPageListCnt
			endRnum = startRnum + intPageListCnt

			select_fields = " idx, gubun, gubun_name, title, contents, contents_html, view_cnt, is_show, reg_date, reg_id, edit_date, edit_id "

			query = " select top " & intPageListCnt & " " & select_fields & " from V_FAQ "

			query = query & " where idx not in ( "
			query = query & "		select top " & ((intCurPage - 1) * intPageListCnt) & " idx from V_FAQ where 1=1"

            If gubun <> "" Then
				query = query & " and gubun = '" & gubun & "' "
			End If

			if is_show = "Y" then
				query = query & "		and is_show = 'Y' "
			end if

			if searchStr <> "" then
				query = query & " and ( TITLE like '%" & searchStr & "%' or CONTENTS like '%" & searchStr & "%' ) "
			end if

			query = query & "		order by idx asc "

			query = query & "	) "

			If gubun <> "" Then
				query = query & " and gubun = '" & gubun & "' "
			End If

			if is_show = "Y" then
				query = query & "	and is_show = 'Y' "
			end if

			if searchStr <> "" then
				query = query & " and ( TITLE like '%" & searchStr & "%' or CONTENTS like '%" & searchStr & "%' ) "
			end if

			query = query & " order by idx asc "

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
		Public Function getInfo(  ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intSeq
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			intSeq	=  dicParam.Item("seq")

			select_fields = " idx, gubun, gubun_name, title, contents, contents_html, view_cnt, is_show, reg_date, reg_id, edit_date, edit_id "

			query = "select " & select_fields & " from V_FAQ  where idx = ? "

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

			query =			" insert into T_FAQ ( "
			query = query & "	 gubun, title, contents, contents_html, view_cnt, is_show, reg_date, reg_id "
			query = query & " ) values ( "
			query = query & "	?, ?, ?, ?, 0, ?, getdate(), ? "
			query = query & " ) "

			arrParams = Array( _
				DBHelper.MakeParam("@gubun", adVarChar, adParamInput, 20, dicParam.item("gubun")), _
				DBHelper.MakeParam("@title", adVarChar, adParamInput, 200, dicParam.item("title")), _
				DBHelper.MakeParam("@contents", adVarChar, adParamInput, 2147483647, dicParam.item("contents")), _
				DBHelper.MakeParam("@contents_html", adVarChar, adParamInput, 2147483647, dicParam.item("contents_html")), _
				DBHelper.MakeParam("@is_show", adChar, adParamInput, 1, dicParam.item("is_show")), _
				DBHelper.MakeParam("@reg_id", adVarChar, adParamInput, 20, dicParam.item("reg_id")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'수정
		Public Function editInfo(ByVal DBHelper, ByVal dicParam)

			'변수 선언
			Dim query, arrParams

			query = " update T_FAQ set "
			query = query & " gubun = ?, "
            query = query & " title = ?, "
			query = query & " contents = ?, "
			query = query & " contents_html = ?, "
			query = query & " is_show = ?, "
			query = query & " edit_id = ?, "
			query = query & " edit_date = getdate() "
			query = query & " where idx = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@gubun", adVarChar, adParamInput, 20, dicParam.item("gubun")), _
				DBHelper.MakeParam("@title", adVarChar, adParamInput, 200, dicParam.item("title")), _
				DBHelper.MakeParam("@contents", adVarChar, adParamInput, 2147483647, dicParam.item("contents")), _
				DBHelper.MakeParam("@contents_html", adVarChar, adParamInput, 2147483647, dicParam.item("contents_html")), _
				DBHelper.MakeParam("@is_show", adVarChar, adParamInput, 1, dicParam.item("is_show")), _
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
			query = " delete from T_FAQ "
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

			query = " update T_FAQ set "
			query = query & " view_cnt = view_cnt + 1 "
			query = query & " where idx = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@idx", adInteger, adParamInput, 4, dicParam.item("idx")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'고객 문의 관련
		Public Function getCounsel( DBHelper )

			'변수 선언
			Dim intSeq
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList, rtnList

			'변수값 세팅

			query = " select top 1 counsel from dongsuh.faq_list where ftype='disc' order by idx desc "

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
				rtnList = arrayList(0, 0)
			Else
				rtnList = false
			end if

			objRs.close
			set objRs = nothing

			getCounsel = rtnList

		End function

		Public Function insertFaqList( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim strGubun
			Dim ftype, writer, email, tel, zipcode, addr, goods, period, ip, wdate, content, filename, weight, counsel, period_time, period_factory, confirm_gubun
			Dim query, arrParams

			'변수값 세팅
			ftype			=  dicParam.Item("gubun")
			writer			=  dicParam.Item("name")
			email			=  dicParam.Item("email")
			tel				=  dicParam.Item("tel")
			zipcode			=  dicParam.Item("zip")
			addr			=  dicParam.Item("addr")
			goods			=  dicParam.Item("goods")
			period			=  dicParam.Item("period")
			ip				=  dicParam.Item("userip")
			content			=  dicParam.Item("con")
			filename		=  dicParam.Item("file")
			weight			=  dicParam.Item("weight")
			counsel			=  dicParam.Item("strCounsel")
			period_time		=  dicParam.Item("strTime")
			period_factory	=  dicParam.Item("strFactory")
			confirm_gubun	=  dicParam.Item("strConfirm")

			if gubun="disc" Then
				query = 		" insert into dongsuh.faq_list( "
				query = query & " ftype, writer, email, tel, zipcode, addr, goods, period, ip, wdate, content, filename, weight, counsel, period_time, period_factory, confirm_gubun "
				query = query & " ) values ("
				query = query & " ?, ?, ?, ?, ?, ?, ?, ?, ?, getdate(), ?, ?, ?, ?, ?, ?, ? "
				query = query & " ) "

				arrParams = Array( _
					DBHelper.MakeParam("@ftype", adVarChar, adParamInput, 20, ftype), _
					DBHelper.MakeParam("@writer", adVarChar, adParamInput, 100, writer), _
					DBHelper.MakeParam("@email", adVarChar, adParamInput, 300, email), _
					DBHelper.MakeParam("@tel", adVarChar, adParamInput, 20, tel), _
					DBHelper.MakeParam("@zipcode", adVarChar, adParamInput, 10, zipcode), _
					DBHelper.MakeParam("@addr", adVarChar, adParamInput, 500, addr), _
					DBHelper.MakeParam("@goods", adVarChar, adParamInput, 200, goods), _
					DBHelper.MakeParam("@period", adVarChar, adParamInput, 15, period), _
					DBHelper.MakeParam("@ip", adVarChar, adParamInput, 50, ip), _
					DBHelper.MakeParam("@content", adVarChar, adParamInput, 2147483647, content), _
					DBHelper.MakeParam("@filename", adVarChar, adParamInput, 50, filename), _
					DBHelper.MakeParam("@weight", adVarChar, adParamInput, 50, weight), _
					DBHelper.MakeParam("@counsel", adVarChar, adParamInput, 1, counsel), _
					DBHelper.MakeParam("@period_time", adVarChar, adParamInput, 6, period_time), _
					DBHelper.MakeParam("@period_factory", adVarChar, adParamInput, 50, period_factory), _
					DBHelper.MakeParam("@confirm_gubun", adVarChar, adParamInput, 3, confirm_gubun) _
				)
			else
				query = 		" insert into dongsuh.faq_list( "
				query = query & " ftype,	writer,	email,	tel,	zipcode,	addr,	goods,	period,	ip,	wdate,	content,	filename,	weight,	confirm_gubun "
				query = query & " ) values ( "
				query = query & " ?, ?, ? , ?, ?, ?, ?, ?, ?, getdate(), ?, ?, ?, ? "
				query = query & " ) "

				arrParams = Array( _
					DBHelper.MakeParam("@ftype", adVarChar, adParamInput, 20, ftype), _
					DBHelper.MakeParam("@writer", adVarChar, adParamInput, 100, writer), _
					DBHelper.MakeParam("@email", adVarChar, adParamInput, 300, email), _
					DBHelper.MakeParam("@tel", adVarChar, adParamInput, 20, tel), _
					DBHelper.MakeParam("@zipcode", adVarChar, adParamInput, 10, zipcode), _
					DBHelper.MakeParam("@addr", adVarChar, adParamInput, 500, addr), _
					DBHelper.MakeParam("@goods", adVarChar, adParamInput, 200, goods), _
					DBHelper.MakeParam("@period", adVarChar, adParamInput, 15, period), _
					DBHelper.MakeParam("@ip", adVarChar, adParamInput, 50, ip), _
					DBHelper.MakeParam("@content", adVarChar, adParamInput, 2147483647, content), _
					DBHelper.MakeParam("@filename", adVarChar, adParamInput, 50, filename), _
					DBHelper.MakeParam("@weight", adVarChar, adParamInput, 50, weight), _
					DBHelper.MakeParam("@confirm_gubun", adVarChar, adParamInput, 3, confirm_gubun) _
				)
			End If

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

	End Class
%>
