<%
	Class ProdCategoryCls

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
			is_show		=  dicParam.Item("is_show")
			depth1		=  dicParam.Item("depth1")
			depth2		=  dicParam.Item("depth2")

			select_fields = " idx, depth1, depth2, name, thumb_img, reg_date, reg_id, edit_date, edit_id, cate1_order "

			query = " select " & select_fields & " from V_PROD_CATEGORY where 1=1 "

			if depth1 <> "" then
				query = query & " and depth1 = " & depth1
			end if

			if depth2 = "0" then
				query = query & " and depth2 = 0 "
			end if

			query = query & " order by cate1_order, depth2 "
		
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
			intIdx	=  dicParam.Item("idx")

			select_fields = " idx, depth1, depth2, name, thumb_img, reg_date, reg_id, edit_date, edit_id "

			query = "select " & select_fields & " from T_PROD_CATEGORY where idx = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@idx", adInteger, adParamInput, 4, dicParam.item("idx")) _
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

			if dicParam.item("depth2") = "0" then

                query =			" insert into T_PROD_CATEGORY ( "
                query = query & "	 depth1, depth2, name, thumb_img, reg_date, reg_id, cate1_order "
                query = query & " ) values ( "
    			query = query & "	?, ?, ?, ?, getdate(), ?, ? "
	       		query = query & " ) "

	       		arrParams = Array( _
	       			DBHelper.MakeParam("@depth1", adInteger, adParamInput, 4, dicParam.item("depth1")), _
	       			DBHelper.MakeParam("@depth2", adInteger, adParamInput, 4, dicParam.item("depth2")), _
	       			DBHelper.MakeParam("@name", adVarChar, adParamInput, 200, dicParam.item("name")), _
	       			DBHelper.MakeParam("@thumb_img", adVarChar, adParamInput, 200, dicParam.item("thumb_img")), _
	       			DBHelper.MakeParam("@reg_od", adVarChar, adParamInput, 20, dicParam.item("reg_id")), _
					DBHelper.MakeParam("@depth1", adInteger, adParamInput, 4, dicParam.item("depth1")) _
	       		)

	       	else

	       	   query =			" insert into T_PROD_CATEGORY ( "
                query = query & "	 depth1, depth2, name, reg_date, reg_id, cate1_order "
                query = query & " ) values ( "
    			query = query & "	?, (select isnull(max(depth2),0) + 1 from T_PROD_CATEGORY where depth1 = ? ), ?, getdate(), ?, ? "
	       		query = query & " ) "

	       		arrParams = Array( _
	       			DBHelper.MakeParam("@depth1", adInteger, adParamInput, 4, dicParam.item("depth1")), _
	       			DBHelper.MakeParam("@depth1", adInteger, adParamInput, 4, dicParam.item("depth1")), _
	       			DBHelper.MakeParam("@name", adVarChar, adParamInput, 200, dicParam.item("name")), _
	       			DBHelper.MakeParam("@reg_od", adVarChar, adParamInput, 20, dicParam.item("reg_id")), _
					DBHelper.MakeParam("@depth1", adInteger, adParamInput, 4, dicParam.item("depth1")) _
	       		)

	       	end if

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'수정
		Public Function editInfo(ByVal DBHelper, ByVal dicParam)

			'변수 선언
			Dim query, arrParams

			query = " update T_PROD_CATEGORY set "
			query = query & " name = ?, "
			query = query & " thumb_img = ?, "
			query = query & " edit_id = ?, "
            	query = query & " edit_date= getdate() "
			query = query & " where idx = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@name", adVarChar, adParamInput, 200, dicParam.item("name")), _
				DBHelper.MakeParam("@thumb_img", adVarChar, adParamInput, 200, dicParam.item("thumb_img")), _
				DBHelper.MakeParam("@reg_od", adVarChar, adParamInput, 20, dicParam.item("reg_id")), _
				DBHelper.MakeParam("@idx", adInteger, adParamInput, 4, dicParam.item("idx")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

		'삭제
		Public Function deleteInfo( ByVal DBHelper, ByVal dicParam )

			'변수 선언
			Dim query, arrParams

			'게시판 삭제
			query = " delete from T_PROD_CATEGORY "
			query = query & " where idx = ? "

			arrParams = Array( _
				DBHelper.MakeParam("@idx", adInteger, adParamInput, 4, dicParam.item("idx")) _
			)

			DBHelper.ExecSQL query, arrParams, nothing

		End Function

	End Class
%>
