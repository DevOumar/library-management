{% extends 'layouts/base.volt' %}
{% block title %}Mise à jour de {{user.prenom}} {{user.nom}} {% endblock %}
{% block pageTitle %} {{user.prenom}} {{user.nom}} {% endblock %}
{% block addcss %}
<!-- DataTables -->
<link rel="stylesheet" href="{{url('template/plugins/datatables/css/dataTables.bootstrap.min.css')}}">
{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
    <li><a href="{{url('user')}}">Utilisateur</a></li>
    <li><i class="fa fa-angle-right"></i> Mise à jour</li>
</ol>
{% endblock %}

{% block content %}
<div class="info-box">
 <div class="col-md-6">
     {{flash.output()}}
 </div>
 <div class="row m-t-3">
    <div class="col-lg-12">
      <div class="card ">
        <div class="card-header bg-blue">
          <h5 class="text-white m-b-0">Modifier votre profil</h5>
      </div>
      <div class="card-body">
          <form method="POST" action="{{url('user/profil/'~user.id)}}" enctype="multipart/form-data">
            <div class="form-group">
                <label>Date de création de compte:</label>
                {{date('d-m-Y \à H:i',strtotime(user.create_date))}}
            </div>
            <div class="form-group">
                <label>Dernière connexion:</label>
                {% if user.datelastlogin != null %}{{date("d-m-Y \à H:i:s", strtotime(user.datelastlogin))}}{% endif %}
            </div>
            <div class="form-group">
                <label>Connexion précédente:</label>
                {% if user.datelastlogin != null %}{{date("d-m-Y \à H:i:s", strtotime(user.datepreviouslogin))}}{% endif %}
            </div>
            <div class="form-group">
                <label>Statut profil : </label>
                {% if user.status == 1 %}
              <i class="fa fa-circle text-success"></i>&nbsp;<span style="color: green">Activé</span>
                {% else %}
              <i class="fa fa-circle text-danger"></i>&nbsp;<span style="color: red">Désactivé</span>
                {% endif %}
            </div>
            <div class="row">
              <div class="col-md-6">
                <div class="form-group has-feedback">
                    <label class="control-label">Matricule<span class="text-muted"> (généré automatiquement)</span></label>
                    {{form.render("matricule")}}
                    <span class="fa fa-spinner form-control-feedback" aria-hidden="true"></span> </div>
                </div>
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
                                        <label class="control-label">Téléphone</label>
                                        {{form.render("telephone")}}
                                        <span class="fa fa-phone form-control-feedback" aria-hidden="true"></span>
                                    </div>
                                </div>
                                {% if session.role == 'ETUDIANT' %}
                                <div class="col-md-6">
                                    <div class="form-group has-feedback">
                                        <label class="control-label">Filière</label>
                                        {{form.render("id_filiere")}}
                                    </div>
                                </div>
                                {% endif %}
                                {% if session.role == 'ETUDIANT' %}
                                <div class="col-md-6">
                                    <div class="form-group has-feedback">
                                        <label class="control-label">Cycle</label>
                                        {{form.render("id_cycle")}}
                                    </div>
                                </div>
                                {% endif %}
                                <div class="col-md-6">
                                    <div class="form-group has-feedback">
                                        <label class="control-label">Status</label>
                                        {{form.render("status")}}
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6">
                                    <div class="card">
                                      <div class="card-body">
                                        <h4 class="text-black">Photo de profil</h4>
                                        <label for="input-file-now"></label>
                                        {{form.render("photo")}}
                                    </div>
                                </div>
                            </div>
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
</div>
{% endblock %}
{% block addjs %}
{% endblock %}