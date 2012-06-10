// Compone URL

function urlcomposer(base) {
	loc = window.location.toString();
    subs = loc.substr(loc.indexOf(base) + base.length).split("/");
	 
	//a = (loc.indexOf() == -1) ? 1 : 2;
    for (i = 0; i < (subs.length); i++) {
        //subs[i] = makeCaps(unescape(subs[i]));
	
		host = subs[0];
		
	if (subs[1] == "tomcat" || subs[1] == "fedeejay_tomcat") {
		var context =  subs[1] + '/';
		}	
	else {
		var context =  "";
		}
		
		//Sezione Blog statica
		if (subs[1] == "blog") { 
		sezione = 'blog';
		} else if (subs[2] == "forum") { 
		sezione = 'forum';
		} else {
		sezione = '';
		}
		
		//alert(subs[i]);
		
	}
	
	//alert(host);
	if (host == 'voice.deejay.it') { sezione = 'voice'; host = 'www.deejay.it' }
	
	var url = 'http://' + host + '/' + context;
	
	//alert(url);
	 return url;
	
}

function makeCaps(a) {
    g = a.split(" ");
    for (l = 0; l < g.length; l++) {
        g[l] = g[l].toUpperCase().slice(0, 1) + g[l].slice(1);
    }
    return g.join(" ");
}
 
function getLoc(c) {
    var d = "";
    if (c > 0) {
        for (k = 0; k < c; k++) {
            d = d + "../";
        }
    }
    return d;
}


//Funzione per gestire i conteggi dello SpotCover per quanto riguarda click e replay
function spotcoverPixel(tipo) {
//alert(tipo);
var OASd;
var ifr;
var pos;

if (tipo=="click")
	pos='x10';
else if (tipo=="replay")
	pos='x20';
else
	return;

OASd = '<';
OASd += 'IMG SRC='+OAS_url+'adstream_nx.ads/'+OAS_sitepage+'@'+pos+'>';

ifr=document.getElementById("divPixel");
if(ifr!=null){
     ifr.innerHTML= OASd;
} 
else
   return;
} 


//Menu a tendina

function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}


// Funzione per il link delle select
function yup_jumpMenu(targ,selObj,restore,urlA,urlB){ //v3.0
//url = 'http://' + urlA;
eval(targ+".location='"+urlA+selObj.options[selObj.selectedIndex].value+urlB+"'");

if (restore) selObj.selectedIndex=0;
}



//Prova Overlay
swapped = false;

function swapEm()
{
	var swf = document.getElementById("swf");
	var container = document.getElementById("container");
	if(swapped){
		swf.style.zIndex = "2";
		container.style.zIndex = "1";
		swapped = false;
	} else {
		swf.style.zIndex = "1";
		container.style.zIndex = "2";
		swapped = true;
	}
}

//OpenWin per OnAir
function openwin(url,target) {

		if (target == 'onair') {

			if (window.onair && window.onair.open && !window.onair.closed) {
			
			window.onair.focus();
			
			} else {
			
			onair = window.open(url, target);

			}

		} else {
		
			window.open(url, target);
		
		}

}

//Content da OnAir a finestra principale
function actionclick(url) {
		if (window.opener && !window.opener.closed) {			
		window.opener.location.href=url;
		setTimeout('window.opener.focus();',1000);
		}
		else {
 		window.open(url);
		}
}


//Flash detect
function flashdetect(version) {
 
var playerversion = version;
 
	 if (navigator.appVersion.indexOf("MSIE 4.5") != -1) {
	 
	 	return true;
	 
	 } else {
  
		 var agent = navigator.userAgent.toLowerCase();
		 gotflash = 0;
		 if (navigator.mimeTypes
		   && navigator.mimeTypes["application/x-shockwave-flash"]
		   && navigator.mimeTypes["application/x-shockwave-flash"].enabledPlugin
		   && navigator.plugins
		   && navigator.plugins["Shockwave Flash"]){
			// NS3+ and Opera3+ (support plugin array):  check for Flash plugin in plugin array
			if (navigator.plugins != null && navigator.plugins.length > 0) {
				var flashPlugin = navigator.plugins['Shockwave Flash'];
				if (typeof flashPlugin == 'object') {
				desc = flashPlugin.description;
				startpnt = desc.indexOf('Flash') +6;
		     endpnt = desc.indexOf('.');
				gotflash = parseInt((desc.substring(startpnt, endpnt)));
				}
			}
		}
		
		// Check the browser...we're looking for ie/win, but not aol
		var isIE  = (navigator.appVersion.indexOf("MSIE") != -1) ? true : false;    // true if we're on ie
		var isWin = (navigator.appVersion.toLowerCase().indexOf("win") != -1) ? true : false; // true if we're on windows


		// This is a js1.1 code block, so make note that js1.1 is supported.
		jsVersion = 1.1;

		// Write vbscript detection on ie win. IE on Windows doesn't support regular
		// JavaScript plugins array detection.
		if(isIE && isWin){
	
		var WM_startTagFix = '</';
		document.writeln('<script language="VBscript">');
		document.writeln('on error resume next');
		document.writeln('if IsObject(CreateObject("ShockwaveFlash.ShockwaveFlash.10")) then gotflash = 10');
		document.writeln('if gotflash < 10 and IsObject(CreateObject("ShockwaveFlash.ShockwaveFlash.9")) then gotflash = 9');
		document.writeln('if gotflash < 9 and IsObject(CreateObject("ShockwaveFlash.ShockwaveFlash.8")) then gotflash = 8');
		document.writeln('if gotflash < 8 and IsObject(CreateObject("ShockwaveFlash.ShockwaveFlash.7")) then gotflash = 7');
		document.writeln('if gotflash < 7 and IsObject(CreateObject("ShockwaveFlash.ShockwaveFlash.6")) then gotflash = 6');
		document.writeln('if gotflash < 6 and IsObject(CreateObject("ShockwaveFlash.ShockwaveFlash.5")) then gotflash = 5');
		document.writeln('if gotflash < 5 and IsObject(CreateObject("ShockwaveFlash.ShockwaveFlash.4")) then gotflash = 4');
		document.writeln('if gotflash < 4 and IsObject(CreateObject("ShockwaveFlash.ShockwaveFlash.3")) then gotflash = 3'); 
		document.writeln(WM_startTagFix+'script>');
		}		
			
		if (gotflash < playerversion){
			//Flash 4 or later
			return false;
		} else {
		    //Flash 5 or more
			return true;
		} 

	}

} 

// Genera il flash o l'alternativa statica
function generatorflash(nomefile,width,height,bgcolor,version,playerversion,no1,no2) {

var playerversion = 7;
var N1;
var NNONE;
	NNONE= no1;	
	
	//Controllo per settare cookie alla spotcover
	if (no2 == 'copertina') { 
	//var nomefile = nomefile + '&session=' + show(); 
	var nomefile = nomefile + '&session=false'; 
	}
	
	address = urlcomposer('http://');
	
	if (no2 == 'navigazione') {
	
	//Controllo per settare host di navigazione nel menu
	if (sezione == 'blog' || sezione == 'forum') {
	var nomefile = nomefile + '?url=' + address + '&s=community&l=' + sezione;
	} else if (sezione == 'voice') {
	var nomefile = nomefile + '?url=' + address + '&s=world&l=' + sezione;
	} else {		
	var nomefile = nomefile + '?url=' + address;
	} 
	
	}
	
	if (no2 == 'navigazioneonair'){
	var nomefile = nomefile + '&url=' + address;	
	}

	//alert(sezione);
	//window.status = sezione;
	
	N1=('<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=' + version + '" ID="ticker_news" WIDTH="' + width + '" HEIGHT="' + height + '">');
	N1= N1+ ('<PARAM NAME=movie VALUE="' + nomefile + '">');
	N1= N1+ ('<PARAM NAME=quality VALUE=high>');
	N1= N1+ ('<PARAM NAME=bgcolor VALUE=#' + bgcolor + '>');
	N1= N1+ ('<PARAM NAME=menu VALUE=False>');
	N1= N1+ ('<PARAM NAME=borders VALUE=noborder>');
	N1= N1+ ('<PARAM NAME=loop VALUE=true>');
	N1= N1+ ('<PARAM NAME=wmode VALUE=transparent>');
	N1= N1+ ('<embed src="' + nomefile + '" quality=high loop=true menu=false bgcolor=#' + bgcolor + '');
	N1= N1+ ('swLiveConnect="FALSE" WIDTH="' + width + '" HEIGHT="' + height + '" border="0" wmode="transparent" TYPE="application/x-shockwave-flash"');
	N1= N1+ ('PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer"></embed></OBJECT>')

if (flashdetect(playerversion)) document.write(N1);

else { document.write(NNONE); setTimeout("document.location.replace('/flash.asp/')",5000); }


}

// Carica i prodotti nel carrello
function AddToBasket(ItemID){ 
basket = window.open("http://OnTheFlight.CDFlash.com/index.cfm?AddItemID="+ItemID+"&FuseAction=Basket&Redirect=1&SID=5341&SName=RADIODJ", "newWindow", "resizable=no,top=20,left=20,width=750,height=480,menubar=no,status=no,toolbar=no,location=no,scrollbars=yes,toolbar=no");
}


//Finestre sendmail
function sendmail(to) {
var string="mailto:"+to+"@deejay.it";
document.location=string;
}

//Finestre sendmail
function sendmailStreaming(to) {
var string="mailto:"+to+"@kataweb.it";
document.location=string;
}


// funzioni settaggio cookies

  var bikky = document.cookie; 
  
  function getCookie(name) { 
    var index = bikky.indexOf(name + "=");
    if (index == -1) return null;
    index = bikky.indexOf("=", index) + 1;
    var endstr = bikky.indexOf(";", index);
    if (endstr == -1) endstr = bikky.length;
    return unescape(bikky.substring(index, endstr));
  }
  
function setCookie(name, value, duration) {   

  if (session_browser == false) {
  var duration = duration;
  var today = new Date();
  
  var expiry = new Date(today.getTime() + duration * ( 60 * 1000));
  
  if (value != null && value != "")
  document.cookie=name + "=" + escape(value) + "; expires=" + expiry.toGMTString();
  bikky = document.cookie;
  
  } else {
  
  if (value != null && value != "")
  document.cookie=name + "=" + escape(value);
  bikky = document.cookie;
  
  }  
  
}

var fShowCookieName = "spotcover";
var fIDuration=4000;
var session_browser=true;

function show(){
    if (!getCookie(fShowCookieName)) {
        setCookie (fShowCookieName, true, 30);
        return(false);
    } else {
        return(true);
    }
}


function openDownload(url){
   url = "http://www.deejay.it/php/download/download2.php?&prov=dload&file=" + url;
   var n=open(url,'1','toolbar=no,location=no,directories=no,status=no,menubar=no,titlebar=no,scrollbars=no,resizable=no,width=300,height=300,left=0,top=0');
}

function openDownloadPath(path, url){
   url = "http://www.deejay.it/php/download/download2.php?path=" + path + "&file=" + url;
   var n=open(url,'1','toolbar=no,location=no,directories=no,status=no,menubar=no,titlebar=no,scrollbars=no,resizable=no,width=300,height=300,left=0,top=0');
}

function openMedia(nomeFile, tipo, id, w, h){
   url = "http://www.deejay.it/php/player/player.php?audio=" + nomeFile + "&type=" + tipo + "&id=" + id;
   var n=open(url,'1','toolbar=no,location=no,directories=no,status=no,menubar=no,titlebar=no,scrollbars=no,resizable=no,width=' + w + ',height=' + h + ',left=0,top=0');
}

function openSuonerie(id, tipo, w, h){
   url = "http://www.deejay.it/php/suonerie/suonerie.php?id=" + id + "&type=" + tipo;
   var n=open(url,'1','toolbar=no,location=no,directories=no,status=no,menubar=no,titlebar=no,scrollbars=no,resizable=no,width=' + w + ',height=' + h + ',left=0,top=0');
}




//Finestre popup
function popup(url, windowname, atrib, radio, channel) {
	window.open(url, windowname, atrib);
}



function jump(){
   document.location.href = "/dj/home";
}


//Ricerca blog
function addPrefix(rrr) {

 var add;

//       add = "site:blog.deejay.it " + rrr.testo.value ;

/*       rrr.q.value = add;
alert(add);
     return rrr.q.value;*/

add =  "site:blog.deejay.it " + rrr.q.value;
rrr.q.value = add;
return rrr.q.value;
}

function popcallwindow(url){
   tastierinoWnd=window.open(url,'popcallwin','height=600,width=800,scrollbars=yes,menubar=no,location=no,status=yes,toolbar=no,top=0,left=0');
   if (window.focus) {tastierinoWnd.focus()}
   return;
}

 function go2Sso(){
   document.location.href="/static/sso/sso.html?ref=hplog";
 }

 function go2Ssout(){
   javascript:document.location.href="http://login.kataweb.it/login/SSO?op=logout&service=djfantacalcio&backurl=http://fantacalcio.deejay.it";
 }

 function jump2home(){
   document.location.href="/dj/home";
}
