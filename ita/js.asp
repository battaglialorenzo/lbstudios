  <script language="JavaScript">
<!--
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
// -->

function MM_findObj(n, d) { //v3.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document); return x;
}

function MM_showHideLayers() { //v3.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v='hide')?'hidden':v; }
    obj.visibility=v; }
}
//-->
  </script>
  
  <script language="javascript" type="text/javascript">
   <!--
    // Creo lo script per l'apertura del popup
    function ApriImmagini(file)
    {
      var prop = "top=100, left=100,width=300,height=300"
      window.open(file, null, prop);
    }
   //-->
  </script>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
  </script>
<SCRIPT language=JavaScript 
src="data<%=lingua%>.js" 
type=text/javascript></SCRIPT>



<script LANGUAGE="JavaScript">
function afficheVignette(cheminVignette,cheminMaxi)
	{
	document.write('<A HREF="javascript:afficheMaxi(\''+cheminMaxi+'\')"><IMG SRC="'+cheminVignette+'"  BORDER=0  class=fotosmall align=left></A>');
	}
	function afficheMaxi(chemin)
	{
	i1 = new Image;
	i1.src = chemin;
	html = '<HTML>\n<HEAD>\n</HEAD>\n<BODY LEFTMARGIN=0 MARGINWIDTH=0 TOPMARGIN=0 MARGINHEIGHT=0>\n<CENTER><IMG SRC="'+chemin+'" class=fotosmall BORDER=0 NAME=imageTest onLoad="window.resizeTo(document.imageTest.width+14,document.imageTest.height+32)"></CENTER>\n</BODY>\n</HTML>';
	popupImage = window.open('','_blank','width=200,height=200,toolbar=0,location=0,directories=0,menuBar=0,scrollbars=0,resizable=0');
	popupImage.document.open();
	popupImage.document.write(html);
	popupImage.document.close()
	};
 </script>
 