<%
	Class CoffeeClassicCls

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
			strKind	 		= dicParam.Item("kind")
			searchStr		= dicParam.Item("searchStr")

			query = "select ceiling(cast(count(*) as float)/" & intPageListCnt & "), count(*) from dongsuh.coffeClassic_eventJoin "
			query = query & " WHERE kind = ? "

			if searchStr <> "" then
				query = query & " and ( TITLE like '%" & searchStr & "%' or CONTENTS like '%" & searchStr & "%' ) "
			end if

			arrParams = Array( _
				DBHelper.MakeParam("@kind", adVarChar, adParamInput, 10, strKind) _
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
			intCurPage		= dicParam.Item("page")
			strKind	 		= dicParam.Item("kind")
			searchStr		= dicParam.Item("searchStr")

			startRnum = (intCurPage - 1) * intPageListCnt
			endRnum = startRnum + intPageListCnt

			select_fields = " seq, kind, userID, userNM, userAddr, userPhone, userEmail, event_type, contents, regdate, reg_ip "

			query = " select top " & intPageListCnt & " " & select_fields & " from dongsuh.coffeClassic_eventJoin "

			query = query & " where kind = ? and seq not in ( "
			query = query & "		select top " & ((intCurPage - 1) * intPageListCnt) & " seq from dongsuh.coffeClassic_eventJoin where kind = ? "

			query = query & "		order by seq desc "

			query = query & "	) "

			query = query & " order by seq desc "

			arrParams = Array( _
				DBHelper.MakeParam("@kind", adVarChar, adParamInput, 10, strKind), _
				DBHelper.MakeParam("@kind", adVarChar, adParamInput, 10, strKind) _
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
		Public Function getInfo( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intIdx
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			intSeq	=  dicParam.Item("seq")

			select_fields = " seq, kind, userID, userNM, userAddr, userPhone, userEmail, event_type, contents, regdate, reg_ip "

			query = "select " & select_fields & " from dongsuh.coffeClassic_eventJoin where seq = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@seq", adInteger, adParamInput, 4, intSeq) _
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
			Dim strKind, strUserID, strUserNM, strUserAddr, strUserPhone, strUserEmail, strEventType, strContents, strRegIp

			strKind			= dicParam.item("kind")
			strUserID		= dicParam.item("userID")
			strUserNM		= dicParam.item("userNM")
			strUserAddr		= dicParam.item("userAddr")
			strUserPhone	= dicParam.item("userPhone")
			strUserEmail	= dicParam.item("userEmail")
			strEventType	= dicParam.item("event_type")
			strContents		= dicParam.item("contents")
			strRegIp		= dicParam.item("reg_ip")

			query =			" insert into dongsuh.coffeClassic_eventJoin ( "
			query = query & "	 kind, userID, userNM, userAddr, userPhone, userEmail, event_type, contents, regdate, reg_ip "
			query = query & " ) values ( "
			query = query & "	?, ?, ?, ?, ?, ?, ?, ?, getdate(), ? "
			query = query & " ) "

			arrParams = Array( _
				DBHelper.MakeParam("@kind", adVarChar, adParamInput, 10, strKind), _
				DBHelper.MakeParam("@userID", adVarChar, adParamInput, 50, strUserID), _
				DBHelper.MakeParam("@userNM", adVarChar, adParamInput, 50, strUserNM), _
				DBHelper.MakeParam("@userAddr", adVarChar, adParamInput, 200, strUserAddr), _
				DBHelper.MakeParam("@userPhone", adVarChar, adParamInput, 200, strUserPhone), _
				DBHelper.MakeParam("@userEmail", adVarChar, adParamInput, 200, strUserEmail), _
				DBHelper.MakeParam("@event_type", adVarChar, adParamInput, 200, strEventType), _
				DBHelper.MakeParam("@contents", adVarChar, adParamInput, 200, strContents), _
				DBHelper.MakeParam("@reg_ip", adVarChar, adParamInput, 20, strRegIp) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'삭제
		Public Function deleteInfo( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim query, arrParams

			intSeq	=  dicParam.Item("seq")

			'게시판 삭제
			query = " delete from dongsuh.coffeClassic_eventJoin "
			query = query & " where seq = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@seq", adInteger, adParamInput, 4, intSeq) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

	End Class
%>
