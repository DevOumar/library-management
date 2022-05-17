// On crée une date
var date1 = new Date();
var dateLocale = date1.toLocaleString('fr-FR', {
weekday: 'long',
year: 'numeric',
month: 'long',
day: 'numeric'
});

function Timer() {
var dt = new Date();
var formatedTime = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();

document.getElementById("p1").innerHTML = 'Date : ' + dateLocale + ", " + formatedTime;
setTimeout("Timer()", 900);
}
Timer();