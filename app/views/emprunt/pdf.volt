<!DOCTYPE html>
<head>
	<meta charset="UTF-8"/>
	<title>Facture
		{{emprunt.getUsers().prenom}}
		{{emprunt.getUsers().nom}}
	- N°{{emprunt.id}}</title>
	<link
	rel="stylesheet" href="{{url('template/bootstrap/css/bootstrap.min.css')}}">

	<!-- Google Font -->
	<link
	href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet">

	<!-- Theme style -->
	<link rel="stylesheet" href="{{url('template/css/style.css')}}">
	<link rel="stylesheet" href="{{url('template/css/font-awesome/css/font-awesome.min.css')}}">
	<link rel="stylesheet" href="{{url('template/build/css/intlTelInput.css')}}">
	<link rel="stylesheet" href="{{url('template/css/et-line-font/et-line-font.css')}}">
	<link rel="stylesheet" href="{{url('template/css/themify-icons/themify-icons.css')}}">
	<style>
	table {
		font-family: arial, sans-serif;
		border-collapse: collapse;
		width: 100%;
	}

	td,
	th {
		border: 1px solid #dddddd;
		text-align: left;
		padding: 8px;
	}

	tr:nth-child(even) {
		background-color: #dddddd;
	}
	</style>

</head>
<body>
	<header>
		<h2 align="center" ;>FACTURE DE RETOUR N°{{emprunt.id}}</h2>
		<h5>Matricule :
		{{emprunt.getUsers().matricule}}</h5>
		<h5>Nom & Prénom :
			{{emprunt.getUsers().nom|upper}}
		{{emprunt.getUsers().prenom|upper}}</h5>
		<h5>
			ISBN du livre :
		{{emprunt.getLivre().isbn}}</h5>
		<h5 align="left">Livre retourné :
		{{emprunt.getLivre().nom_livre|upper}}</h5>

		{% if emprunt.amende is defined %}
		<h5 align="right">Status:
			{% endif %}
			<?php
				$date1 = new DateTime($emprunt->retour_emprunt);
				$date2 = new DateTime($emprunt->delai_livre . ' 23:59:59.999999');
			?>
			<?php 
				if (($date1 <= $date2) && $emprunt->amende != NULL) : ?>
					<span class="fa fa-circle" style="color:#00ff51;"></span>
					Retourner à temps
					
					<?php endif ?>
					<?php if (($date1 > $date2) && $emprunt->amende != NULL ) : ?>
					<span class="fa fa-circle" style="color:#ff0000;"></span>
					Retourner en retard

					<?php endif ?>
					<hr>
				</header>
				<h5 align="center" ;>Description du livre retourné:</h5>
				<br>
				<table>
					<tr>
						<th>Nom du livre</th>
						<th>Date d'emprunt</th>
						<th>Délai de retour</th>
						<th>Date de retour</th>
						<th>Amende en F CFA</th>
					</tr>
					<tr>
						<td>{{emprunt.getLivre().nom_livre}}</td>
						<td>{{date('d-m-Y',strtotime(emprunt.date_emprunt))}}</td>
						<td>{{date('d-m-Y',strtotime(emprunt.delai_livre))}}</td>
						<td>{{date('d-m-Y',strtotime(emprunt.retour_emprunt))}}</td>
						<td>{{number_format(emprunt.amende, 0, '',' ')}}</td>
					</tr>
				</table>
				<br>
				<hr>
				<h5>Nombre de page :
				{{emprunt.getLivre().nbre_page}}</h5>
				<h5>Casier :
				{{emprunt.getLivre().id_casier}}</h5>
				<h5>Rangée :
				{{emprunt.getLivre().id_ranger}}</h5>
				<hr>
				{% if emprunt.amende > 0 %}
				<h6>Nous avons constaté qu'à la suite de votre emprunt, le livre n'est pas en bon état tel emprunté au départ. Vous devez payer la somme de :
					<b>
						{{core.convertChiffreEnLettre(emprunt.amende)|upper}}
						F CFA.
					</b>
				</h6>
				<hr>
				{% endif %}
				<br>
				<h6>Date: Bamako, le {{date('d-m-Y \à H:i', strtotime(emprunt.retour_emprunt))}}</h6>
				<br>
				À bientôt,<br/>
				<br>
				L'équipe Bibliothèque-BIBLIO
				<br>
				<br>
				-------------------------------------------<br><br></body>
			</body></html>