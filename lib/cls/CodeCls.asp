<%
	Class CodeCls

		private sub Class_Initialize()
			'클래스 초기화 시 해야할 작업
		End Sub

		'리스트 구하기
		Public Function getList(  ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intPageListCnt, intCurPage, strSearchKey, strSearchText, is_show, kind
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList
			Dim startRnum , endRnum

			'변수값 세팅

			select_fields = " gubun, id, name, orderby "

			query = " select " & select_fields & " from T_CODE "
			query = query & " where gubun = ? "
    		query = query & " order by orderby "
    		
    		arrParams = Array( _
    			DBHelper.MakeParam("@gubun", adVarChar, adParamInput, 20, dicParam.item("gubun")) _
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

	End Class
%>
