<!--#include file="config.asp"-->
<%
if cn<>"" then
cn.close
set cn=nothing
cn=""
end if



session.lcid=1040
Set cn = Server.CreateObject("ADODB.Connection")
cn.open "PROVIDER=SQLNCLI10;DATA SOURCE=intranet.landlogic.it;UID=sa;PWD=nutella;"




Response.ExpiresAbsolute = now()-2
Response.Addheader "pragma","no-cache"
Response.Addheader "cache-control","private"
Response.Cachecontrol="no-cache"
response.buffer=true
'response.expires=-1500
Const adOpenKeyset = 1


lingua=request("idLingua")
if lingua="" then lingua=session("lingua")
if lingua="" then lingua="2"
session ("lingua")=lingua



Function Anteprima(sText, nParole)
if stext<>"" then
  Dim nTemp, nVolte
  stext=trim(stext)
  stext=trim(stext)
  sText = Replace(sText, vbCrLf, " ")
  nTemp = InStr(sText, " ")
  ntemp=cint(ntemp)
	  If nTemp>0 Then
	  	nVolte = 1
		While nTemp <> 0 And nVolte < nParole 
	       nVolte = nVolte + 1
	       nTemp = InStr(nTemp + 1, sText, " ")
  		Wend
  	End If
  	
	if nVolte > 0 Then
	   If nTemp > 0 Then
           Anteprima = Mid(sText, 1, nTemp - 1) & "..."
	 Else
         Anteprima = sText
     End If
  Else
   If Len(sText) > 0 Then

         Anteprima =sText
     Else
         Anteprima=""
     End If
  End If
  end if
End Function


Function hlink(messaggio)
if messaggio<>"" then
messaggio=replace(messaggio,","," ,")
   messaggio=replace(messaggio,")"," ) ")
   messaggio=replace(messaggio,"("," ( ")

messaggio = SPLIT(messaggio,VbCrLf)

FOR m=0 TO ubound(messaggio) 
parola = SPLIT(messaggio(m)," ") 

  FOR i=0 TO ubound(parola)
  
 IF (InStr(lcase(parola(i)),"href") = 0) then
   
    IF Mid (parola(i),1,7) = "http://" THEN 
      parola(i)="<a href="&parola(i)&" target=_blank>"&parola(i)&"</a>" 
    END IF 
  IF Mid (parola(i),1,8) = "(http://" THEN


parola(i)="<a href="&parola(i)&" target=_blank>"&parola(i)&"</a>" 
    END IF
    
    IF Mid (parola(i),1,4) = "www." THEN 
     
      parola(i)="<a href=http://"&parola(i)&" target=_blank>"&parola(i)&"</a>" 
    END IF 
      IF Mid (parola(i),1,5) = "(www." THEN 
     
      parola(i)="<a href=http://"&parola(i)&" target=_blank >"&parola(i)&"</a>" 
    END IF 

    IF (InStr(parola(i),"@") <> 0) AND (InStr(parola(i),".") <> 0) THEN 
      parola(i)="<a href=""mailto:"&parola(i)&""">"&parola(i)&"</a>" 
    END IF 
end if


  NEXT 

  messaggio(m)=JOIN(parola," ") 
 
NEXT 
messaggio = JOIN(messaggio,VbCrLf) 

messaggio=replace(messaggio," ," ,",")
messaggio=replace(messaggio," )",")")
messaggio=replace(messaggio,"( ","(")
hlink = REPLACE (messaggio, VbCrLf, "<BR>")
end if
End Function






Function parolalunga(messaggio)



  parola = SPLIT(messaggio," ") 
  FOR kk=0 TO ubound(parola)
  lenparola=len(parola(i))

if lenparola>120 then
parola(kk)=""
end if

if lenparola>60 then
parolaS=left(parola(kk),60)
parolaR=right(parola(kk),lenparola-60)
parola(kk)=parolaS&"<br>"&parolar
end if



NEXT
parolalunga=JOIN(parola," ") 
End Function














Function AntRicerca(sText, nParole,ricerca)
  Dim nTemp, nVolte

stext=trim(stext)
sText = Replace(sText, vbCrLf, " ")
stext=" "&stext

len_txt=len(sText)
testo=split(ricerca," ")
ricercas=testo(0)
dparola=instr(1,sText,ricercas,1)
dparola=dparola-145

if dparola<=0 then dparola=1

nTemp = InStr(dparola,sText, " ",1)
base=nTemp

finale= InStr(dparola,sText, " ",1)

While nTemp <> 0 And nVolte < nParole 
	       nVolte = nVolte + 1
	       nTemp = InStr(nTemp + 1, sText, " ")
  		Wend
	if nVolte > 0 Then

	   If nTemp > 0 Then
           AntRicerca = Mid(sText,base,ntemp-base) & " ..."
	 Else
         AntRicerca = Mid(sText,base) & " ..."
     End If
     
  Else
   If Len(sText) > 0 Then
         AntRicerca = sText & " ..."
     Else
         AntRicerca = " ..." 
     End If
  End If
End Function







function RemoveTags(txt)
  'memorizza il testo in un buffer temporaneo
  dim tmptxt
  tmptxt = txt

  'esci se viene passata una stringa nulla (che è diverso da stringa di lunghezza 0)
  if IsNull(tmptxt) then
    exit function
  end if

  dim i, pos1, pos2
  'inzia il ciclo di ricerca...
  do
    'cerca il prossimo inizio di tag
    pos1 = Instr(tmptxt, "<")
    'se non lo trovi esci dal ciclo di ricerca (non ci sono più tag da eliminare)
    if pos1=0 then
      exit do
    else
      'se lo trovi, cerca il simbolo di chiusura del tag
      pos2 = Instr(pos1, tmptxt, ">")
      'se non lo trovi esci dal ciclo di ricerca
      if pos2=0 then
        exit do
      else
        'elimina il tag determinato da pos1 e pos2
        tmptxt = Left(tmptxt, pos1-1)&Mid(tmptxt, pos2+1)
      end if
    end if
  loop
  'restituisci il testo "depurato" dai tag HTML
  RemoveTags = tmptxt
end function





function removeBR(messaggio)
messaggios=messaggio

messaggios=replace(messaggios,"<BR><BR><BR><BR>","<BR>")
messaggios=replace(messaggios,"<br><br><br><br>","<BR>")
messaggios=replace(messaggios,"<BR><BR><BR>","<BR>")
messaggios=replace(messaggios,"<br><br><br>","<BR>")
messaggios=replace(messaggios,"<BR><BR><BR>","<BR>")
messaggios=replace(messaggios,"<BR><BR><BR>","<BR>")
messaggios=replace(messaggios,"<BR><BR><BR>","<BR>")
removebr=messaggios
end function



url=Request.ServerVariables("URL")
url=lcase(url)
url=replace(url,"/","")


if left(url,8)="turnover" then
idutente=request.cookies("Idutente")
if idutente="" then 
vedi_tutto="no"
end if
end if



id=request("Id")
idtiponews=request("Idtiponews")

if id<>"" or idtiponews<>""   then


if id<>"" then
set rstipo=cn.execute("select * from [93.186.241.74].[toplegalinternational].dbo.newsattive where id="&SQLint(id)&" ")
end if

if idtiponews<>"" then
set rstipo=cn.execute("select * from [93.186.241.74].[toplegalinternational].dbo.tiponews_query where idtiponews="&SQLint(idtiponews)&" ")
end if





if not rstipo.eof then
'response.write idtiponews

tiponews=rstipo("tiponews")
idformato=cint(rstipo("Idformato"))
ordinamento=rstipo("ordquery")

idgruppo=rstipo("idgruppo")
idmenu=rstipo("idmenu")
menu=rstipo("menu")
img_icona=rstipo("img_icona")
img_interna=rstipo("img_interna")
testohome=rstipo("testohome")
rstipo.close
set rstipo=nothing
rstipo=""



if left(url,15)="approfondimento" then
if idgruppo<>0 then
idutente=request.cookies("Idutente")
if idutente="" then 
prov="approfondimento.asp?id="&id&""
vedi_tutto="no"
else


set rsxx=cn.execute("select * from [93.186.241.74].[toplegalinternational].dbo.mailing where idmailing="&int(idutente)&" ")
idgruppoa=rsxx("idgruppo")
idgruppoa=cint(Idgruppoa)
if idgruppo<>idgruppoA then
response.cookies("idgruppoA")=""
response.cookies("Idutente")=""

prov="approfondimento.asp?id="&id&""

vedi_tutto="no"
end if
end if
end if
end if
end if
end if



	//Se numero è >= 0 restituisce numero, altrimenti restituisce 0
	function SQLint( numero )
		If Not IsNumeric(numero) Then
			numero = 0
		End if
		SQLint = numero
	End function


	//Sostituisce il carattere ' ''
	function SQLstr( testo )
		if testo <> "" then 
			SQLstr = Replace( testo, "'", "''")
		End if
	End function


Function IsMail(sEmail)
Dim objRegExp
Set objRegExp = New RegExp 
objRegExp.Pattern = "^[a-z._-]+\@[a-z._-]+\.[a-z]{2,4}$" 
objRegExp.IgnoreCase = True 
IsMail = objRegExp.Test(sEmail)
End Function 

%>



