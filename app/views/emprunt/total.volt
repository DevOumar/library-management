{% extends 'layouts/base.volt' %}
{% block title %}Emprunt
{% endblock %}
{% block pageTitle %}
emprunts
{% endblock %}
{% block addcss %}
<!-- DataTables -->
<link rel="stylesheet" href="{{url('template/plugins/datatables/css/dataTables.bootstrap.min.css')}}">
{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
	<li>
		<a href="{{url('dashboard')}}">Accueil</a>
	</li>
	<li>
		<i class="fa fa-angle-right"></i>
		emprunts
	</li>
</ol>
{% endblock %}

{% block content %}
<div class="info-box">
	<div class="col-md-6">
		{{flash.output()}}
	</div>
	<h4 class="text-black">Liste({{emprunt_jour |length}})
	</h4>
	<hr />
	<div class="table-responsive">
		<table id="dataList" class="table table-bordered table-hover" data-name="cool-table">
			<thead>
				<tr>
					<th>ID #</th>
					<th>Nom complet</th>
					<th>Nom du livre</th>
					<th>ISBN</th>
					<th>Rôle</th>
					<th>Rangées</th>
					<th>Casiers</th>
					<th>Nbre pages</th>
					<th>Date d'emprunt</th>
					<th>Date de retour</th>
					<th>Délai de retour</th>
					<th>Status</th>
					<th>Amende (en F CFA )</th>
				</tr>
			</thead>
			<tbody>
				{% for k,emprunt in emprunt_jour %}
				<tr>
					<td>{{k+1}}</td>
					<td>{{emprunt.prenom}}
					{{emprunt.nom}}</td>
					<td>{{emprunt.nom_livre}}</td>
					<td>
						<span class="label label-primary">{{emprunt.isbn}}</span>
					</td>
					<td>
						<span class="label label-primary">{{emprunt.role}}</span>
					</td>

					<td>
						<span class="label label-warning">{{emprunt.id_ranger}}</span>
					</td>
					<td>
						<span class="label label-warning">{{emprunt.id_casier}}</span>
					</td>
					<td>
						<span class="label label-warning">{{emprunt.nbre_page}}</span>
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
								<span class="label label-danger">{{emprunt.amende}}</span>
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
		<script src="{{url('template/plugins/datatables/jquery.dataTables.min.js')}}"></script>
		<script src="{{url('template/plugins/datatables/dataTables.bootstrap.min.js')}}"></script>
		{% endblock %}