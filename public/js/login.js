$(document).ready(function () {
    $("select#id_cycle").hide();

    $("select#role option[value='ADMINISTRATEUR']").remove();

    $("select#role").change(function (e) {
        //.preventDefault();

        if (e.target.value === "ETUDIANT") {
            $("select#id_cycle").show();
        } else {
            $("select#id_cycle").hide();
        }
    });
});