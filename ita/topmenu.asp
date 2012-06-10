


<div align="center"><!--#include file="banner_top_principale.asp"--></div>

<div style="height:5px"></div>
<!--#include file="js.asp"-->

<table width="<%=wsito%>" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="<%=wsito%>">
	<table border="0"  cellspacing="0" cellpadding="0">
	<tr><td width="50%"></td>

			<td>
<img border="0" src="../img/TL_Logo_international_BlackB5.gif" width="350" height="97"></td>
<td width="50%" align="right" valign="bottom">
<span class="data"><%session.lcid=2057%>
<b><%=WeekDayName(datepart("w",date))%>   <%=day(date)%> <%=monthname(month(date))%> <%=year(date)%></b></span><br><br></td>
</tr>
	</table>
	</td>
  </tr>
  
  <tr><td align="center"><!--#include file="bannertop.asp"--></td></tr>
  
  <tr>
    <td width="<%=wsito%>">
 <table border="0" width="100%" cellspacing="0" cellpadding="0" id="table1">
	<tr>
		<td width="100%" valign="bottom">
 <table border="0" cellspacing="1" id="table2">
  <tr>
  	<%if lingua=2 then%>
    <td nowrap>
		<a href="default.asp">Home</a></td>
		
		  <td>|</td>
	
    <td nowrap>
  
		<a href="domande.asp?idtiponews=434">Lead Stories</a></td>
		
		  <td>|</td>
	
    <td nowrap>
  
		<a href="domande.asp?idtiponews=435">News</a></td>
		
		<%end if%>
		
		<td>|</td>
		
		<td><a href="domande.asp?idtiponews=436">Events</a></td>
		

		
		<td>|</td>
			<%
		set rsb=cn.execute("select * from [93.186.241.74].[toplegalinternational].dbo.tiponews_query where dove='top' and idlingua="&SQLint(lingua)&" and attivotiponews=1")
		do while not rsb.eof
		%>
		   <td nowrap>
		<a href="<%=rsb("pag")%>?idtiponews=<%=rsb("idtiponews")%>"><%=rsb("tiponews")%></a></td>
		<td>|</td>
		<%rsb.movenext
		loop
		rsb.close
		set rsb=nothing
		%>
	<td nowrap>
		<a href="area_riservata.asp?idmenu=<%=idmenu%>">Newsletter</a></td>
		<td>|</td>
			<td nowrap>
		<a href="http://www.toplegal.it" target="_blank">toplegal.it</a></td>
		<td>|</td>
		
			<td nowrap><a href="modulo_contatti.asp">Subscriptions</a></td>
			
			
	
		
				
	
		
		
  </tr>
</table>
    
    
    	<td nowrap valign="bottom"><a href="/login.asp"><b>Login</b></a></td>
		
		
				<td valign="bottom"> | </td>
		<td nowrap valign="bottom"><a href="/area_riservata.asp"><b>Register</b></a></td>
		
		
		<td nowrap valign="bottom">           </td>
		
		
		<td nowrap>&nbsp;</td>
    
		</td>
		<td><A HREF='#' onclick='window.open("http://toplegalinternational.ita.newsmemory.com/ee/toplegalinternational/default1.php","TLinternational","height=" + (screen.availHeight-30) + ",width=" + (screen.availWidth-5) + ",alwaysRaised,dependent");'><img border="0" src="../img/EEditions.gif" width="145" height="56"></a></td>
	</tr>
	</table>
    
</td>
  </tr>
  
  <tr><td bgcolor="#ECF2F4" height="26">
  <table>
  <tr><td >
  
  	<form action="ricerca.asp" method="get">  
      Search: </span>
		<input name="ricerca" type="text" size="19">
      <input name="cerca" type="submit" value="Send"></form>
  
</td>

<td><select size="1" name="blog" onChange="DropDownMenu(this)" style="width:130">
                  <option value="default.asp">Region</option>                      
         <%
set rsw=cn.execute("select distinct newsattive.idprovincia,provincia.provincia from [93.186.241.74].[toplegalinternational].dbo.newsattive inner join [93.186.241.74].[toplegalinternational].dbo.provincia on newsattive.idprovincia=provincia.idprovincia order by provincia.provincia")

do while not rsw.eof
idprovincia=request("idprovincia")
if idprovincia="" then idprovincia=0
idprovincia=cint(idprovincia)
%>                            
<option <%if idprovincia=cint(rsw("idprovincia")) then%>selected<%end if%> value="domande.asp?IDprovincia=<%=rsw("idprovincia")%>" ><%=rsw("provincia")%></option>
                                        

<%
rsw.movenext
loop
%>
</select></td>
<td>
<select size="1" name="Mondo legale" onChange="DropDownMenu(this)" style="width:140">
<option value="<%=url%>">Legal Market</option>                      
<%
set rsh=cn.execute("select distinct stato,stato.idstato from [93.186.241.74].[toplegalinternational].dbo.newsattive inner join [93.186.241.74].[toplegalinternational].dbo.stato on stato.idstato=newsattive.idstato order by stato.stato asc")
do while not rsh.eof
%>                            
<option value="domande.asp?IDstato=<%=rsh("idstato")%>"><%=rsh("stato")%></option>
<%
rsh.movenext
loop
%>
</select></td>
<td><select size="1" name="settore" onChange="DropDownMenu(this)" style="width:140">
                  <option value="<%=url%>">Industries</option>                      
<%
set rsh=cn.execute("select distinct settore,settore.idsettore from [93.186.241.74].[toplegalinternational].dbo.newsattive inner join [93.186.241.74].[toplegalinternational].dbo.settore on newsattive.idsettore=settore.idsettore order by settore.settore asc")
do while not rsh.eof
%>                            
<option value="domande.asp?IDsettore=<%=rsh("idsettore")%>"><%=rsh("settore")%></option>
<%
rsh.movenext
loop
%>
</select></td>
<td>

<select size="1" name="argomento" onChange="DropDownMenu(this)" style="width:140">
 <option value="<%=url%>">Practice Areas</option>  
<%
set rsh=cn.execute("select distinct argomento,argomento.idargomento from [93.186.241.74].[toplegalinternational].dbo.newsattive inner join [93.186.241.74].[toplegalinternational].dbo.argomento on newsattive.idargomento=argomento.idargomento order by argomento.argomento asc")
do while not rsh.eof
%>
<option value="domande.asp?IDargomento=<%=rsh("idargomento")%>"><%=rsh("argomento")%></option><%
rsh.movenext
loop
%>
</select></td>

</tr>
	
	
	
</table></td>	  
	</tr>

	</table>
	
	
	<div align="center"><!--#include file="banner_sotto_top.asp"--></div>
	
	<br>