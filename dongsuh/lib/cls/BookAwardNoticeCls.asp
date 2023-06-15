<%
	Class BookAwardNoticeCls

		private sub Class_Initialize()
			'클래스 초기화 시 해야할 작업
		End Sub
		
		'공지사항 관리 갯수 구하기
		Public Function getTotalCnt( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim query, objRs, arrParams, arrayList
			Dim searchStr, searchMd
			
			'변수값 세팅
			intPageListCnt	= dicParam.Item("page_list_cnt")
			searchStr		= dicParam.Item("searchStr")
			searchMd		= dicParam.Item("searchMd")

			query = "select ceiling(cast(count(*) as float)/?), count(*) from board_notice "
			query = query & " WHERE 1=1 AND DEL_YN = 'N'"
			
						If 	searchMd = "title" AND searchStr <> "" Then 
				query = query & "AND ( REPLACE(title, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' ))"
			End If 
			
			If 	searchMd = "content" AND searchStr <> "" Then 
				query = query & " AND ( REPLACE(title, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' ))"
			End If 	
			
			If 	searchMd = "all" AND searchStr <> "" Then 
				query = query & " AND (( REPLACE(title, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' )) OR ( REPLACE(notice_content, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' )))"
			End If 	
			
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
				
		'공지사항 관리 리스트
		Public Function getList(ByVal DBHelper, ByVal dicParam)
			
			'변수선언
			Dim query, objRs, arrParams, arrayList
			Dim intPageListCnt, nowPage, genre
			Dim searchStr, searchMd

			'변수값 세팅
			intPageListCnt	= dicParam.Item("page_list_cnt")
			nowPage 		= dicParam.Item("page")
			searchStr		= dicParam.Item("searchStr")
			searchMd		= dicParam.Item("searchMd")
						
			query = "SELECT TOP "& intPageListCnt &" seq, title, notice_content, display_yn, regdate, isnull(hit, 0) as hit, del_yn "
			query = query & " FROM  board_notice WHERE seq NOT IN "
			query = query & "( " 
			query = query & " SELECT TOP "& (nowPage - 1) * intPageListCnt &"seq FROM board_notice  WHERE 1=1 AND DEL_YN = 'N' " 
			
			If 	searchMd = "title" AND searchStr <> "" Then 
				query = query & "AND ( REPLACE(title, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' ))"
			End If 
			
			If 	searchMd = "content" AND searchStr <> "" Then 
				query = query & " AND ( REPLACE(title, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' ))"
			End If 	
			
			If 	searchMd = "all" AND searchStr <> "" Then 
				query = query & " AND (( REPLACE(title, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' )) OR ( REPLACE(notice_content, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' )))"
			End If 	
			
			query = query & " ORDER BY seq DESC"
			query = query & ") AND DEL_YN = 'N'" 
			
			If 	searchMd = "title" AND searchStr <> "" Then 
				query = query & "AND ( REPLACE(title, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' ))"
			End If 
			
			If 	searchMd = "content" AND searchStr <> "" Then 
				query = query & " AND ( REPLACE(title, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' ))"
			End If 	
			
			If 	searchMd = "all" AND searchStr <> "" Then 
				query = query & " AND (( REPLACE(title, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' )) OR ( REPLACE(notice_content, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' )))"
			End If 	
			
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
		
		'공지사항 관리 정보
		Public Function getNoticeInfo(ByVal DBHelper, ByVal dicParam)
		
			'변수선언
			Dim query, objRs, arrParams, arrayList, seq

			'변수값 세팅		
			query = "SELECT * FROM board_notice WHERE seq = ?"

			arrParams = Array( _
				DBHelper.MakeParam("@seq", adInteger, adParamInput, 4, dicParam.item("seq")) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getNoticeInfo = arrayList
		
		End Function
		
		'공지사항 관리 등록
		Public Function insertInfo(ByVal DBHelper, ByVal dicParam)

			'변수선언
			Dim query, objRs, arrParams
			
		
			query = "INSERT INTO board_notice (title, notice_content, display_yn, regdate, hit , del_yn)" 			
			query = query &	 " VALUES (?, ?, ?, getdate(), 0, 'N') "
		
			arrParams = Array( _
				DBHelper.MakeParam("@title", adVarChar, adParamInput, 300, dicParam.item("title")), _
				DBHelper.MakeParam("@notice_content", adVarChar, adParamInput, 4000, dicParam.item("notice_content")), _
				DBHelper.MakeParam("@display_yn", adChar, adParamInput, 1, dicParam.item("display_yn")) _
			)
			
			DBHelper.ExecSQL query, arrParams, nothing
		
		end function
		
		'공지사항 관리 수정
		Public Function updateNoticeInfo(ByVal DBHelper, ByVal dicParam)
		
			'변수 선언
			Dim query, arrParams

			query = " UPDATE board_notice SET "
            query = query & " title = ?, "
            query = query & " notice_content = ?, "
            query = query & " display_yn = ? "
			query = query & " WHERE seq = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@title", adVarChar, adParamInput, 300, dicParam.item("title")), _
				DBHelper.MakeParam("@notice_content", adVarChar, adParamInput, 4000, dicParam.item("notice_content")), _
				DBHelper.MakeParam("@display_yn", adChar, adParamInput, 18, dicParam.item("display_yn")), _
				DBHelper.MakeParam("@seq", adInteger, adParamInput, 4, dicParam.item("seq")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing
			
		End Function
		
		'공지사항 관리 삭제
		Public Function deleteNoticeInfo(ByVal DBHelper, ByVal dicParam)
		
			'변수 선언
			Dim query, arrParams

			'게시판 삭제
			query = " delete from board_notice "
			query = query & " where seq = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@seq", adInteger, adParamInput, 4, dicParam.item("seq")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing
			
		End Function
	End Class
%>
