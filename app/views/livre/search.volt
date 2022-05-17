{% extends 'layouts/base.volt' %}
{% block title %}Recherche{% endblock %}
{% block pageTitle %} Résultats de la recherche ({{livres |length}}){% endblock %}
{% block addcss %}
<!-- DataTables -->
<link rel="stylesheet" href="{{url('template/plugins/datatables/css/dataTables.bootstrap.min.css')}}">
{% endblock %}
{% block breadcrumb %}
    <ol class="breadcrumb">
        <li><a href="{{url('livre')}}">Livre</a></li>
        <li><i class="fa fa-angle-right"></i> Recherche</li>
    </ol>
{% endblock %}

{% block content %}
<div class="info-box">
      {{flash.output()}}
      <div class="table-responsive">
                {% if livres |length > 0 %}
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
                      </tr>
                    </thead>
                    <tbody>
                    {% for k,livre in livres %}
                      <tr>
                        <td>{{k+1}}</td>
                        <td>{{livre.nom_livre |upper}}</td>
                        <td>{{livre.getCategorie().libelle}}</td>
                        <td>{{livre.getAuteur().nom_auteur}}</td>
                        <td>{{livre.isbn}}</td>
                        <td>{{livre.id_ranger}}</td>
                        <td>{{livre.id_casier}}</td>
                        <td>{{livre.nbre_page}}</td>
                        <td>{{livre.quantite}}</td>
                        <td>{{livre.getQteStock()}}</td>
                        <td>{{date('d/m/Y \à H:i',strtotime(livre.create_date))}}</td>
                      </tr>
                    {% endfor %}
                    </tbody>
                    
                  </table>
                  {% else %}
                  <h4 class="alert alert-info text-center"> Aucun élément trouvé !</h4>
                  {% endif %}
                </div>
      </div>
      </div>
      </div>
      
{% endblock %}
{% block addjs %}
<!-- DataTable --> 
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

                        if(result == "1"){
                            $(currentTr).css('background-color', '#ff9933').fadeOut(1000, function(){ $(this).remove();});
                            swal(
                                'Supprimé!',
                                'L\'element  a été supprimée avec succès.',
                                'success'
                            );
                           
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