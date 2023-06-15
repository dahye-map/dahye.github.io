<%
'********************************************************
' 작성일 : 2011-05-30
' 작성자 : 모션블루 박재영
' 요약 : 파일 업로드 관리
'********************************************************
'// 경로 존재 유무에 따라 에러 처리 할것
Class UploadCls
	Dim oFSO
	Dim m_Save_Path

	Dim m_Save_File_Ids
	Dim m_Save_File_Names
	Dim m_Save_File_Sizes
	Dim m_Save_File_Mime

	Dim m_Del_FileNames

	Dim m_Html_Tag_Name

	Private Sub Class_Initialize   ' Setup Initialize event.
		Set oFSO = Server.CreateObject("Scripting.FileSystemObject")
	End Sub

	Private Sub Class_Terminate   ' Setup Terminate event.
		Set oFSO = Nothing
	End Sub

	Property Get Path
		Path = m_Save_Path
	End Property
	Property Let Path(ByVal P_V)
		If ( P_V <> "" ) Then
			If ( Not oFSO.FolderExists(P_V) ) Then
				oFSO.CreateFolder(P_V)
			End If
		End If
		m_Save_Path = P_V
	End Property

	Property Get FileIds
		FileIds = m_Save_File_Ids
	End Property
	Property Let FileIds(ByVal P_V)
		m_Save_File_Ids = P_V
	End Property
	
	Property Get ArrFileNames
		Dim arr
		If ( m_Save_File_Names = "" ) Then
			FileNames = ""
			Exit Property
		End If
		arr = Split(m_Save_File_Names, "||")
		FileNames = arr
	End Property
	Property Get FileNames		
		FileNames = m_Save_File_Names
	End Property
	Property Let FileNames(ByVal P_V)
		m_Save_File_Names = P_V
	End Property

	Property Get ArrFileSizes
		Dim arr
		If ( m_Save_File_Sizes = "" ) Then
			FileSizes = ""
			Exit Property
		End If
		arr = Split(m_Save_File_Sizes, "||")
		FileSizes = arr
	End Property
	Property Get FileSizes
		FileSizes = m_Save_File_Sizes
	End Property
	Property Let FileSizes(ByVal P_V)
		m_Save_File_Sizes = P_V
	End Property

	Property Get ArrFileMimes
		Dim arr
		If ( m_Save_File_Mime = "" ) Then
			FileMimes = ""
			Exit Property
		End If
		arr = Split(m_Save_File_Mime, "||")
		FileMimes = arr
	End Property
	Property Get FileMimes
		FileMimes = m_Save_File_Mime
	End Property
	Property Let FileMimes(ByVal P_V)
		m_Save_File_Mime = P_V
	End Property

	Property Get DelFileNames
		DelFileNames = m_Del_FileNames
	End Property
	Property Let DelFileNames(ByVal P_V)
		m_Del_FileNames = P_V
	End Property

	Property Let TagName(ByVal P_V)
		m_Html_Tag_Name = P_V
	End Property

	'/////////////////////////////////////////////////////////
	'// 파일명 생성
	'/////////////////////////////////////////////////////////
	Function GetFileName(ByVal P_FileName)
		Dim i
		Dim ReturnFileName
		Dim sf_FileName, sf_FileExt

		If ( Not oFSO.FileExists(m_Save_Path & "\" & P_FileName) ) Then
			GetFileName = P_FileName
			Exit Function
		End If

		sf_FileName = Replace(Mid(P_FileName, InstrRev(P_FileName, "\") + 1), " ", "_")
		sf_FileExt = Mid(sf_FileName, InstrRev(sf_FileName, ".") + 1)
		sf_FileName = Mid(sf_FileName, 1, InstrRev(sf_FileName, ".") - 1)

		i = 1
		Do while True
			ReturnFileName = m_Save_Path & "\" & sf_FileName & "(" & i & ")." & sf_FileExt
			If ( oFSO.FileExists(ReturnFileName) ) Then
			Else
				ReturnFileName = sf_FileName & "(" & i & ")." & sf_FileExt
				Exit Do
			End If
			i = i + 1
		Loop

		GetFileName = ReturnFileName
	End Function

	Function Save(ByRef oP_Upload)
		Dim bf_Result
		Dim sf_FileName
		Dim if_FileCnt
		Dim sFileObjName
		
		If ( m_Html_Tag_Name = "" ) Then
			sFileObjName = "dev_file"
		Else
			sFileObjName = m_Html_Tag_Name
		End If

		if_FileCnt = oP_Upload(sFileObjName).Count

		If ( if_FileCnt = 1 ) Then
			sf_FileName = oP_Upload(sFileObjName).FileName

			If ( sf_FileName <> "" ) Then
				m_Save_File_Sizes = oP_Upload(sFileObjName).FileLen
				m_Save_File_Mime = oP_Upload(sFileObjName).MimeType
				sf_FileName = GetFileName(sf_FileName)
				'-- 파일 저장
				'response.write m_Save_Path & "\" & sf_FileName
				oP_Upload(sFileObjName).SaveAs(m_Save_Path & "\" & sf_FileName)
				'-- Return 할 파일명 저장
				m_Save_File_Names = sf_FileName
			End If

		ElseIf ( if_FileCnt >= 2 ) Then
			Dim i
			For i = 1 To if_FileCnt
			response.write "upload form index : " & i & "<br/>"
				sf_FileName = oP_Upload(sFileObjName)(i).FileName
				If ( sf_FileName <> "" ) Then
					
					sf_FileName = GetFileName(sf_FileName)
					
					'-- 파일 저장
					oP_Upload(sFileObjName)(i).SaveAs(m_Save_Path & "\" & sf_FileName)

					'-- Return 할 파일명 저장
					If ( m_Save_File_Names = "" ) Then
						m_Save_File_Sizes = oP_Upload(sFileObjName).FileLen
						m_Save_File_Mime = oP_Upload(sFileObjName).MimeType
						m_Save_File_Names = sf_FileName
					Else
						m_Save_File_Sizes = m_Save_File_Sizes & "||" & oP_Upload(sFileObjName).FileLen
						m_Save_File_Mime = m_Save_File_Mime & "||" & oP_Upload(sFileObjName).MimeType
						m_Save_File_Names = m_Save_File_Names & "||" & sf_FileName
					End If
					
				End If
			Next

		End If

		If ( Err.Number = 0 ) Then
			bf_Result = True
		Else
			bf_Result = False
		End If

		Save = bf_Result
	End Function

	'// 파일 삭제
	Sub Delete()
		If ( m_Del_FileNames <> "" ) Then
			Dim sFileName
			If ( Instr(m_Del_FileNames, "||") > 0 ) Then
				Dim arDelFiles
				Dim i				
				arDelFiles = Split(m_Del_FileNames, "||")
				For i = 0 To UBOUND(arDelFiles)
					sFileName = m_Save_Path & "\" & arDelFiles(i)
					response.write sFileName
					If ( oFSO.FileExists(sFileName) ) Then
						oFSO.DeleteFile(m_Save_Path & "\" & arDelFiles(i))
					End If
				Next
			Else
				'// 단일 파일 삭제
				sFileName = m_Save_Path & "\" & m_Del_FileNames
				If ( oFSO.FileExists(sFileName) ) Then
					oFSO.DeleteFile(sFileName)
				End If
			End If
		End If
	End Sub

	'// 저장된 파일 취소
	Function Rollback()
	End Function
End Class
%>