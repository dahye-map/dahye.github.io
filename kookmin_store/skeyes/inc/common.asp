<% 'KISA WEB Security Template
  Application("CASTLE_ASP_VERSION_BASE_DIR") = "/castle-asp"
  Server.Execute(Application("CASTLE_ASP_VERSION_BASE_DIR") & "/castle_referee.asp")
%>
<%
    Response.Expires = 0
    Response.Expiresabsolute = Now() - 1
    Response.AddHeader "pragma","no-cache"
    Response.AddHeader "cache-control","private"
    Response.CacheControl = "no-cache"
%>
<!--#include virtual="/common/Common2011.asp" -->
<!--#include virtual="/common/include_count.asp"-->
<!--#include virtual="/common/SSL_utf8.asp" -->
