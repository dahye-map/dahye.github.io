<%
	Class NoticeCls

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
			is_show 		= dicParam.Item("is_show")

			query = "select ceiling(cast(count(*) as float)/" & intPageListCnt & "), count(*) from NOTICE "
			query = query & " WHERE 1=1 "
			If is_show = "Y" Then 
				query = query & " and is_show = 'Y' "
			End If 

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
			intPageListCnt	=  dicParam.Item("page_list_cnt")
			intCurPage		=  dicParam.Item("page")
			is_show		=  dicParam.Item("is_show")

			startRnum = (intCurPage - 1) * intPageListCnt
			endRnum = startRnum + intPageListCnt

			select_fields = " seq, title, contents, contents_html, reg_date, view_cnt, is_show "

			query = " select top " & intPageListCnt & " " & select_fields & " from NOTICE "
			
			query = query & " where SEQ not in ( "
			query = query & "		select top " & ((intCurPage - 1) * intPageListCnt) & " SEQ from NOTICE "

			if is_show = "Y" then 
				query = query & "		where is_show = 'Y' "
			end if 

			query = query & "		order by SEQ desc "

			query = query & "	) "

			if is_show = "Y" then 
				query = query & "	and is_show = 'Y' "
			end if 


			query = query & " order by seq desc "

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

			select_fields = "seq, title, contents, contents_html, reg_date, view_cnt, is_show "

			query = "select " & select_fields & " from NOTICE where seq = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@seq", adInteger, adParamInput, 30, dicParam.item("seq")) _
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
			Dim intSeq, is_show 
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			intSeq		=  dicParam.Item("seq")
			is_show	=  dicParam.Item("is_show")

			select_fields = "seq, title, reg_date, view_cnt "

			query = "select " & select_fields & " from NOTICE where seq = ( "
			query = query & "	select min(seq) from NOTICE where seq > ? "
			
			if is_show = "Y" then 
				query = query & "		and is_show = 'Y' "
			end if 
			
			query = query & " ) "

			if is_show = "Y" then 
				query = query & "		and is_show = 'Y' "
			end if 

			arrParams = Array( _
				DBHelper.MakeParam("@seq", adInteger, adParamInput, 30, dicParam.item("seq")) _
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
			intSeq		=  dicParam.Item("seq")
			is_show	=  dicParam.Item("is_show")

			select_fields = "seq, title, reg_date, view_cnt "

			query = "select " & select_fields & " from NOTICE where seq = ( "
			query = query & "	select max(seq) from NOTICE where seq < ? "
			
			if is_show = "Y" then 
				query = query & "		and is_show = 'Y' "
			end if 
			
			query = query & " ) "

			if is_show = "Y" then 
				query = query & "		and is_show = 'Y' "
			end if 

			arrParams = Array( _
				DBHelper.MakeParam("@seq", adInteger, adParamInput, 30, dicParam.item("seq")) _
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

			query =			" insert into NOTICE ( "
			query = query & "	 title, contents, contents_html, reg_date, view_cnt, is_show "
			query = query & " ) values ( "
			query = query & "	?, ?, ?, getdate(), 0, ? "
			query = query & " ) "

			arrParams = Array( _
				DBHelper.MakeParam("@title", adVarChar, adParamInput, 200, dicParam.item("title")), _
				DBHelper.MakeParam("@contents", adVarChar, adParamInput, 2147483647, dicParam.item("contents")), _
				DBHelper.MakeParam("@contents_html", adVarChar, adParamInput, 2147483647, dicParam.item("contents_html")), _
				DBHelper.MakeParam("@is_show", adVarChar, adParamInput, 1, dicParam.item("is_show")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'수정
		Public Function editInfo(ByVal DBHelper, ByVal dicParam)
			
			'변수 선언
			Dim query, arrParams

			query = " update T_NOTICE set "
			query = query & " title = ?, "
			query = query & " contents = ?, "
			query = query & " contents_html = ?, "
			query = query & " is_show = ? "

			query = query & " where seq = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@title", adVarChar, adParamInput, 200, dicParam.item("title")), _
				DBHelper.MakeParam("@contents", adVarChar, adParamInput, 2147483647, dicParam.item("contents")), _
				DBHelper.MakeParam("@contents_html", adVarChar, adParamInput, 2147483647, dicParam.item("contents_html")), _
				DBHelper.MakeParam("@is_show", adVarChar, adParamInput, 1, dicParam.item("is_show")), _
				DBHelper.MakeParam("@seq", adInteger, adParamInput, 4, dicParam.item("seq")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'삭제
		Public Function deleteInfo( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim query, arrParams

			'게시판 삭제
			query = " delete from NOTICE "
			query = query & " where seq = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@seq", adInteger, adParamInput, 4, dicParam.item("seq")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'조회수 올리기
		Public Function upViewCntInfo( ByVal DBHelper, ByVal dicParam )

			
			'변수 선언
			Dim query, arrParams

			query = " update NOTICE set "
			query = query & " view_cnt = view_cnt + 1 "
			query = query & " where seq = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@seq", adInteger, adParamInput, 4, dicParam.item("seq")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function
	

	End Class
%>
