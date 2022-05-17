{% extends 'layouts/base.volt' %}
{% block title %}Rangées{% endblock %}
{% block pageTitle %} Rangées{% endblock %}
{% block addcss %}
<!-- DataTables -->
<link rel="stylesheet" href="{{url('template/plugins/datatables/css/dataTables.bootstrap.min.css')}}">
{{ stylesheet_link("template/vendor/sweetalert/dist/sweetalert.css") }}
{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
    <li><a href="{{url('dashboard')}}">Accueil</a></li>
    <li><i class="fa fa-angle-right"></i> rangée</li>
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
            <div class="card-header bg-primary d-flex justify-content-between">
                <h5 class="text-white m-b-0">Formulaire</h5>
                <a href="{{url('ranger')}}" class="badge badge-info">Recharger</a>
            </div> 
            <div class="card-body">
                <form method="POST" {% if ranger is defined %} action="{{url('ranger/index/'~ranger.id)}}" {% else %} action="{{url('ranger/new')}}" {% endif %}>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group has-feedback">
                                <label class="control-label">Nom de la rangée</label>
                                {{form.render("libelle")}}
                                <span class="fa fa-user form-control-feedback" aria-hidden="true"></span> </div>
                            </div>
                        </div>
                        <hr />
                        <div class="row">
                            <div class="col-md-12">
                                {% if ranger is defined %}
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
               <h4 class="text-white m-b-0">Liste des rangers({{rangers |length}})</h4>
           </div>
           <div class="card-body">
               <hr />
               <div class="table-responsive">
                  <table id="dataList" class="table table-bordered table-hover" data-name="cool-table">
                    <thead>
                      <tr>
                        <th>ID #</th>
                        <th>Rangées</th>
                        <th>Date de création</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    {% for k,ranger in rangers %}
                    <tr>
                        <td>{{k+1}}</td>
                        <td>{{ranger.libelle |upper}}</td>
                        <td>{{date('d/m/Y \à H:i',strtotime(ranger.create_date))}}</td>
                    <td>
                        <a href="{{url('ranger/index/'~ranger.id)}}"><i class="fa fa-edit"></i></a>
                        <a href="#" class="supelm" data-id = {{ranger.id}}><i class="fa fa-trash"></i></a>
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
$(function () {
    $('#example1').DataTable()
    $('#example2').DataTable({
      'paging'      : true,
      'lengthChange': false,
      'searching'   : false,
      'ordering'    : true,
      'info'        : true,
      'autoWidth'   : false
  })
})
</script>
<script>
$('body').on('click', '.supelm', function (e) {

    e.preventDefault();
    var id = $(this).data('id');
    var currentTr = $(this).closest("tr");
    swal({
      title: 'Êtes-vous sûr ?',
      text: 'Supprimer cette rangée !',
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#DD6B55',
      confirmButtonText: 'Oui, valider !',
      cancelButtonText: 'Annuler',
      closeOnConfirm: false,
  }, function () {
    $.ajax({
        url: "{{url('ranger/delete')}}/"+id,
        cache: false,
        async: true
    })
    .done(function( result ) {

        if(result = "1"){
            $(currentTr).css('background-color', '#ff9933').fadeOut(1000, function(){ $(this).remove();});
            swal(
            'Supprimé!',
            'L\'element  a été supprimé avec succès.',
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