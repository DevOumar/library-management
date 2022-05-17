<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>{% block title %} {% endblock %} - BIBLIOTHEQUE</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />

  <!-- v4.0.0-alpha.6 -->
  <link rel="stylesheet" href="{{url('template/bootstrap/css/bootstrap.min.css')}}">

  <!-- Google Font -->
  <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet">

  <!-- Theme style -->
  <link rel="stylesheet" href="{{url('template/css/style.css')}}">
  <link rel="stylesheet" href="{{url('template/css/font-awesome/css/font-awesome.min.css')}}">
  <link rel="stylesheet" href="{{url('template/css/et-line-font/et-line-font.css')}}">
  <link rel="stylesheet" href="{{url('template/css/themify-icons/themify-icons.css')}}">
  <link rel="stylesheet" href="{{url('template/plugins/hmenu/ace-responsive-menu.css')}}">
  <link rel="stylesheet" href="{{url('template/plugins/datatables/css/dataTables.bootstrap.min.css')}}">
  <link rel="stylesheet" href="{{url('template/vendor/select2/dist/css/select2.min.css')}}">
  <!-- dropify -->
  <link rel="stylesheet" href="{{url('template/plugins/dropify/dropify.min.css')}}">
  {{ stylesheet_link("template/vendor/sweetalert/dist/sweetalert.css") }}
  <!-- Chartist CSS -->


  <!-- HTML5 Shim and Respond.js')}} IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js')}} doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js')}}"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js')}}"></script>
<![endif]-->
  <style type="text/css">
  .orange {
    color: #ff7a00;
  }
  </style>

  {% block addcss %}{% endblock %}
</head>
<body class="hold-transition skin-blue sidebar-mini">
  <div class="wrapper boxed-wrapper">
    <header class="main-header"> 
      <!-- Logo --> 
      <a href="{{url('dashboard')}}" class="logo blue-bg"> 
        <!-- mini logo for sidebar mini 50x50 pixels --> 
        <h4 class="logo-lg text-white">BIBLIO<span class="orange" style="font-size:40px;">.</span></h4>
      </a> 
      <!-- Header Navbar: style can be found in header.less -->
      <nav class="navbar blue-bg navbar-static-top"> 
        <!-- Sidebar toggle button-->
        <div class="pull-left search-box">
          <form action="{{url('livre/search')}}" method="post" class="search-form">
            <div class="input-group">
              <input name="query" class="form-control" placeholder=" Rechercher un livre..." type="text" >
              <span class="input-group-btn">
                <button type="submit" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i> </button>
              </span></div>
            </form>
            <!-- search form --> </div>
            {% block navbar_custom_menu %}
            <div class="navbar-custom-menu">
              <ul class="nav navbar-nav">
                <!-- Messages: style can be found in dropdown.less-->
                <li class="dropdown messages-menu"> <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="fa fa-envelope-o"></i>
                  <div class="notify"> <span class="heartbit"></span> <span class="point"></span> </div>
                </a>
                <ul class="dropdown-menu">
                  <li class="header">Vous avez 1 message</li>
                  <li>
                    <ul class="menu">
                      <li><a href="#">
                        <div class="pull-left"><img src="{{url('template/img/img1.jpg')}}" class="img-circle" alt="User Image"> <span class="profile-status online pull-right"></span></div>
                        <h4>Alex C. Patton</h4>
                        <p>I've finished it! See you so...</p>
                        <p><span class="time">9:30 AM</span></p>
                      </a></li>
                    </ul>
                  </li>
                  <li class="footer"><a href="{{url('mailbox')}}">Voir tous les Messages</a></li>
                </ul>
              </li>
              <!-- Notifications: style can be found in dropdown.less -->
              <li class="dropdown messages-menu"> <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="fa fa-bell-o"></i>
                {% if notifs |length > 0 %}

                {{notifs |length}}
                {% endif %}
              </a>
              <ul class="dropdown-menu">
                <li class="header">Notifications</li>
                <li>
                  <ul class="menu">
                    {% for notif in notifications %}
                    <li><a {% if notif.url != null %} href="{{notif.url}}" {% else %}href="#"{% endif %}>
                      <div class="pull-left icon-circle red"><i class="icon-lightbulb"></i></div>
                      <p>{{notif.message}}</p>
                      <p style="" title="{{notif.message}}"><span class="time">{{date('d/m/Y \à H:i', strtotime(notif.create_date))}}</span></p>
                    </a>
                  </li>
                  {% endfor %}
                </ul>
              </li>
              <li class="footer"><a href="{{url('notification')}}">Voir toutes les Notifications</a></li>
            </ul>
          </li>
          <!-- User Account: style can be found in dropdown.less -->
          <li class="dropdown user user-menu p-ph-res"> <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            {% if in_array(session.role, ['ADMINISTRATEUR','PROFESSEUR','ETUDIANT']) %}
            {% if user.photo != null %}
            <img src="{{url('files/users_upload/'~user.photo)}}" class="user-image" alt="User Image">
            {% else %}
            <img src="{{url('img/avatar1.png')}}" class="user-image" alt="User Image">
            {% endif %}
            {% endif %}
            <span class="d-none d-lg-inline" id="logged-user" data-name="{{session.prenom}} {{session.nom |upper}}">
              {% if in_array(session.role, ['ADMINISTRATEUR']) %}{{session.prenom}} {{session.nom |upper}} | {{session.role}}{% endif %}
              {% if in_array(session.role, ['PROFESSEUR']) %}{{session.prenom}} {{session.nom |upper}} | {{session.role}}{% endif %}
              {% if in_array(session.role, ['ETUDIANT']) %}{{session.prenom}} {{session.nom |upper}} | {{session.libelle}}{% endif %}
            </span></a>
            <ul class="dropdown-menu">
              <li class="user-header">
                <div class="pull-left user-img"></div>
                <p class="text-left">{{session.pseudo}} <a><i class="fa fa-circle text-success"></i> en ligne</a><small>{{session.email}}</small> </p>
                <div class="view-link text-left"><a href="{{url('user/profil')}}" class="mr-10 btn btn-xs btn-secondary show-details" data-toggle="tooltip" class="mr-10 btn btn-xs btn-secondary" data-toggle="modal-show">Voir le profil</a> </div>
              </li>
              <li><a href="{{url('user/update')}}"><i class="icon-profile-male"></i> Modifier profil</a></li>
              <li role="separator" class="divider"></li>
              <li><a href="{{url('user/resetPassword')}}"><i class="icon-gears"></i> Changer mot de passe</a></li>
              <li role="separator" class="divider"></li>
              <li><a href="{{url('user/logout')}}"><i class="fa fa-power-off"></i>Se déconnecter</a></li>
            </ul>
          </li>
        </ul>
      </div>
      {% endblock %}
    </nav>
  </header>

  <!-- Main Nav -->
  <div class="main-nav">
    <nav> 
      <!-- Menu Toggle btn-->
      <div class="menu-toggle">
        <h3>Menu</h3>
        <button type="button" id="menu-btn"> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
      </div>
      <!-- Responsive Menu Structure--> 
      <!--Note: declare the Menu style in the data-menu-style="horizontal" (options: horizontal, vertical, accordion) -->
      <ul id="respMenu" class="ace-responsive-menu" data-menu-style="horizontal">
        <li><a href="{{url('dashboard')}}"><i class="fa fa-dashboard"></i> <span>Tableau de bord</span></a>
        </li>
        {% if session.role == 'ADMINISTRATEUR' %}
        <li><a href="{{url('auteur')}}"><i class="fa fa-user"></i> <span>Auteurs</span></a>
        </li>
        {% endif %}
        <li class="">
          <a href="#"><i class="fa fa-book"></i> <span>Livres</span></a>
          <ul class="sub-menu">
            <li><a href="{{url('livre')}}"><i class="fa fa-book"></i>Livres disponibles</a></li>
            <li><a href="{{url('livres-numeriques')}}"><i class="fa fa-book"></i>Livres numériques</a></li>
          </ul>
        </li>
        {% if in_array(session.role, ['ADMINISTRATEUR','PROFESSEUR']) or in_array(session.libelle, ['LICENCE','MASTER','DOCTORAT']) %}
        <li><a href="{{url('memoire')}}"><i class="fa fa-folder"></i> <span>Mémoires</span></a> 
          {% endif %}
          {% if session.role == 'ADMINISTRATEUR' %}
          <li class="">
            <a href="#"><i class="fa fa-spinner"></i> <span>Administration</span></a>
            <ul class="sub-menu">
              <li><a href="{{url('user')}}"><i class="fa fa-user-circle "></i><span>Gestion des utilisateurs</span></a></li>
              
              <li><a href="{{url('user/administrateur')}}"><i class="fa fa-user-circle"></i>Gestion des administrateurs</a></li>
            </ul>
          </li>
          {% endif %}
          {% if session.role == 'ADMINISTRATEUR' %}
          <li class="">
            <a href="#"><i class="fa fa-spinner"></i> <span>Affectation des emprunts</span></a>
            <ul class="sub-menu">
              <li><a href="{{url('emprunt')}}"><i class="fa fa-circle-o"></i>Affecter un emprunt</a></li>
              {% endif %}
              <li><a href="{{url('emprunt/historique')}}"><i class="fa fa-circle-o"></i>Historique des emprunts</a></li>
            </ul>
          </li>
          
          {% if session.role == 'ADMINISTRATEUR' %}
          <li class="">
            <a href="#"><i class="fa fa-cog"></i> <span>Configurations</span></a>
            <ul class="sub-menu">
              <li><a href="{{url('categorie')}}"><i class="fa fa-cog"></i>Catégorie</a></li>
              <li><a href="{{url('cycle')}}"><i class="fa fa-cog"></i>Cycle</a></li>
              <li><a href="{{url('ranger')}}"><i class="fa fa-cog"></i>Rangée</a></li>
              <li><a href="{{url('casier')}}"><i class="fa fa-cog"></i>Casier</a></li>
              <li><a href="{{url('filiere')}}"><i class="fa fa-cog"></i>Filière</a></li>
            </ul>
          </li>
          {% endif %}
        </ul>
      </nav>
    </div>


    <!-- Main Nav --> 

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper"> 
      <!-- Content Header (Page header) -->
      <div class="content-header sty-one">
        <h1>{% block pageTitle %} {% endblock %}</h1>
        {% block breadcrumb %}
        {% endblock %}
      </div>

      <!-- Main content -->
      <div class="content"> 
        {% block content %}
        {% endblock %}
      </div>
      <div class="modal fade" id="form" tabindex="-1" role="dialog" aria-labelledby="show-details" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <div class="modal-title" style="display: flex"><h5 class="col-md-12"  id="show-details">Mon profil</h5><h5 style="font-size: 14px; color: gray; align-self: center;" class="col-md-5">
                <a href="#" class="desac btn btn-danger btn-xs pull-right" data-id = {{user.id}}> <i class="fa fa-lock"></i> Désactiver mon compte</a> 
              
            </h5>
          </div>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <table class="table" >
              <tbody>
                <tr>
                  <td><i class="ti-target target-muted"></i> Status du compte :</td>
                  <td>
                    {% if user.status == 1 %}
                    <i class="fa fa-circle text-success"></i>&nbsp;<span class="badge badge-success">Activé</span>
                    {% else %}
                    <i class="fa fa-circle text-danger"></i>&nbsp;<span class="badge badge-danger">Désactivé</span>
                    {% endif %}
                  </td>
                </tr>
                <tr>
                  <td><i class="ti-target target-muted"></i> Date de création de compte :</td>
                  <td>
                    {{date('d-m-Y \à H:i',strtotime(user.create_date))}}
                  </td>
                </tr>
                <tr>
                  {% if user.datelastlogin != null %}
                  <td><i class="ti-target target-muted"></i> Dernière connexion :</td>
                  <td>
                    {{date("d-m-Y \à H:i:s", strtotime(user.datelastlogin))}}
                  </td>
                </tr>
                {% endif %}
                <tr>
                  <td><i class="ti-target target-muted"></i> Connexion précédente :</td>
                  {% if user.datepreviouslogin != null %}
                  <td>
                    {{date("d-m-Y \à H:i:s", strtotime(user.datepreviouslogin))}}
                  </td>
                </tr>
                {% endif %}
                {% if user.matricule is defined %}
                <tr>
                  <td><i class="ti-target target-muted"></i> Matricule :<span class="text-muted"> (généré automatiquement)</span></td>
                  <td>
                    {{user.matricule}}
                  </td>
                </tr>
                {% endif %}
                <tr>
                 <td><i class="ti-target target-muted"></i> Nom complet :</td>
                 <td> {{user.prenom}} {{user.nom}}</td>
               </tr>
               <tr>
                <td><i class="ti-target target-muted"></i> Pseudo :</td>
                <td> {{user.pseudo}}</td>
              </tr>
              <tr>
                <td><i class="ti-target target-muted"></i> Adresse e-mail :</td>
                <td> {{user.email}}</td>
              </tr>
              <tr>
                <td><i class="ti-target target-muted"></i> Téléphone :</td>
                <td> {{user.telephone}}</td>
              </tr>
              <tr>
                <td><i class="ti-target target-muted"></i> Rôle :</td>
                <td><span class="badge badge-success"> {{user.role}}</span></td>
              </tr>
              {% if session.role == 'ETUDIANT' %}
              <tr>
                <td><i class="ti-target target-muted"></i> Filière :</td>
                <td> {{user.getFiliere().libelle}}</td>
              </tr>
              {% endif %}
              {% if session.role == 'ETUDIANT' %}
              <tr>
                <td><i class="ti-target target-muted"></i> Cycle :</td>
                <td> {{user.getCycle().libelle}}</td>
              </tr>
              {% endif %}
            </tr>
          </tbody>
        </table>
      
        <!-- /.content --> 
     
      </div>
      
    </div>
  </div>
  </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="pull-right hidden-xs">Version 1.0</div>
  Copyright © 2021 BIBLIO. All rights reserved.</footer>

  <!-- ./wrapper --> 

  <!-- jQuery 3 --> 

  <script src="{{url('template/js/jquery.min.js')}}"></script> 

  <!-- v4.0.0-alpha.6 --> 
  <script src="https://npmcdn.com/tether@1.2.4/dist/js/tether.min.js"></script>
  <script src="{{url('template/bootstrap/js/bootstrap.min.js')}}"></script> 

  <script src="{{url('template/plugins/popper/popper.min.js')}}"></script>
  <script src="{{url('template/bootstrap/js/bootstrap.beta.min.js')}}"></script> 
  <!-- template --> 
  <script src="{{url('template/js/niche.js')}}"></script> 
  <!-- DataTable --> 
  <script src="{{url('template/plugins/datatables/jquery.dataTables.min.js')}}"></script> 
  <script src="{{url('template/plugins/datatables/dataTables.bootstrap.min.js')}}"></script>
  <script src="{{url('template/vendor/select2/dist/js/select2.full.min.js')}}"></script>
  <!-- dropify --> 
  <script src="{{url('template/plugins/dropify/dropify.min.js')}}"></script> 
  <script src="{{url('js/function.js')}}"></script>
  <script src="{{url('js/dateheure.js')}}"></script>
  {{ javascript_include("template/vendor/sweetalert/dist/sweetalert.min.js") }}
  <script type="{{('text/javascript')}}">
  $(".select2").select2({ 'data-placeholder': 'Choisir...' });
  </script>

  <script src="{{url('template/plugins/hmenu/ace-responsive-menu.js')}}" type="text/javascript"></script> 
  <!--Plugin Initialization--> 
  <script type="text/javascript">
  $(document).ready(function () {
   $("#respMenu").aceResponsiveMenu({
                 resizeWidth: '768', // Set the same in Media query       
                 animationSpeed: 'fast', //slow, medium, fast
                 accoridonExpAll: false //Expands all the accordion menu on click
               });
 });
  </script>
  <script type="text/javascript">
  $('body').on('click', '.show-details', function (e) {
    e.preventDefault();
    var url = $(this).attr('href');

    $.ajax({
      url: url,
      method:'get',
      cache: false,
      async: true
    })
    .done(function(html) {
      $('body #form .modal-body').html(html);  
      $('#form').modal('show');
    });

  });

  </script>
  <script>
  $('body').on('click', '.desac', function (e) {
    e.preventDefault();
    var id = $(this).data('id');
    var currentTr = $(this).closest("tr");
    swal({
      title: 'Êtes-vous sûr ?',
      text: 'Désactiver votre compte ! Attention, cette opération est irréversible !',
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#DD6B55',
      confirmButtonText: 'Oui, désactiver !',
      cancelButtonText: 'Annuler',
      closeOnConfirm: false,
    }, function () {
      $.ajax({
        url: "{{url('user/desac')}}/"+id,
        cache: false,
        async: true
      })
      .done(function( result ) {

        if(result = "1"){
          $(currentTr).css('background-color', '#ff9933').fadeOut(1000, function(){ $(this).remove();});
          swal(
            'Désactivé!',
            'Votre compte a été désactivé avec succès.',
            'success'
            );

        }
        else{
          swal(
            'Impossible de désactiver. Objet lié !',
            'Erreur de suppression',
            'error'
            );
        }
      });
    });

  });
  </script>
  {% block addjs %}
  
  {% endblock %}
</body>
</html>