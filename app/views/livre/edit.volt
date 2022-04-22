{% extends 'layouts/base.volt' %}
{% block title %}Mise à jour de {{livre.nom_livre}} {% endblock %}
{% block pageTitle %} {{livre.nom_livre}} {% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
    <li><a href="{{url('livre')}}">Livre</a></li>
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
          <form method="POST" action="{{url('livre/edit/'~livre.id)}}">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group has-feedback">
                        <label class="control-label">Nom du livre</label>
                        {{form.render("nom_livre")}}
                        <span class="fa fa-user form-control-feedback" aria-hidden="true"></span> </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group has-feedback">
                            <label class="control-label">Auteur du livre</label>
                            {{form.render("id_auteur")}}
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group has-feedback">
                            <label class="control-label">Catégorie</label>
                            {{form.render("id_categorie")}}
                        </span> </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group has-feedback">
                            <label class="control-label">Numéro ISBN</label>
                            {{form.render("isbn")}}
                            <span class="fa fa-spinner form-control-feedback" aria-hidden="true"></span> </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group has-feedback">
                                <label class="control-label">Rangée</label>
                                {{form.render("id_ranger")}}
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group has-feedback">
                                <label class="control-label">Casier</label>
                                {{form.render("id_casier")}}
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group has-feedback">
                                <label class="control-label">Nombre de pages</label>
                                {{form.render("nbre_page")}}
                                <span class="fa fa-spinner form-control-feedback" aria-hidden="true"></span> </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group has-feedback">
                                    <label class="control-label">Quantité</label>
                                    {{form.render("quantite")}}
                                    <span class="fa fa-spinner form-control-feedback" aria-hidden="true"></span> </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer text-left">
                      <a href="{{url('livre')}}" class="btn btn-default">Annuler</a>
                      <button type="submit" class="btn btn-success">Modifier</button>
                  </div>
              </form>
          </div>
      </div>
  </div>
  {% endblock %}