{% extends 'layouts/base.volt' %}
{% block title %}Détail Livre Recommandation
{% endblock %}
{% block addcss %}
{% endblock %}
{% block pageTitle %}
Détail Livre Recommandation
{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
	<li>
		<a href="{{url('recommandation')}}">Livre recommandation</a>
	</li>
	<li>
		<i class="fa fa-angle-right"></i>
	Détail Recommandation</li>
</ol>
{% endblock %}

{% block content %}
{{flash.output()}}
<div class="row">
	<div class="col-lg-4">

		<div class="info-box">
			<div class="box-body">
				<strong>
					<i class="fa fa-user margin-r-5"></i>
				Titre du livre</strong>
				<p class="text-muted">{{recommandation.nom_livre }}</p>
				<hr>
				<strong>
					<i class="fa fa-user margin-r-5"></i>
				Auteur du livre</strong>
				<p class="text-muted">{{recommandation.nom_auteur }}</p>
				<hr>
				<strong>
					<i class="fa fa-user margin-r-5"></i>
					
				Recommandé par</strong>
				<p class="text-muted">{{recommandation.getUsers().prenom~" "~recommandation.getUsers().nom }}</p>
				
				<hr>
				<strong>
					<i class="fa fa-user margin-r-5"></i>
					
				Rôle</strong>
				<p class="text-muted">{{recommandation.getUsers().role}}</p>
				
				<hr>
				<strong>
					<i class="fa fa-calendar margin-r-5"></i>
					Date de création
				</strong>
				<p class="text-muted">{{date("d-m-Y", strtotime(recommandation.create_date))}}</p>
				<hr>
			</div>
			<!-- /.box-body -->
		</div>
	</div>
	<div class="col-lg-8">
		<div class="info-box">
			<div
			class="card tab-style1">
			<!-- Nav tabs -->
			<ul class="nav nav-tabs profile-tab" role="tablist">
				<li class="nav-item">Description du livre recommandé</li>
			</ul>
			<!-- Tab panes -->
			<div class="tab-content">
				<div class="tab-pane active" id="home" role="tabpanel" aria-expanded="true">
					<div class="card-body">
						<div class="row">
							<div class="col-lg-2">
								<div class="user-img pull-left">
									<img src="{{url('img/cover2.jpg')}}" class="img-circle img-responsive" alt="User Image">
								</div>
							</div>
							<div class="col-lg-10">
								<div class="mail-contnet">
									<strong>{{recommandation.nom_livre |upper }}</strong>
									<p>{{recommandation.description }}</p>
									<hr>
								</div>
							</div>
						</div>
						<p class="text-muted">
							<strong>{{recommandation.nom_auteur }}</strong>, auteur du livre
							<strong>{{recommandation.nom_livre |upper }}.</strong>
						</p>

					</div>
				</div>
				<!--second tab-->

			</div>
			<hr>
		</div>
	</div>
	<div class="text-left">
		<a href="{{url('recommandation')}}" class="btn btn-default">Retourner</a>
	</div>
</div>
</div>
</div></div></div><!-- Main row --></div><!-- /.content --></div>
{% endblock %}
{% block addjs %}
{% endblock %}
