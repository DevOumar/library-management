<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title></title>
	<link rel="stylesheet" href="{{url('template/bootstrap/css/bootstrap.min.css')}}">

	<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet">

	<!-- Theme style -->
	<link rel="stylesheet" href="{{url('template/css/style.css')}}">
	<style>
	* {
		background-color: rgba(169, 169, 169, 0.1);
	}

	</style>
</head>
<body>
	<p><span style="color:#0000FF;font-size:16px;">Un nouveau message via formulaire de contact !</span></p>
	<hr>
	<div class="info-box">
		<p><strong>Nom complet :</strong> {{ nom_complet }} </p>
		<p><strong>Adresse e-mail : </strong> {{ email }} </p>
		<p><strong>Numéro de téléphone : </strong> {{ telephone }} </p>
		<p><strong>Message : </strong> {{ message }} </p>
		<br>
		<hr>

		À très bientôt,<br />
		<p>
			<span style="color:#000000;font-size:18px;"> BIBLIO</span><br />
			<b style="color:#000000;">Bibliothèque</b><br />
			Hamdallaye ACI-2000<br />
			Ventes aux professionnels <br />
			Hippodrome - Bacodjiocroni - Bibliothèque <br />
			<a href="mailto:cisseoumar621@gmail.com">cisseoumar621@gmail.com </a> <br />
			Hamdallaye en partance vers Sébenicoro <br />
			<img src="{{url('https://crmeni.ldcenter.net/img/logo_eni.jpg')}}" width=300/>
		</p>
		<hr>
		<footer class="main-footer">
			<div class="pull-right hidden-xs">Version 1.0</div>
		Copyright © {{date('Y')}} BIBLIO. All rights reserved.</footer>
	</div>
</body>
</html>
