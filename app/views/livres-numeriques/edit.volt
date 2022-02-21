{% extends 'layouts/base.volt' %}
{% block title %}Mise à jour de {{numerique.nom_auteur}}{% endblock %}
{% block pageTitle %} {{numerique.nom_auteur}} {% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
  <li><a href="{{url('numerique')}}">Livre numérique</a></li>
  <li><i class="fa fa-angle-right"></i> Mise à jour</li>
</ol>
{% endblock %}

{% block content %}
<div class="row m-t-3">
  <div class="col-lg-12">
    <div class="card ">
      <div class="card-header bg-blue">
        <h5 class="text-white m-b-0">Formulaire</h5>
      </div>
      <div class="card-body">
        <form method="POST" action="{{url('livres-numeriques/edit/'~numerique.id)}}">
          <div class="row">
            <div class="col-md-6">
              <div class="form-group has-feedback">
                <label class="control-label">Nom de l'auteur</label>
                {{form.render("nom_auteur")}}
                <span class="fa fa-user form-control-feedback" aria-hidden="true"></span> </div>
              </div>
              <div class="col-md-6">
                <div class="form-group has-feedback">
                  <label class="control-label">Nom du livre</label>
                  {{form.render("nom_livre")}}
                  <span class="fa fa-user form-control-feedback" aria-hidden="true"></span> </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group has-feedback">
                    <label class="control-label">Description du livre</label>
                    {{form.render("description")}}
                    <span class="fa fa-spinner form-control-feedback" aria-hidden="true"></span> </div>
                  </div>
                </div>
                    </div>
                    <div class="card-footer text-left">
                      <a href="{{url('livres-numeriques')}}" class="btn btn-default">Annuler</a>
                      <button type="submit" class="btn btn-success">Modifier</button>
                    </div>
                  </form>
                </div>
              </div>
            </div>
            {% endblock %}
