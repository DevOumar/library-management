{% extends 'layouts/base.volt' %}
{% block title %}Tableau de bord{% endblock %}
{% block addcss %}
<!-- Chartist CSS -->
<link rel="stylesheet" href="{{url('template/plugins/chartist-js/chartist.min.css')}}">
<link rel="stylesheet" href="{{url('template/jquery-toast-plugin/dist/jquery.toast.min.css')}}">
<link rel="stylesheet" href="{{url('template/c3-charts/c3/c3.min.css')}}">
<link rel="stylesheet" href="{{url('template/plugins/chartist-js/chartist-plugin-tooltip.css')}}">
{% endblock %}
{% block pageTitle %} Tableau de bord{% endblock %}
{% block breadcrumb %}
<ol class="breadcrumb">
    <li><a href="dashboard">Accueil</a></li>
    <li><i class="fa fa-angle-right"></i> Tableau de bord</li>
</ol>
<hr>
<h4 id='p1'></h4>
<h4>
    <marquee>Bienvenue
        {{session.prenom}}
        {{session.nom}}
        dans l'application de gestion de bibliothèque.
    </marquee>
</h4>
{% endblock %}
{% block content %}
<div class="row">
    <div class="col-lg-3 col-xs-6">
        <a href="{{url('livre')}}">
            <div class="info-box">
                <span class="info-box-icon bg-aqua">
                    <i class="ti-book"></i>
                </span>
                <div class="info-box-content">
                    <span class="info-box-number">{{tbook |length}}</span>
                    <span class="info-box-text">Total Livres</span>
                </div>
            </div>
            <!-- /.info-box-content -->
        </a>
    </div>
    <!-- /.col -->
    {% if in_array(session.role, ['ADMINISTRATEUR']) %}
    <div class="col-lg-3 col-xs-6">
        <a href="{{url('auteur')}}">
            <div class="info-box">
                <span class="info-box-icon bg-aqua">
                    <i class="ti-user"></i>
                </span>
                <div class="info-box-content">
                    <span class="info-box-number">{{auteurs |length}}</span>
                    <span class="info-box-text">Total Auteurs</span>
                </div>
                <!-- /.info-box-content -->
            </div>
        </a>
    </div>
    {% endif %}
    {% if in_array(session.role, ['ADMINISTRATEUR']) %}
    <div class="col-lg-3 col-xs-6">
        <a href="{{url('user/index/nombre-etudiant')}}">
            <div class="info-box">
                <span class="info-box-icon bg-green">
                    <i class="icon-layers"></i>
                </span>
                <div class="info-box-content">
                    <span class="info-box-number">{{studentNumber |length}}</span>
                    <span class="info-box-text">Nombre d'étudiants</span>
                </div>
                <!-- /.info-box-content -->

            </div>
        </a>
    </div>
    {% endif %}
    {% if in_array(session.role, ['ADMINISTRATEUR']) %}

    <div class="col-lg-3 col-xs-6">
        <a href="{{url('user/index/nombre-professeur')}}">
            <div class="info-box">
                <span class="info-box-icon bg-green">
                    <i class="icon-layers"></i>
                </span>
                <div class="info-box-content">
                    <span class="info-box-number">{{teacherNumber |length}}</span>
                    <span class="info-box-text">Nombre Professeurs</span>
                </div>
                <!-- /.info-box-content -->

            </div>
        </a>
    </div>
    {% endif %}
    {% if in_array(session.role, ['ADMINISTRATEUR']) %}


    <div class="col-lg-3 col-xs-6">
        <a href="{{url('emprunt/total/livres_empruntes_etudiant')}}">
            <div class="info-box">
                <span class="info-box-icon bg-danger">
                    <i class="icon-layers"></i>
                </span>
                <div class="info-box-content">
                    <span class="info-box-number">{{totalEmpruntEtudiant |length}}</span>
                    <span class="info-box-text">Total Livres empruntés | Étudiant</span>
                </div>
                <!-- /.info-box-content -->
                
            </div>
        </a>
    </div>
    {% endif %}
    {% if in_array(session.role, ['ADMINISTRATEUR']) %}


    <div class="col-lg-3 col-xs-6">
        <a href="{{url('emprunt/total/livres_retournes_etudiant')}}">
            <div class="info-box">
                <span class="info-box-icon bg-blue">
                    <i class="icon-layers"></i>
                </span>
                <div class="info-box-content">
                    <span class="info-box-number">{{totalEmpruntRetounerEtudiant |length}}</span>
                    <span class="info-box-text">Total Livres retournés | Étudiant</span>
                </div>
                <!-- /.info-box-content -->
                
            </div>
        </a>
    </div>
    {% endif %}
    {% if in_array(session.role, ['ADMINISTRATEUR']) %}


    <div class="col-lg-3 col-xs-6">
        <a href="{{url('emprunt/total/livres_empruntes_professeur')}}">
            <div class="info-box">
                <span class="info-box-icon bg-danger">
                    <i class="icon-layers"></i>
                </span>
                <div class="info-box-content">
                    <span class="info-box-number">{{totalEmpruntProfesseur |length}}</span>
                    <span class="info-box-text">Total Livres empruntés | Professeur</span>
                </div>
                <!-- /.info-box-content -->
                
            </div>
        </a>
    </div>
    {% endif %}
    {% if in_array(session.role, ['ADMINISTRATEUR']) %}


    <div class="col-lg-3 col-xs-6">
        <a href="{{url('emprunt/total/livres_retournes_professeur')}}">
            <div class="info-box">
                <span class="info-box-icon bg-blue">
                    <i class="icon-layers"></i>
                </span>
                <div class="info-box-content">
                    <span class="info-box-number">{{totalEmpruntRetounerProfesseur |length}}</span>
                    <span class="info-box-text">Total Livres retournés | Professeur</span>
                </div>
                <!-- /.info-box-content -->
                
            </div>
        </a>
    </div>
    {% endif %}

    {% if in_array(session.role, ['PROFESSEUR']) %}

    <div class="col-lg-3 col-xs-6">
        <a href="{{url('emprunt/index/livres_empruntes')}}">
            <div class="info-box">
                <span class="info-box-icon bg-green">
                    <i class="icon-layers"></i>
                </span>
                <div class="info-box-content">
                    <span class="info-box-number">{{teacherIssueReturn |length}}</span>
                    <span class="info-box-text">Livres empruntés & retournés</span>
                </div>
                <!-- /.info-box-content -->

            </div>
        </a>
    </div>
    {% endif %}
    {% if in_array(session.role, ['ETUDIANT']) %}

    <div class="col-lg-3 col-xs-6">
        <a href="{{url('emprunt/index/livres_empruntes')}}">
            <div class="info-box">
                <span class="info-box-icon bg-green">
                    <i class="icon-layers"></i>
                </span>
                <div class="info-box-content">
                 <span class="info-box-number">{{studentIssueReturn |length}}</span>
                 <span class="info-box-text">Livres empruntés & retournés</span>
             </div>
             <!-- /.info-box-content -->

         </div>
     </a>
 </div>
 {% endif %}
 <!-- /.col -->
 {% if in_array(session.role, ['PROFESSEUR']) %}
 <div class="col-lg-3 col-xs-6">
    <a href="{{url('emprunt/index/non-retourne')}}">
        <div class="info-box">
            <span class="info-box-icon bg-red">
                <i class="icon-layers"></i>
            </span>
            <div class="info-box-content">
                <span class="info-box-number">{{teacherNotReturn |length}}</span>
                <span class="info-box-text">Livres non retournés</span>
            </div>
            <!-- /.info-box-content -->

        </div>
    </a>
</div>
{% endif %}
{% if in_array(session.role, ['ETUDIANT']) %}
<div class="col-lg-3 col-xs-6">
    <a href="{{url('emprunt/index/non-retourne')}}">
        <div class="info-box">
            <span class="info-box-icon bg-red">
                <i class="icon-layers"></i>
            </span>
            <div class="info-box-content">
                <span class="info-box-number">{{studentNotReturn |length}}</span>
                <span class="info-box-text">Livres non retournés</span>
            </div>
            <!-- /.info-box-content -->

        </div>
    </a>
</div>
{% endif %}
{% if in_array(session.role, ['ADMINISTRATEUR']) %}
<div class="col-lg-3 col-xs-6">
    <a href="{{url('cycle')}}">
        <div class="info-box">
            <span class="info-box-icon bg-yellow">
                <i class="icon-layers"></i>
            </span>
            <div class="info-box-content">
                <span class="info-box-number">{{cycles |length}}</span>
                <span class="info-box-text">Total Cycles</span>
            </div>
            <!-- /.info-box-content -->

        </div>
    </a>
</div>
{% endif %}
{% if in_array(session.role, ['ADMINISTRATEUR']) %}
<div class="col-lg-3 col-xs-6">
    <a href="{{url('casier')}}">
        <div class="info-box">
            <span class="info-box-icon bg-yellow">
                <i class="icon-layers"></i>
            </span>
            <div class="info-box-content">
                <span class="info-box-number">{{casiers |length}}</span>
                <span class="info-box-text">Total Casiers</span>
            </div>
            <!-- /.info-box-content -->
        </div>
    </a>
</div>
{% endif %}
{% if in_array(session.role, ['ADMINISTRATEUR']) %}

<div class="col-lg-3 col-xs-6">
    <a href="{{url('ranger')}}">
        <div class="info-box">
            <span class="info-box-icon bg-yellow">
                <i class="icon-layers"></i>
            </span>
            <div class="info-box-content">
                <span class="info-box-number">{{rangers |length}}</span>
                <span class="info-box-text">Total Rangées</span>
            </div>
            <!-- /.info-box-content -->

        </div>
    </a>
</div>
{% endif %}
{% if in_array(session.role, ['ADMINISTRATEUR','PROFESSEUR']) or in_array(session.libelle, ['LICENCE','MASTER','DOCTORAT']) %}
<div class="col-lg-3 col-xs-6">
    <a href="{{url('memoire')}}">
        <div class="info-box">
            <span class="info-box-icon bg-yellow">
                <i class="icon-layers"></i>
            </span>
            <div class="info-box-content">
                <span class="info-box-number">{{memoires |length}}</span>
                <span class="info-box-text">Total Mémoires</span>
            </div>
            <!-- /.info-box-content -->
        </div>
    </a>
</div>
{% endif %}
<!-- /.col -->
</div>
<div class="row">
    {% if in_array(session.role, ['ADMINISTRATEUR','ETUDIANT']) %}
    <div  class="col-lg-7 col-xlg-9">
      <div class="info-box">
        <div class="d-flex flex-wrap">
          <div>
            <h4 class="text-black">Graphe de production des étudiants</h4>
        </div>
        <div class="ml-auto">
            <ul class="list-inline">

            </ul>
        </div>
    </div>
    <div>
      <canvas id="line-chart"></canvas>
  </div>
</div>
</div>
{% endif %}
<div class="col-lg-5 col-xlg-3">
  <div class="info-box">
    <div class="d-flex flex-wrap">
      <div>
        <h4 class="text-black">Nombre d'étudiants inscrit par cycle</h4>
    </div>
</div>
<div class="m-t-2">
 <canvas id="pie-chart" height="210"></canvas>
</div>
</div>
</div>
{% if in_array(session.role, ['ADMINISTRATEUR']) %}
<div class="col-lg-6 col-xlg-6" >
    <div class="info-box">
        <div class="d-flex flex-wrap">
            <span class="text-black">LES 5 DERNIERS ETUDIANTS INSCRITS</span>
            <hr/>
            <div class="table-responsive">
                <table id="dataList" class="table table-bordered table-hover" data-name="cool-table">
                    <thead>
                        <tr>
                            <th>ID #</th>
                            <th>Matricule</th>
                            <th>Nom de l'étudiant</th>
                            <th>Cycle</th>
                            <th>Adresse e-mail</th>

                        </tr>
                    </thead>
                    <tbody>

                        {% for k,lastStudent in lastStudents %}
                        <tr>
                            <td>{{k+1}}</td>
                            <td>
                                <div class="media align-items-center">
                                    <div class="media-img-wrap d-flex mr-10">
                                        <div class="avatar avatar-sm">
                                            
                                            <span class="avatar-text avatar-text-purple rounded-circle">
                                                <span class="initial-wrap">
                                                    <span>{{lastStudent.initials}}</span>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                                    
                                    <div class="media-body">
                                        <div class="text-capitalize font-weight-500 text-dark">
                                            <span>{{lastStudent.matricule}}</span>
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <td>{{lastStudent.prenom}}
                            {{lastStudent.nom |upper}}</td>
                            <td>{{lastStudent.getCycle().libelle}}/{{lastStudent.getFiliere().libelle}}</td>
                            <td>{{lastStudent.email}}</td>

                        </tr>
                        {% endfor %}
                    </tbody>

                </table>
            </div>
        </div>
    </div>
</div>

{% endif %}

{% if in_array(session.role, ['ADMINISTRATEUR']) %}
<div class="col-lg-6 col-xlg-6">
    <div class="info-box">
        <div class="d-flex flex-wrap">
            <span class="text-black">LES 5 DERNIERS PROFESSEURS INSCRITS</span>
            <hr/>
            <div class="table-responsive">
                <table id="dataList1" class="table table-bordered table-hover" data-name="cool-table">
                    <thead>
                        <tr>
                            <th>ID #</th>
                            <th>Matricule</th>
                            <th>Nom du professeur</th>
                            <th>Adresse e-mail</th>

                        </tr>
                    </thead>
                    <tbody>
                        {% for k,lastTeacher in lastTeachers %}
                        <tr>
                            <td>{{k+1}}</td>
                            <td>
                                <div class="media align-items-center">
                                    <div class="media-img-wrap d-flex mr-10">
                                        <div class="avatar avatar-sm">
                                            
                                            <span class="avatar-text avatar-text-teal rounded-circle">
                                                <span class="initial-wrap">
                                                    <span>{{lastTeacher.initials}}</span>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                                    
                                    <div class="media-body">
                                        <div class="text-capitalize font-weight-500 text-dark">
                                            <span>{{lastTeacher.matricule}}</span>
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <td>{{lastTeacher.prenom}}
                            {{lastTeacher.nom |upper}}</td>
                            <td>{{lastTeacher.email}}</td>

                        </tr>
                        {% endfor %}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
{% endif %}
{% if in_array(session.role, ['ADMINISTRATEUR','PROFESSEUR']) %}
<div  class="col-lg-7 col-xlg-9">
  <div class="info-box">
    <div class="d-flex flex-wrap">
      <div>
        <h4 class="text-black">Graphe de production des professeurs</h4>
    </div>
    <div class="ml-auto">
        <ul class="list-inline">

        </ul>
    </div>
</div>
<div>
  <canvas id="line-chart2"></canvas>
</div>
</div>
</div>
{% endif %}
</div>
</div>

{% endblock %}
{% block addjs %}
<!-- Toast JavaScript --> 
<script src="{{url('template/jquery-toast-plugin/dist/jquery.toast.min.js')}}"></script>
<script src="{{url('template/js/dashboard-data.js')}}"></script>
<!-- Chartjs JavaScript --> 
<script src="{{url('template/plugins/chartjs/chart.min.js')}}"></script>
<script src="{{url('template/c3-charts/c3.min.js')}}"></script>
<script src="{{url('template/c3-charts/d3.min.js')}}"></script>
<script>
// ======
// line chart
// ======   
var ctx = document.getElementById('line-chart').getContext('2d');
var chart = new Chart(ctx, {
    // The type of chart we want to create
    type: 'line',

    // The data for our dataset
    data: {{fiches_graph}},
    options: {
        responsive: true
    }
});
</script>
<script>
// ======
// line chart
// ======
var ctx = document.getElementById('line-chart2').getContext('2d');
var chart = new Chart(ctx, { // The type of chart we want to create
    type: 'line',

// The data for our dataset
data: {{ fiches_graph2 }},
options: {
    responsive: true
}
});
</script>
<script>
// ======
// Pie chart
// ======
new Chart(document.getElementById("pie-chart"), {
    type: 'pie',
    data: {
        labels: [
        {% for p,stat in studentStatByCycle %}'{{ stat.cycle }}'{% if p < studentStatByCycle |length - 1 %},{% endif %}
        {% endfor %},{% if in_array(session.role, ['ADMINISTRATEUR','PROFESSEUR']) %}'PROFESSEUR'{% endif %}
        ],
        datasets: [
        {
            'label': 'My First Dataset',
            data: [
            {% for p,stat in studentStatByCycle %}
            {{ stat.number }}{% if p < studentStatByCycle |length - 1 %},{% endif %}
            {% endfor %},{% if in_array(session.role, ['ADMINISTRATEUR','PROFESSEUR']) %}{{teacherNumber |length}}{% endif %}
            ],
            backgroundColor: [
            'rgb(230, 150, 245)',
            'rgb(54, 162, 235)',
            'rgb(255, 230, 86)',
            'rgb(255, 70, 80)',
            'rgb(190, 200, 230)'
            ]
        }
        ]
    },

    options: {
        responsive: true
    },
});
</script>
{% endblock %}