

<table width="<%=wmsx%>" border="0" cellspacing="0" cellpadding="0">

<%

 if idmenu<>67  then
  set rsu=cn.execute("select top 1 * from [93.186.241.74].[toplegalinternational].dbo.tiponews_query where idmenu=67 and attivotiponews=1 and home='si' order by ordtiponews desc")
if not rsu.eof then
 %>

<tr><td align="center">
<script language="JavaScript1.1">generatorflash('/toplegal_en.swf','150','230','ffffff','7,0,0,0','7','','flash');</script>
</td></tr>
<%
end if
else
%>
<tr><td align="center">
<img border="0" src="../images/icona.gif" width="130" height="140"></td></tr>
<%

end if
%>

<tr><td><img border="0" src="../img/trasparente.gif" width="1" height="5"></td></tr>
<tr><td align="center">
<script>
function DropDownMenu(entered)
{
// ********** DROP DOWN MENU (c) Henrik Petersen / NetKontoret - All rights reserved ****************
// The script is explained along with other useful scripts at: http://www.echoecho.com/javascript.htm
// You may freely use this script as long as you do not remove this line and the 2 lines above.
with (entered)
{
ref=options[selectedIndex].value;
splitcharacter=ref.lastIndexOf("$");

if (splitcharacter!=-1) {loc=ref.substring(0,splitcharacter); target=ref.substring(splitcharacter+1,1000).toLowerCase();}
else {loc=ref; target="_self";};
lowloc=loc.toLowerCase();
if (lowloc=="false") {return;}

if (target=="_self") {document.location=loc;}
else {if (target=="_top") {top.location=loc;}
      else {if (target=="_blank") {window.open(loc);}
           else{if (target=="_parent") {parent.location=loc;}
               else {parent.frames[target].location=loc;};
               }
           }
     }
}
}
</script>


</td></tr>





<tr><td>&nbsp;</td></tr>
<tr><td><!--#include file="banner_left.asp"--></td></tr>
<tr><td>&nbsp;</td></tr>
</table>
		