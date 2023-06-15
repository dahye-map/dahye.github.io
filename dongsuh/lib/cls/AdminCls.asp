<%
	Class AdminCls

		private sub Class_Initialize()
			'클래스 초기화 시 해야할 작업
		End Sub

		'정보 보기(로그인)
		Public Function getInfo(  ByVal DBHelper, ByVal dicParam )
			
			'변수 선언
			Dim admin_id 
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'admin_id 세팅
			admin_id	=  dicParam.Item("admin_id")

			select_fields = " admin_id, admin_pw, admin_name, grade "

			query = "select " & select_fields & " from T_ADMIN where admin_id = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@admin_id", adVarWChar, adParamInput, 20, admin_id) _
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
		
		'등록
        Public Function insertInfo( ByVal DBHelper, ByVal dicParram )
            
            '변수 선언
			Dim query, arrParams

			query =			" insert into T_ADMIN ( "
			query = query & "	 admin_id, admin_pw, admin_name, grade "
			query = query & " ) values ( "
			query = query & "	?, ?, ?, ? "
			query = query & " ) "

			arrParams = Array( _
				DBHelper.MakeParam("@admin_id", adVarChar, adParamInput, 20, dicParam.item("admin_id")), _
				DBHelper.MakeParam("@admin_pw", adVarChar, adParamInput, 20, dicParam.item("admin_pw")), _
				DBHelper.MakeParam("@admin_name", adVarChar, adParamInput, 20, dicParam.item("admin_name")), _
				DBHelper.MakeParam("@grade", adInteger, adParamInput, 4, dicParam.item("grade")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing
            
        End Function
        
        '수정
		Public Function editInfo(ByVal DBHelper, ByVal dicParam)
			
			'변수 선언
			Dim query, arrParams

			query = " update T_ADMIN set "
			query = query & " title = ?, "
			query = query & " contents = ?, "
			query = query & " contents_html = ?, "
			query = query & " is_show = ? "

			query = query & " where admin_id = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@admin_pw", adVarChar, adParamInput, 20, dicParam.item("admin_pw")), _
				DBHelper.MakeParam("@admin_name", adVarChar, adParamInput, 20, dicParam.item("admin_name")), _
				DBHelper.MakeParam("@grade", adInteger, adParamInput, 4, dicParam.item("grade")), _
				DBHelper.MakeParam("@admin_id", adVarChar, adParamInput, 20, dicParam.item("admin_id")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'삭제
		Public Function deleteInfo( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim query, arrParams

			'게시판 삭제
			query = " delete from T_ADMIN "
			query = query & " where admin_id = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@admin_id", adVarChar, adParamInput, 20, dicParam.item("admin_id")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

	End Class
%>
