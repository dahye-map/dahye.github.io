<%@ Language=VBScript CODEPAGE=65001 %>
<%
	option explicit
	Response.Expires = -1
	Server.ScriptTimeout = 600
	' All communication must be in UTF-8, including the response back from the request
	Session.CodePage  = 65001

	On Error Resume Next
%>
<!-- #include virtual="/2017/lib/common.asp" -->
<!-- #include virtual="/2017/lib/cls/freeaspupload.asp" -->
<%
	Dim uploadsDirVar

	uploadsDirVar = Server.MapPath(fileUploadDir + "/editor")

	Dim Upload, fileName, fileSize, ks, i, fileKey
	Dim msg, ckeditorfuncnum

	ckeditorfuncnum = setDefaultStr(Request("CKEditorFuncNum"), "")

	Set Upload = New FreeASPUpload
	'Upload.Save(uploadsDirVar)
	'fileName = Upload.SaveOneFile(uploadsDirVar)
	fileName = Upload.SaveOneKey(uploadsDirVar, "upload")

	' If something fails inside the script, but the exception is handled
	If Err.Number<>0 then
		Response.End
	End If

  	'ks = Upload.UploadedFiles.keys
  	'if (UBound(ks) <> -1) then
	'	for each fileKey in Upload.UploadedFiles.keys
	'		fileName = Upload.UploadedFiles(fileKey).FileName
	'	Next

	'	msg = "전송되었습니다."
	'else
	'	msg = "파일이 없습니다."
	'end If

	'ckeditorfuncnum = setDefaultStr(Upload.Form("CKEditorFuncNum"), "")


%>
<!DOCTYPE HTML>
<html>
 <head>
  <meta charset="utf-8">

<script type="text/javascript">
	var CKEDITORFUNCNUM = "<%= ckeditorfuncnum %>";
	var fileName = "<%= fileName %>";
	var editorRootUrl = "<%= fileUploadDir %>/editor";
	var imageUrl = editorRootUrl + "/" + fileName;
	window.parent.CKEDITOR.tools.callFunction(CKEDITORFUNCNUM ,imageUrl , "전송되었습니다");
</script>

</head>
<body>
</body>
</html
