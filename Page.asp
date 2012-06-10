<%@ Language="VBScript" %>
<!--#include file="connessione.asp"-->
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>TopLegal International, the European legal market</title>
<meta charset="utf-8" />
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-1967248-1";
urchinTracker();
</script>

        
<link rel="stylesheet" type="text/css" href="stile.css">
<script type="text/javascript" src="CalendarPopup.js"></script>
<script type="text/javascript" src="library.js"></script>

<script LANGUAGE="JavaScript">document.write(getCalendarStyles());</script>

<script type="text/javascript">
	var cal = new CalendarPopup();
	</script>
	
<script type="text/javascript">
var win2;
function fullScreen(theURL) {
win2 = window.open(theURL, '', 'width=' + (screen.width-5) + ',height=' + (screen.height-30) + ', scrollbars=auto, resizable=yes, ').focus();
}
function CloseTheWindow() {
 if (win2) win2.close();
}
</script>
	
<style type="text/css">
table.righealterne tr.alterna td{background-color: #3366CC;}
</style>
<script type="text/javascript"> 
onload=ColoraRighe;

function ColoraRighe(){
var tabelle=document.getElementsByTagName("table");
for(i=0;i<tabelle.length;i++){
if(tabelle[i].className.indexOf("righealterne")>=0){
trs=tabelle[i].tBodies[0].rows;
for(j=1;j<trs.length;j+=2)
trs[j].className="grigio";
        }
    }
}
</script>

</head>
    <body>
        <div align="center" width="<%=wsito%>px">
            
            <table border="0" cellpadding="0" cellspacing="0" width="<%=wsito%>"  class="basesito">
            
                <tr>
								<td>
<!--#include file="ita/topmenu.asp"-->
								</td>
							</tr>
                <tr>
					<td valign="top">
                        
                        <table border="0" cellpadding="0" cellspacing="0" width="<%=wsito%>"  class="centrosito">
						
						
							<tr>
							
<%if wmsx>0 then%>				
<td class="menusx" width="<%=wmsx%>" valign="top" > 
<!--#include file="ita/menusx.asp"-->
</td>
<%end if%>	
									
									
									
<td  valign="top" class="centro" width="<%=wcenter%>" >
<!--#include file="ita/home.asp"-->
</td>


<%if wmdx>0 then%>				
<td class="menudx" width="<%=wmdx%>" valign="top" >
<!--#include file="ita/menudx.asp"-->
</td>
<%end if%>


<%if wedx>0 then%>				
<td class="menuedx" width="<%=wedx%>" valign="top" >
<!--#include file="ita/menuedx.asp"-->
</td>
<%end if%>	

									
							</tr>
						</table>
                        
                    </td>
                    
                </tr>
                <tr>
			<td>
			<!--#include file="ita/under.asp"-->
			</td>
			</tr>
                </table>
            
</div>
 <div align="center"><a href="http://www.mavilab.it" target="_blank" title="Web Agency Realizzazione siti internet">Designed by Mavilab</a></div>	
        </body>

</html>
