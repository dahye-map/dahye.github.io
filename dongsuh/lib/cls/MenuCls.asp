<%
	Class MenuCls

		private sub Class_Initialize()
			'클래스 초기화 시 해야할 작업
		End Sub

		'관리자 메뉴 리스트
		Public Function getMenus( ByVal DBHelper, ByVal dicParam )
		
			Dim arrayList
			Dim query, arrParams
		
			query = "SELECT menu_seq, depth1, depth2, depth3, menu_name, link_url, param "
			query = query & "FROM T_ADMIN_MENU ORDER BY depth1, depth2, depth3"
		
			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getMenus = arrayList
		
		End Function


		'메뉴등록
        Public Function insertInfo( ByVal DBHelper, ByVal dicParam )
            
            '변수 선언
			Dim query, arrParams

			query =			" insert into T_ADMIN_MENU ( "
			query = query & "	 menu_seq, depth1, depth2, depth3, menu_name, link_url, param "
			query = query & " ) values ( "
			query = query & "	?, ?, ?, ? , ? , ?"
			query = query & " ) "

			arrParams = Array( _
				DBHelper.MakeParam("@menu_seq", adInteger, adParamInput, 4, dicParam.item("menu_seq")), _
				DBHelper.MakeParam("@depth1", adInteger, adParamInput, 2, dicParam.item("depth1")), _
				DBHelper.MakeParam("@depth2", adInteger, adParamInput, 2, dicParam.item("depth2")), _
				DBHelper.MakeParam("@depth3", adInteger, adParamInput, 2, dicParam.item("depth3")), _
				DBHelper.MakeParam("@menu_name", adVarChar, adParamInput, 50, dicParam.item("menu_name")), _
				DBHelper.MakeParam("@link_url", adVarChar, adParamInput, 200, dicParam.item("link_url")), _
				DBHelper.MakeParam("@param", adVarChar, adParamInput, 200, dicParam.item("param")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing
            
        End Function


		'관리자 메뉴 정보
		public Function getMenuInfo( ByVal DBHelper, ByVal dicParam )
		   
		    '변수 선언
			Dim query, arrParams, objRs
			Dim depth1, depth2, get_depth
			Dim arrayList 
			
			'변수값 세팅
			get_depth	= dicParam.Item("get_depth")
			depth1 		= dicParam.Item("depth1")
			depth2 		= dicParam.Item("depth2")
			
			query = "SELECT ISNULL(MAX(menu_seq), '0') as menu_seq, ISNULL(MAX(DEPTH1), '0') as DEPTH1, ISNULL(MAX(DEPTH2), '0') as DEPTH2, ISNULL(MAX(DEPTH3), '0') as DEPTH3 "
			query =	query & "FROM T_ADMIN_MENU where 1=1 "
			 

				
			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)
			
			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getMenuInfo = arrayList	
			
		End Function
		

	End Class
%>
