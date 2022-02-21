<!DOCTYPE html>
<html lang="en">
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
  <!-- Chartist CSS -->


  <!-- HTML5 Shim and Respond.js')}} IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js')}} doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js')}}"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js')}}"></script>
<![endif]-->

  {% block addcss %}{% endblock %}
</head>
<body class="hold-transition skin-blue sidebar-mini">
  <div class="wrapper boxed-wrapper">
    <header class="main-header"> 
      <!-- Logo --> 
      <a href="{{url('dashboard')}}" class="logo blue-bg"> 
        <!-- mini logo for sidebar mini 50x50 pixels --> 
        <img src="{{url('img/logo.jpeg')}}" width="200" />
      </a> 
      <!-- Header Navbar: style can be found in header.less -->
      <nav class="navbar blue-bg navbar-static-top"> 
        <!-- Sidebar toggle button-->
        <div class="pull-left search-box">
          <form action="{{url('livre/search')}}" method="get" class="search-form">
            <div class="input-group">
              <input name="query" class="form-control" placeholder=" Rechercher un livre..." type="text" {% if query is defined %}value="{{query}}"{% endif %}>
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
                    <li><a {% if notif.url != null %} href="{{notif.url}}/{{notif.id}}" {% else %}href="#"{% endif %}>
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
            <span class="d-none d-lg-inline">
              {% if in_array(session.role, ['ADMINISTRATEUR']) %}{{session.prenom}} {{session.nom}} | {{session.role}}{% endif %}
              {% if in_array(session.role, ['PROFESSEUR']) %}{{session.prenom}} {{session.nom}} | {{session.role}}{% endif %}
              {% if in_array(session.role, ['ETUDIANT']) %}{{session.prenom}} {{session.nom}} | {{session.libelle}}{% endif %}
            </span></a>
            <ul class="dropdown-menu">
              <li class="user-header">
                <div class="pull-left user-img"></div>
                <p class="text-left">{{session.pseudo}} <a><i class="fa fa-circle text-success"></i> en ligne</a><small>{{session.email}}</small> </p>
                <div class="view-link text-left"><a href="{{url('user/profil/'~user_id)}}">Voir le profil</a> </div>
              </li>
              <li><a href="{{url('user/profil/'~user_id)}}"><i class="icon-profile-male"></i> Mon Profil</a></li>
              <li><a href="{{url('mailbox')}}"><i class="icon-envelope"></i> Boite de reception</a></li>
              <li role="separator" class="divider"></li>
              <li><a href="{{url('user/resetPassword')}}"><i class="icon-gears"></i> Changer mot de passe</a></li>
              <li role="separator" class="divider"></li>
              <li><a href="{{url('user/logout')}}"><i class="fa fa-power-off"></i> Se déconnecter</a></li>
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
            <li><a href="{{url('livre')}}">Livres disponibles</a></li>
            <li><a href="{{url('livres-numeriques')}}">Livres numériques</a></li>
          </ul>
        </li>
        {% if in_array(session.role, ['ADMINISTRATEUR','PROFESSEUR']) or in_array(session.libelle, ['LICENCE','MASTER','DOCTORAT']) %}
        <li><a href="{{url('memoire')}}"><i class="fa fa-folder"></i> <span>Mémoires</span></a> 
          {% endif %}

          <li><a href="{{url('user')}}"><i class="fa fa-user"></i><span>Utilisateurs</span></a></li>
          
          {% if session.role == 'ADMINISTRATEUR' %}
          <li class="">
            <a href="#"><i class="fa fa-book"></i> <span>Affectation des emprunts</span></a>
            <ul class="sub-menu">
              <li><a href="{{url('emprunt')}}">Affecter un emprunt</a></li>
              <li><a href="{{url('emprunt/historique')}}">Historique des emprunts</a></li>
            </ul>
          </li>
          {% endif %}
          {% if session.role == 'ADMINISTRATEUR' %}
          <li class="">
            <a href="#"><i class="fa fa-table"></i> <span>Configurations</span></a>
            <ul class="sub-menu">
              <li><a href="{{url('categorie')}}">Catégorie</a></li>
              <li><a href="{{url('cycle')}}">Cycle</a></li>
              <li><a href="{{url('ranger')}}">Rangée</a></li>
              <li><a href="{{url('casier')}}">Casier</a></li>
              <li><a href="{{url('filiere')}}">Filière</a></li>
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
      <!-- /.content --> 
    </div>
    <!-- /.content-wrapper -->
    <footer class="main-footer">
      <div class="pull-right hidden-xs">Version 1.0</div>
    Copyright © 2021 BIBLIO. All rights reserved.</footer>

    <!-- ./wrapper --> 

    <!-- jQuery 3 --> 
    <script src="{{url('template/js/jquery.min.js')}}"></script> 

    <!-- v4.0.0-alpha.6 --> 
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
    {% block addjs %}{% endblock %}
  </body>
  </html>
