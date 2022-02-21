{% extends 'layouts/base.volt' %}
{% block title %}Livres{% endblock %}
{% block pageTitle %} Livres{% endblock %}
{% block addcss %}
<!-- DataTables -->
<link rel="stylesheet" href="{{url('template/plugins/datatables/css/dataTables.bootstrap.min.css')}}">
{{ stylesheet_link("template/vendor/sweetalert/dist/sweetalert.css") }}
{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
    <li><a href="{{url('dashboard')}}">Accueil</a></li>
    <li><i class="fa fa-angle-right"></i> livre</li>
</ol>
{% endblock %}

{% block content %}
<div class="info-box">
 <div class="col-md-6">
     {{flash.output()}}
 </div>
 <h4 class="text-black">Liste({{livres |length}}) {% if session.role == "ADMINISTRATEUR" %} <a href="{{url('livre/new')}}" class="btn btn-primary btn-sm"><i class="fa fa-plus-circle"></i> Nouveau</a>{% endif %}
    <a href="{{url('recommandation')}}" class="btn btn-success btn-sm pull-right" title="Liste des livres recommandés par les utilisateurs."><i class="fa fa-book"></i> Recommandations</a>
</h4>
<hr />
<div class="table-responsive">
  <table id="dataList" class="table table-bordered table-hover" data-name="cool-table">
    <thead>
      <tr>
        <th>ID #</th>
        <th>Nom du livre</th>
        <th>Catégories</th>
        <th>Auteurs</th>
        <th>ISBN</th>
        <th>Rangées</th>
        <th>Casiers</th>
        <th>Nbre pages</th>
        <th>Quantité</th>
        <th>Stock</th>
        <th>Date de création</th>
        <th>Action</th>
    </tr>
</thead>
<tbody>
    {% for k,livre in livres %}
    <tr>
        <td>{{k+1}}</td>
        <td>{{livre.nom_livre |upper}}</td>
        <td><span class="label label-primary">{{livre.getCategorie().libelle}}</span></td>
        <td>{{livre.getAuteur().nom_auteur}}</td>
        <td><span class="label label-warning">{{livre.isbn}}</span></td>
        <td><span class="label label-warning">{{livre.getRanger().libelle}}</span></td>
        <td><span class="label label-warning">{{livre.getCasier().libelle}}</span></td>
        <td><span class="label label-warning">{{livre.nbre_page}}</span></td>
        <td><span class="label label-warning">{{livre.quantite}}</span></td>
        <td><span class="label label-danger">{{livre.getQteStock()}}</span></td>
        <td>{{date('d/m/Y \à H:i',strtotime(livre.create_date))}}</span></td>
    </td>
    <td>
        <a href="{{url('livre/details/'~livre.id)}}"><i class="fa fa-eye"></i></a>
        {% if session.role == "ADMINISTRATEUR" %}
        <a href="{{url('livre/edit/'~livre.id)}}"><i class="fa fa-edit"></i></a>
        <a href="#" class="supelm" data-id = "{{livre.id}}"><i class="fa fa-trash"></i></a>
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
      text: 'Supprimer ce livre !',
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#DD6B55',
      confirmButtonText: 'Oui, valider !',
      cancelButtonText: 'Annuler',
      closeOnConfirm: false,
  }, function () {
    $.ajax({
        url: "{{url('livre/delete')}}/"+id,
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