<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>CONNEXION | UTILISATEUR</title>
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

     {#  <img src="{{url('img/logo-login.jpeg')}}" alt="logo" width="250">#}

      </div>
      <p class="login-box-msg">Veuillez-vous connecter</p>
      {{flash.output()}}
      <form action="{{url('user/connexion')}}" method="post">
        <div class="form-group has-feedback">
          <input type="email" class="form-control sty1" name="email" placeholder="Adresse e-mail" required="required">
        </div>
        <div class="form-group has-feedback">
          <input type="password" class="form-control sty1" name="password" placeholder="Mot de passe" required="required">
        </div>
      <div class="checkbox icheck">
        <label>
          <a href="{{url('user/resetpasswordUser')}}" class="pull-right"><i class="fa fa-lock"></i> Mot de passe oublié?</a> </div>
          <div>
            <!-- /.col -->
            <div class="col-xs-4 m-t-1">
              <button type="submit" class="btn btn-primary btn-block btn-flat">Se connecter</button>
            </div>
            <!-- /.col --> 
          </div>
        </form>
        <div class="m-t-2">
          <a href="{{url('user/inscription')}}" class="text-center">Inscrivez-vous gratuitement !</a></div>
          <a href="{{url('accueil')}}" class="text-center">Retourner à la page d'accueil !</a></div>

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