{% extends 'layouts/base.volt' %}
{% block title %}Mise à jour mot de passe{% endblock %}
{% block pageTitle %}Changer mot de passe{% endblock %}
{% block addcss %}
{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
  <li><a href="{{url('dashboard')}}">Accueil</a></li>
  <li><i class="fa fa-angle-right"></i>Mise à jour du mot de passe</li>
</ol>
{% endblock %}
{% block content %}
<div class="col-md-6">
 {{flash.output()}}
</div>
<div class="row">
    <div class="col-lg-6">
        <div class="card ">
        <div class="card-header bg-blue">
          <h5 class="text-white m-b-0">Reinitialisation du Mot de passe</h5>
      </div>
      <div class="card-body">
      <form class="form" method="POST" action="{{url('user/resetPassword')}}">
        <div class="form-group">
          <label for="pwd1">Mot de passe actuel</label>
          <div class="input-group">
            <div class="input-group-addon"><i class="ti-lock"></i></div>
            {{form.render("old_password")}}
          </div>
        </div>
        <div class="form-group">
          <label for="pwd1">Nouveau mot de passe</label>
          <div class="input-group">
            <div class="input-group-addon"><i class="ti-lock"></i></div>
            {{form.render("new_password")}}
          </div>
        </div>
        <div class="form-group">
          <label for="pwd2">Confirmer votre mot de passe</label>
          <div class="input-group">
            <div class="input-group-addon"><i class="ti-lock"></i></div>
            {{form.render("con_password")}}
          </div>
          <div id="result"></div>
        </div>
        <button type="submit" class="btn btn-success waves-effect waves-light m-r-10">Valider</button>
      </form>
    </div>
  </div>
</div>
</div>
</div>
</div>

{% endblock %}