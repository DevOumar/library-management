<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Reinitialisation - UTILISATEUR</title>
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

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js')}}"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js')}}"></script>
<![endif]-->

</head>
<body class="hold-transition login-page sty1">
  <div class="login-box sty1">
    <div class="login-box-body sty1">
      <div class="login-logo">

        <img src="{{url('img/logo-login.jpeg')}}" alt="logo" width="250">

      </div>
      {{flash.output()}}
      <form action="{{url('user/resetpasswordUser')}}" method="post">
        <h6>Entrez votre adresse e-mail ci-dessous et nous vous enverrons la marche à suivre. Si vous ne voyez pas notre e-mail, regardez dans votre dossier Spam.</h6>
        <div class="form-group has-feedback">
          <input type="email" class="form-control sty1" name="email" placeholder="Adresse e-mail" required="required">
        </div>
        <div>
          <div class="col-xs-8">
            <div class="checkbox icheck">
            </div>
            <!-- /.col -->
            <div class="col-xs-4 m-t-1">
              <button type="submit" class="btn btn-primary btn-block btn-flat">Envoyer ma demande</button>
            </div>
            <p>
              <a href="{{url('user/connexion')}}" class="text-center"><i class="fa fa-arrow-left"></i> Retourner en arrière</a>
            </p>
            <!-- /.col --> 
          </div>
        </form>
        
        <!-- /.social-auth-links -->
        
      </div>
      <!-- /.login-box-body --> 
    </div>
    <!-- /.login-box --> 

    <!-- jQuery 3 --> 
    <script src="{{url('template/js/jquery.min.js')}}"></script> 

    <!-- v4.0.0-alpha.6 --> 
    <script src="{{url('template/bootstrap/js/bootstrap.min.js')}}"></script> 

    <!-- template --> 
    <script src="{{url('template/js/niche.js')}}"></script>

  </body>
  </html>