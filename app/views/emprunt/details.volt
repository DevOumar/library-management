{% extends 'layouts/base.volt' %}
{% block title %}Détail Emprunt{% endblock %}
{% block pageTitle %} Détail Emprunt{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
  {% if session.role == "ADMINISTRATEUR"%}
  <li><a href="{{url('emprunt')}}">Emprunt</a></li>
  {% endif %}
  <li><i class="fa fa-angle-right"></i> Détail Emprunt</li>
</ol>
{% endblock %}

{% block content %}
{{flash.output()}}
<div class="row">
  <div class="col-lg-4">
    <div class="user-profile-box m-b-3" style="padding:0;">
      {% if session.role == "ADMINISTRATEUR" %}
      <a href="{{url('emprunt/edit/'~emprunt.id)}}" class="pull-right btn btn-default btn-xs" title="Modifier"><i class="fa fa-edit"></i></a>{% endif %}
      <div class="box-profile text-white"><img class="profile-user-img img-responsive img-circle m-b-2" src="{{url('template/img/img1.jpg')}}" alt="User profile picture" />
        <h3 class="profile-username text-center">{{emprunt.getLivre().nom_livre |upper}}</h3>
        <p class="text-center">ISBN: {{emprunt.getLivre().isbn}}</p>
        <p class="text-center">{{emprunt.getUsers().role}}</p>
        {# <p class="text-center">Praesent libero. Sed cursus ante dapi bus diam. Sed nisi nulla quis sem at nibh elementum imperdiet. Duis sagi diam ipsum resent.</p> #}
      </div>
    </div>
  </div>
  <div class="col-lg-8">
    <div class="info-box"> 
      <strong><i class="fa fa-spinner margin-r-5"></i> Matricule:</strong>
      <span class="pull-right">{{emprunt.getUsers().matricule}}</span>
      <hr>
      <strong><i class="fa fa-spinner margin-r-5"></i> Nom complet:</strong>
      <span class="pull-right">{{emprunt.getUsers().prenom}} {{emprunt.getUsers().nom}}</span>
      <hr>
      <strong><i class="fa fa-user margin-r-5"></i> Rôle:</strong>
      <span class="pull-right ">{{emprunt.getUsers().role}}</span>
      <hr>
      <strong><i class="fa fa-spinner margin-r-5"></i> Dernière connexion:</strong>
      <span class="pull-right ">{% if emprunt.getUsers().datelastlogin != null %}
        {{date("d-m-Y \à H:i:s", strtotime(emprunt.getUsers().datelastlogin))}}
      {% endif %} </span>
      <hr>
      <strong><i class="fa fa-spinner margin-r-5"></i> Nom du livre:</strong>
      <span class="pull-right ">{{emprunt.getLivre().nom_livre |upper}}</span>
      <hr>
      <strong><i class="fa fa-spinner margin-r-5"></i> ISBN:</strong>
      <span class="pull-right label label-primary">{{emprunt.getLivre().isbn}}</span>
      <hr>
      <strong><i class="fa fa-spinner margin-r-5"></i> Rangée:</strong>
      <span class="pull-right label label-warning">{{emprunt.getLivre().id_ranger}} </span>
      <hr>
      <strong><i class="fa fa-spinner margin-r-5"></i> Casier:</strong>
      <span class="pull-right label label-warning">{{emprunt.getLivre().id_casier}} </span>
      <hr>
      <strong><i class="fa fa-spinner margin-r-5"></i> Nombre de pages:</strong>
      <span class="pull-right label label-warning">{{emprunt.getLivre().nbre_page}} </span>
      <hr>
      <strong><i class="fa fa-spinner margin-r-5"></i> Date d'emprunt:</strong>
      <span class="pull-right label label-warning">{{date('d-m-Y',strtotime(emprunt.date_emprunt))}} </span>
      <hr>
      <strong><i class="fa fa-spinner margin-r-5"></i> Délai de retour:</strong>
      <span class="pull-right label label-danger">{{date('d-m-Y',strtotime(emprunt.delai_livre))}}</span>
      <?php $date1 = new DateTime('now');
        $date2 = new DateTime($emprunt->delai_livre.' 23:59:59.999999');
      ?>
      <?php if (($date1 > $date2) && $emprunt->retour_status == 0) : ?>
      <span class="pull-right label label-danger">
      Délai expiré</span>
      <?php endif ?>
      <hr>
      <strong><i class="fa fa-spinner margin-r-5"></i> Date de retour:</strong>
      {% if emprunt.retour_emprunt == "" or emprunt.retour_emprunt == NULL  %}
      <span class="pull-right label label-danger">
        Non retourné
      </span>
      {% else %}
      <span class="pull-right label label-success">
      {{date('d-m-Y',strtotime(emprunt.retour_emprunt))}}</td>
    </span>
    {% endif %}
    <hr>
    <strong><i class="fa fa-spinner margin-r-5"></i> Amende:</strong>
    <span class="pull-right label label-{% if emprunt.amende == 0 %}danger{% else %}success{% endif %}">{{number_format( emprunt.amende,0, '', ' ')}} </span>
    <hr>
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
      {% if session.role == "ADMINISTRATEUR" %}
      <div class="text-left">
        <a href="{{url('emprunt')}}" class="btn btn-default">Retourner</a>
      </div>
      {% else %}
      <div class="text-left">
        <a href="{{url('emprunt/index/livres_empruntes')}}" class="btn btn-default">Retourner</a>
      </div>
      {% endif %}
      <!-- /.box-body --> 
    </div>
  {% endblock %}
  {% block addjs %}
  {% endblock %}