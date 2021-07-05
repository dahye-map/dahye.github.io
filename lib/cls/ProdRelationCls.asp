<%
	Class ProdRelationCls

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
			category 		= dicParam.Item("category")
			brand			= dicParam.Item("brand")
			brand_is_show 	= dicParam.Item("brand_is_show")

			query = "select ceiling(cast(count(*) as float)/" & intPageListCnt & "), count(*) from T_PROD_RELATION "
			query = query & " WHERE 1=1 "
			
			If category <> "" Then 
				query = query & " and category = " & category
			End If 
			
			If brand  <> "" Then 
				query = query & " and brand = " & brand
			End If 
			
			If is_show = "Y" Then 
				query = query & " and is_show = 'Y' "
			End If 
			
			If brand_is_show = "Y" Then 
				query = query & " and brand_is_show = 'Y' "
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
			product_idx		= dicParam.Item("product_idx")
			relation_idx	= dicParam.Item("relation_idx")

			query = " select a.IDX, a.PROD_NAME, a.THUMB_IMG, a.PROD_IMG, isnull(b.RELATION_IDX, 0) from T_PRODUCT a left outer join T_PROD_RELATION b on (a.IDX = b.PRODUCT_IDX and b.GUBUN = ? and b.RELATION_IDX = ?) "
			query = query + " order by ORDERBY asc, IDX asc "

			arrParams = Array( _
				DBHelper.MakeParam("@GUBUN", adVarChar, adParamInput, 200, dicParam.item("gubun")), _
				DBHelper.MakeParam("@RELATION_IDX", adVarChar, adParamInput, 200, dicParam.item("relation_idx")) _
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

		'입력
		Public Function insertInfo(ByVal DBHelper, ByVal dicParam)
			
			'변수 선언
			Dim query, arrParams

			query =			" insert into T_PROD_RELATION ( "
			query = query & "	GUBUN, PRODUCT_IDX, RELATION_IDX "
			query = query & " ) values ( "
			query = query & "	?, ?, ? "
			query = query & " ) "

			arrParams = Array( _
				DBHelper.MakeParam("@GUBUN", adVarChar, adParamInput, 200, dicParam.item("gubun")), _
				DBHelper.MakeParam("@PRODUCT_IDX", adInteger, adParamInput, 4, dicParam.item("product_idx")), _
				DBHelper.MakeParam("@RELATION_IDX", adInteger, adParamInput, 4, dicParam.item("relation_idx")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'삭제
		Public Function deleteInfo( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim query, arrParams
			
			gubun 			= dicParam.item("gubun")
			product_idx		= dicParam.item("product_idx")
			relation_idx	= dicParam.item("relation_idx")

			'게시판 삭제
			query = " delete from T_PROD_RELATION "
			query = query & " where 1 = 1 "
			
			if gubun <> "" then 
				query = query & " and gubun = '" & gubun & "' "
			end if
			
			if product_idx <> "" then 
				query = query & " and product_idx = " & product_idx
			end if  
			
			if relation_idx <> "" then 
				query = query & " and relation_idx = " & relation_idx
			end if

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'관련 사이트 리스트 구하기
		Public Function getRelateionList(  ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intPageListCnt, intCurPage, strSearchKey, strSearchText, is_show, kind
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList
			Dim startRnum , endRnum

			'변수값 세팅
			product_idx		= dicParam.Item("product_idx")
			relation_idx	= dicParam.Item("relation_idx")

			query = " select  a.IDX, a.TITLE, a.LINK_URL, a.THUMB_IMG, a.IS_SHOW, isnull(b.RELATION_IDX, 0) from T_RELATION_SITE a left outer join T_PROD_RELATION b on (a.IDX = b.PRODUCT_IDX and b.GUBUN = ? and b.RELATION_IDX = ?) "
			query = query + " order by a.IDX asc "

			arrParams = Array( _
				DBHelper.MakeParam("@GUBUN", adVarChar, adParamInput, 200, dicParam.item("gubun")), _
				DBHelper.MakeParam("@RELATION_IDX", adVarChar, adParamInput, 200, dicParam.item("relation_idx")) _
			)
						
			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getRelateionList = arrayList

		End Function 
		
		'관련 사이트 Front 리스트 구하기
		Public Function getFrontRelateionList(  ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intPageListCnt, intCurPage, strSearchKey, strSearchText, is_show, kind
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList
			Dim startRnum , endRnum

			'변수값 세팅
			product_idx		= dicParam.Item("product_idx")
			relation_idx	= dicParam.Item("relation_idx")

			query = "SELECT IDX, TITLE, LINK_URL, GUBUN  FROM T_RELATION_SITE  "
			query = query + " WHERE IDX IN (select PRODUCT_IDX FROM T_PROD_RELATION WHERE GUBUN = ? and RELATION_IDX = ?)  "
			query = query + " ORDER BY GUBUN ASC"
			arrParams = Array( _
				DBHelper.MakeParam("@GUBUN", adVarChar, adParamInput, 200, dicParam.item("gubun")), _
				DBHelper.MakeParam("@RELATION_IDX", adVarChar, adParamInput, 200, dicParam.item("relation_idx")) _
			)
						
			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getFrontRelateionList = arrayList

		End Function 
		
	End Class
%>
