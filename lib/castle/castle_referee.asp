<%

'//@ castle_referee.asp
'/*
' * Castle: KISA Web Attack Defender - ASP Version
' * 
' * Author : ����ȣ <hackeran@hotmail.com>
' *          ���缭 <mirr1004@gmail.com>
' *          ����ȯ <juluxer@gmail.com>
' *
' * Last modified Jan. 09, 2009
' *
' */

Option Explicit

if (inStr(Request.ServerVariables("Script_Name"), "castle_") > 0) then
	Dim access_err	
	access_err = "<script language=""javascript"" "&_
		"CodePage="" "& Session.CodePage &" "" charset="" "& Response.Charset &" "">"&_
		"alert(""�������� ������ �ƴմϴ�."");"&_
	        "history.back(-1);</script>"
	Response.Write(access_err)
	Response.End	
end if

if (IsEmpty(Application("CASTLE_ASP_VERSION_BASE_DIR"))) then
	Dim dir_err	
	dir_err = "<script language=""javascript"" "&_
		"CodePage="" "& Session.CodePage &" "" charset="" "& Response.Charset &" "">"&_
		"alert(""��ġ ���丮�� �ùٸ��� �������� �ʾҽ��ϴ�."");"&_
	        "history.back(-1);</script>"
	Response.Write(dir_err)
	Response.End	
end if

Dim castle_xmlDoc
Set castle_xmlDoc = Server.CreateObject("Microsoft.XMLDOM")
castle_xmlDoc.async = "false"

'/* CASTLE ��å ���� ���� �˻� */
Dim castle_objFS
Set castle_objFS = Server.CreateObject("Scripting.FileSystemObject")

Dim castle_CAPIUtil, castle_policy, castle_check, castle_log, castle_objReg
Set castle_CAPIUtil = Server.CreateObject("CAPICOM.Utilities") 
Set castle_policy = CreateObject("Scripting.Dictionary")
Set castle_check = CreateObject("Scripting.Dictionary")
Set castle_log = CreateObject("Scripting.Dictionary")
Set castle_objReg = new RegExp
	castle_objReg.Global = true
	castle_objReg.IgnoreCase = true

If (castle_objFS.FileExists(Server.MapPath(Application("CASTLE_ASP_VERSION_BASE_DIR") & "/castle_policy.asp"))) Then

'/* CASTLE ��å ���� ���� */
    castle_xmlDoc.Load (Server.MapPath(Application("CASTLE_ASP_VERSION_BASE_DIR") & "/castle_policy.asp"))

    if (castle_xmlDoc.parseError.errorCode <> 0) Then
	    Response.Write "���� �ε��� ������ �߻��Ͽ����ϴ�."
	    Response.End
    end if
    
	if ("TRUE" = castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("SITE")(0).GetElementsByTagName("UTF-8")(0).firstChild.nodeValue)) then
  	    Session.CodePage = 65001
  	    Response.Charset = "UTF-8"
	else
		 Session.CodePage = 65001
  	    Response.Charset = "UTF-8"
	end if

Else
		Session.CodePage = 65001
  	    Response.Charset = "UTF-8"
		
	Dim castle_install_err	
	castle_install_err = "<script language=""javascript"" "&_
		"CodePage="" "& Session.CodePage &" "" charset="" "& Response.Charset &" "">"&_
		"alert(""CASTLE�� ��ġ�Ǿ� ���� �ʽ��ϴ�."");"&_
	               "history.back(-1);</script>" 
	Response.Write(castle_install_err)
	Response.End
End If
	
'/* CASTLE ���� �����ӿ�ũ �Լ��� */

'/* CASTLE ���۸� ��� �޽��� �Լ�
' *
' * �Լ���: castle_referee_alert
' *
' * ��å ������ ���� �Էµ� �޽����� ������ ȭ�鿡 ����ϰų�
' * ���â�� ���� �����. ���ڽ� ����� ��쿡�� �ƹ��͵� ������� ����
' *
' * �Ķ����: 
' *    castle_msg - ����� �޽���
' *
' * ����: ����
' */
function castle_referee_alert(castle_msg)

	'/* ��� �κ� ��å ���� ���� */
	if Not(castle_xmlDoc.GetElementsByTagName("ALERT")(0).hasChildNodes) then
		castle_referee_alert = null
		Exit function
	end if

	'/* ��� ��å �������� */
	castle_policy("config") = castle_xmlDoc.GetElementsByTagName("MODULE_NAME")(0).firstChild.nodeValue
	castle_policy("config_title") = castle_CAPIUtil.Base64Decode(castle_policy("config"))
	castle_policy("alert") = castle_xmlDoc.GetElementsByTagName("CONFIG")(0).GetElementsByTagName("ALERT")(0).firstChild.nodeValue
	castle_policy("alert_alert") = castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("ALERT")(0).GetElementsByTagName("ALERT")(0).firstChild.nodeValue)
	castle_policy("alert_message") = castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("ALERT")(0).GetElementsByTagName("MESSAGE")(0).firstChild.nodeValue)
	castle_policy("alert_stealth") = castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("ALERT")(0).GetElementsByTagName("STEALTH")(0).firstChild.nodeValue)

	'// ���ڽ� ����� ���
	if (castle_policy("alert_stealth") = "TRUE") then
	    Response.Write("")
		castle_referee_alert = null
	    Exit function
	end if

	Dim castle_page
	castle_page = "http://" & Request.ServerVariables("SERVER_NAME") & Request.ServerVariables("SCRIPT_NAME")

	Dim error_img
	error_img = Application("CASTLE_ASP_VERSION_BASE_DIR") & "/img/sorry.gif"
    
	'// �޽��� ����� ���
	if (castle_policy("alert_message") = "TRUE") then
        Response.Write("<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.01 Transitional//EN"">")
        Response.Write("<html>")
        Response.Write("<head>")
        Response.Write("<meta http-equiv=""Content-Type"" content=""text/html; charset=UTF-8"">")
        Response.Write("</head>")
        Response.Write("<body bgcolor=""#FFFFFF"">")
        Response.Write("<center><br><br><br><img src=" & error_img & "></center>")
        Response.Write("</body>")
        Response.Write("</html>")
        castle_referee_alert = null
        exit Function
	end if

	'// ��� ����� ���
	if (castle_policy("alert_alert") = "TRUE") then
		Dim castle_alert_msg
		castle_alert_msg  = "<script language=""javascript"" "&_
			"codepage="" "& Session.CodePage & " "" charset="" "& Response.charset &" "">" &_
			"alert(""\n" &_
	                "�� CASTLE �˸� �� \n" &_
	                "\n" &_
	                "CASTLE�� ���� ������ ���ܵǾ����ϴ�.\n" &_
	                "\n" &_
	                "--- ���� ������ ---\n\n" & castle_page & "\n" &_
	                "\n" &_
	                "--- ���� ���� ---\n\n" & castle_msg & "\n" &_
	                "\n" &_
	                "Ư���� ���� ���� ���� ������ �ݺ��Ǹ� �����ڿ��� �����Ͻʽÿ�.\n" &_
	                "���� ����� ��� ������ �α׿� ��ϵ˴ϴ�.\n" &_
	                "\n""); history.back(-1);</script>"
	                
		Response.Write(castle_alert_msg)

		castle_referee_alert = null
        exit function
	end if

    castle_referee_alert = null
end function


'/* CASTLE ���۸� �α� �Լ�
' *
' * �Լ���: castle_referee_logger
' *
' * ��å ������ ���� �Էµ� �α� �޽����� �α� ���Ͽ� �߰���
' * ����� ����� ��쿡�� �α׸� ������� ����
' *
' * �Ķ����: 
' *    castle_msg - �α� �޽���
' *
' * ����: ����
' */
function castle_referee_logger(castle_msg)

	'/* �α� �κ� ��å ���� ���� */
	if Not(castle_xmlDoc.GetElementsByTagName("LOG")(0).hasChildNodes) then
	    castle_referee_logger = null
		exit Function
	end if

	'/* �α� ��å �������� */	
	castle_policy("log_bool") = castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("LOG")(0).GetElementsByTagName("BOOL")(0).firstChild.nodeValue)
	castle_policy("log_filename") = castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("LOG")(0).GetElementsByTagName("FILENAME")(0).firstChild.nodeValue)

	'/* �α� ��� ���� �Ǵ� */
	if (castle_policy("log_bool") = "FALSE") then
		castle_referee_logger = null
		exit Function
	end if
	
	'/* �α� ���丮 ���� �Ǵ� �� ���� */
	if (castle_objFS.FolderExists(Server.MapPath(Application("CASTLE_ASP_VERSION_BASE_DIR") & "/log")) <> True) Then
	    castle_objFS.CreateFolder(Server.MapPath( Application("CASTLE_ASP_VERSION_BASE_DIR") & "/log"))
	end if

	'/* �α� ���� */
	castle_log("filename") = Application("CASTLE_ASP_VERSION_BASE_DIR") &_
	                  "/log/" & Replace(Date, "-", "") & "-" & castle_policy("log_filename")

    	Dim castle_objLog
	if (castle_objFS.FileExists(Server.MapPath(castle_log("filename")))) then
    	Set castle_objLog = castle_objFS.OpenTextFile(Server.MapPath(castle_log("filename")), 8, True) 		'ForAppending
	else
		Set castle_objLog = castle_objFS.CreateTextFile(Server.MapPath(castle_log("filename")), True)
	end if	

	if Not(isEmpty(castle_objLog)) then
		castle_objLog.WriteLine(castle_msg)
		castle_objLog.Close
	end if

	Set castle_objLog = nothing

    castle_referee_logger = null
end function


'/* CASTLE ���۸� Ȯ�� ����ǥ���� üũ �Լ�
' *
' * �Լ���: castle_referee_eregi
' *
' * �Էµ� ����ǥ���� ���ϰ� �Ԏ� ���ڿ��� ���ڵ��ϰ�
' * UTF-8, CP949(eucKR)�� ��ȯ�� �� ���� �׽�Ʈ�� ������
' *
' * �Ķ����: 
' *    castle_regexp - ����ǥ���� ����
' *    castle_str - �Էµ� ���ڿ�
' *
' * ����:
' *    (utf8_regexp or eucKR_regexp) - Ž���� ����ǥ���� ����
' *    NULL - Ž������ ���� ��� ��
' */
function castle_referee_eregi(castle_list, castle_string)

Dim list, castle_regexp
for each list in castle_list

    castle_regexp = castle_CAPIUtil.Base64Decode(list.text)
    
    Dim castle_str
    castle_str = castle_string
    castle_regexp = trim(castle_regexp)
    castle_str = trim(castle_str)

	'// ���ܻ���
    if (Len(castle_regexp) = 0 Or Len(castle_str) = 0) then
	castle_referee_eregi = null
	exit function
    end if
    
	'// �Է°� ���ڵ�
	castle_str = castle_referee_urldecode(castle_str)
	castle_str = castle_referee_unhtmlentities(castle_str)

	'// ����ǥ���� üũ
    castle_objReg.IgnoreCase = True
    castle_objReg.Pattern = castle_regexp

    if (castle_objReg.Test(castle_str)) then
	'// SkipList üũ
	if Not(IsEmpty(Application("SkipList"))) then
	    castle_objReg.IgnoreCase = True
	    castle_objReg.Pattern = "(" & Application("SkipList") & ")"
	    if (castle_objReg.Test(castle_str)) then
		castle_referee_eregi = null
	        exit function
	    end if
	end if

	castle_referee_eregi = castle_regexp
	exit function

    end if
    
next
	
    castle_referee_eregi = null
end function

function castle_referee_urldecode(castle_str)

    On Error Resume Next
	'/* HTTP URL Decoding */
    Dim aSplit
    Dim sOutput
    Dim i
    Dim castle_regEx, Match, Matches
    Set castle_regEx = New RegExp

    If IsNull(castle_str) Then
       castle_referee_urldecode = ""
       Exit Function
    End If

    sOutput = Replace(castle_str, "+", " ")
    castle_regEx.Pattern = "%([0-9A-F]{2})"
    castle_regEx.IgnoreCase = True
    castle_regEx.Global = True
    Set Matches = castle_regEx.Execute(sOutput)

    For Each Match in Matches
    	sOutput = Replace(sOutput, Match.Value, Chr("&H" & Match.SubMatches(0)))
    	if (Err.Number <> 0) then
            castle_error_handler()
            Err.Clear
        end if
    Next

    Set Matches = Nothing
    Set	castle_regEx = Nothing

    castle_referee_urldecode = sOutput
end function

function castle_referee_unhtmlentities(castle_str)

    On Error Resume Next
	'// replace numeric entities
    Dim Match, Matches
    castle_objReg.IgnoreCase = True

    castle_objReg.Pattern = "&#x([0-9A-F]+);?" '"&#[xX]?([0-9A-Fa-f]+);?"
    Set Matches = castle_objReg.Execute(castle_str)
    For Each Match in Matches
        castle_str = Replace(castle_str, Match.Value, ChrW("&H" & Match.SubMatches(0)))
        if (Err.Number <> 0) then
            castle_error_handler()
            Err.Clear
        end if
    Next

    castle_objReg.Pattern = "&#([0-9]+);?"
    Set Matches = castle_objReg.Execute(castle_str)
    For Each Match in Matches
        castle_str = Replace(castle_str, Match.Value, ChrW(Match.SubMatches(0)))
        if (Err.Number <> 0) then
            castle_error_handler()
            Err.Clear
        end if
    Next

    'castle_referee_unhtmlentities = Server.HTMLEncode(castle_str)
    castle_referee_unhtmlentities = castle_str
end function

function castle_referee_htmldecode(castle_str)

    Dim index
    castle_str = Replace(castle_str, "&quot;", Chr(34))
    castle_str = Replace(castle_str, "&lt;"  , Chr(60))
    castle_str = Replace(castle_str, "&gt;"  , Chr(62))
    castle_str = Replace(castle_str, "&amp;" , Chr(38))
    castle_str = Replace(castle_str, "&nbsp;", Chr(32))

    castle_referee_htmldecode = castle_str
End Function

function castle_referee_delete_directory_traverse(castle_path)

	'/* Delete directory traverse attack.. */

	castle_path = castle_referee_urldecode(castle_path)
	
	castle_objReg.IgnoreCase = true

	'	// "/../" -> "/"
	castle_objReg.Pattern = "/\.\./"
	while (castle_objReg.Test(castle_path)) 
		castle_path = castle_objReg.Replace(castle_path, "/")
	wend

	'	// "./" -> ""
	castle_objReg.Pattern = "\./"
	while (castle_objReg.Test(castle_path))
		castle_path = castle_objReg.Replace(castle_path ,"")
	wend
		
	'	// "//" -> "/"
	castle_objReg.Pattern = "//"
	while (castle_objReg.Test(castle_path)) 
		castle_path = castle_objReg.Replace(castle_path, "/")
	wend

	'	// "\..\" -> "\"
	castle_objReg.Pattern = "\\\.\.\\"
	while (castle_objReg.Test(castle_path)) 
		castle_path = castle_objReg.Replace(castle_path, "\")
	wend
	
	'	// ".\" -> ""
	castle_objReg.Pattern = "\.\\"
	while (castle_objReg.Test(castle_path))
	    castle_path = castle_objReg.Replace(castle_path, "")
    wend
    
	'	// "\\" -> "\"
	castle_objReg.Pattern = "\\\\"
	while (castle_objReg.Test(castle_path)) 
		castle_path = castle_objReg.Replace(castle_path, "\")
	wend

	castle_referee_delete_directory_traverse = castle_path
end function

function castle_referee_error_handler(policy_type, rule, method, key, value, castle_msg)

	'/* ��� �� �α� �κ� ��å ���� ���� */
	if Not(castle_xmlDoc.GetElementsByTagName("ALERT")(0).hasChildNodes) then
		castle_referee_error_handler = null
		exit function
	end if

	if Not(castle_xmlDoc.GetElementsByTagName("LOG")(0).hasChildNodes) then
		castle_referee_error_handler = null
		exit function
	end if

	'/* �α� ��å �������� */
	castle_policy("log_bool") = castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("LOG")(0).GetElementsByTagName("BOOL")(0).firstChild.nodeValue)
	castle_policy("log_simple") = castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("SIMPLE")(0).firstChild.nodeValue)
	castle_policy("log_detail") = castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("DETAIL")(0).firstChild.nodeValue)
	
	'/* CASTLE ���� ��� ���� */
	castle_policy("mode_enforcing") = castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("ENFORCING")(0).firstChild.nodeValue)
	castle_policy("mode_permissive") = castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("PERMISSIVE")(0).firstChild.nodeValue)

	'/* �α� �κ� ��å ���� ���� */
	if Not(castle_xmlDoc.GetElementsByTagName("SQL_INJECTION")(0).hasChildNodes) then
		castle_referee_error_handler = null
		exit function
	end if

	'/* �α� �޽��� �ۼ�: REMOTE_ADDR - [DATE] REQUEST_URL : MESSAGE */
	
	'// ��������
	castle_objReg.IgnoreCase = true
	castle_objReg.Pattern = Chr(13)
	value = castle_objReg.Replace(value, "\r")
	castle_objReg.Pattern = Chr(10)
	value = castle_objReg.Replace(value, "\n")

	'// ���� �޽��� �ۼ�
	if (castle_policy("log_simple") = "TRUE") then
		castle_log("simple")  = Request.ServerVariables("REMOTE_ADDR") & " - [" & Now &_
		                 Request.ServerVariables("SCRIPT_NAME") & ": " & key & " = " & Mid(value, 1, 64) & ": " &_
		                 castle_msg & vbCrLf

		castle_referee_logger(castle_log("simple"))
	else
		'// �� �޽��� �ۼ�
	    if (castle_policy("log_detail") = "TRUE") then
		    castle_log("detail") = Request.ServerVariables("REMOTE_ADDR") & " - [" & Now &_
		                    Request.ServerVariables("SCRIPT_NAME") & ": " & key & " = " & Mid(value, 1, 64) & ": " &_
		                    castle_msg & vbCrLf &_
		                     
		                    " -> [Method: " & method & "]" & vbCrLf &_
		                    " -> [Policy: " & policy_type & "]" & vbCrLf &_
		                    " -> [Pattern: " & rule & "]" & vbCrLf

		    rule = "/" & rule & "/"

		    Dim Matches, Match
		    castle_objReg.IgnoreCase = true
		    castle_objReg.Pattern = rule
		    Set Matches = castle_objReg.Execute(value)

			'// �� ���� ���
		    if Not(isEmpty(Matches)) then
			    for each Match in Matches
    	        castle_log("detail") = castle_log("detail") & " -> [Offset: " & Match.FirstIndex & "] [Matched-Content: " & Match.Value & "]" & vbCrLf
			    next
		    end if

		    castle_referee_logger(castle_log("detail"))
	    end if
	    
    end if

    '// �������̸� ���� ����
    if (castle_policy("mode_enforcing") = "TRUE") then
		castle_referee_alert(castle_msg & ": " & key)
		Response.End
	end if

	'// �������̸� ��� ����
	if (castle_policy("mode_permissive") = "TRUE") then
		castle_referee_error_handler = null
		exit function
	end if

	castle_referee_error_handler = null
end function

function castle_referee_detect_sql_injection(castle_string)

	'/* SQL INJECTION ��å ���� ���� */
	if Not(castle_xmlDoc.GetElementsByTagName("SQL_INJECTION")(0).hasChildNodes) then
		castle_referee_detect_sql_injection = null
		exit function
	end if

	castle_policy("sql_injection_bool") = castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("SQL_INJECTION")(0).GetElementsByTagName("BOOL")(0).firstChild.nodeValue)

	'// SQL INJECTION ������ ���
	if (castle_policy("sql_injection_bool") = "FALSE") then
		castle_referee_detect_sql_injection = null
		exit function
	end if

	Dim sql_injection_list, list, castle_regexp
	Set sql_injection_list = castle_xmlDoc.GetElementsByTagName("SQL_INJECTION")(0).GetElementsByTagName("LIST")

	'// ����ǥ�������� Ž��
	castle_regexp = castle_referee_eregi(sql_injection_list, castle_string)
	if Not(isNull(castle_regexp)) then
		castle_referee_detect_sql_injection = castle_regexp
		exit function
	end if

	castle_referee_detect_sql_injection = FALSE
end function

function castle_referee_detect_xss(castle_string)

	'/* XSS ��å ���� ���� */
	if Not(castle_xmlDoc.GetElementsByTagName("XSS")(0).hasChildNodes) then
		castle_referee_detect_xss = null
		exit function
	end if

    castle_policy("xss_bool") = castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("XSS")(0).GetElementsByTagName("BOOL")(0).firstChild.nodeValue)

	'// XSS ������ ���
	if (castle_policy("xss_bool") = "FALSE") then
		castle_referee_detect_xss = null
		exit function
	end if

	Dim xss_list, list, castle_regexp
	Set xss_list = castle_xmlDoc.GetElementsByTagName("XSS")(0).GetElementsByTagName("LIST")

	'// ����ǥ�������� Ž��
	castle_regexp = castle_referee_eregi(xss_list, castle_string)
	if Not(isNull(castle_regexp)) then
		castle_referee_detect_xss = castle_regexp
		exit function
	end if

	castle_referee_detect_xss = FALSE
end function

function castle_referee_detect_word(castle_string)

	'/* WORD ��å ���� ���� */
	if Not(castle_xmlDoc.GetElementsByTagName("WORD")(0).hasChildNodes) then
		castle_referee_detect_word = null
		exit function
	end if

	castle_policy("word_bool") = castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("WORD")(0).GetElementsByTagName("BOOL")(0).firstChild.nodeValue)

	'// WORD ������ ���
	if (castle_policy("word_bool") = "FALSE") then
		castle_referee_detect_word = null
		exit function
	end if

	Dim word_list, list, castle_regexp
	Set word_list = castle_xmlDoc.GetElementsByTagName("WORD")(0).GetElementsByTagName("LIST")

	'// ����ǥ�������� Ž��
	castle_regexp = castle_referee_eregi(word_list, castle_string)
	if Not(isNull(castle_regexp)) then
		castle_referee_detect_word = castle_regexp
		exit function
	end if

	castle_referee_detect_word = FALSE
end function

function castle_referee_detect_tag(castle_string)

	'/* TAG ��å ���� ���� */
	if Not(castle_xmlDoc.GetElementsByTagName("TAG")(0).hasChildNodes) then
		castle_referee_detect_tag = null
		exit function
	end if

	castle_policy("tag_bool") = castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("TAG")(0).GetElementsByTagName("BOOL")(0).firstChild.nodeValue)

	'// TAG ������ ���
	if (castle_policy("tag_bool") = "FALSE") then
		castle_referee_detect_tag = null
		exit function
	end if

	Dim tag_list, list, castle_regexp
	Set tag_list = castle_xmlDoc.GetElementsByTagName("TAG")(0).GetElementsByTagName("LIST")

	'// ����ǥ�������� Ž��
	castle_regexp = castle_referee_eregi(tag_list, castle_string)
	if Not(isNull(castle_regexp)) then
		castle_referee_detect_tag = castle_regexp
		exit function
	end if

	castle_referee_detect_tag = FALSE
end function

function castle_referee_check_ip_policy()

	'// Ŭ���̾�Ʈ ������ ������
    castle_check("ip") = Request.ServerVariables("REMOTE_ADDR")

    if (castle_xmlDoc.GetElementsByTagName("IP")(0).hasChildNodes) then
	castle_policy("ip") = castle_xmlDoc.GetElementsByTagName("IP")(0).hasChildNodes
    end if

	'/* ������ ��å ���� �Ǵ� : IP ��å�� ������ �⺻ ��� */
    if Not(castle_policy("ip")) then 
	castle_referee_check_ip_policy = null
	exit function
    end if

    castle_policy("ip_bool") = castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("IP")(0).GetElementsByTagName("BOOL")(0).firstChild.nodeValue)
    castle_policy("ip_allow") = castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("IP")(0).GetElementsByTagName("ALLOW")(0).firstChild.nodeValue)
    castle_policy("ip_deny") = castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("IP")(0).GetElementsByTagName("DENY")(0).firstChild.nodeValue)
	
	'// ������ �˻� ��� ����
    if (castle_policy("ip_bool") = "FALSE") then
	castle_referee_check_ip_policy = null
	exit function
    end if

	'// ��� ���� �Ǵ�
    if Not(castle_xmlDoc.GetElementsByTagName("IP")(0).GetElementsByTagName("LIST")(0).hasChildNodes) then
	castle_referee_check_ip_policy = null
	exit function
    end if

	'// ��� ��������
    Dim ip_list, list, ip_exists, ip_regexp
    Set ip_list = castle_xmlDoc.GetElementsByTagName("IP")(0).GetElementsByTagName("LIST")

	'// ��Ͽ��� ������ ���� �˻�
	ip_exists = FALSE
  
    Dim ip_comp1, ip_comp2, str_comp1, str_comp2
	
	for each list in ip_list
	    list = castle_CAPIUtil.Base64Decode(list.text)

        'IP Address validation
        list = Replace(list, "-", ".")
        ip_comp1 = Split(list, ".")
        ip_comp2 = Split(castle_check("ip"), ".")
        str_comp1 = ip_comp1(0) & ip_comp1(1) & ip_comp1(2)
        str_comp2 = ip_comp2(0) & ip_comp2(1) & ip_comp2(2)
        
        if (str_comp1 = str_comp2) then
	        
	        'IP ������ ���
	        if (UBound(ip_comp1) = 4) then
	        
	            if (ip_comp1(3) <= ip_comp2(3) And ip_comp2(3) <= ip_comp1(4)) then
	                ip_exists = TRUE
	            end if
            
            else
            
                if (ip_comp1(3) = 0 or ip_comp1(3) = ip_comp2(3)) then
	                ip_exists = TRUE
	            end if
            
	        end if
	        
        else

            str_comp1 = ip_comp1(0) & ip_comp1(1)
            str_comp2 = ip_comp2(0) & ip_comp2(1)
            
            if (str_comp1 = str_comp2 And ip_comp1(2) = 0 And ip_comp1(3) = 0) then
                ip_exists = TRUE
            else
            
                str_comp1 = ip_comp1(0)
                str_comp2 = ip_comp2(0)
                
                if (str_comp1 = str_comp2 And ip_comp1(1) = 0 And ip_comp1(2) = 0 And ip_comp1(3) = 0) then
                    ip_exists = TRUE
                else 
                    str_comp1 = ip_comp1(0) & ip_comp1(1) & ip_comp1(2) & ip_comp1(3)
                    if (str_comp1 = 0) then
                        ip_exists = TRUE
                    end if
                end if
                
            end if
	        
        end if
        	    
    next
    
    '/* ������ ����� ��å ���� */
	    '// ȭ��Ʈ����Ʈ
    if (castle_policy("ip_allow") = "TRUE") then

        if Not(ip_exists) then
	        castle_referee_error_handler "������ ��å", "check remote_ip", "IP", castle_check("ip"), "", "������ ���� ������ �뿪���� ���� �õ�"
        end if
    	    
    else 
        '// ������Ʈ
        if (castle_policy("ip_deny") = "TRUE") then
            if (ip_exists) then
	           castle_referee_error_handler "������ ��å", "check remote_ip", "IP", castle_check("ip"), "", "���ܵ� ������ �뿪���� ���� �õ�"
            end if
        end if		

    end if

    castle_referee_check_ip_policy = null
end function

function castle_referee_check_file_policy()

	castle_referee_check_file_policy = null
end function

function castle_referee_check_site_policy()

	'/* ����Ʈ ��å ���� */
	if (isEmpty(isEmpty(castle_xmlDoc.GetElementsByTagName("SITE")(0).GetElementsByTagName("BOOL")(0).firstChild.nodeValue))) then
		castle_referee_check_site_policy = null
	    exit function
    	end if

	'// ����Ʈ ��å ��������
	castle_policy("site") = castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("SITE")(0).GetElementsByTagName("BOOL")(0).firstChild.nodeValue)

	'// ����Ʈ ��å ����
	if (castle_policy("site") = "FALSE") then
	    castle_referee_error_handler "����Ʈ ��å", "check site-policy", "SITE", "����Ʈ���ܵ�", "", "����Ʈ ���"
	end if	

	castle_referee_check_site_policy = null
end function

function castle_referee_check_basic_policy()

	'// ������ �̸��� ������
	castle_check("page_name") = Request.ServerVariables("SCRIPT_NAME")
	castle_check("page_name") = castle_referee_delete_directory_traverse(castle_check("page_name"))

	'/* GET �޼ҵ� ó�� */
	Dim key, value, pattern

	if (castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("GET")(0).firstChild.nodeValue) = "TRUE") then

	for each key in Request.QueryString
	
		'/* Ž�� ��� Ž�� */
		value = Request.QueryString(key)
		'// SQL_INJECTION Ž��
		pattern = castle_referee_detect_sql_injection(value)
		if (pattern <> False) then
			castle_referee_error_handler "�⺻��å", pattern, "GET", key, value, "SQL_Injection ���� ���� Ž��"
        end if		

		'// XSS Ž��
		pattern = castle_referee_detect_xss(value)
		if (pattern <> False) then
			castle_referee_error_handler "�⺻��å", pattern, "GET", key, value, "XSS ���� ���� Ž��"
	    end if		
		
		'// WORD Ž��
		pattern = castle_referee_detect_word(value)
		if (pattern <> False) then
			castle_referee_error_handler "�⺻��åa", pattern, "GET", key, value, "�ҷ� WORD Ž��"
	    end if		
		
		'// TAG Ž��
		pattern = castle_referee_detect_tag(value)
		if (pattern <> False) then
			castle_referee_error_handler "�⺻��å", pattern, "GET", key, value, "TAG  ���� ���� Ž��"
	    end if
	    	
	next
	
	end if
    
	'/* POST �޼ҵ� ó�� */
	if (castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("POST")(0).firstChild.nodeValue) = "TRUE") then	

	for each key in Request.Form 
	
		'/* Ž�� ��� Ž�� */
		value = Request.Form(key)

		'// SQL_INJECTION Ž��
		pattern = castle_referee_detect_sql_injection(value)
		if (pattern <> False) then
			castle_referee_error_handler "�⺻��å", pattern, "POST", key, value, "SQL_Injection ���� ���� Ž��"
	    end if

		'// XSS Ž��
		pattern = castle_referee_detect_xss(value)
		if (pattern <> False) then
			castle_referee_error_handler "�⺻��å", pattern, "POST", key, value, "XSS ���� ���� Ž��"
        end if		

		'// WORD Ž��
		pattern = castle_referee_detect_word(value)
		if (pattern <> False) then
			castle_referee_error_handler "�⺻��å", pattern, "POST", key, value, "�ҷ� WORD Ž��"
	    end if
	    	
		'	// TAG Ž��
		pattern = castle_referee_detect_tag(value)
		if (pattern <> False) then
			castle_referee_error_handler "�⺻��å", pattern, "POST", key, value, "TAG ���� ���� Ž��"
	    end if
	    		
	next

	end if

	castle_referee_check_basic_policy = null
end function

function castle_referee_check_cookie_policy()

	'/* COOKIE ���� ���� ó�� */
	Dim key, value, pattern

	if (castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("COOKIE")(0).firstChild.nodeValue) = "TRUE") then

	for each key in Request.Cookies 
	
		'/* COOKIE ���� ���� ó�� */
        value = Request.Cookies(key)
		'/* Ž�� ��� Ž�� */
		pattern = castle_referee_detect_sql_injection(value)
		if (pattern <> False) then
			castle_referee_error_handler "�⺻��å", pattern, "COOKIE", key, value, "SQL_Injection ���� ���� Ž��"
	    end if		

		'// XSS Ž��
		pattern = castle_referee_detect_xss(value)
		if (pattern <> False) then
			castle_referee_error_handler "�⺻��å", pattern, "COOKIE", key, value, "XSS ���� ���� Ž��"
        end if		
		
		'// WORD Ž��
		pattern = castle_referee_detect_word(value)
		if (pattern <> False) then
			castle_referee_error_handler "�⺻��å", pattern, "COOKIE", key, value, "�ҷ� WORD Ž��"
	    end if		
		
		'// TAG Ž��
		pattern = castle_referee_detect_tag(value)
		if (pattern <> False) then
			castle_referee_error_handler "�⺻��å", pattern, "COOKIE", key, value, "TAG ���� ���� Ž��"
	    end if
	    
	next

	end if

	castle_referee_check_cookie_policy = null
end function

function castle_referee_check_advance_policy()

	castle_referee_check_advance_policy = null
end function

'/* CASTLE Referee ���� �Լ� */
function castle_referee_main()

	'	// IP ���� �õ� ����
	castle_referee_check_site_policy()

	'	// IP ���� �õ� ����
	castle_referee_check_ip_policy()

	'	// �⺻ ��å ����
	castle_referee_check_basic_policy()

	'	// COOKIE ����
	castle_referee_check_cookie_policy()

	castle_referee_main = null
end function
'/* CASTLE ���� �����ӿ�ũ �Լ��� �� */


if (isEmpty(castle_xmlDoc.GetElementsByTagName("ENFORCING")(0).firstChild.nodeValue)) then
	Response.End
end if

'/* CASTLE ���ø� DISABLED �����̸� �ٷ� ���� */
castle_policy("disabled") = castle_CAPIUtil.Base64Decode(castle_xmlDoc.GetElementsByTagName("DISABLED")(0).firstChild.nodeValue)

if (castle_policy("disabled") = "FALSE") then

	'/* CASTLE Referee ���� �Լ� ȣ�� */
	castle_referee_main()

end if

function castle_error_handler()
	
    ' For Windows 2000 or XP
    ' For Script Version Upgrade
    if (hex(Err.Number) = "800A01B6" or hex(Err.Number) = "1B6") then
    
        Response.Write("===== ���� ������ ���� ��ũ��Ʈ ��� ���� ======<br><br>")
	    Response.Write "���� " & ScriptEngine & " " & _
		ScriptEngineMajorVersion & "." & _
		ScriptEngineMinorVersion & "." & _
		ScriptEngineBuildVersion & " ������Դϴ�.<br><br>"
	    Response.Write(ScriptEngine & " 5.5 �̻��̳� Microsoft Windows Script 5.6 �̻����� Upgrade �ϼ���.<br><br>")
	    Response.Write("����ũ�μ���Ʈ���� Ȩ���������� �ٿ�ε� ���� �� �ֽ��ϴ�.<br>")
	    Response.Write("<script>if (confirm(""Windows 2000 �� XP�� Windows Script 5.6 �� \n\n�ٿ�ε� �� �� �ִ� Microsoft ������Ʈ�� �̵��մϴ�.""))")
	    Response.Write("{location.href=""http://www.microsoft.com/downloads/details.aspx?familyid=c717d943-7e4b-4622-86eb-95a22b832caa&displaylang=ko"";}")
	    Response.Write("else {history.back();}</script>")
	    Response.End
        
    end if       

end function
'/* End of castle_referee.asp */
%>