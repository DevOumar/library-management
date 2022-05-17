{% extends 'layouts/base.volt' %}
{% block title %}Mise à jour de {{user.prenom}} {{user.nom}} {% endblock %}
{% block pageTitle %} {{user.matricule}} {% endblock %}
{% block addcss %}
{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
    <li><a href="{{url('user')}}">Utilisateur</a></li>
    <li><i class="fa fa-angle-right"></i> Mise à jour</li>
</ol>
{% endblock %}

{% block content %}
<div class="row">
    <div class="col-lg-12">
      <div class="card ">
        <div class="card-header bg-blue">
          <h5 class="text-white m-b-0">Formulaire</h5>
      </div>
      <div class="card-body">
          <form method="POST" action="{{url('user/edit/'~user.id)}}">
            <div class="row">
            {% if user.matricule is defined %}
                <div class="col-md-6">
                    <div class="form-group has-feedback">
                        <label class="control-label">Matricule</label>
                        {{form.render("matricule")}}
                        <span class="fa fa-user form-control-feedback" aria-hidden="true"></span> </div>
                    </div>
                    {% endif %}
                    <div class="col-md-6">
                        <div class="form-group has-feedback">
                            <label class="control-label">Nom</label>
                            {{form.render("nom")}}
                            <span class="fa fa-user form-control-feedback" aria-hidden="true"></span> </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group has-feedback">
                                <label class="control-label">Prénom</label>
                                {{form.render("prenom")}}
                                <span class="fa fa-user form-control-feedback" aria-hidden="true"></span> </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group has-feedback">
                                    <label class="control-label">Pseudo</label>
                                    {{form.render("pseudo")}}
                                    <span class="fa fa-user form-control-feedback" aria-hidden="true"></span> </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group has-feedback">
                                        <label class="control-label">Adresse e-mail</label>
                                        {{form.render("email")}}
                                        <span class="fa fa-envelope form-control-feedback" aria-hidden="true"></span> </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group has-feedback">
                                            <label class="control-label">Rôle</label>
                                            {{form.render("role")}}
                                        </div>
                                    </div>
                                    {% if user.id_cycle != null %}
                                    <div class="col-md-6">
                                        <div class="form-group has-feedback">
                                            <label class="control-label">Cycle</label>
                                            {{form.render("id_cycle")}}
                                        </div>
                                    </div>
                                    {% endif %}
                                    {% if user.id_filiere != null %}
                                    <div class="col-md-6">
                                        <div class="form-group has-feedback">
                                            <label class="control-label">Filière</label>
                                            {{form.render("id_filiere")}}
                                        </div>
                                    </div>
                                    {% endif %}
                                    <div class="col-md-6">
                                        <div class="form-group has-feedback">
                                            <label class="control-label">Téléphone</label>
                                            {{form.render("telephone")}}
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group has-feedback">
                                            <label class="control-label">Status</label>
                                            {{form.render("status")}}
                                            <span class="fa fa-check-square form-control-feedback" aria-hidden="true"></span> </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer text-left">
                                  <a href="{{url('user')}}" class="btn btn-default">Annuler</a>
                                  <button type="submit" class="btn btn-success">Modifier</button>
                              </div>
                          </form>
                      </div>
                  </div>
              {% endblock %}
              {% block addjs %}

              {% endblock %}