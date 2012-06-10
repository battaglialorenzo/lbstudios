<!--#include file="bannerbottom.asp"--><table width="<%=wsito%>" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr>
    <td bgcolor="#000000"><div align="center" class="testo_footer"> Penta Group S.r.l. - Viale Abruzzi 37, 20131 Milano  - Italy</div></td>
  </tr>
  <tr>
    <td align="center" valign="middle"><br>
    

<a href="default.asp">Home</a> | 
<a href="domande.asp?idtiponews=435">News</a> | 
<a href="domande.asp?idtiponews=436">Events</a> | 
<a href="modulo_contatti.asp">Subscriptions</a> | 

    <%
		set rsb=cn.execute("select * from [93.186.241.74].[toplegalinternational].dbo.tiponews_query where dove='top' and idlingua="&SQLint(lingua)&" and attivotiponews=1")
		do while not rsb.eof
		%>
<a href="<%=rsb("pag")%>?idtiponews=<%=rsb("idtiponews")%>"><%=rsb("tiponews")%></a> |
		
		<%rsb.movenext
		loop
		rsb.close
		set rsb=nothing
		%>
		<a href="login.asp">Reserved Area</a>
	<br>
<br>
 
</td>
  </tr>
</table>
<%
if cn<>"" then
cn.close
set cn=nothing
cn=""
end if

if cn1<>"" then
cn1.close
set cn1=nothing
cn1=""
end if
%>