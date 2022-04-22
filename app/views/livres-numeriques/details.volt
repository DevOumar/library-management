{% extends 'layouts/base.volt' %}
{% block title %}Détail Livre Numérique{% endblock %}
{% block pageTitle %} Détail Livre Numérique{% endblock %}
{% block breadcrumb %}
    <ol class="breadcrumb">
        <li><a href="{{url('livres-numeriques')}}">Livre numérique</a></li>
        <li><i class="fa fa-angle-right"></i> Détail Numérique</li>
    </ol>
{% endblock %}

{% block content %}
{{flash.output()}}
<div class="row">
<div class="col-lg-4">
        
          <div class="info-box">
            <div class="box-body"> <strong><i class="fa fa-user margin-r-5"></i> Titre du livre</strong>
              <p class="text-muted">{{numerique.nom_livre }}</p>
              <hr>
              <strong><i class="fa fa-user margin-r-5"></i> Auteur du livre</strong>
              <p class="text-muted">{{numerique.nom_auteur }}</p>
              <hr>
              <strong><i class="fa fa-calendar margin-r-5"></i> Date de création </strong>
              <p class="text-muted">{{date("d-m-Y", strtotime(numerique.create_date))}}</p>
              <hr>
            </div>
            <!-- /.box-body --> 
          </div>
        </div>
        <div class="col-lg-8">
          <div class="info-box">
            <div class="card tab-style1"> 
              <!-- Nav tabs -->
              <ul class="nav nav-tabs profile-tab" role="tablist">
                <li class="nav-item">Description du livre</li>
              </ul>
              <!-- Tab panes -->
              <div class="tab-content">
                <div class="tab-pane active" id="home" role="tabpanel" aria-expanded="true">
                  <div class="card-body">
                    <div class="row">
                      <div class="col-lg-2">
                        <div class="user-img pull-left"> <img src="{{url('files/imagelivre_upload/'~numerique.photo)}}" class="img-circle img-responsive" alt="User Image"> </div>
                      </div>
                      <div class="col-lg-10">
                        <div class="mail-contnet">
                          <strong>{{numerique.nom_livre |upper }}</strong>
                          <p>{{numerique.description }}</p>
                          <a href="{{url('files/livre_upload/'~numerique.file_livre)}}" class="btn btn-success" target="_blank">
                            <i class="fa fa-download"></i>
                            Télécharger</a>
                            <a href="{{url('livres-numeriques')}}" class="btn btn-info">
                                <i class="fa fa-close"></i>
                                Annuler</a>
                         
                        </div>
                      </div>
                    </div>
                    
                    
                  </div>
                </div>    
                    </div>
    
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- Main row --> 
    </div>
    <!-- /.content --> 
  </div>
  {% endblock %}