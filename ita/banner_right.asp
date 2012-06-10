<table border="0" cellpadding="0" cellspacing="0" align="center">

                                                  
                              
                                                  
                                       
  <%
  set rsbl=cn.execute("select * from [93.186.241.74].[toplegalinternational].dbo.link where banner<>0 and dovebanner='right' and idlingua="&SQLint(lingua)&" order by ordlink ")
 if rsbl.eof then
 set rsbl=cn.execute("select * from [93.186.241.74].[toplegalinternational].dbo.link where banner<>0 and dovebanner='right'  order by ordlink ")
 end if
 
 imgbanner=""
 link=""
 idnewscollegato=0
 linkattivo=""
 do while not rsbl.eof
 idlink=rsbl("idlink")
 imgbanner=rsbl("imgbanner")
 width=rsbl("width")
 height=rsbl("height")
 estensione=lcase(right(imgbanner,3))
 link=rsbl("link")
 idnewscollegato=rsbl("idnewscollegato")
 
 if idnewscollegato<>0 then 
linkAttivo="approfondimento.asp?ID="&idNewscollegato&""
target="_self"
end if

if link<>"" then 
link=replace(link,"http://","")
linkattivo="http://"&link&""
if left(link,15)="www.toplegal.eu" then
target="_top"
else
target="_blank"
end if
end if

 %><tr>
  <td align="center">
  <%if estensione="swf" then%>
  <script language="JavaScript1.1">generatorflash('/upload/banner/<%=imgbanner%>?idlink=<%=idlink%>&link=<%=linkattivo%>','<%=width%>','<%=height%>','ffffff','7,0,0,0','7','','flash');</script>
  <%else%>
  
  <%if linkattivo<>"" then%>
  <a href="cont.asp?idlink=<%=idlink%>&link=<%=linkattivo%>" target="<%=target%>">
<img src="<%=cartellas%>/banner/<%=imgbanner%>" border="0" class="imgbanner">
</a>
<%else%>
<img src="<%=cartellas%>/banner/<%=imgbanner%>"  border="0" class="imgbanner">
<%end if%>
<%end if%>

</td>
</tr>
<tr><td>&nbsp;</td></tr>
<%
 imgbanner=""
 link=""
 idnewscollegato=0
 linkattivo=""
rsbl.movenext
loop
 imgbanner=""
 link=""
 idnewscollegato=0
 linkattivo=""
rsbl.close
set rslb=nothing
%>
 
 
 </table>
