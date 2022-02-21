<!DOCTYPE html>
<html lang="fr">
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
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->

</head>
<body class="hold-transition login-page">
  <div class="login-box">
    <div class="login-box-body">
      <h3 class="login-box-msg m-b-1">Récupérer mot de passe</h3>
      <p>Ça y est, vous êtes presque arrivé ! </p>
      <form action="{{url('user/confirmation?token_activation='~token_activation)}}" method="post">
        {{flash.output()}}
        <div class="form-group">
          <label for="pwd1">Nouveau mot de passe</label>
          <div class="input-group">
            <div class="input-group-addon"><i class="ti-lock"></i></div>
            {{form.render("new_password")}}
          </div>
        </div>
        <div class="form-group">
          <label for="pwd2">Confirmer votre mot de passe</label>
          <div class="input-group">
            <div class="input-group-addon"><i class="ti-lock"></i></div>
            {{form.render("con_password")}}
          </div>
          <div id="result"></div>
        </div>
        <div>
          <div class="col-xs-4 m-t-1">
            <button type="submit" class="btn btn-primary btn-block btn-flat">Réinitialiser</button>
          </div>
          <div class="m-t-2">
            <a href="{{url('user/connexion')}}" class="text-center">Connectez-vous facilement !</a>
          </div>
        </div>
        <!-- /.col --> 
      </div>
    </form>
  </div>
  <!-- /.login-box-body --> 
</div>
<!-- /.login-box --> 

<!-- jQuery 3 --> 
<script src="{{url('template/js/jquery.min.js')}}"></script> 

<!-- v4.0.0-alpha.6 --> 
<script src="{{url('template/bootstrap/js/bootstrap.min.js')}}"></script> 
<script src="{{url('js/function.js')}}"></script>
<!-- template --> 
<script src="{{url('template/js/niche.js')}}"></script>
<script src="{{url('template/plugins/hmenu/ace-responsive-menu.js')}}" type="text/javascript"></script> 
<!--Plugin Initialization--> 
<script type="{{url('template/text/javascript')}}">
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