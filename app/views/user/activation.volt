<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>BIBLIOTHEQUE | ACTIVATION </title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
  <meta charset="utf-8">

  <!-- v4.0.0-alpha.6 -->
  <link rel="stylesheet" href="{{url('template/bootstrap/css/bootstrap.min.css')}}">
  <link rel="icon" href="{{url('template/img/logo1.png" type="image/png')}}" />
  <!-- Google Font -->
  <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet">

  <!-- Theme style -->
  <link rel="stylesheet" href="{{url('template/css/style.css')}}">
  <link rel="stylesheet" href="{{url('template/css/font-awesome/css/font-awesome.min.css')}}">
  <link rel="stylesheet" href="{{url('template/css/et-line-font/et-line-font.css')}}">
  <link rel="stylesheet" href="{{url('template/css/themify-icons/themify-icons.css')}}">
  <link rel="stylesheet" href="{{url('template/plugins/hmenu/ace-responsive-menu.css')}}">

  <!-- DataTables -->
  <link rel="stylesheet" href="{{url('template/plugins/datatables/css/dataTables.bootstrap.min.css')}}">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->

</head>
<body class="hold-transition skin-blue sidebar-mini">
  <div class="wrapper boxed-wrapper">
    <header class="main-header"> 
      <!-- Logo --> 
      <!-- Logo --> 
      <a href="confirmation" class="logo blue-bg"> 
        <!-- mini logo for sidebar mini 50x50 pixels --> 
        <span class="logo-mini"><img src="{{url('template/img/logo-n.png')}}" alt=""></span> 
        <!-- logo for regular state and mobile devices --> 
        <span class="logo-lg text-white">BIBLIO</span> </a>
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar blue-bg navbar-static-top">
          <div class="pull-left search-box">


          </header>
          <!-- Main Nav -->
        </div>
      </div>
      <div class="panel-body">

        <div class="content-header sty-one">
          <h1 class="text-black">Page d'activation de votre compte</h1>

        </div>

        <!-- Main content -->
        <div class="content">
          <div class="m-b-3">
            <div  style="margin-bottom: 0!important;">
              <h4><i class="fa fa-info"></i> Note:</h4>
              {{flash.output()}}
              <div class="content">
                <div class="m-b-3">
                  <div class="callout callout-info" style="margin-bottom: 0!important;">
                    <h4><i class="fa fa-info"></i> Note:</h4>
                    <a href="connexion">Cliquez ici pour vous connecter !</div></a>
                  </div>
                </div>
              </div>



              <!-- /.content-wrapper -->
              Copyright © {{date('Y')}} BIBLIO. All rights reserved.
            </div>
            <!-- ./wrapper --> 

            <!-- jQuery 3 --> 
            <script src="{{url('template/js/jquery.min.js')}}"></script> 

            <!-- v4.0.0-alpha.6 --> 
            <script src="{{url('template/bootstrap/js/bootstrap.min.js')}}"></script> 

            <!-- template --> 
            <script src="{{url('template/js/niche.js')}}"></script> 

            <!-- jQuery UI 1.11.4 --> 
            <script src="{{url('template/plugins/jquery-ui/jquery-ui.min.js')}}"></script>
            <script src="{{url('template/plugins/hmenu/ace-responsive-menu.js')}}" type="text/javascript')}}"></script> 
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
          </body>
          </html>
