<%
	Class ProductCls

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
			is_show 			= dicParam.Item("is_show")
			category 			= dicParam.Item("category")
			brand				= dicParam.Item("brand")
			brand_is_show 	= dicParam.Item("brand_is_show")
			searchStr			= dicParam.Item("searchStr")

			query = "select ceiling(cast(count(*) as float)/" & intPageListCnt & "), count(*) from T_PRODUCT "
			query = query & " WHERE 1=1 "
			
			If category <> "" Then 
				query = query & " and category in (select IDX from V_PROD_CATEGORY where DEPTH1 = (select DEPTH1 from V_PROD_CATEGORY where idx = "& category &")) " 
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
			
			if searchStr <> "" then 
				query = query & " and ( PROD_NAME like '%" & searchStr & "%' or EXPLAIN like '%" & searchStr & "%' ) "
			end if 

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
			is_show			=  dicParam.Item("is_show")
			category 		=  dicParam.Item("category")
			brand			=  dicParam.Item("brand")
			brand_is_show 	=  dicParam.Item("brand_is_show")
			brand_orderby 	=  dicParam.Item("brand_orderby")
			search_orderby 	=  dicParam.Item("search_orderby")

			startRnum = (intCurPage - 1) * intPageListCnt
			endRnum = startRnum + intPageListCnt

			select_fields = " a.IDX, a.CATEGORY, a.BRAND, a.PROD_NAME, a.EXPLAIN, a.VOLUME, a.THUMB_IMG, a.PROD_IMG, a.BRAND_IMG, a.IS_SHOW, a.ORDERBY, a.VIEW_CNT, a.REG_DATE, a.REG_ID, a.EDIT_DATE, a.EDIT_ID, a.BRAND_IS_SHOW, a.BRAND_ORDERBY, a.BRAND_VOLUME, b.DEPTH1, b.DEPTH2, c.BRAND_NAME, a.HM_THUMB_IMG , a.HM_PROD_IMG "
			
			if brand_orderby = "Y" then
				row = ",  ROW_NUMBER() OVER (ORDER BY a.BRAND_ORDERBY asc) as num "
			elseif search_orderby = "Y" then
				row = ",  ROW_NUMBER() OVER (ORDER BY a.BRAND asc, a.BRAND_ORDERBY asc) as num "
			else 
				row = ",  ROW_NUMBER() OVER (ORDER BY a.IDX asc) as num "
			end if
			
			query = " select top " & intPageListCnt & " " & select_fields & " "& row &" from T_PRODUCT a inner join V_PROD_CATEGORY b on (a.CATEGORY = b.IDX) left outer join T_PROD_BRAND c on (a.BRAND = c.IDX)"
			
			query = query & " where a.IDX not in ( "
			query = query & "		select top " & ((intCurPage - 1) * intPageListCnt) & " IDX from T_PRODUCT where 1=1 "
					
			If category <> "" Then 
				query = query & " 		and category = " & category
			End If 
			
			If brand <> "" Then 
				query = query & " 		and brand = " & brand
			End If 
			
			if is_show = "Y" then 
				query = query & "		and is_show = 'Y' "
			end if 
			
			If brand_is_show = "Y" Then 
				query = query & " and brand_is_show = 'Y' "
			End If 
			
			if searchStr <> "" then 
				query = query & " and ( PROD_NAME like '%" & searchStr & "%' or EXPLAIN like '%" & searchStr & "%' ) "
			end if 
			
			if brand_orderby = "Y" then
				query = query & "		order by BRAND_ORDERBY asc "
			elseif search_orderby = "Y" then
				query = query & "		order by BRAND asc, BRAND_ORDERBY asc "
			else 
				query = query & "		order by IDX asc "
			end if 

			query = query & "	) "
			
			If category <> "" Then 
				query = query & " and a.category = " & category
			End If 
			
			If brand <> "" Then 
				query = query & " and a.brand = " & brand
			End If 
			
			if is_show = "Y" then 
				query = query & "	and a.is_show = 'Y' "
			end if 
			
			If brand_is_show = "Y" Then 
				query = query & " and a.brand_is_show = 'Y' "
			End If 
			
			if searchStr <> "" then 
				query = query & " and ( a.PROD_NAME like '%" & searchStr & "%' or a.EXPLAIN like '%" & searchStr & "%' ) "
			end if 

			if brand_orderby = "Y" then
				query = query & "		order by a.BRAND_ORDERBY asc "
			elseif search_orderby = "Y" then
				query = query & "		order by a.BRAND asc, a.BRAND_ORDERBY asc "
			else 
				query = query & "		order by a.IDX asc "
			end if 

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
			product_idx	=  dicParam.Item("product_idx")
			
			select_fields = " IDX, CATEGORY, BRAND, PROD_NAME, EXPLAIN, VOLUME, THUMB_IMG, PROD_IMG, BRAND_IMG, IS_SHOW, ORDERBY, VIEW_CNT, REG_DATE, REG_ID, EDIT_DATE, EDIT_ID, BRAND_IS_SHOW, BRAND_ORDERBY, BRAND_VOLUME "

			query = " select top " & intPageListCnt & " " & select_fields & " from T_PRODUCT "
			query = query & " where IDX in (" & product_idx & ") "
			query = query & " order by ORDERBY asc"
			
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

			select_fields = " a.IDX, a.CATEGORY, a.BRAND, a.PROD_NAME, a.EXPLAIN, a.VOLUME, a.THUMB_IMG, a.PROD_IMG, a.BRAND_IMG, a.IS_SHOW, a.ORDERBY, a.VIEW_CNT, a.REG_DATE, a.REG_ID, a.EDIT_DATE, a.EDIT_ID, a.BRAND_IS_SHOW, a.BRAND_ORDERBY, a.BRAND_VOLUME, a.HM_THUMB_IMG, a.HM_PROD_IMG, b.BRAND_NAME "

			query = "select " & select_fields & " from T_PRODUCT a, T_PROD_BRAND b where a.BRAND = b.idx and a.IDX = ? "

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

			select_fields = " IDX, CATEGORY, BRAND, PROD_NAME, EXPLAIN, VOLUME, THUMB_IMG, PROD_IMG, BRAND_IMG, IS_SHOW, ORDERBY, VIEW_CNT, REG_DATE, REG_ID, EDIT_DATE, EDIT_ID, BRAND_IS_SHOW, BRAND_ORDERBY, BRAND_VOLUME "

			query = "select " & select_fields & " from T_PRODUCT where IDX = ( "
			query = query & "	select min(IDX) from T_PRODUCT where IDX > ? "
			
			if is_show = "Y" then 
				query = query & "		and is_show = 'Y' "
			end if 
			
			query = query & " ) "

			if is_show = "Y" then 
				query = query & "		and is_show = 'Y' "
			end if 

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

			select_fields = " IDX, CATEGORY, BRAND, PROD_NAME, EXPLAIN, VOLUME, THUMB_IMG, PROD_IMG, BRAND_IMG, IS_SHOW, ORDERBY, VIEW_CNT, REG_DATE, REG_ID, EDIT_DATE, EDIT_ID, BRAND_IS_SHOW, BRAND_ORDERBY, BRAND_VOLUME "

			query = "select " & select_fields & " from T_PRODUCT where IDX = ( "
			query = query & "	select max(IDX) from T_PRODUCT where IDX < ? "
			
			if is_show = "Y" then 
				query = query & "		and is_show = 'Y' "
			end if 
			
			query = query & " ) "

			if is_show = "Y" then 
				query = query & "		and is_show = 'Y' "
			end if 

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

			getNextInfo = arrayList

		End Function

		'입력
		Public Function insertInfo(ByVal DBHelper, ByVal dicParam)
			
			'변수 선언
			Dim query, arrParams

			query =			" insert into T_PRODUCT ( "
			query = query & "	CATEGORY, BRAND, PROD_NAME, EXPLAIN, VOLUME, THUMB_IMG, PROD_IMG, BRAND_IMG, IS_SHOW, ORDERBY, VIEW_CNT, REG_DATE, REG_ID, BRAND_IS_SHOW, BRAND_ORDERBY, BRAND_VOLUME, HM_THUMB_IMG, HM_PROD_IMG  "
			query = query & " ) values ( "
			query = query & "	?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, getdate(), ?, ?, ?, ?, ?, ? "
			query = query & " ) "

			arrParams = Array( _
				DBHelper.MakeParam("@CATEGORY", adInteger, adParamInput, 4, dicParam.item("category")), _
				DBHelper.MakeParam("@BRAND", adInteger, adParamInput, 4, dicParam.item("brand")), _
				DBHelper.MakeParam("@PROD_NAME", adVarChar, adParamInput, 200, dicParam.item("prod_name")), _
				DBHelper.MakeParam("@EXPLAIN", adVarChar, adParamInput, 2147483647, dicParam.item("explain")), _
				DBHelper.MakeParam("@VOLUME", adVarChar, adParamInput, 2147483647, dicParam.item("volume")), _
				DBHelper.MakeParam("@THUMB_IMG", adVarChar, adParamInput, 200, dicParam.item("thumb_img")), _
				DBHelper.MakeParam("@PROD_IMG", adVarChar, adParamInput, 200, dicParam.item("prod_img")), _
				DBHelper.MakeParam("@BRAND_IMG", adVarChar, adParamInput, 200, dicParam.item("brand_img")), _
				DBHelper.MakeParam("@IS_SHOW", adVarChar, adParamInput, 1, dicParam.item("is_show")), _
				DBHelper.MakeParam("@ORDERBY", adInteger, adParamInput, 4, dicParam.item("orderby")), _
				DBHelper.MakeParam("@REG_ID", adVarChar, adParamInput, 20, dicParam.item("reg_id")), _
				DBHelper.MakeParam("@BRAND_IS_SHOW", adVarChar, adParamInput, 1, dicParam.item("brand_is_show")), _
				DBHelper.MakeParam("@BRAND_ORDERBY", adInteger, adParamInput, 4, dicParam.item("brand_orderby")), _
				DBHelper.MakeParam("@BRAND_VOLUME", adVarChar, adParamInput, 1000, dicParam.item("brand_volume")), _
				DBHelper.MakeParam("@HM_THUMB_IMG", adVarChar, adParamInput, 200, dicParam.item("hm_thumb_img")), _
				DBHelper.MakeParam("@HM_PROD_IMG", adVarChar, adParamInput, 200, dicParam.item("hm_prod_img")) _				
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'수정
		Public Function editInfo(ByVal DBHelper, ByVal dicParam)
			
			'변수 선언
			Dim query, arrParams

			query = " update T_PRODUCT set "
			query = query & " CATEGORY = ?, "
			query = query & " BRAND = ?, "
			query = query & " PROD_NAME = ?, "
			query = query & " EXPLAIN = ?, "
			query = query & " VOLUME = ?, "
			query = query & " THUMB_IMG = ?, "
			query = query & " PROD_IMG = ?, "
			query = query & " HM_THUMB_IMG = ?, "
			query = query & " HM_PROD_IMG = ?, "
			query = query & " BRAND_IMG = ?, "
			query = query & " IS_SHOW = ?, "
			query = query & " ORDERBY = ?, "			
			query = query & " EDIT_DATE = getdate(), "
			query = query & " EDIT_ID = ?, "
			query = query & " BRAND_IS_SHOW = ?, "
			query = query & " BRAND_ORDERBY = ?, "
			query = query & " BRAND_VOLUME = ? "
			query = query & " where IDX = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@CATEGORY", adInteger, adParamInput, 4, dicParam.item("category")), _
				DBHelper.MakeParam("@BRAND", adInteger, adParamInput, 4, dicParam.item("brand")), _
				DBHelper.MakeParam("@PROD_NAME", adVarChar, adParamInput, 200, dicParam.item("prod_name")), _
				DBHelper.MakeParam("@EXPLAIN", adVarChar, adParamInput, 2147483647, dicParam.item("explain")), _
				DBHelper.MakeParam("@VOLUME", adVarChar, adParamInput, 2147483647, dicParam.item("volume")), _
				DBHelper.MakeParam("@THUMB_IMG", adVarChar, adParamInput, 200, dicParam.item("thumb_img")), _
				DBHelper.MakeParam("@PROD_IMG", adVarChar, adParamInput, 200, dicParam.item("prod_img")), _
				DBHelper.MakeParam("@HM_THUMB_IMG", adVarChar, adParamInput, 200, dicParam.item("hm_thumb_img")), _
				DBHelper.MakeParam("@HM_PROD_IMG", adVarChar, adParamInput, 200, dicParam.item("hm_prod_img")), _				
				DBHelper.MakeParam("@BRAND_IMG", adVarChar, adParamInput, 200, dicParam.item("brand_img")), _
				DBHelper.MakeParam("@IS_SHOW", adVarChar, adParamInput, 1, dicParam.item("is_show")), _
				DBHelper.MakeParam("@ORDERBY", adInteger, adParamInput, 4, dicParam.item("orderby")), _
				DBHelper.MakeParam("@EDIT_ID", adVarChar, adParamInput, 20, dicParam.item("edit_id")), _
				DBHelper.MakeParam("@BRAND_IS_SHOW", adVarChar, adParamInput, 1, dicParam.item("brand_is_show")), _
				DBHelper.MakeParam("@BRAND_ORDERBY", adInteger, adParamInput, 4, dicParam.item("brand_orderby")), _
				DBHelper.MakeParam("@BRAND_VOLUME", adVarChar, adParamInput, 1000, dicParam.item("brand_volume")), _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("idx")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'삭제
		Public Function deleteInfo( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim query, arrParams

			'게시판 삭제
			query = " delete from T_PRODUCT "
			query = query & " where IDX = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("idx")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'조회수 올리기
		Public Function upViewCntInfo( ByVal DBHelper, ByVal dicParam )

			
			'변수 선언
			Dim query, arrParams

			query = " update T_PRODUCT set "
			query = query & " VIEW_CNT = VIEW_CNT + 1 "
			query = query & " where IDX = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("idx")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function
		
		'TOP 노출 제품 리스트 구하기
		Public Function getTopProdList(  ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intPageListCnt
			Dim query, objRs, arrParams
			Dim topCnt
			
			'전달값 받기
			topCnt =  dicParam.Item("topCnt")

			query = " select top "& topCnt &" a.IDX, a.CATEGORY, (select BRAND_NAME from T_PROD_BRAND where IDX = a.BRAND), a.PROD_NAME, a.HM_THUMB_IMG, a.HM_PROD_IMG ,a.REG_DATE, b.DEPTH1, b.DEPTH2, a.IS_SHOW " 
			query = query & " FROM T_PRODUCT a inner join V_PROD_CATEGORY b on (a.CATEGORY = b.IDX)"				
			query = query & " WHERE a.IS_SHOW = 'Y' "
			query = query & " ORDER BY a.REG_DATE DESC "				
						
			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getTopProdList = arrayList			
			
		End Function
		
		
		'ajax 리스트 구하기
		Public Function getAjaxList(  ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intPageListCnt, intCurPage, strSearchKey, strSearchText, is_show, kind
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList
			Dim startRnum , endRnum

			'변수값 세팅
			intPageListCnt	=  dicParam.Item("page_list_cnt")
			intCurPage		=  dicParam.Item("page")
			is_show			=  dicParam.Item("is_show")
			category 		=  dicParam.Item("category")
			brand			=  dicParam.Item("brand")
			brand_is_show 	=  dicParam.Item("brand_is_show")
			brand_orderby 	=  dicParam.Item("brand_orderby")
			search_orderby 	=  dicParam.Item("search_orderby")

			startRnum = (intCurPage - 1) * intPageListCnt
			endRnum = startRnum + intPageListCnt

			select_fields = " a.IDX, a.CATEGORY, a.BRAND, a.PROD_NAME, a.EXPLAIN, a.VOLUME, a.THUMB_IMG, a.PROD_IMG, a.BRAND_IMG, a.IS_SHOW, a.ORDERBY, a.VIEW_CNT, a.REG_DATE, a.REG_ID, a.EDIT_DATE, a.EDIT_ID, a.BRAND_IS_SHOW, a.BRAND_ORDERBY, a.BRAND_VOLUME, b.DEPTH1, b.DEPTH2, c.BRAND_NAME, a.HM_THUMB_IMG , a.HM_PROD_IMG "
			
			if brand_orderby = "Y" then
				row = ",  ROW_NUMBER() OVER (ORDER BY a.BRAND_ORDERBY asc) as num "
			elseif search_orderby = "Y" then
				row = ",  ROW_NUMBER() OVER (ORDER BY a.BRAND asc, a.BRAND_ORDERBY asc) as num "
			else 
				row = ",  ROW_NUMBER() OVER (ORDER BY a.IDX asc) as num "
			end if
			
			query = " select top " & intPageListCnt & " " & select_fields & " "& row &" from T_PRODUCT a inner join V_PROD_CATEGORY b on (a.CATEGORY = b.IDX) left outer join T_PROD_BRAND c on (a.BRAND = c.IDX)"
			
			query = query & " where a.IDX not in ( "
			query = query & "		select top " & ((intCurPage - 1) * intPageListCnt) & " IDX from T_PRODUCT where 1=1 "
					
			If category <> "" Then 
				query = query & " 		and category in (select IDX from V_PROD_CATEGORY where DEPTH1 = (select DEPTH1 from V_PROD_CATEGORY where idx ="& category &"))" 
			End If 
			
			If brand <> "" Then 
				query = query & " 		and brand = " & brand
			End If 
			
			if is_show = "Y" then 
				query = query & "		and is_show = 'Y' "
			end if 
			
			If brand_is_show = "Y" Then 
				query = query & " and brand_is_show = 'Y' "
			End If 
			
			if searchStr <> "" then 
				query = query & " and ( PROD_NAME like '%" & searchStr & "%' or EXPLAIN like '%" & searchStr & "%' ) "
			end if 
			
			if brand_orderby = "Y" then
				query = query & "		order by BRAND_ORDERBY asc "
			elseif search_orderby = "Y" then
				query = query & "		order by BRAND asc, BRAND_ORDERBY asc "
			else 
				query = query & "		order by IDX asc "
			end if 

			query = query & "	) "
			
			If category <> "" Then 
				query = query & " and a.category in (select IDX from V_PROD_CATEGORY where DEPTH1 = (select DEPTH1 from V_PROD_CATEGORY where idx = "& category &"))" 
			End If 
			
			If brand <> "" Then 
				query = query & " and a.brand = " & brand
			End If 
			
			if is_show = "Y" then 
				query = query & "	and a.is_show = 'Y' "
			end if 
			
			If brand_is_show = "Y" Then 
				query = query & " and a.brand_is_show = 'Y' "
			End If 
			
			if searchStr <> "" then 
				query = query & " and ( a.PROD_NAME like '%" & searchStr & "%' or a.EXPLAIN like '%" & searchStr & "%' ) "
			end if 

			if brand_orderby = "Y" then
				query = query & "		order by a.BRAND_ORDERBY asc "
			elseif search_orderby = "Y" then
				query = query & "		order by a.BRAND asc, a.BRAND_ORDERBY asc "
			else 
				query = query & "		order by a.IDX asc "
			end if 
						
			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)
			
			
			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getAjaxList = arrayList

		End Function 
	End Class
%>
