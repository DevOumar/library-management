{% extends 'layouts/base.volt' %}
{% block title %}Liste des notifications{% endblock %}
{% block pageTitle %}Liste des notifications{% endblock %}
{% block addcss %}
<!-- DataTables -->
<link rel="stylesheet" href="{{url('template/plugins/datatables/css/dataTables.bootstrap.min.css')}}">
{{ stylesheet_link("template/vendor/sweetalert/dist/sweetalert.css") }}
{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
    <li><a href="{{url('dashboard')}}">Accueil</a></li>
    <li><i class="fa fa-angle-right"></i>Notifications</li>
</ol>
{% endblock %}

{% block content %}
<div class="info-box">
  <div class="table-responsive">
      <table id="dataList" class="table table-bordered table-hover" data-name="cool-table">
        <thead>
          <tr>
            <th>ID #</th>
            <th>Message</th>
            <th>Date et heure</th>
            <th>Lien</th>

        </tr>
    </thead>
    <tbody>
        {% for k,notification in notifs %}
        <tr>
            <td>{{k+1}}</td>
            <td>{{notification.message}}</td>
            <td>{{date('d/m/Y \à H:i',strtotime(notification.create_date))}}</td>
            <td>
              <a href="{{url(notification.url)}}"><i class="fa fa-eye"></i></a>
          </td>
      </tr>

      {% endfor %}
  </tbody>

</table>
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
      text: 'Supprimer cette notification !',
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#DD6B55',
      confirmButtonText: 'Oui, valider !',
      cancelButtonText: 'Annuler',
      closeOnConfirm: false,
  }, function () {
    $.ajax({
        url: "{{url('notification/delete')}}/"+id,
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