{% extends 'layouts/base.volt' %}
{% block title %}Auteurs{% endblock %}
{% block pageTitle %} Auteurs{% endblock %}
{% block addcss %}
<!-- DataTables -->
<link rel="stylesheet" href="{{url('template/plugins/datatables/css/dataTables.bootstrap.min.css')}}">
{{ stylesheet_link("template/vendor/sweetalert/dist/sweetalert.css") }}
{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
    <li><a href="{{url('dashboard')}}">Accueil</a></li>
    <li><i class="fa fa-angle-right"></i> auteur</li>
</ol>
{% endblock %}

{% block content %}
<div class="info-box">
 <div class="col-md-6">
     {{flash.output()}}
 </div>
 <div class="row">
    
    <div class="col-xl-4">
        <div class="card">
            <div class="card-header bg-primary d-flex justify-content-between">
                <h5 class="text-white m-b-0">Formulaire</h5>
                <a href="{{url('auteur')}}" class="badge badge-info">Recharger</a>
            </div> 
            <div class="card-body">
                <form method="POST" {% if auteur is defined %} action="{{url('auteur/index/'~auteur.id)}}" {% else %} action="{{url('auteur/new')}}" {% endif %}>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group has-feedback">
                                <label class="control-label">Nom de l'auteur</label>
                                {{form.render("nom_auteur")}}
                                <span class="fa fa-user form-control-feedback" aria-hidden="true"></span> </div>
                            </div>
                        </div>
                        <hr />
                        <div class="row">
                            <div class="col-md-12">
                                {% if auteur is defined %}
                                <button type="submit" class="btn btn-success mr-10 pull-right">Modifier</button>
                                {% else %}
                                <button type="submit" class="btn btn-success mr-10 pull-right">Ajouter</button>
                                {% endif %}
                            </div>
                        </div>
                    </form>
                </div>
                
            </div>
        </div>
        <div class="col-xl-8">
         <div class="card ">

            <div class="card-header bg-primary">
             <h4 class="text-white m-b-0">Liste des auteurs({{auteurs |length}})</h4>
         </div>
         <div class="card-body">
             <hr />
             <div class="table-responsive">
              <table id="dataList" class="table table-bordered table-hover" data-name="cool-table">
                <thead>
                  <tr>
                    <th>ID #</th>
                    <th>Auteurs</th>
                    <th>Date de cr??ation</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                {% for k,auteur in auteurs %}
                <tr>
                    <td>{{k+1}}</td>
                    <td>{{auteur.nom_auteur |upper}}</td>
                    <td>{{date('d/m/Y \?? H:i',strtotime(auteur.create_date))}}</td>
                    <td>
                        <a href="{{url('auteur/index/'~auteur.id)}}"><i class="fa fa-edit"></i></a>
                        <a href="#" class="supelm" data-id = {{auteur.id}}><i class="fa fa-trash"></i></a>
                    </td>
                </tr>
                {% endfor %}
            </tbody>

        </table>
    </div>
</div>
</div>
</div>
</div>
{% endblock %}
{% block addjs %}
<!-- DataTable --> 
{{ javascript_include("template/vendor/sweetalert/dist/sweetalert.min.js") }}
<script src="{{url('template/plugins/datatables/jquery.dataTables.min.js')}}"></script> 
<script src="{{url('template/plugins/datatables/dataTables.bootstrap.min.js')}}"></script>
<script>
$('body').on('click', '.supelm', function (e) {

    e.preventDefault();
    var id = $(this).data('id');
    var currentTr = $(this).closest("tr");
    swal({
      title: '??tes-vous s??r ?',
      text: 'Supprimer cet auteur !',
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#DD6B55',
      confirmButtonText: 'Oui, valider !',
      cancelButtonText: 'Annuler',
      closeOnConfirm: false,
  }, function () {
    $.ajax({
        url: "{{url('auteur/delete')}}/"+id,
        cache: false,
        async: true
    })
    .done(function( result ) {

        if(result = "1"){
            $(currentTr).css('background-color', '#ff9933').fadeOut(1000, function(){ $(this).remove();});
            swal(
                'Supprim??!',
                'L\'element  a ??t?? supprim?? avec succ??s.',
                'success'
                );
            location.reload();
        }
        else{
            swal(
                'Impossible de supprimer. Objet li?? !',
                'Erreur de suppression',
                'error'
                );
        }
    });
});

});
</script>
{% endblock %}