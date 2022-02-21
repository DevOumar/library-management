{% extends 'layouts/base.volt' %}
{% block title %}Détail Livre{% endblock %}
{% block addcss %}
<link rel="stylesheet" href="{{url('template/plugins/dropify/dropify.min.css')}}">
{{ stylesheet_link("template/vendor/sweetalert/dist/sweetalert.css") }}
{% endblock %}
{% block pageTitle %} Détail Livre{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
  <li><a href="{{url('livre')}}">Livre</a></li>
  <li><i class="fa fa-angle-right"></i> Détail Livre</li>
</ol>
{% endblock %}

{% block content %}
{{flash.output()}}
<div class="row">
  <div class="col-lg-12">
    <div class="user-profile-box m-b-3" style="padding:0;">
      {% if session.role == "ADMINISTRATEUR" %}
      <a href="{{url('livre/edit/'~livre.id)}}" class="pull-right btn btn-default btn-xs" title="Modifier"><i class="fa fa-edit"></i></a>{% endif %}
      <div class="box-profile text-white"><img class="profile-user-img img-responsive img-circle m-b-2" src="{{url('template/img/img1.jpg')}}" alt="User profile picture" />
        <h3 class="profile-username text-center">{{livre.nom_livre |upper}}</h3>
        <p class="text-center">ISBN: {{livre.isbn}}</p>
        <p class="text-center">{{livre.getCategorie().libelle}}</p>
        
      </div>
    </div>
    <div class="info-box">
      <div class="box-body"> 
        <strong><i class="fa fa-spinner margin-r-5"></i> Nom du livre:</strong>
        <span class="text-muted pull-right">{{livre.nom_livre}}</span>
        <hr>
        <strong><i class="fa fa-spinner margin-r-5"></i> Catégorie:</strong>
        <span class="pull-right label label-warning">{{livre.getCategorie().libelle}}</span>
        <hr>
        <strong><i class="fa fa-user margin-r-5"></i> Auteur:</strong>
        <span class="pull-right label label-primary">{{livre.getAuteur().nom_auteur}}</span>
        <hr>
        <strong><i class="fa fa-spinner margin-r-5"></i> ISBN:</strong>
        <span class="pull-right label label-warning">{{livre.isbn}} </span>
        <hr>
        <strong><i class="fa fa-spinner margin-r-5"></i> Rangée:</strong>
        <span class="pull-right label label-warning">{{livre.id_ranger}} </span>
        <hr>
        <strong><i class="fa fa-spinner margin-r-5"></i> Casier:</strong>
        <span class="pull-right label label-warning">{{livre.id_casier}} </span>
        <hr>
        <strong><i class="fa fa-spinner margin-r-5"></i> Nombre de pages:</strong>
        <span class="pull-right label label-warning">{{livre.nbre_page}} </span>
        <hr>
        <strong><i class="fa fa-chevron-right margin-r-5"></i> Quantité:</strong>
        <span class="pull-right label label-warning">{{livre.quantite}} </span>
        <hr>
        <strong><i class="fa fa-chevron-right margin-r-5"></i> Stock:</strong>
        <span class="pull-right label label-danger">{{livre.getQteStock()}} </span>
      </div>
      <!-- /.box-body --> 
    </div>
  </div>
  
  {% endblock %}
  {% block addjs %}
  {% endblock %}