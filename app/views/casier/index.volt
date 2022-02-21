{% extends 'layouts/base.volt' %}
{% block title %}Casiers{% endblock %}
{% block pageTitle %} Casiers{% endblock %}
{% block addcss %}
<!-- DataTables -->
<link rel="stylesheet" href="{{url('template/plugins/datatables/css/dataTables.bootstrap.min.css')}}">
{{ stylesheet_link("template/vendor/sweetalert/dist/sweetalert.css") }}
{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
    <li><a href="{{url('dashboard')}}">Accueil</a></li>
    <li><i class="fa fa-angle-right"></i> casier</li>
</ol>
{% endblock %}

{% block content %}
<div class="info-box">
   <div class="col-md-6">
       {{flash.output()}}
   </div>
   <div class="row">
    <div class="col-xl-4">
        <div class="card ">
            <div class="card-header bg-primary">
                <h5 class="text-white m-b-0">Formulaire</h5>

            </div> 
            <div class="card-body">
                <form method="POST" {% if casier is defined %} action="{{url('casier/index/'~casier.id)}}" {% else %} action="{{url('casier/new')}}" {% endif %}>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group has-feedback">
                                <label class="control-label">Nom du casier</label>
                                {{form.render("libelle")}}
                                <span class="fa fa-user form-control-feedback" aria-hidden="true"></span> </div>
                            </div>
                        </div>
                        <hr />
                        <div class="row">
                            <div class="col-md-12">
                                <button type="submit" class="btn btn-success mr-10 pull-right">Ajouter</button>
                            </div>
                        </div>
                        </form>
                    </div>
                     
                </div>
            </div>
        <div class="col-xl-8">
           <div class="card ">

            <div class="card-header bg-primary">
               <h4 class="text-white m-b-0">Liste des casiers({{casiers |length}})</h4>
           </div>
           <div class="card-body">
               <hr />
               <div class="table-responsive">
                  <table id="dataList" class="table table-bordered table-hover" data-name="cool-table">
                    <thead>
                      <tr>
                        <th>ID #</th>
                        <th>Casiers</th>
                        <th>Date de création</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    {% for k,casier in casiers %}
                    <tr>
                        <td>{{k+1}}</td>
                        <td>{{casier.libelle |upper}}</td>
                        <td>{{date('d/m/Y \à H:i',strtotime(casier.create_date))}}</td>
                    <td>
                        <a href="{{url('casier/index/'~casier.id)}}"><i class="fa fa-edit"></i></a>
                        <a href="#" class="supelm" data-id = {{casier.id}}><i class="fa fa-trash"></i></a>
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
      title: 'Êtes-vous sûr ?',
      text: 'Supprimer ce casier !',
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#DD6B55',
      confirmButtonText: 'Oui, valider !',
      cancelButtonText: 'Annuler',
      closeOnConfirm: false,
  }, function () {
    $.ajax({
        url: "{{url('casier/delete')}}/"+id,
        cache: false,
        async: true
    })
    .done(function( result ) {

        if(result = "1"){
            $(currentTr).css('background-color', '#ff9933').fadeOut(1000, function(){ $(this).remove();});
            swal(
            'Supprimé!',
            'L\'element  a été supprimée avec succès.',
            'success'
            );
            location.reload();
        }
        else{
            swal(
            'Impossible de supprimer. Objet lié !',
            'Erreur de suppression',
            'error'
            );
        }
    });
});

});
</script>
{% endblock %}