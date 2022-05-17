{% extends 'layouts/base.volt' %}
{% block title %}Nouveu Livre numérique{% endblock %}
{% block pageTitle %}Nouveu Livre numérique{% endblock %}
{% block addcss %}
{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
    <li><a href="{{url('numerique')}}">Livre numérique</a></li>
    <li><i class="fa fa-angle-right"></i>Nouveau</li>
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
                <h5 class="text-white m-b-0">Formulaire</h5>
            </div>
            <div class="card-body">
                <form method="POST" action="{{url('livres-numeriques/new')}}" enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group has-feedback">
                                <label class="control-label">Nom complet de l'auteur</label>
                                {{form.render("nom_auteur")}}
                                <span class="fa fa-user form-control-feedback" aria-hidden="true"></span> </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group has-feedback">
                                    <label class="control-label">Nom de livre</label>
                                    {{form.render("nom_livre")}}
                                    <span class="fa fa-user form-control-feedback" aria-hidden="true"></span> </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group has-feedback">
                                        <label class="control-label">Description du livre</label>
                                        {{form.render("description")}}
                                        <span class="fa fa-spinner form-control-feedback" aria-hidden="true"></span> </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6">
                                        <div class="card">
                                          <div class="card-body">
                                            <h4 class="text-black">Livre numérique</h4>
                                            <label for="input-file-now"></label>
                                            {{form.render("file_livre")}}
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6">
                                    <div class="card">
                                      <div class="card-body">
                                        <h4 class="text-black">Couverture du livre numérique</h4>
                                        <label for="input-file-now"></label>
                                        {{form.render("photo")}}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="card-footer text-left">
            <a href="{{url('livres-numeriques')}}" class="btn btn-default">Annuler</a>
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