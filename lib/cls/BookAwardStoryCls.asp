<%
	Class StoryCls

		private sub Class_Initialize()
			'클래스 초기화 시 해야할 작업
		End Sub
	
		'함께 읽는 이야기 갯수 구하기
		Public Function getTotalCnt( ByVal DBHelper, ByVal dicParam )
			
			'변수 선언
			Dim query, objRs, arrParams, arrayList
			Dim genre, serial_process, title, intro_content, author
			Dim searchStr, searchMd
			
			'변수값 세팅
			intPageListCnt	= dicParam.Item("page_list_cnt")
			genre			= dicParam.Item("genre")
			searchStr		= dicParam.Item("searchStr")
			searchMd		= dicParam.Item("searchMd")

			query = "select ceiling(cast(count(*) as float)/?), count(*) from board_story "
			query = query & " WHERE 1=1 AND DEL_YN = 'N'"

			If 	genre <> "" Then 
				query = query & " AND genre = '"& genre &"'"
			End If 
			
			If 	searchMd = "title" AND searchStr <> "" Then 
				query = query & "AND ( REPLACE(title, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' ))"
			End If 
			
			If 	searchMd = "content" AND searchStr <> "" Then 
				query = query & " AND ( REPLACE(title, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' ))"
			End If 	
			
			If 	searchMd = "all" AND searchStr <> "" Then 
				query = query & " AND (( REPLACE(title, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' )) OR ( REPLACE(intro_content, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' )))"
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
		
		'함께 읽는 이야기 리스트
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
						
			query = "SELECT TOP "& intPageListCnt &" work_code, title, genre, author, intro_content, regdate, thumb_img, display_yn, serial_process, isnull(hit, 0) as hit "
			query = query & " FROM  board_story WHERE work_code NOT IN "
			query = query & "( " 
			query = query & " SELECT TOP "& (nowPage - 1) * intPageListCnt &"work_code FROM board_story  WHERE 1=1 AND DEL_YN = 'N' " 
			
			If genre <> "" Then 
				query = query & " AND genre = '"& genre &"'" 
			End If
					
			If 	searchMd = "title" AND searchStr <> "" Then 
				query = query & "AND ( REPLACE(title, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' ))"
			End If 
			
			If 	searchMd = "content" AND searchStr <> "" Then 
				query = query & " AND ( REPLACE(title, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' ))"
			End If 	
			
			If 	searchMd = "all" AND searchStr <> "" Then 
				query = query & " AND (( REPLACE(title, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' )) OR ( REPLACE(intro_content, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' )))"
			End If 	
			
			query = query & " ORDER BY work_code DESC"
			query = query & ") AND DEL_YN = 'N'" 
			
			If genre <> "" Then 
				query = query & " AND genre = '"& genre &"'" 
			End If
						
			If 	searchMd = "title" AND searchStr <> "" Then 
				query = query & "AND ( REPLACE(title, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' ))"
			End If 
			
			If 	searchMd = "content" AND searchStr <> "" Then 
				query = query & " AND ( REPLACE(title, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' ))"
			End If 	
			
			If 	searchMd = "all" AND searchStr <> "" Then 
				query = query & " AND (( REPLACE(title, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' )) OR ( REPLACE(intro_content, ' ', '') LIKE CONCAT('%', REPLACE('%"& searchStr &"%', ' ', ''), '%' )))"
			End If 	
			
			query = query & " ORDER BY work_code DESC "
						
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
		
		'함께 읽는 이야기 등록
		Public Function insertInfo(ByVal DBHelper, ByVal dicParam)

			'변수선언
			Dim query, objRs, arrParams
			
		
			query = "INSERT INTO board_story (title, genre, author, intro_content, regdate, thumb_img, display_yn, serial_process, hit , del_yn)" 			
			query = query &	 " VALUES (?, ?, ?, ?, getdate(), ?, ?, ?, 0, 'N') "
		
			arrParams = Array( _
				DBHelper.MakeParam("@title", adVarChar, adParamInput, 300, dicParam.item("title")), _
				DBHelper.MakeParam("@genre", adChar, adParamInput, 18, dicParam.item("genre")), _
				DBHelper.MakeParam("@author", adVarChar, adParamInput, 50, dicParam.item("author")), _
				DBHelper.MakeParam("@intro_content", adVarChar, adParamInput, 4000, dicParam.item("intro_content")), _
				DBHelper.MakeParam("@thumb_img", adVarChar, adParamInput, 4000, dicParam.item("thumb_img")), _
				DBHelper.MakeParam("@display_yn", adChar, adParamInput, 1, dicParam.item("display_yn")), _
				DBHelper.MakeParam("@serial_process", adChar, adParamInput, 1, dicParam.item("serial_process")) _			
			)
			
			DBHelper.ExecSQL query, arrParams, nothing
		
		end function
		
		'함께 읽는 이야기 정보
		Public Function getStoryInfo(ByVal DBHelper, ByVal dicParam)
		
			'변수선언
			Dim query, objRs, arrParams, arrayList

			'변수값 세팅		
			query = "SELECT * FROM board_story WHERE work_code = ?"

			arrParams = Array( _
				DBHelper.MakeParam("@work_code", adInteger, adParamInput, 4, dicParam.item("work_code")) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getStoryInfo = arrayList
		
		End Function
		
		'함께 읽는 이야기 삭제
		Public Function deleteStoryInfo(ByVal DBHelper, ByVal dicParam)
		
			'변수 선언
			Dim query, arrParams

			'게시판 삭제
			query = " delete from board_story "
			query = query & " where work_code = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@work_code", adInteger, adParamInput, 4, dicParam.item("work_code")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing
			
		End Function
		
		'함께 읽는 이야기 수정
		Public Function updateStoryInfo(ByVal DBHelper, ByVal dicParam)
		
			'변수 선언
			Dim query, arrParams

			query = " UPDATE board_story SET "
            query = query & " title = ?, "
            query = query & " genre = ?, "
            query = query & " author = ?, "
            query = query & " intro_content = ?, "
            query = query & " thumb_img = ?, "
            query = query & " display_yn = ?, "
            query = query & " serial_process = ? "                                                                        			
			query = query & " WHERE work_code = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@title", adVarChar, adParamInput, 300, dicParam.item("title")), _
				DBHelper.MakeParam("@genre", adVarChar, adParamInput, 18, dicParam.item("genre")), _
				DBHelper.MakeParam("@author", adVarChar, adParamInput, 50, dicParam.item("author")), _
				DBHelper.MakeParam("@intro_content", adVarChar, adParamInput, 4000, dicParam.item("intro_content")), _
				DBHelper.MakeParam("@thumb_img", adVarChar, adParamInput, 200, dicParam.item("thumb_img")), _
				DBHelper.MakeParam("@display_yn", adChar, adParamInput, 1, dicParam.item("display_yn")), _
				DBHelper.MakeParam("@serial_process", adChar, adParamInput, 1, dicParam.item("serial_process")), _
				DBHelper.MakeParam("@work_code", adInteger, adParamInput, 4, dicParam.item("work_code")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing
			
		End Function
		
	End Class
%>
