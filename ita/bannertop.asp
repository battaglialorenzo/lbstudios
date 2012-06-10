<%
set rsbl=cn.execute("select top 1 * from [93.186.241.74].[toplegalinternational].dbo.link where banner<>0 and dovebanner='top' order by idlink desc")
if not rsbl.eof then
idlink=rsbl("idlink")
 imgbanner=""
 link=""
 idnewscollegato=0
 linkattivo=""
if not rsbl.eof then
 imgbanner=rsbl("imgbanner")
 link=rsbl("link")
 idnewscollegato=rsbl("idnewscollegato")
 if idnewscollegato<>0 then 
linkAttivo="approfondimento.asp?ID="&idNewscollegato&""
target="_top"
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
 %>
<%if linkattivo<>"" then%><a href="cont.asp?idlink=<%=idlink%>&link=<%=linkattivo%>" target="<%=target%>"><img src="<%=cartellas%>/banner/<%=imgbanner%>" border="0" title="<%=linkattivo%>"><%else%><img src="<%=cartellas%>/banner/<%=imgbanner%>" border="0"></a>
<%end if%><%
rsbl.close
set rslb=nothing
end if
 imgbanner=""
 link=""
 idnewscollegato=0
 linkattivo=""
 end if
%>