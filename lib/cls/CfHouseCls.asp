<%
	Class CfHouseCls

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
			searchStr			= dicParam.Item("searchStr")

			query = "select ceiling(cast(count(*) as float)/" & intPageListCnt & "), count(*) from T_CF_HOUSE "
			query = query & " WHERE 1=1 "
			
			If is_show = "Y" Then 
				query = query & " and IS_SHOW = 'Y' "
			End If 
			
			if searchStr <> "" then 
				query = query & " and ( TITLE like '%" & searchStr & "%' or CONTENTS like '%" & searchStr & "%' ) "
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
			intPageListCnt	= dicParam.Item("page_list_cnt")
			intCurPage			= dicParam.Item("page")
			is_show			= dicParam.Item("is_show")
			searchStr			= dicParam.Item("searchStr")

			startRnum = (intCurPage - 1) * intPageListCnt
			endRnum = startRnum + intPageListCnt

			select_fields = " IDX, TITLE, CONTENTS, THUMB_IMG, VIDEO, VIEW_CNT, IS_SHOW, REG_DATE, REG_ID, EDIT_DATE, EDIT_ID, PROD_NM  "

			query = " select top " & intPageListCnt & " " & select_fields & " from T_CF_HOUSE "
			
			query = query & " where IDX not in ( "
			query = query & "		select top " & ((intCurPage - 1) * intPageListCnt) & " IDX from T_CF_HOUSE "

			if is_show = "Y" then 
				query = query & "		where IS_SHOW = 'Y' "
			end if 
			
			if searchStr <> "" then 
				query = query & " and ( TITLE like '%" & searchStr & "%' or CONTENTS like '%" & searchStr & "%' ) "
			end if 

			query = query & "		order by IDX desc "

			query = query & "	) "

			if is_show = "Y" then 
				query = query & "	and is_show = 'Y' "
			end if 
			
			if searchStr <> "" then 
				query = query & " and ( TITLE like '%" & searchStr & "%' or CONTENTS like '%" & searchStr & "%' ) "
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
			
			select_fields = " IDX, TITLE, CONTENTS, THUMB_IMG, VIDEO, VIEW_CNT, IS_SHOW, REG_DATE, REG_ID, EDIT_DATE, EDIT_ID "

			query = " select " & select_fields & " from T_CF_HOUSE a inner join T_PROD_RELATION b on (b.GUBUN = 'CF_HOUSE' and a.IDX = b.RELATION_IDX) "
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

			select_fields = "IDX, TITLE, CONTENTS, THUMB_IMG, VIDEO, VIEW_CNT, IS_SHOW, REG_DATE, REG_ID, EDIT_DATE, EDIT_ID, HM_VIDEO, PROD_NM "

			query = "select " & select_fields & " from T_CF_HOUSE where IDX = ? "

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

			select_fields = "IDX, TITLE, CONTENTS, THUMB_IMG, VIDEO, VIEW_CNT, IS_SHOW, REG_DATE, REG_ID, EDIT_DATE, EDIT_ID "

			query = "select " & select_fields & " from T_CF_HOUSE where IDX = ( "
			query = query & "	select min(IDX) from T_CF_HOUSE where IDX > ? "
			
			if is_show = "Y" then 
				query = query & "		and is_show = 'Y' "
			end if 
			
			query = query & " ) "

			if is_show = "Y" then 
				query = query & "		and is_show = 'Y' "
			end if 

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

			select_fields = "IDX, TITLE, CONTENTS, THUMB_IMG, VIDEO, VIEW_CNT, IS_SHOW, REG_DATE, REG_ID, EDIT_DATE, EDIT_ID"

			query = "select " & select_fields & " from T_CF_HOUSE where IDX = ( "
			query = query & "	select max(IDX) from T_CF_HOUSE where IDX < ? "
			
			if is_show = "Y" then 
				query = query & "		and is_show = 'Y' "
			end if 
			
			query = query & " ) "

			if is_show = "Y" then 
				query = query & "		and is_show = 'Y' "
			end if 

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

			getNextInfo = arrayList

		End Function

		'입력
		Public Function insertInfo(ByVal DBHelper, ByVal dicParam)
			
			'변수 선언
			Dim query, arrParams

			query =			" insert into T_CF_HOUSE ( "
			query = query & "	 TITLE, CONTENTS, THUMB_IMG, VIDEO, VIEW_CNT, IS_SHOW, REG_DATE, REG_ID, HM_VIDEO, PROD_NM "
			query = query & " ) values ( "
			query = query & "	?, ?, ?, ?, 0, ?, getdate(), ?, ?, ? "
			query = query & " ) "

			arrParams = Array( _
				DBHelper.MakeParam("@TITLE", adVarChar, adParamInput, 200, dicParam.item("TITLE")), _
				DBHelper.MakeParam("@CONTENTS", adVarChar, adParamInput, 2147483647, dicParam.item("CONTENTS")), _
				DBHelper.MakeParam("@THUMB_IMG", adVarChar, adParamInput, 200, dicParam.item("THUMB_IMG")), _
				DBHelper.MakeParam("@VIDEO", adVarChar, adParamInput, 200, dicParam.item("VIDEO")), _
				DBHelper.MakeParam("@IS_SHOW", adVarChar, adParamInput, 1, dicParam.item("IS_SHOW")), _
				DBHelper.MakeParam("@REG_ID", adVarChar, adParamInput, 20, dicParam.item("REG_ID")), _
				DBHelper.MakeParam("@HM_VIDEO", adVarChar, adParamInput, 200, dicParam.item("HM_VIDEO")), _
				DBHelper.MakeParam("@PROD_NM", adVarChar, adParamInput, 200, dicParam.item("PROD_NM")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'수정
		Public Function editInfo(ByVal DBHelper, ByVal dicParam)
			
			'변수 선언
			Dim query, arrParams

			query = " update T_CF_HOUSE set "
			query = query & " TITLE = ?, "
			query = query & " CONTENTS = ?, "
			query = query & " THUMB_IMG = ?, "
			query = query & " HM_VIDEO = ?, "
			query = query & " VIDEO = ?, "
			query = query & " IS_SHOW = ?, "
			query = query & " PROD_NM = ?, "
			query = query & " EDIT_DATE = getdate(), "
			query = query & " EDIT_ID = ? "
			query = query & " where IDX = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@TITLE", adVarChar, adParamInput, 200, dicParam.item("TITLE")), _
				DBHelper.MakeParam("@CONTENTS", adVarChar, adParamInput, 2147483647, dicParam.item("CONTENTS")), _
				DBHelper.MakeParam("@THUMB_IMG", adVarChar, adParamInput, 200, dicParam.item("THUMB_IMG")), _
				DBHelper.MakeParam("@HM_VIDEO", adVarChar, adParamInput, 2000, dicParam.item("HM_VIDEO")), _
				DBHelper.MakeParam("@VIDEO", adVarChar, adParamInput, 2000, dicParam.item("VIDEO")), _
				DBHelper.MakeParam("@IS_SHOW", adVarChar, adParamInput, 1, dicParam.item("IS_SHOW")), _
				DBHelper.MakeParam("@PROD_NM", adVarChar, adParamInput, 200, dicParam.item("PROD_NM")), _
				DBHelper.MakeParam("@EDIT_ID", adVarChar, adParamInput, 20, dicParam.item("EDIT_ID")), _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("IDX")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'삭제
		Public Function deleteInfo( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim query, arrParams

			'게시판 삭제
			query = " delete from T_CF_HOUSE "
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

			query = " update T_CF_HOUSE set "
			query = query & " VIEW_CNT = VIEW_CNT + 1 "
			query = query & " where IDX = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("IDX")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function
	
		'리스트 구하기
		Public Function getFrontCfList(  ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intPageListCnt, intCurPage, strSearchKey, strSearchText, is_show, kind
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList
			Dim startRnum , endRnum

			'변수값 세팅
			intPageListCnt	= dicParam.Item("page_list_cnt")

			select_fields = " ROW_NUMBER() OVER (ORDER BY REG_DATE DESC) as num, IDX, TITLE, THUMB_IMG, PROD_NM  "

			query = " SELECT top " & intPageListCnt & " " & select_fields & " From T_CF_HOUSE "
			query = query & " WHERE IDX IN ( "
			query = query & "	SELECT DISTINCT RELATION_IDX FROM T_PROD_RELATION "
			query = query & "	WHERE PRODUCT_IDX IN (SELECT IDX FROM T_PRODUCT WHERE BRAND = ?)and GUBUN = ? "
			query = query & " ) and IS_SHOW = 'Y'"
			query = query & " ORDER BY REG_DATE DESC "

			arrParams = Array( _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("idx")), _
				DBHelper.MakeParam("@GUBUN", adVarChar, adParamInput, 50, dicParam.item("gubun")) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getFrontCfList = arrayList

		End Function 
	
	
		'Product_View cf 리스트 구하기
		Public Function getFrontProDCfList(  ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim intPageListCnt, intCurPage, strSearchKey, strSearchText, is_show, kind
			Dim query, objRs, arrParams
			Dim select_fields
			Dim arrayList
			Dim startRnum , endRnum

			'변수값 세팅
			intPageListCnt	= dicParam.Item("page_list_cnt")

			select_fields = " ROW_NUMBER() OVER (ORDER BY REG_DATE DESC) as num, IDX, TITLE, THUMB_IMG, PROD_NM  "

			query = " SELECT top " & intPageListCnt & " " & select_fields & " From T_CF_HOUSE "
			query = query & "WHERE IDX IN ( "
			query = query & "SELECT DISTINCT RELATION_IDX FROM T_PROD_RELATION "
			query = query & "WHERE PRODUCT_IDX = ? and GUBUN = ? "
			query = query & " ) and IS_SHOW = 'Y'"
			query = query & " ORDER BY REG_DATE DESC"

			arrParams = Array( _
				DBHelper.MakeParam("@IDX", adInteger, adParamInput, 4, dicParam.item("idx")), _
				DBHelper.MakeParam("@GUBUN", adVarChar, adParamInput, 50, dicParam.item("gubun")) _
			)

			set objRs = DBHelper.ExecSQLReturnRS(query, arrParams, nothing)

			if (not objRs.EOF) then
				arrayList = objRs.getRows
			Else
				arrayList = false
			end if

			objRs.close
			set objRs = nothing

			getFrontProDCfList = arrayList

		End Function 
	End Class
%>
