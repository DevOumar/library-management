{% extends 'layouts/base.volt' %}
{% block title %}Livres Numériques
{% endblock %}
{% block pageTitle %}Livres Numériques
{% endblock %}
{% block addcss %}
{{ stylesheet_link("template/vendor/sweetalert/dist/sweetalert.css") }}
{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
	<li>
		<a href="{{url('dashboard')}}">Accueil</a>
	</li>
	<li>
		<i class="fa fa-angle-right"></i>
	numérique</li>
</ol>
{% endblock %}
{% block content %}
<div class="info-box">
	<div class="col-md-6">
		{{flash.output()}}
	</div>
	<h4 class="text-black">Liste({{numeriques |length}})
		{% if in_array(session.role, ['ADMINISTRATEUR']) %}
		<a href="{{url('livres-numeriques/new')}}" class="btn btn-primary btn-sm">
			<i class="fa fa-plus-circle"></i>
		Nouveau</a>
		{% endif %}
	</h4>
	<hr/>
	<div class="pull-right">
		{{paginate.getCurrent()}}/{{paginate.getLast()}}
		- Total:
		{{paginate.total_items}}
		<div class="btn-group">
			<a href="{{url('numerique?page='~paginate.previous)}}" class="btn btn-default btn-sm">
				<i class="fa fa-chevron-left"></i>
			</a>
			<a href="{{url('numerique?page='~paginate.next)}}" class="btn btn-default btn-sm">
				<i class="fa fa-chevron-right"></i>
			</a>
		</div>
		<!-- /.btn-group -->
	</div>
	<h4 class="text-black m-t-3">| Des livres numériques disponibles |</h4>
	<p>Beaucoup de livres numériques téléchargeables en toute simplicité et facilité sont disponibles sur notre application, qui vous permettront d'être encore plus performants dans vos différentes recherches. N'hésitez pas à les télécharger pour vos besoins !</p>
	<div class="content">
		<div class="row">
			{% for k,numerique in numeriques %}
			<div class="col-lg-6">
				<div class="info-box">
					<div class="row">
						<div class="col-lg-3">
							<div class="user-img pull-left">
								<img src="{{url('files/imagelivre_upload/'~numerique.photo)}}" class="img-circle img-responsive" alt="User Image">
							</div>
						</div>
						<div class="col-lg-9">
							<div class="mail-contnet">
								<h4 class="text-black m-b-0">{{numerique.nom_livre }}</h4>
								<small>
									<abbr title="Nom de l'auteur">Auteur:
									</abbr>
								{{numerique.nom_auteur}}</small>
								<p class="m-t-1">{{substr(numerique.description,0,100)}}
									<?php
										$taille = $numerique->description;
									?>

									<?php if (strlen($taille) > 100) : ?>
									<a href="{{url('livres-numeriques/details/'~numerique.id)}}">...voir plus
									</a>
									<?php endif ?></p>
									<abbr title="Date de création">Date:</abbr>
								{{date("d-m-Y", strtotime(numerique.create_date))}}</div>
								<div class="btn btn-default">
									<a title="Télécharger le document" href="{{url('files/livre_upload/'~numerique.file_livre)}}" target="_blank">
										<i class="fa fa-download"></i>
									</a>
								</div>
								{% if in_array(session.role, ['ADMINISTRATEUR']) %}
								<div class="btn btn-default">
									<a title="Modifier le document" href="{{url('livres-numeriques/edit/'~numerique.id)}}">
										<i class="fa fa-edit"></i>
									</a>
								</div>
								<div class="btn btn-default">
									<a title="Supprimer le document" href="#" class="supelm" data-id={{numerique.id}}>
										<i class="fa fa-trash"></i>
									</a>
								</div>
								{% endif %}
							</div>
						</div>
					</div>
				</div>
				{% endfor %}
				<!-- Main row -->
			</div>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
	</div>
	{% endblock %}
	{% block addjs %}
	<!-- ./wrapper -->
	<!--Plugin Initialization-->
	<script type="{{url('template/javascript')}}"> $(document).ready(function () {
		$("#respMenu").aceResponsiveMenu({
			                 resizeWidth: '768', // Set the same in Media query       
			                 animationSpeed: 'fast', //slow, medium, fast
			                 accoridonExpAll: false //Expands all the accordion menu on click
			             });
	});
	</script>
	<!-- DataTable -->
	{{ javascript_include("template/vendor/sweetalert/dist/sweetalert.min.js") }}
	
	<script>
	$('body').on('click', '.supelm', function (e) {

		e.preventDefault();
		var id = $(this).data('id');
		var currentTr = $(this).closest("tr");
		swal({
			title: 'Êtes-vous sûr ?',
			text: 'Supprimer ce livre numérique !',
			type: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#DD6B55',
			confirmButtonText: 'Oui, valider !',
			cancelButtonText: 'Annuler',
			closeOnConfirm: false
		}, function () {
			$.ajax({
				url: "{{ url('numerique/delete') }}/" + id,
				cache: false,
				async: true
			}).done(function (result) {

				if (result = "1") {
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

	});
	</script>
	{% endblock %}
