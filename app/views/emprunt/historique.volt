{% extends 'layouts/base.volt' %}
{% block title %}Historique Emprunt
{% endblock %}
{% block pageTitle %}
Historique de mes emprunts
{% endblock %}
{% block addcss %}
<!-- DataTables -->
<link rel="stylesheet" href="{{url('template/plugins/datatables/css/dataTables.bootstrap.min.css')}}">
<!-- daterangepicker -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
{% endblock %}
{% block breadcrumb %}
<div class="pull-right mt-5 d-flex " style="position: absolute; right: 20px; font-size:13px;">
	<div id="reportrange" class="form-control text-truncate">
		<span>January 5, 2022 - February 3, 2022</span>
		<i class="fa fa-caret-down text-light-40 font-12 ml-10"></i>&nbsp;
	</div>
	<form id="date-filter" method="POST" hidden>
		<input type="date" value="{% if start_date is defined %}{{ start_date }}{% endif %}" name="start_date"
		id="start_date">
		<input type="date" value="{% if end_date is defined %}{{ end_date }}{% endif %}" name="end_date"
		id="end_date">
		<input type="text"
		value="{% if date_filter_chosen_label is defined %}{{ date_filter_chosen_label }}{% endif %}"
		name="date_filter_chosen_label" id="date_filter_chosen_label">
	</form>
	<button id="reportrange-toggler" class="btn btn-outline"
	style="background-color: #008000; box-shadow: 1px 2px 0 2px #FFFF; border-radius: 5px; margin-left: 20px;">
	<i class="fa fa-calendar text-light-40"></i>
</button>
</div>
<ol class="breadcrumb">
	<li>
		<a href="{{url('dashboard')}}">Accueil</a>
	</li>
	<li>
		<i class="fa fa-angle-right"></i>
		historique de mes emprunts
	</li>

</ol>
{% endblock %}
{% block content %}
<div class="info-box">
	<h4 class="text-black">Liste({{emprunt_filter_etudiant |length}})

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
				{% for k,emprunt in emprunt_filter_etudiant %}
				<tr>
					<td>{{k+1}}</td>
					<td>{{emprunt.prenom}}
					{{emprunt.nom}}</td>
					<td>
						<span class="label label-primary">{{emprunt.matricule}}
						</span></td>
						<td>{{emprunt.nom_livre}}</td>
						<td>
							<span class="label label-primary">{{emprunt.role}}</span>
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
							<span class="label label-danger">{{date('d/m
							/Y',strtotime(emprunt.delai_livre))}}</span>
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
									Retard
									<?php endif ?>
								</td>
								<td>
									<span class="label label-{% if emprunt.amende == 0 %}danger{% else %}success{% endif %}">{{number_format( emprunt.amende,0, '', '. ')}}</span>
								</td>
								<td>
									{% if emprunt.retour_status == 1 %}
									<a href="{{url('emprunt/pdf/'~emprunt.id)}}" title="Imprimer" target="_blank">
										<i class="fa fa-print"></i>
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
		</div>
	</div>
	{% endblock %}
	{% block addjs %}
	<!-- daterangepicker -->
	<script type="{{('text/javascript')}}" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="{{('text/javascript')}}" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	<!-- DataTable -->
	<script src="{{url('template/plugins/datatables/jquery.dataTables.min.js')}}"></script>
	<script src="{{url('template/plugins/datatables/dataTables.bootstrap.min.js')}}"></script>
	<script src="{{url('js/calendrier.js')}}"></script>

	{% endblock %}