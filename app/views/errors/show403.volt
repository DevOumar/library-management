<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Erreur 403 - BIBLIOTHEQUE</title>
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
<body class="hold-transition lockscreen">
<!-- Automatic element centering -->
<div>
  <div class="error-page text-center">
    <h2 class="headline text-yellow"> 403</h2>
    <div>
      <h3><i class="fa fa-warning text-yellow"></i> Accès interdit !</h3>
      <p> Vous n'êtes pas autorisés à acceder à la ressource demandée.
        En attendant, vous pouvez <a href="{{url('dashboard')}}">retourner au tableau de bord</a> </p>
      
    </div>
    <!-- /.error-content --> 
  </div>
  <div class="lockscreen-footer text-center m-t-3"> Copyright © 2021 BIBLIO. All rights reserved. </div>
</div>
<!-- /.center --> 
<!-- /.login-box --> 

<!-- jQuery 3 --> 
<script src="{{url('template/js/jquery.min.js')}}"></script> 

<!-- v4.0.0-alpha.6 --> 
<script src="{{url('template/bootstrap/js/bootstrap.min.js')}}"></script> 

<!-- template --> 
<script src="{{url('template/js/niche.js')}}"></script>
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
</body>
</html>