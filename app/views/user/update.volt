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
   <div class="col-md-6">
       {{flash.output()}}
   </div>
    <div class="row">
    <div class="col-lg-12">
        <div class="card ">
        <div class="card-header bg-blue">
          <h5 class="text-white m-b-0">Modifier votre profil</h5>
      </div>
      <div class="card-body">
        <form method="POST" action="{{url('user/update/'~user.id)}}" enctype="multipart/form-data">
            <div class="row">
                {% if user.matricule is defined %}
              <div class="col-md-6">
                <div class="form-group has-feedback">
                    <label class="control-label">Matricule<span class="text-muted"> (généré automatiquement)</span></label>
                    {{form.render("matricule")}}
                    <span class="fa fa-spinner form-control-feedback" aria-hidden="true"></span> </div>
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
                                    {{form.render("email" , {"disabled" : "disabled"})}}
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
                                        {{form.render("id_filiere", {"disabled" : "disabled"})}}
                                    </div>
                                </div>
                                {% endif %}
                                {% if session.role == 'ETUDIANT' %}
                                <div class="col-md-6">
                                    <div class="form-group has-feedback">
                                        <label class="control-label">Cycle</label>
                                        {{form.render("id_cycle", {"disabled" : "disabled"})}}
                                    </div>
                                </div>
                                {% endif %}
                                <div class="col-md-8 rounded mx-auto d-block">
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