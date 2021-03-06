{% extends 'layouts/base.volt' %}
{% block title %}Recommandations
{% endblock %}
{% block pageTitle %}
Recommandations
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
	recommandation</li>
</ol>
{% endblock %}

{% block content %}
<div class="info-box">
	<div class="col-md-6">
		{{flash.output()}}
	</div>
	<h4 class="text-black">Liste({{recommandations |length}})
		{% if in_array(session.role, ['ETUDIANT','PROFESSEUR']) %}
		<a href="{{url('recommandation/new')}}" class="btn btn-primary btn-sm">
			<i class="fa fa-plus-circle"></i>
		Nouveau</a>
		{% endif %}
	</h4>
	<hr/>
	<div class="table-responsive">
		<table id="dataList" class="table table-bordered table-hover" data-name="cool-table">
			<thead>
				<tr>
					<th>ID #</th>
					<th>Nom du livre</th>
					<th>Nom de l'auteur</th>
					<th>Description</th>
					<th>Recommandé par</th>
					<th>Rôle</th>
					<th>Date de création</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				{% for k,recommandation in recommandations %}
				<tr>
					<td>{{k+1}}</td>
					<td>{{recommandation.nom_livre | upper}}</td>
					<td><span class="label label-primary">{{recommandation.nom_auteur }}</span></td>
					<td>{{substr(recommandation.description, 0,100) }}
						<?php
							$taille = $recommandation->description;
						?>

						<?php if (strlen($taille) > 100) : ?>
						<a href="{{url('recommandation/details/'~recommandation.id)}}">...voir plus
						</a>
						<?php endif ?>
					</td>
					<td>

						<span class="label label-primary">{{recommandation.getUsers().prenom~" "~recommandation.getUsers().nom }}</span>

					</td>
					<td>
						<span class="label label-primary">{{recommandation.getUsers().role}}</span>

					</td>

					<td>{{date('d/m/Y \à H:i',strtotime(recommandation.create_date))}}</td>
					<td>
						<a href="{{url('recommandation/details/'~recommandation.id)}}"><i class="fa fa-eye"></i></a>
						<a href="{{url('recommandation/edit/'~recommandation.id)}}">
							<i class="fa fa-edit"></i>
						</a>
						<a href="#" class="supelm" data-id={{recommandation.id}}>
							<i class="fa fa-trash"></i>
						</a>
					</td>
				</tr>
				{% endfor %}
			</tbody>

		</table>
	</div>
{% endblock %}
{% block addjs %}
<!-- DataTable -->
{{ javascript_include("template/vendor/sweetalert/dist/sweetalert.min.js") }}
<script src="{{url('template/plugins/datatables/jquery.dataTables.min.js')}}"></script>
<script src="{{url('template/plugins/datatables/dataTables.bootstrap.min.js')}}"></script>
<script>
$('body').on('click', '.supelm', function (e) {

	e.preventDefault();
	var id = $(this).data('id');
	var currentTr = $(this).closest("tr");
	swal({
		title: 'Êtes-vous sûr ?',
		text: 'Supprimer cette Recommandation !',
		type: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#DD6B55',
		confirmButtonText: 'Oui, valider !',
		cancelButtonText: 'Annuler',
		closeOnConfirm: false
	}, function () {
		$.ajax({
			url: "{{ url('recommandation/delete') }}/" + id,
			cache: false,
			async: true
		}).done(function (result) {

			if (result = "1") {
				$(currentTr).css('background-color', '#ff9933').fadeOut(1000, function () {
					$(this).remove();
				});
				swal('Supprimé!', 'L\'element  a été supprimé avec succès.', 'success');
				location.reload();
			} else {
				swal('Impossible de supprimer. Objet lié !', 'Erreur de suppression', 'error');
			}
		});
	});

});
</script>
{% endblock %}
