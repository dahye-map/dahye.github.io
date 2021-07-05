<%
	Class LibCls

		private sub Class_Initialize()
			'클래스 초기화 시 해야할 작업
		End Sub

		Function getEncodingData( ByVal DBHelper )

			'변수선언
			Dim query, objRs, arrParams
			Dim arrayList

			query = query & "SELECT  TOP 1 A.MakeDt "
			query = query & "       ,A.MakeKey "
			query = query & "       ,A.MakePos "
			query = query & "  FROM  dbo.MakeEncoding AS A "
			query = query & " ORDER  BY MakeDt DESC "

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getEncodingData = arrayList

		End Function

	End Class
%>
