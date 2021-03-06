{% extends 'layouts/base.volt' %}
{% block title %}Nouveau Livre{% endblock %}
{% block pageTitle %}Nouveau Livre{% endblock %}
{% block addcss %}
{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
    <li><a href="{{url('livre')}}">Livre</a></li>
    <li><i class="fa fa-angle-right"></i>Nouveau</li>
</ol>
{% endblock %}
{% block content %}
{{flash.output()}}
<div class="row">
    <div class="col-lg-12">
        <div class="card ">
            <div class="card-header bg-blue">
                <h5 class="text-white m-b-0">Formulaire</h5>
            </div>
            <div class="card-body">
                <form method="POST" action="{{url('livre/new')}}">
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
                                </span> </div>
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
                          <button type="submit" class="btn btn-success">Ajouter</button>
                      </div>
                  </div>
              </form>
          </div>
      </div>
  </div>
  {% endblock %}
  {% block addjs %}
  {% endblock %}