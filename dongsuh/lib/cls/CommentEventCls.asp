<%
	Class CommentEventCls

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

			query = "select ceiling(cast(count(*) as float)/" & intPageListCnt & "), count(*) from T_COMMENT_EVENT "
			query = query & " WHERE event_id = ? and board_idx = ? "
			
			arrParams = Array( _
				DBHelper.MakeParam("@event_id", adVarChar, adParamInput, 20, dicParam.item("event_id")), _
				DBHelper.MakeParam("@board_idx", adInteger, adParamInput, 4, dicParam.item("board_idx")) _
			)


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
			gubun           	= dicParam.Item("gubun")
			is_ing 			= dicParam.Item("is_ing")
			searchStr			= dicParam.Item("searchStr")

			startRnum = (intCurPage - 1) * intPageListCnt
			endRnum = startRnum + intPageListCnt

			select_fields = " idx, event_id, board_idx, name, phone1, phone2, phone3, comment, agree, reg_date, reg_ip "

			query = " select top " & intPageListCnt & " " & select_fields & " from T_COMMENT_EVENT "
			
			query = query & " where event_id = ? and board_idx = ? and idx not in ( "
			query = query & "		select top " & ((intCurPage - 1) * intPageListCnt) & " idx from T_COMMENT_EVENT where event_id = ? and board_idx = ? "
			query = query & "		order by idx desc "
			query = query & "	) "
			query = query & " order by idx desc "
			
			arrParams = Array( _
				DBHelper.MakeParam("@event_id", adVarChar, adParamInput, 20, dicParam.item("event_id")), _
				DBHelper.MakeParam("@board_idx", adInteger, adParamInput, 4, dicParam.item("board_idx")), _
				DBHelper.MakeParam("@event_id", adVarChar, adParamInput, 20, dicParam.item("event_id")), _
				DBHelper.MakeParam("@board_idx", adInteger, adParamInput, 4, dicParam.item("board_idx")) _
			)

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
			intIdx	=  dicParam.Item("idx")

			select_fields = " idx, event_id, board_idx, name, phone1, phone2, phone3, comment, agree, reg_date, reg_ip "

			query = "select " & select_fields & " from T_COMMENT_EVENT  where idx = ? "

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

			query =			" insert into T_COMMENT_EVENT ( "
			query = query & 	"	event_id, board_idx, name, phone1, phone2, phone3, comment, agree, reg_date, reg_ip "
			query = query & 	" ) values ( "
			query = query & 	"	?, ?, ?, ?, ?, ?, ?, ?, getdate(), ? "
			query = query & 	" ) "

			arrParams = Array( _
				DBHelper.MakeParam("@event_id", adVarChar, adParamInput, 20, dicParam.item("event_id")), _
				DBHelper.MakeParam("@board_idx", adInteger, adParamInput, 4, dicParam.item("board_idx")), _
				DBHelper.MakeParam("@name", adVarChar, adParamInput, 20, dicParam.item("name")), _
				DBHelper.MakeParam("@phone1", adVarChar, adParamInput, 3, dicParam.item("phone1")), _
				DBHelper.MakeParam("@phone2", adVarChar, adParamInput, 4, dicParam.item("phone2")), _
				DBHelper.MakeParam("@phone3", adVarChar, adParamInput, 4, dicParam.item("phone3")), _
				DBHelper.MakeParam("@comment", adVarChar, adParamInput, 2147483647, dicParam.item("comment")), _
				DBHelper.MakeParam("@agree", adChar, adParamInput, 1, dicParam.item("agree")), _
				DBHelper.MakeParam("@reg_ip", adVarChar, adParamInput, 20, dicParam.item("reg_ip")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'삭제
		Public Function deleteInfo( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim query, arrParams

			'게시판 삭제
			query = " delete from T_COMMENT_EVENT "
			query = query & " where idx = ? and event_id = ? and board_idx = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@idx", adInteger, adParamInput, 4, dicParam.item("idx")), _
				DBHelper.MakeParam("@event_id", adVarChar, adParamInput, 20, dicParam.item("event_id")), _
				DBHelper.MakeParam("@board_idx", adInteger, adParamInput, 4, dicParam.item("board_idx")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function
		
	End Class
%>
