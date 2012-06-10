<table cellpadding="0" cellspacing="0" border="0" width="100%">
<!--
<%
sessionid=session.sessionid
if request.cookies("tpa")<>sessionid then
%>
<tr><td align="left" style="padding-left:35">

<div id="Pub1" style="border-style:none; position:absolute;width:250px; height:13px; z-index:2; background-color:#000000" onMouseOver="aff1()">
<div align="right" style="padding-right:5px"><b><font size="1"><a href="#" onClick="dis2()" title="Chiudi" class="bianco">[X]</a></font></b></font></div></div>
<div id="Pub2" style="position:absolute; z-index:1; border: 1px none #000000">
<a href="http://www.toplegal.it/awards.asp"><img border="0" src="../Popup_Award.gif" width="250" height="250"></a>
</div></td></tr>
<%
response.cookies("tpa")=sessionid
end if
%>
-->


<%
set rsg=cn.execute("select id,titolo,immagine,approfondimento  from [93.186.241.74].[toplegalinternational].dbo.newsattive where idtiponews=434 and htmlnews<>0 order by data desc,id desc")
for h=1 to 3
if rsg.Eof = true then exit for
testo=rsg("approfondimento")
testo=removetags(testo)
testo=anteprima(testo,20)
immagine=rsg("immagine")
id=rsg("id")
%>
<tr>
<td valign="top" class="testo_interno">
<span class="titblu"><a href="approfondimento.asp?id=<%=id%>"><i><%=rsg("titolo")%></i></a></span><br>
<%if immagine<>"" then%>
<img src="square.aspx?img=upload/news/<%=immagine%>&opx=80" align="left" hspace="5" width="80" class="bordogrigio">
<%end if%>

<%=testo%>
<div class="smallblu" style="clear:both;">&nbsp;</div>
</td></tr>

<%
testo=""
immagine=""
rsg.movenext
next

%>

 <%
set rsv=cn.execute("select top 8 * from [93.186.241.74].[toplegalinternational].dbo.newsattive where idtiponews=429 and artbase=0 ")
   if not rsv.eof then%>

<tr><td><div class="smallissimo">&nbsp;</div>
<div align="right" class="testo"><span class="titrosso">&lt;&lt;</span>&nbsp;<a href="domande.asp?idtiponews=434">all 
	news</a>&nbsp;&nbsp;&nbsp;</div><div class="small">&nbsp;</div></td></tr>
	




<tr><td align="center">
<table cellpadding="0" cellspacing="0" border="0" width="93%">
<tr><td class="small">&nbsp;</td></tr><tr><td class="titoli">Careers</td></tr>
<tr><td class="smallblu">&nbsp;</td></tr>
<%

   do while not rsv.eof
   testo_lavoro=rsv("approfondimento")
   testo_lavoro=anteprima(testo_lavoro,10)
   immagine=rsv("immagine")
   %>
<tr><td><span class="testo_neretto">
   <%if immagine<>"" then%>
   <a href="approfondimento.asp?id=<%=rsv("id")%>&idtiponews=429"><img src="<%=cartellas%>/news/<%=immagine%>" width="100" align="left" hspace="4" border="0"></a>
   <%end if%>
   <a href="approfondimento.asp?id=<%=rsv("id")%>&idtiponews=429"><%=rsv("titolo")%></a></span><br>
   <%=removetags(testo_lavoro)%></td></tr>
<tr><td class="smallissimo" id="grigio">&nbsp;</td></tr>
<tr><td class="smallissimo">&nbsp;</td></tr>
  <%
  rsv.movenext
  loop
  rsv.close
  set rsv=nothing
  %>
</table>
</td></tr><%end if%>






<%
for h=3 to 7
if rsg.Eof = true then exit for
testo=rsg("approfondimento")
testo=removetags(testo)
testo=anteprima(testo,20)
immagine=rsg("immagine")
id=rsg("id")
%>
<tr>
<td valign="top" class="testo_interno">
<span class="titblu"><a href="approfondimento.asp?id=<%=id%>"><i><%=rsg("titolo")%></i></a></span><br>
<%if immagine<>"" then%>
<img src="square.aspx?img=upload/news/<%=immagine%>&opx=80" align="left" hspace="5" width="80" class="bordogrigio">
<%end if%>
<%=testo%>
<div class="smallblu" style="clear:both;">&nbsp;</div>
</td></tr>

<%
testo=""
immagine=""
rsg.movenext
next

%>

<tr><td><div class="smallissimo">&nbsp;</div>
<div align="right" class="testo"><span class="titrosso">&lt;&lt;</span>&nbsp;<a href="domande.asp?idtiponews=434">all 
	news</a>&nbsp;&nbsp;&nbsp;</div><div class="small">&nbsp;</div></td></tr>

<tr><td>&nbsp;</td></tr>

</table>