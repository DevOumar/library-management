{% extends 'layouts/base.volt' %}
{% block title %}Nouvel Utilisateur{% endblock %}
{% block pageTitle %}Nouvel Utilisateur{% endblock %}
{% block addcss %}
{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
    <li><a href="{{url('user')}}">Utilisateur</a></li>
    <li><i class="fa fa-angle-right"></i>Nouveau</li>
</ol>
{% endblock %}
{% block content %}
<div class="col-md-6">
{{flash.output()}}
</div>
<div class="row m-t-3">
    <div class="col-lg-12">
        <div class="card ">
            <div class="card-header bg-blue">
                <h5 class="text-white m-b-0">Formulaire</h5>
            </div>
            <div class="card-body">
                <form method="POST" role="form" action="{{url('user/new')}}" enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group has-feedback">
                                <label class="control-label">Matricule<span class="text-muted"> (généré automatiquement)</span></label>
                                {{form.render("matricule")}}
                                <span class="fa fa-user form-control-feedback" aria-hidden="true"></span> </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group has-feedback">
                                   <label for="nom" class="control-label">Nom de l'utilisateur</label>
                                   {{form.render("nom")}}
                                   <span class="fa fa-user form-control-feedback" aria-hidden="true"></span> </div>
                               </div>
                               <div class="col-md-6">
                                <div class="form-group has-feedback">
                                   <label for="prenom" class="control-label">Prénom</label>
                                   {{form.render("prenom")}}
                                   <span class="fa fa-user form-control-feedback" aria-hidden="true"></span> </div>
                               </div>
                               <div class="col-md-6">
                                <div class="form-group has-feedback">
                                   <label for="pseudo" class="control-label">Pseudo</label>
                                   {{form.render("pseudo")}}
                                   <span class="fa fa-user form-control-feedback" aria-hidden="true"></span> </div>
                               </div>
                               <div class="col-md-6">
                                <div class="form-group has-feedback">
                                    <label for="email" class="control-label">Adresse e-mail</label>
                                    {{form.render("email")}}
                                    <span class="fa fa-envelope form-control-feedback" aria-hidden="true"></span> </div>
                                    <div class="form-group">
                                        <span id="user-availability" style="font-size:16px;"></span> 
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group has-feedback">
                                        <label class="control-label">Rôle</label>
                                        {{form.render("role")}}
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group has-feedback">
                                        <select class="custom-select form-control" {{form.render("id_cycle")}}
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group has-feedback">
                                        <label class="control-label">Téléphone</label>
                                        {{form.render("telephone")}}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer text-left">
                      <a href="{{url('user')}}" class="btn btn-default">Annuler</a>
                      <button type="submit" class="btn btn-success">Ajouter</button>
                  </div>
              </div>
          </form>
      </div>
  </div>
</div>
{% endblock %}
{% block addjs %}

<script>
$(document).ready(function () {
    $("select#id_cycle").hide();

    $("select#role").change(function (e) {
        //.preventDefault();

        if (e.target.value === "ETUDIANT") {
            $("select#id_cycle").show();
        } else {
            $("select#id_cycle").hide();
        }
    });
});
</script>
<script>
function getinfos() {
  $("#loaderIcon").show();
  jQuery.ajax({
    url: "{{url('user/infos')}}",
    data:'email='+$("#email").val(),
    type: "POST",
    success:function(data){
      $("#user-availability").html(data);
      $("#loaderIcon").hide();
    },
    error:function (){}
  });
}
</script>
{% endblock %}