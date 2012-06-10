
<table width="<%=wmdx%>" border="0" cellspacing="0" cellpadding="0">
 


  <tr>
    <td>		<table  width="100%" border="0" cellspacing="0" cellpadding="0" id="table2">
  <tr><td  height="18" class="titoli">
	News</td></tr>
	<tr><td class="smallissimo">&nbsp;</td></tr>
  <tr><td  height="200" class="bordogrigio" id="padding">
  

<marquee width="100%" height="200" direction="up" scrollamount="4" scrolldelay="140" class="testo">
	 <%
  
 set rsd=cn.execute("select top 5 approfondimento,id,titolo,data from [93.186.241.74].[toplegalinternational].dbo.news where idtiponews=435 order by data desc,id desc ")
 do while not rsd.eof
 %>
<div><i><%=rsd("data")%></i></div>
<div class="titblu"><a href="approfondimento.asp?id=<%=rsd("id")%>"><%=rsd("titolo")%></b></div>
<%testo=rsd("approfondimento")%>
<%tst=anteprima(testo,10)%>
<%=RemoveTags(tst)%></a><br><br>
<%
testo=""
rsd.movenext
loop
rsd.close
set rsd=nothing
%>

	
	</marquee>
<br>
<div class="testo">	
<div align="right"><span class="titrosso">&lt;&lt;</span>&nbsp;<a href="domande.asp?ricerca=avanzata&fairicerca=no">in archive</b></div>
<div align="right"><span class="titrosso">&lt;&lt;</span>&nbsp;<a href="domande.asp?idtiponews=435">all news</a></div>
</div>
</td></tr>


</td>
</tr>







  
    <tr><td>&nbsp;</td></tr>
  
  

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

  <tr><td class="bordogrigio" id="padding" NOWRAP><form method="post" action="area_riservata.asp">
  <div class="titrosso">Subscribe to our newsletter</div>
<b>E-mail:</b><br><input type="text" size="18" name="email">
	<input type="submit" value="&gt;&gt;" name="B1" class="titrosso"></form>

</td></tr>
<tr><td>&nbsp;</td></tr>

<tr><td align="center">
<a href="/turnover.asp">
	<img border="0" src="/images/turnover_2011.gif" width="167" height="300"></a></td></tr>

<tr><td>&nbsp;</td></tr>


  
  
  
  
  
  
    <%
   set rsh=cn.execute("select id,titolo,data,approfondimento,orario  from [93.186.241.74].[toplegalinternational].dbo.newsattive where idtiponews=436  order by data asc")
   if not rsh.eof then
   %>

 <tr><td  height="18" class="titoli">Events</td></tr>
<tr><td class="smallblu">&nbsp;</td></tr>
  <tr><td id="padding">  
 
  
<%
 do while not rsh.eof
   testo_lavoro=rsh("approfondimento")
   testo_lavoro=anteprima(testo_lavoro,10)
   %>
 
   <div class="titrosso"><%=rsh("data")%>&nbsp;<%=rsh("orario")%></div>
   <b><a href="approfondimento.asp?id=<%=rsh("id")%>&idtiponews=436"><%=rsh("titolo")%></a></b><br>
   <%=testo_lavoro%>
<br><br>
  <%
  rsh.movenext
 loop
  rsh.close
  set rsh=nothing
  %>
<div align="right" class="testo"><span class="titrosso">&lt;&lt;</span>&nbsp;<a href="domande.asp?idtiponews=436">all events</a></div>

</td></tr>  <tr><td>&nbsp;</td></tr><%end if%>
</table>

		
	</td>
  </tr>
  
  

<tr><td align="center">
<a href="http://www.lawyersandbusiness.com?idlingua=5&lingua=5">
	&nbsp;</a></td></tr>
	<tr><td>&nbsp;</td></tr>	


</table>