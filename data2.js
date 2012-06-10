

// global variables
var myDoc=document

// purpose: To navigate to the URL contained in the value of the option
// usage: doesUrl(this) 
function doesUrl(obj) {
		if (obj.selectedIndex != 0) 
		location.href=obj.options[obj.selectedIndex].value;
}


// write the date in Italian
function doesDate() {
	var now = new Date();
	var year= now.getYear();if (year < 1000) year += 1900;
	nameDay = new Array('Domenica','Lunedi','Martedi','Mercoledi','Giovedi','Venerdi','Sabato');
	nameMth = new Array('gennaio','febbraio','marzo','aprile','maggio', 'giugno', 'luglio', 'agosto', 'settembre', 'ottobre', 'novembre','dicembre');
	myDoc.write('<span class="titolinofux">'+nameDay[now.getDay()]+ ' ' + now.getDate() + " " + nameMth[now.getMonth()] + " " + year+'</span>');
}	


