<%
	Class RelationSiteCls

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
			is_show 		= dicParam.Item("is_show")


			query = "select ceiling(cast(count(*) as float)/" & intPageListCnt & "), count(*) from T_RELATION_SITE "
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

			select_fields = " IDX, TITLE, LINK_URL, THUMB_IMG, IS_SHOW, REG_DATE, REG_ID, EDIT_DATE, EDIT_ID "

			query = " select top " & intPageListCnt & " " & select_fields & " from T_RELATION_SITE "
			
			query = query & " where IDX not in ( "
			query = query & "		select top " & ((intCurPage - 1) * intPageListCnt) & " IDX from T_RELATION_SITE where 1=1 "
			
			if is_show = "Y" then 
				query = query & "		and is_show = 'Y' "
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
		
		Public Function getRelationList(  ByVal DBHelper, ByVal dicParam )
			
			'변수 선언
			Dim intPageListCnt, intCurPage, strSearchKey, strSearchText, is_show, kind
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList
			Dim startRnum , endRnum

			'변수값 세팅
			relation_idx	=  dicParam.Item("relation_idx")
			
			select_fields = " IDX, TITLE, LINK_URL, THUMB_IMG, IS_SHOW, REG_DATE, REG_ID, EDIT_DATE, EDIT_ID "

			query = " select " & select_fields & " from T_RELATION_SITE a inner join T_PROD_RELATION b on (b.GUBUN = 'RELATION_SITE' and a.IDX = b.RELATION_IDX) "
			query = query & " where a.IS_SHOW = 'Y' and b.PRODUCT_IDX = ? "
			query = query & " order by IDX desc"

			arrParams = Array( _
				DBHelper.MakeParam("@PRODUCT_IDX", adInteger, adParamInput, 4, dicParam.item("product_idx")) _
			)
			
			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getRelationList = arrayList

		end Function  

		'정보 보기
		Public Function getInfo(  ByVal DBHelper, ByVal dicParam )
			
			'변수 선언
			Dim intIdx 
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList

			'변수값 세팅
			intIdx	=  dicParam.Item("IDX")

			select_fields = " IDX, TITLE, LINK_URL, THUMB_IMG, IS_SHOW, REG_DATE, REG_ID, EDIT_DATE, EDIT_ID, GUBUN "

			query = "select " & select_fields & " from T_RELATION_SITE where IDX = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("idx")) _
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

			query =			" insert into T_RELATION_SITE ( "
			query = query & "	TITLE, LINK_URL, THUMB_IMG, IS_SHOW, REG_DATE, REG_ID, GUBUN "
			query = query & " ) values ( "
			query = query & "	?, ?, ?, ?, getdate(), ?, ? "
			query = query & " ) "

			arrParams = Array( _
				DBHelper.MakeParam("@TITLE", adVarChar, adParamInput, 100, dicParam.item("title")), _
				DBHelper.MakeParam("@LINK_URL", adVarChar, adParamInput, 100, dicParam.item("link_url")), _
				DBHelper.MakeParam("@THUMB_IMG", adVarChar, adParamInput, 200, dicParam.item("thumb_img")), _
				DBHelper.MakeParam("@IS_SHOW", adVarChar, adParamInput, 1, dicParam.item("is_show")), _
				DBHelper.MakeParam("@REG_ID", adVarChar, adParamInput, 20, dicParam.item("reg_id")), _
				DBHelper.MakeParam("@gubun", adVarChar, adParamInput, 50, dicParam.item("gubun")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'수정
		Public Function editInfo(ByVal DBHelper, ByVal dicParam)
			
			'변수 선언
			Dim query, arrParams

			query = " update T_RELATION_SITE set "
			query = query & " TITLE = ?, "
			query = query & " LINK_URL = ?, "
			query = query & " THUMB_IMG = ?, "
			query = query & " IS_SHOW = ?, "
			query = query & " GUBUN = ?, "
			query = query & " EDIT_DATE = getdate(), "
			query = query & " EDIT_ID = ? "
			query = query & " where IDX = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@TITLE", adVarChar, adParamInput, 100, dicParam.item("title")), _
				DBHelper.MakeParam("@LINK_URL", adVarChar, adParamInput, 100, dicParam.item("link_url")), _
				DBHelper.MakeParam("@THUMB_IMG", adVarChar, adParamInput, 200, dicParam.item("thumb_img")), _
				DBHelper.MakeParam("@IS_SHOW", adVarChar, adParamInput, 1, dicParam.item("is_show")), _
				DBHelper.MakeParam("@GUBUN", adVarChar, adParamInput, 50, dicParam.item("gubun")), _
				DBHelper.MakeParam("@EDIT_ID", adVarChar, adParamInput, 20, dicParam.item("edit_id")), _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("idx")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'삭제
		Public Function deleteInfo( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim query, arrParams

			'게시판 삭제
			query = " delete from T_RELATION_SITE "
			query = query & " where IDX = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("idx")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

	End Class
%>
