<%
	Class BookAwardQnaCls

		private sub Class_Initialize()
			'클래스 초기화 시 해야할 작업
		End Sub
	
		'Q&A 관리 갯수 구하기
		Public Function getTotalCnt( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim query, objRs, arrParams, arrayList
			Dim searchStr, searchMd
			
			'변수값 세팅
			intPageListCnt	= dicParam.Item("page_list_cnt")
			searchStr		= dicParam.Item("searchStr")
			searchMd		= dicParam.Item("searchMd")

			query = "select ceiling(cast(count(*) as float)/?), count(*) from board_qna "
			query = query & " WHERE 1=1 AND DEL_YN = 'N'"
			
			arrParams = Array( _
				DBHelper.MakeParam("@intPageListCnt", adInteger, adParamInput, 4, dicParam.item("page_list_cnt")) _
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
			
		'Q&A 관리 리스트
		Public Function getList(ByVal DBHelper, ByVal dicParam)
			
			'변수선언
			Dim query, objRs, arrParams, arrayList
			Dim intPageListCnt, nowPage, genre
			Dim searchStr, searchMd

			'변수값 세팅
			intPageListCnt	= dicParam.Item("page_list_cnt")
			nowPage 		= dicParam.Item("page")
			genre 			= dicParam.Item("genre")
			searchStr		= dicParam.Item("searchStr")
			searchMd		= dicParam.Item("searchMd")
						
			query = "SELECT TOP "& intPageListCnt &" seq, write_id, write_pwd, title, qna_content, qna_reply, regdate, upddate, reply_yn, del_yn "
			query = query & " FROM  board_qna WHERE seq NOT IN "
			query = query & "( " 
			query = query & " SELECT TOP "& (nowPage - 1) * intPageListCnt &" seq FROM board_qna  WHERE 1=1 AND DEL_YN = 'N' " 		
			query = query & " ORDER BY seq DESC"
			
			query = query & ") AND DEL_YN = 'N'" 
			
			query = query & " ORDER BY seq DESC "
												
			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getList = arrayList

		End function
		
		'Q&A 관리 정보
		'Q&A 관리 등록
		'Q&A 관리 수정
		'Q&A 관리 삭제
		
	End Class
%>
