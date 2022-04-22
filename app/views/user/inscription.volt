
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>INSCRIPTION | BIBLIOTHEQUE</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />

  <!-- v4.0.0-alpha.6 -->
  <link rel="stylesheet" href="{{url('template/bootstrap/css/bootstrap.min.css')}}">

  <!-- Google Font -->
  <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet">

  <!-- Theme style -->
  <link rel="stylesheet" href="{{url('template/css/style.css')}}">
  <link rel="stylesheet" href="{{url('template/css/font-awesome/css/font-awesome.min.css')}}">
  <link rel="stylesheet" href="{{url('template/build/css/intlTelInput.css')}}">
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
      <h3 class="login-box-msg">Inscription</h3>
      {{flash.output()}}
      <form role="form" method="POST" action="{{url('user/inscription')}}">
        <label class="control-label">Matricule<span class="text-muted"> (généré automatiquement)</span></label>
        <div class="form-group has-feedback">
          {{form.render("matricule")}}
        </div>
        <div class="form-group has-feedback">
          {{form.render("nom")}}
        </div>
        <div class="form-group has-feedback">
          {{form.render("prenom")}}
        </div>
        <div class="form-group has-feedback">
          {{form.render("pseudo")}}
        </div>
        <div class="form-group has-feedback">
         {{form.render("telephone")}}
      </div>
        <div class="form-group has-feedback">
          {{form.render("email")}}
          <div class="form-group">
            <span id="user-availability" style="font-size:16px;"></span> 
          </div>
        </div>
         <div class="form-group has-feedback">
         {{form.render("role")}}
      </div>
      <div class="form-group has-feedback">
        <select class="custom-select form-control" name="id_cycle" {{form.render("id_cycle")}}
      </select>
    </div>
    <div class="form-group has-feedback">
        <select class="custom-select form-control" name="id_filiere" {{form.render("id_filiere")}}
      </select>
    </div>
    <div class="form-group has-feedback">
      {{form.render("password")}}
    </div>
    <div class="form-group has-feedback">
      {{form.render("con_password")}}
    </div>
    <div id="result"></div>
    
        <!-- /.col -->
        <div class="col-xs-4 m-t-1">
          <button type="submit" class="btn btn-primary btn-block btn-flat">S'inscrire</button>
        </div>
        <!-- /.col --> 
     
    </form>
    <div class="m-t-2">Avez-vous déjà un compte? <a href="{{url('user/connexion')}}" class="text-center">Connectez-vous facilement</a></div>
  </div>
  <!-- /.login-box-body --> 
</div>
<!-- /.login-box --> 

<!-- jQuery 3 --> 
<script src="{{url('template/js/jquery.min.js')}}"></script> 
<script src="{{url('js/login.js')}}"></script>
<!-- v4.0.0-alpha.6 --> 
<script src="{{url('template/bootstrap/js/bootstrap.min.js')}}"></script> 

<!-- template --> 
<script src="{{url('template/js/niche.js')}}"></script>
<script src="{{url('template/build/js/intlTelInput.js')}}"></script>
  <script>
    var input = document.querySelector("#telephone");
    window.intlTelInput(input, {
      // allowDropdown: false,
      // autoHideDialCode: false,
      // autoPlaceholder: "off",
      // dropdownContainer: document.body,
      // excludeCountries: ["us"],
      // formatOnDisplay: false,
      // geoIpLookup: function(callback) {
      //   $.get("http://ipinfo.io", function() {}, "jsonp").always(function(resp) {
      //     var countryCode = (resp && resp.country) ? resp.country : "";
      //     callback(countryCode);
      //   });
      // },
      // hiddenInput: "full_number",
      // initialCountry: "auto",
      // localizedCountries: { 'de': 'Deutschland' },
      // nationalMode: false,
      // onlyCountries: ['us', 'gb', 'ch', 'ca', 'do'],
      // placeholderNumberType: "MOBILE",
      // preferredCountries: ['cn', 'jp'],
      // separateDialCode: true,
      utilsScript: "{{url('template/build/js/utils.js')}}",
    });
  </script>
<script>
function verif() {
  var a = document.getElementById("current-password").value;
  var b = document.getElementById("con-password").value;
  result = document.getElementById("result");
  if (a!=b) {
   result.innerHTML= "<p class='text-danger'>Oops,les deux mots de passe ne sont pas identiques.</p>";
   return false;
 }
 else {
   result.innerHTML= "<p class='text-success'>Les deux mots de passe sont identiques.</p>";
 }
}
</script>
<script>
function getinfos() {
  $("#loaderIcon").show();
  jQuery.ajax({
    url: "{{url('user/infos')}}",
    data:'email='+$("#email").val(),
    type: "POST",
    success:function(data){
      $("#user-availability").html(data);
      $("#loaderIcon").hide();
    },
    error:function (){}
  });
}
</script>
<style type="text/css">
.others{
  color:red;
}

</style>
</body>
</html>