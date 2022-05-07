{% extends 'layouts/base.volt' %}
{% block title %}Mémoires{% endblock %}
{% block pageTitle %} Mémoires{% endblock %}
{% block addcss %}
<!-- DataTables -->
<link rel="stylesheet" href="{{url('template/plugins/datatables/css/dataTables.bootstrap.min.css')}}">
{{ stylesheet_link("template/vendor/sweetalert/dist/sweetalert.css") }}
{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
    <li><a href="{{url('dashboard')}}">Accueil</a></li>
    <li><i class="fa fa-angle-right"></i> mémoire</li>
</ol>
{% endblock %}

{% block content %}
<div class="info-box">
    <div class="col-md-6">
     {{flash.output()}}
 </div>
 <h4 class="text-black">Liste({{memoires |length}}){% if session.role == "ADMINISTRATEUR" %} <a href="{{url('memoire/new')}}" class="btn btn-primary btn-sm"><i class="fa fa-plus-circle"></i> Nouveau</a>{% endif %}</h4>
 <hr />
 <div class="table-responsive">
  <table id="dataList" class="table table-bordered table-hover" data-name="cool-table">
    <thead>
      <tr>
        <th>ID #</th>
        <th>Thème du mémoire</th>
        <th>Catégories</th>
        <th>Auteurs</th>
        <th>Filières</th>
        <th>Rangées</th>
        <th>Casiers</th>
        <th>Nbre pages</th>
        <th>Date de soutenance</th>
        <th>Action</th>
    </tr>
</thead>
<tbody>
    {% for k,memoire in memoires %}
    <tr>
        <td>{{k+1}}</td>
        <td>{{memoire.nom_memoire |upper}}</td>
        <td>{{memoire.getCategorie().libelle}}</td>
        <td>{{memoire.getAuteur().nom_auteur |upper}}</td>
        <td><span class="label label-primary">{{memoire.getFiliere().libelle}}/{{memoire.getCycle().libelle}}</span></td>

        <td><span class="label label-warning">{{memoire.id_ranger}}</span></td>
        <td><span class="label label-warning">{{memoire.id_casier}}</span></td>
        <td><span class="label label-warning">{{memoire.nbre_page}}</span></td>
        <td><span class="label label-warning">{{date('d/m/Y',strtotime(memoire.date_soutenance))}}</span></td>
    </td>
    <td>
       <a href="{{url('memoire/details/'~memoire.id)}}"><i class="fa fa-eye"></i></a>
      {% if session.role == "ADMINISTRATEUR" %}
       <a href="{{url('memoire/edit/'~memoire.id)}}"><i class="fa fa-edit"></i></a>
       <a href="#" class="supelm" data-id = {{memoire.id}}><i class="fa fa-trash"></i></a>
       {% endif %}
   </td>
</tr>
{% endfor %}
</tbody>
</table>
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
      text: 'Supprimer ce mémoire !',
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#DD6B55',
      confirmButtonText: 'Oui, valider !',
      cancelButtonText: 'Annuler',
      closeOnConfirm: false,
  }, function () {
    $.ajax({
        url: "{{url('memoire/delete')}}/"+id,
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