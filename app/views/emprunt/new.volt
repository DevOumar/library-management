{% extends 'layouts/base.volt' %}
{% block title %}Nouvel Emprunt{% endblock %}
{% block pageTitle %}Nouvel Emprunt{% endblock %}
{% block addcss %}
{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
    <li><a href="{{url('emprunt')}}">Emprunt</a></li>
    <li><i class="fa fa-angle-right"></i>Nouvel</li>
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
                <form method="POST" action="{{url('emprunt/new')}}">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group has-feedback">
                                <label class="control-label">Matricule</label>
                                {{form.render("user_id")}}
                                <input onblur="getinfos()" class="form-control" type="text" id="matricule">
                                <span class="fa fa-user form-control-feedback" aria-hidden="true"></span>
                            </div>
                            <div class="form-group">
                                <span id="get_student_name" style="font-size:16px;"></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group has-feedback">
                                <label class="control-label">Délai de retour</label>
                                {{form.render("delai_livre")}}
                                <span class="fa  form-control-feedback" aria-hidden="true"></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group has-feedback">
                                <label class="control-label mb-10" for="id_livre"> Nom du livre</label>
                                {{ form.render('id_livre') }}
                                <div id="book-stock" style="margin-top: 12px;color:red;">
                                    <strong></strong>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>
            <div class="card-footer text-left">
                <a href="{{url('emprunt')}}" class="btn btn-default">Annuler</a>

                <button type="submit"  class="btn btn-success">Affecter</button>

            </div>
        </div>
    </form>
</div>
</div>
</div>
{% endblock %}
{% block addjs %}
<script type="text/javascript" src="{{url('js/emprunt.js')}}"></script>
<script>
    // function for get student name
    function getinfos() {
      $("#loaderIcon").show();
      $("#user_id").val('');

      jQuery.ajax({
        url: "{{url('emprunt/infos')}}",
        data: 'matricule=' + $("#matricule").val(),
        type: "POST",
        success: function (data) {
            resp = JSON.parse(data);
            if(resp?.error){
                return      $("#get_student_name").html("<span class='text-danger'>Matricule non valide. Veuillez entrer un matricule correct</span>");

            }

            if(resp?.error === false){
                $("#user_id").val(resp?.user?.id);
                return      $("#get_student_name").html(
                    "<span class='text-black'>"+
                    resp?.user?.prenom+ ' ' +resp?.user?.nom+
                    "</span>"
                    );

            }
            console.log(resp)
            $("#loaderIcon").hide();
        },
        error: function () { }
    });
  }

  </script>
  {% endblock %}