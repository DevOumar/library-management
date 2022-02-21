{% extends 'layouts/base.volt' %}
{% block title %}Mise à jour de
{{emprunt.getUsers().prenom}} 
{{emprunt.getUsers().nom}}
{% endblock %}
{% block pageTitle %}
{{emprunt.getUsers().prenom}} 
{{emprunt.getUsers().nom}}
{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
	<li>
		<a href="{{url('emprunt')}}">Emprunt</a>
	</li>
	<li>
		<i class="fa fa-angle-right"></i>
	Mise à jour</li>
</ol>
{% endblock %}

{% block content %}
<div class="row m-t-3">
	<div class="col-lg-12">
		<div class="card">
			<div class="card-header bg-blue">
				<h5 class="text-white m-b-0">Modifier l'emprunt</h5>
			</div>
			<div class="card-body">
				<form method="POST" action="{{url('emprunt/edit/'~emprunt.id)}}" enctype="multipart/form-data">
					<div class="form-group">
						<label>Matricule:</label>
						{{emprunt.getUsers().matricule}}
					</div>
					<div class="form-group">
						<label>Nom complet:</label>
						{{emprunt.getUsers().prenom}} {{emprunt.getUsers().nom}}
					</div>
					<div class="form-group">
						<label>Rôle:</label>
						{{emprunt.getUsers().role}}
					</div>
					<div class="form-group">
						<label>Dernière connexion:</label>
						{% if emprunt.getUsers().datelastlogin != null %}
						{{date("d-m-Y \à H:i:s", strtotime(emprunt.getUsers().datelastlogin))}}
						{% endif %}
					</div>
					<div class="form-group">
						<label>Nom du livre:</label>
						{{emprunt.getLivre().nom_livre}}
					</div>
					<div class="form-group">
						<label>ISBN:</label>
						<span class="label label-primary">{{emprunt.getLivre().isbn}}</span>
					</div>
					<div class="form-group">
						<label>Rangée:</label>
						<span class="label label-primary">{{emprunt.getLivre().id_ranger}}</span>
					</div>
					<div class="form-group">
						<label>Casier:</label>
						<span class="label label-primary">{{emprunt.getLivre().id_casier}}</span>
					</div>
					<div class="form-group">
						<label>Nombre de pages:</label>
						<span class="label label-primary">{{emprunt.getLivre().nbre_page}}</span>
					</div>
					<div class="form-group">
						<label>Date d'emprunt:</label>
						<span class="label label-danger">
							{{date('d-m-Y',strtotime(emprunt.date_emprunt))}}
						</span>
					</div>
					<div class="form-group">
						<label>Délai de retour:</label>
						<span class="label label-danger">{{date('d-m-Y',strtotime(emprunt.delai_livre))}}</span>
						<?php $date1 = new DateTime('now');
							$date2 = new DateTime($emprunt->delai_livre.' 23:59:59.999999');
						?>
						<?php if (($date1 > $date2) && $emprunt->retour_status == 0) : ?>
						<span class="label label-danger">
						Délai expiré</span>
						<?php endif ?>
					</div>
					<div class="form-group">
						<label>Date de retour:</label>
						{% if emprunt.retour_emprunt == "" or emprunt.retour_emprunt == NULL  %}
						<span class="label label-danger">
							Non retourné
						</span>
						{% else %}
						<span class="label label-success">
						{{date('d-m-Y',strtotime(emprunt.retour_emprunt))}}</td>
					</span>
					{% endif %}
				</div>
				<div class="form-group">
					{% if emprunt.amende == "" %}
					<label class="control-label">Amende ( Prix en F CFA ):</label>
					{{form.render("amende")}}
				</div>
				{% else %}
				<div class="form-group">
					<label>Amende:</label>
					<span class="label label-success">{{emprunt.amende}}
					F CFA</span>
				</div>
				{% endif %}
				<div class="form-group">
					{% if emprunt.amende is defined %}
					<label>Status:</label>
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
						</div>
					</div>
				</div>


				<div class="card-footer text-left">
					<a href="{{url('emprunt')}}" class="btn btn-default">Annuler</a>
					{% if emprunt.retour_status == 0 %}
					<button type="submit" class="btn btn-success">Retourner le livre</button>
					{% endif %}
					{% if emprunt.retour_status == 1 %}
					<a href="{{url('emprunt/pdf/'~emprunt.id)}}" class="btn btn-success" target="_blank">
						<i class="fa fa-print"></i>
					Imprimer</a>
					{% endif %}
				</div>
			</form>
		</div>
	</div></div>
	{% endblock %}
