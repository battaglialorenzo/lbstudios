<%@ Language="VBScript" %>
<%if Request.ServerVariables ("HTTP_HOST")="www.toplegal.eu" then response.redirect"http://www.toplegalinternational.com"%>
<!--#include file="connessione.asp"-->
<!--#include file="head.asp"-->
<table border="0" cellpadding="0" cellspacing="0" width="<%=wsito%>"  class="basesito">
		
							<tr>
								<td>
<!--#include file="ita/topmenu.asp"-->
								</td>
							</tr>
					<tr>
					<td valign="top" >

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
<!--#include file="sotto.asp"-->