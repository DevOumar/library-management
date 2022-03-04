{% extends 'layouts/base.volt' %}
{% block title %}Emprunt
{% endblock %}
{% block pageTitle %}
Emprunt
{% endblock %}
{% block addcss %}
<!-- DataTables -->
<link rel="stylesheet" href="{{url('template/plugins/datatables/css/dataTables.bootstrap.min.css')}}">
{{ stylesheet_link("template/vendor/sweetalert/dist/sweetalert.css") }}
{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
	<li>
		<a href="{{url('dashboard')}}">Accueil</a>
	</li>
	<li>
		<i class="fa fa-angle-right"></i>
		emprunt
	</li>
</ol>
{% endblock %}

{% block content %}
<div class="info-box">
	<div class="col-md-6">
		{{flash.output()}}
	</div>
	<h4 class="text-black">Liste({{emprunts |length}})
		{% if session.role == "ADMINISTRATEUR" %}
		<a href="{{url('emprunt/new')}}" class="btn btn-primary btn-sm">
			<i class="fa fa-plus-circle"></i>
		Affecter un livre</a>
		<a href="{{url('emprunt/notifier')}}" class="btn btn-success btn-sm pull-right"
		title="Notifier les utilisateurs dont le délai d'emprunt est expiré.">
		<i class="fa fa-bell-o"></i>
	Notifier</a>
	{% endif %}
</h4>
<hr />
<div class="table-responsive">
	<table id="dataList" class="table table-bordered table-hover" data-name="cool-table">
		<thead>
			<tr>
				<th>ID #</th>
				<th>Nom complet</th>
				<th>Matricule</th>
				<th>Nom du livre</th>
				<th>Rôle</th>
				<th>Date d'emprunt</th>
				<th>Date de retour</th>
				<th>Délai de retour</th>
				<th>Status</th>
				<th>Amende (en F CFA )</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>
			{% for k,emprunt in emprunts %}
			<tr>
				<td>{{k+1}}</td>
				<td>{{emprunt.getUsers().prenom}}
				{{emprunt.getUsers().nom}}</td>
				<td>
					<span class="label label-primary">{{emprunt.getUsers().matricule}}</span>
				</td>
				<td>{{emprunt.getLivre().nom_livre}}</td>
				<td>
					<span class="label label-primary">{{emprunt.getUsers().role}}</span>
				</td>
				<td>
					<span class="label label-warning">{{date('d-m-Y',strtotime(emprunt.date_emprunt))}}</span>
				</td>
				<td>
					{% if emprunt.retour_emprunt == "" or emprunt.retour_emprunt == NULL %}
					<span class="label label-danger">
						Non retourné
					</span>
					{% else %}
					<span class="label label-success">
						{{date('d/m/Y',strtotime(emprunt.retour_emprunt))}}
					</span>
				</td>
				{% endif %}
				<td>
					{% if emprunt.retour_emprunt == "" or emprunt.retour_emprunt == NULL %}
					<span class="label label-danger">{{date('d-m-Y',strtotime(emprunt.delai_livre))}}</span>
					<?php
						$date1 = new DateTime("now");
						$date2 = new DateTime($emprunt->delai_livre . ' 23:59:59.999999');
					?>
					<?php if ($date1 > $date2) : ?>
					<br><span class="label label-danger">
					Délai expiré</span>
					<?php endif ?>
				</td>
				{% else %}
				<span class="label label-success">Retourné</span>
				{% endif %}
				<td>
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
						</td>
						<td>
							<span class="label label-{% if emprunt.amende == 0 %}danger{% else %}success{% endif %}">{{number_format( emprunt.amende,0, '', ' ')}}</span>
						</td>
						
						<td>
							{% if emprunt.retour_status == 1 %}
							<a href="{{url('emprunt/pdf/'~emprunt.id)}}" title="Imprimer" target="_blank">
								<i class="fa fa-print"></i>
							</a>
							{% endif %}
							{% if session.role == "ADMINISTRATEUR" %}
							<a href="{{url('emprunt/edit/'~emprunt.id)}}" title="Modifier">
								<i class="fa fa-edit"></i>
							</a>
							
							<a href="#" title="Supprimer" class="supelm" data-id={{emprunt.id}}>
								<i class="fa fa-trash"></i>
							</a>
							{% endif %}
							<a href="{{url('emprunt/details/'~emprunt.id)}}" title="Details de l'emprunt">
								<i class="fa fa-eye"></i>
							</a>
						</td>
						
					</tr>
					{% endfor %}
				</tbody>
			</table>
		</div>
	</div>
	{% endblock %}
	{% block addjs %}
	<!-- DataTable -->
	{{ javascript_include("template/vendor/sweetalert/dist/sweetalert.min.js") }}
	<script src="{{url('template/plugins/datatables/jquery.dataTables.min.js')}}"></script>
	<script src="{{url('template/plugins/datatables/dataTables.bootstrap.min.js')}}"></script>
	<script>$('body').on('click', '.supelm', function (e) {
		e.preventDefault();
		var id = $(this).data('id');
		var currentTr = $(this).closest("tr");
		swal({
			title: 'Êtes-vous sûr ?',
			text: 'Supprimer cet emprunt !',
			type: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#DD6B55',
			confirmButtonText: 'Oui, valider !',
			cancelButtonText: 'Annuler',
			closeOnConfirm: false
		}, function () {
			$.ajax({
				url: "{{ url('emprunt/delete') }}/" + id,
				cache: false,
				async: true
			}).done(function (result) {
				if (result == "1") {
					$(currentTr).css('background-color', '#ff9933').fadeOut(1000, function () {
						$(this).remove();
					});
					swal('Supprimé!', 'L\'element  a été supprimée avec succès.', 'success');
					location.reload();
				} else {
					swal('Impossible de supprimer. Objet lié !', 'Erreur de suppression', 'error');
				}
			});
		});
	});</script>
	{% endblock %}