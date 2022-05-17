{% extends 'layouts/base.volt' %}
{% block title %}Détail Mémoire{% endblock %}
{% block pageTitle %} Détail Mémoire{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
  <li><a href="{{url('memoire')}}">Mémoire</a></li>
  <li><i class="fa fa-angle-right"></i> Détail Mémoire</li>
</ol>
{% endblock %}
{% block content %}
{{flash.output()}}
<div class="row">
  <div class="col-lg-4">
    <div class="user-profile-box m-b-3" style="padding:0;">
      {% if session.role == "ADMINISTRATEUR" %}
      <a href="{{url('memoire/edit/'~memoire.id)}}" class="pull-right btn btn-default btn-xs" title="Modifier"><i class="fa fa-edit"></i></a>{% endif %}
      <div class="box-profile text-white"><img class="profile-user-img img-responsive img-circle m-b-2" src="{{url('template/img/img1.jpg')}}" alt="User profile picture" />
        <h3 class="profile-username text-center">{{memoire.nom_memoire |upper}}</h3>
        <p class="text-center">FILIERE: {{memoire.getFiliere().libelle}}</p>
        <p class="text-center">{{memoire.getCategorie().libelle}}</p>
        {# <p class="text-center">Praesent libero. Sed cursus ante dapi bus diam. Sed nisi nulla quis sem at nibh elementum imperdiet. Duis sagi diam ipsum resent.</p> #}
      </div>
    </div>
    </div>
    <div class="col-lg-8">
    <div class="info-box">
        <strong><i class="fa fa-spinner margin-r-5"></i> Nom du mémoire:</strong>
        <span class="pull-right">{{memoire.nom_memoire}}</span>
        <hr>
        <strong><i class="fa fa-spinner margin-r-5"></i> Catégorie:</strong>
        <span class="pull-right">{{memoire.getCategorie().libelle |upper}}</span>
        <hr>
        <strong><i class="fa fa-user margin-r-5"></i> Auteur:</strong>
        <span class="pull-right">{{memoire.getAuteur().nom_auteur |upper}}</span>
        <hr>
        <strong><i class="fa fa-spinner margin-r-5"></i> Filière:</strong>
        <span class="pull-right label label-warning">{{memoire.getFiliere().libelle}} </span>
        <hr>
        <strong><i class="fa fa-spinner margin-r-5"></i> Rangée:</strong>
        <span class="pull-right label label-warning">{{memoire.id_ranger}} </span>
        <hr>
        <strong><i class="fa fa-spinner margin-r-5"></i> Casier:</strong>
        <span class="pull-right label label-warning">{{memoire.id_casier}} </span>
        <hr>
        <strong><i class="fa fa-spinner margin-r-5"></i> Nombre de pages:</strong>
        <span class="pull-right label label-warning">{{memoire.nbre_page}} </span>
        <hr>
        <strong><i class="fa fa-calendar margin-r-5"></i> Date de soutenance:</strong>
        <span class="pull-right label label-warning">{{date('d-m-Y',strtotime(memoire.date_soutenance))}} </span>
        </div>
        <div class="text-left">
        <a href="{{url('memoire')}}" class="btn btn-default">Retourner</a>
      </div>
      </div>
      <!-- /.box-body --> 
    </div>
  </div>
  </div>
  {% endblock %}