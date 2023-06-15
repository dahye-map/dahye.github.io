<%
	Class PrizeCls

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

			query = "select ceiling(cast(count(*) as float)/" & intPageListCnt & "), count(*) from T_PRIZE "
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

			select_fields = " IDX, TITLE, CONTENTS, CONTENTS_HTML, SHOW_DATE, VIEW_CNT, IS_SHOW, REG_DATE, REG_ID, EDIT_DATE, EDIT_ID "

			query = " select top " & intPageListCnt & " " & select_fields & " from T_PRIZE "
			
			query = query & " where IDX not in ( "
			query = query & "		select top " & ((intCurPage - 1) * intPageListCnt) & " IDX from T_PRIZE "

			if is_show = "Y" then 
				query = query & "		where is_show = 'Y' "
			end if 

			query = query & "		order by IDX desc "

			query = query & "	) "

			if is_show = "Y" then 
				query = query & "	and is_show = 'Y' "
			end if 


			query = query & " order by IDX desc "

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
			Dim intIdx 
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			intIdx	=  dicParam.Item("IDX")

			select_fields = "IDX, TITLE, CONTENTS, CONTENTS_HTML, SHOW_DATE, VIEW_CNT, IS_SHOW, REG_DATE, REG_ID, EDIT_DATE, EDIT_ID "

			query = "select " & select_fields & " from T_PRIZE where IDX = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("IDX")) _
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
			Dim intIdx, is_show 
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			intIdx		=  dicParam.Item("IDX")
			is_show	=  dicParam.Item("is_show")

			select_fields = "IDX, TITLE, CONTENTS, CONTENTS_HTML, SHOW_DATE, VIEW_CNT, IS_SHOW, REG_DATE, REG_ID, EDIT_DATE, EDIT_ID"

			query =         	" select top 1 " & select_fields & " from "
			query = query & 	" ( "
			query = query & 	" 	select * from T_PRIZE where SHOW_DATE > (select SHOW_DATE from T_PRIZE where IDX = ?) "
			if is_show = "Y" then 
				query = query & "		and is_show = 'Y' "
			end if 
			query = query & 	" 	union all "
			query = query & 	" 	select * from T_PRIZE where SHOW_DATE = (select SHOW_DATE from T_PRIZE where IDX = ?) and IDX > ? "
			if is_show = "Y" then 
				query = query & "		and is_show = 'Y' "
			end if 
			query = query & 	" ) t "

			arrParams = Array( _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("IDX")), _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("IDX")), _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("IDX")) _
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
			intIdx		=  dicParam.Item("IDX")
			is_show	=  dicParam.Item("is_show")

			select_fields = "IDX, TITLE, CONTENTS, CONTENTS_HTML, SHOW_DATE, VIEW_CNT, IS_SHOW, REG_DATE, REG_ID, EDIT_DATE, EDIT_ID"

			query =         	" select top 1 " & select_fields & " from "
			query = query & 	" ( "
			query = query & 	" 	select * from T_PRIZE where SHOW_DATE < (select SHOW_DATE from T_PRIZE where IDX = ?) "
			if is_show = "Y" then 
				query = query & "		and is_show = 'Y' "
			end if 
			query = query & 	" 	union all "
			query = query & 	" 	select * from T_PRIZE where SHOW_DATE = (select SHOW_DATE from T_PRIZE where IDX = ?) and IDX < ? "
			if is_show = "Y" then 
				query = query & "		and is_show = 'Y' "
			end if 
			query = query & 	" ) t "

			arrParams = Array( _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("IDX")), _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("IDX")), _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("IDX")) _
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

			query =			" insert into T_PRIZE ( "
			query = query & "	 TITLE, CONTENTS, CONTENTS_HTML, SHOW_DATE, VIEW_CNT, IS_SHOW, REG_DATE, REG_ID "
			query = query & " ) values ( "
			query = query & "	?, ?, ?, ?, 0, ?, getdate(), ? "
			query = query & " ) "

			arrParams = Array( _
				DBHelper.MakeParam("@TITLE", adVarChar, adParamInput, 200, dicParam.item("TITLE")), _
				DBHelper.MakeParam("@CONTENTS", adVarChar, adParamInput, 2147483647, dicParam.item("CONTENTS")), _
				DBHelper.MakeParam("@CONTENTS_HTML", adVarChar, adParamInput, 2147483647, dicParam.item("CONTENTS_HTML")), _
				DBHelper.MakeParam("@SHOW_DATE", adVarChar, adParamInput, 10, dicParam.item("SHOW_DATE")), _
				DBHelper.MakeParam("@IS_SHOW", adVarChar, adParamInput, 1, dicParam.item("IS_SHOW")), _
				DBHelper.MakeParam("@REG_ID", adVarChar, adParamInput, 20, dicParam.item("REG_ID")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'수정
		Public Function editInfo(ByVal DBHelper, ByVal dicParam)
			
			'변수 선언
			Dim query, arrParams

			query = " update T_PRIZE set "
			query = query & " TITLE = ?, "
			query = query & " CONTENTS = ?, "
			query = query & " CONTENTS_HTML = ?, "
			query = query & " SHOW_DATE = ?, "
			query = query & " IS_SHOW = ?, "
			query = query & " EDIT_DATE = getdate(), "
			query = query & " EDIT_ID = ? "
			query = query & " where IDX = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@TITLE", adVarChar, adParamInput, 200, dicParam.item("TITLE")), _
				DBHelper.MakeParam("@CONTENTS", adVarChar, adParamInput, 2147483647, dicParam.item("CONTENTS")), _
				DBHelper.MakeParam("@CONTENTS_HTML", adVarChar, adParamInput, 2147483647, dicParam.item("CONTENTS_HTML")), _
				DBHelper.MakeParam("@SHOW_DATE", adVarChar, adParamInput, 10, dicParam.item("SHOW_DATE")), _
				DBHelper.MakeParam("@IS_SHOW", adVarChar, adParamInput, 1, dicParam.item("IS_SHOW")), _
				DBHelper.MakeParam("@REG_ID", adVarChar, adParamInput, 20, dicParam.item("REG_ID")), _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("IDX")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'삭제
		Public Function deleteInfo( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim query, arrParams

			'게시판 삭제
			query = " delete from T_PRIZE "
			query = query & " where IDX = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("IDX")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'조회수 올리기
		Public Function upViewCntInfo( ByVal DBHelper, ByVal dicParam )

			
			'변수 선언
			Dim query, arrParams

			query = " update T_PRIZE set "
			query = query & " VIEW_CNT = VIEW_CNT + 1 "
			query = query & " where IDX = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("IDX")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function
	

	End Class
%>
