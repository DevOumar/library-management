$(document).ready(function () {
    $("select#id_cycle").hide();
    $("select#id_filiere").hide();
    

    $("select#role option[value='ADMINISTRATEUR']").remove();
    
    $("select#role").change(function (e) {
        //.preventDefault();

        if (e.target.value === "ETUDIANT") {

            $("select#id_cycle").show();
            $("select#id_filiere").show();
            $("select#id_cycle").attr("required","required");
            $("select#id_filiere").attr("required","required");

            
        }else {
            $("select#id_cycle").hide();
            $("select#id_filiere").hide();
            $("select#id_cycle").removeAttr("required");
            $("select#id_filiere").removeAttr("required");
            
        }
    });
});


//

$("select#id_filiere").hide();
$("#id_cycle").change(function(e){
    if("#id_cycle"){
        $("select#id_filiere ").show();
        $("select#id_filiere ").attr("required","required");
    } else {
        $("select#id_filiere").hide();
    }
});

//


$(document).ready(function () {
  $(".account-type").click((e) => {
    let selectedButton = $(e.target);
    let selectedAccountType = selectedButton.data("type");

    let submitButton = $("button#submit");

    switch (selectedAccountType) {
      case "ETUDIANT":
      submitButton.removeAttr("disabled");
      submitButton
      .removeClass("btn-primary")
      .removeClass("btn-danger")
      .addClass("btn-secondary");
      $("input#account-type").val(selectedAccountType);
      break;

      case "PROFESSEUR":
      submitButton.removeAttr("disabled");
      submitButton
      .removeClass("btn-primary")
      .removeClass("btn-danger")
      .addClass("btn-success");
      $("input#account-type").val(selectedAccountType);
      break;

      case "ADMINISTRATEUR":
      submitButton.removeAttr("disabled");
      submitButton
      .removeClass("btn-primary")
      .removeClass("btn-secondary")
      .addClass("btn-danger");
      $("input#account-type").val(selectedAccountType);

      break;

      default:
      break;
  }

  console.log(selectedAccountType);
  e.preventDefault();
});
});


