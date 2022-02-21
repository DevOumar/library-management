{% extends 'layouts/base.volt' %}
{% block title %}Mise à jour de {{memoire.nom_memoire}} {% endblock %}
{% block pageTitle %} {{memoire.nom_memoire}} {% endblock %}
{% block addcss %}
<!-- DataTables -->
<link rel="stylesheet" href="{{url('template/plugins/datatables/css/dataTables.bootstrap.min.css')}}">
{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
    <li><a href="{{url('memoire')}}">Mémoire</a></li>
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
          <form method="POST" action="{{url('memoire/edit/'~memoire.id)}}">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group has-feedback">
                        <label class="control-label">Thème du mémoire</label>
                        {{form.render("nom_memoire")}}
                        <span class="fa fa-user form-control-feedback" aria-hidden="true"></span> </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group has-feedback">
                            <label class="control-label">Auteur du mémoire</label>
                            {{form.render("id_auteur")}}
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group has-feedback">
                            <label class="control-label">Catégorie</label>
                            {{form.render("id_categorie")}}
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group has-feedback">
                            <label class="control-label">Filière</label>
                            {{form.render("id_filiere")}}
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group has-feedback">
                            <label class="control-label">Cycle</label>
                            {{form.render("id_cycle")}}
                        </div>
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
                                <label class="control-label">Date de soutenance</label>
                                {{form.render("date_soutenance")}}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-footer text-left">
              <a href="{{url('memoire')}}" class="btn btn-default">Annuler</a>
              <button type="submit" class="btn btn-success">Modifier</button>
          </div>
      </form>
  </div>
</div>
</div>
{% endblock %}
{% block addjs %}
{% endblock %}