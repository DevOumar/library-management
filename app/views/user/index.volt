{% extends 'layouts/base.volt' %}
{% block title %}Utilisateurs{% endblock %}
{% block pageTitle %} Utilisateurs{% endblock %}
{% block addcss %}
<!-- DataTables -->
<link rel="stylesheet" href="{{url('template/plugins/datatables/css/dataTables.bootstrap.min.css')}}">
{{ stylesheet_link("template/vendor/sweetalert/dist/sweetalert.css") }}
{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
    <li><a href="{{url('dashboard')}}">Accueil</a></li>
    <li><i class="fa fa-angle-right"></i> utilisateurs</li>
</ol>
{% endblock %}

{% block content %}
<div class="info-box">
   <div class="col-md-6">
       {{flash.output()}}
   </div>
   <h4 class="text-black">Liste({{users |length}}){% if in_array(session.role, ['ADMINISTRATEUR']) %}
    <a href="{{url('user/new')}}" class="btn btn-primary btn-sm"><i class="fa fa-plus-circle"></i> Nouveau</a>{% endif %}</h4>
    <hr />
    <div class="table-responsive">
      <table id="dataList" class="table table-bordered table-hover" data-name="cool-table">
        <thead>
          <tr>
            <th>ID #</th>
            <th>Matricule</th>
            <th>Nom & Prénom</th>
            <th>Pseudo</th>
            <th>E-mail</th>
            <th>Téléphone</th>
            <th>Rôle</th>
            <th>{% if in_array(session.role, ["ADMINISTRATEUR","ETUDIANT"]) %}Cycle/Filière{% endif %}</th>
            <th>Status</th>
            <th>Dernière connexion</th>
            <th>Date de création</th>
            {% if in_array(session.role, ['ADMINISTRATEUR']) %}
            <th>Action</th>
            {% endif %}
        </tr>
    </thead>
    <tbody>
        {% for k,user in users %}
        <tr>
            <td>{{k+1}}</td>
            <td> <div class="media align-items-center">
                <div class="media-img-wrap d-flex mr-10">
                    <div class="avatar avatar-sm">
                        {% if in_array(session.role, ['ADMINISTRATEUR','PROFESSEUR','ETUDIANT']) %}
                        {% if user.photo != null %}
                        <img src="{{url('files/users_upload/'~user.photo)}}" class="avatar-text avatar-text-primary rounded-circle" alt="User Image">
                        {% else %}
                        <span class="avatar-text avatar-text-primary rounded-circle"><span class="initial-wrap"><span>{{user.initials}}</span></span>
                    </span>
                </div>
            </div>
            {% endif %}
            {% endif %}
            <div class="media-body">
                <div class="text-capitalize font-weight-500 text-dark">{{user.matricule}}</div>
            </div>
        </div>
    </td>
    
    
    <td>{{user.prenom}} {{user.nom |upper}}</td>
    <td><span class="label label-primary">{{user.pseudo}}</span></td>
    <td>{{user.email}}</td>
    <td>{{user.telephone}}</span></td>
    <td><span class="label label-primary">{{user.role}}</span></td>
    
    <td>{% if user.id_cycle != null and user.id_filiere != null %}<span class="label label-primary">{{user.getCycle().libelle}}/{{user.getFiliere().libelle}}</span>{% endif %}</td>
    

    <td>
        {% if user.status %}
        <a href="#" class="changeStat" data-id = "{{user.id}}"><span class="label label-success">Activé</span></a>
        {% else %}
        <a href="#" class="changeStat" data-id = "{{user.id}}"><span class="label label-danger">Désactivé</span></a>
        {% endif %}
    </td>
    <td>{{date('d/m/Y \à H:i',strtotime(user.datelastlogin))}}</td>
    <td>{{date('d/m/Y \à H:i',strtotime(user.create_date))}}</td>
</td>
{% if in_array(session.role, ['ADMINISTRATEUR']) %}
<td>
    <a href="{{url('user/edit/'~user.id)}}"><i class="fa fa-edit"></i></a>
    <a href="#" class="supelm" data-id = {{user.id}}><i class="fa fa-trash"></i></a>
    {% endif %}
</td>
</tr>
{% endfor %}
</tbody>

</table>
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
      text: 'Supprimer cet étudiant !',
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#DD6B55',
      confirmButtonText: 'Oui, valider !',
      cancelButtonText: 'Annuler',
      closeOnConfirm: false,
  }, function () {
    $.ajax({
        url: "{{url('user/delete')}}/"+id,
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
<script>
$('.changeStat').click(function (e) {

    var id = $(this).data('id');

    swal({
      title: 'Êtes-vous sûr ?',
      text: 'Changer ce status !',
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#DD6B55',
      confirmButtonText: 'Oui, changer !',
      cancelButtonText: 'Annuler',
      closeOnConfirm: false,
  }, function () {
    $.ajax({
        url: "{{url('user/updateStatus')}}/"+id,
        cache: false,
        async: true
    })
    .done(function(result) {

        if(result = "1"){
            swal(
                'Modifé!',
                'L\'element  a été modifié avec succès.',
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