<?php

declare(strict_types=1);

class RecommandationController extends ControllerBase
{


    public function indexAction()
    {

        // Filtrage des recommandations par rôle
        $user_id = $this->session->get('id');
        
        if ($this->session->get('role') == "ETUDIANT") {
            $user =  Users::findFirst($user_id);
            $this->view->recommandations = Recommandation::find(["user_id = '" . $user->id . "'"]);
        }
        elseif ($this->session->get('role') == "PROFESSEUR") {
            $user =  Users::findFirst($user_id);
            $this->view->recommandations = Recommandation::find(["user_id = '" . $user->id . "'"]);
        }else{
            $this->view->recommandations = Recommandation::find();
        }

    }
    public function newAction()
    {


        if ($this->request->isPost()) {
            $data = $this->request->getPost();
            $recommandationForm = new RecommandationForm();
            $recommandation = new Recommandation();
            if ($recommandationForm->isValid($data, $recommandation)) {
                $recommandation->user_id = $this->session->get('id');
                $recommandation->create_date = date('Y-m-d H:i:s');

                if (!$recommandation->save()) {
                }
                $this->flash->success("Recommandation " . strtoupper($recommandation->nom_livre) . " a été envoyée avec succès !");
                $this->response->redirect("recommandation");
            }
        }
        $recommandationForm = new RecommandationForm();

        $this->view->form = $recommandationForm;
    }

    public function detailsAction($id){

        if($id > 0){
         $recommandation = Recommandation::findFirst($id);

         if(!$recommandation){
             $this->flash->error("Objet introuvable !"); 
             $this->response->redirect("recommandation");

             return;
         }

         $this->view->recommandation = $recommandation;

     }else{
         $this->flash->error("Erreur de requête !"); 
         $this->response->redirect("recommandation");

     }
 }

 public function deleteAction($id)
 {


    if ($id > 0) {
        $elm = Recommandation::findFirst($id);

        if (!$elm) {
            echo 0;
            exit();
        }

        if ($this->request->isAjax()) {
            if (!$elm->delete()) {
                echo 0;
                exit();
            } else {
                echo 1;
                exit();
            }
        }
        echo 0;
        exit();
    }

    echo 0;
    exit;
}


public function editAction($id)
{


    if ($id > 0) {

        $recommandation = Recommandation::findFirst($id);
        if (!$recommandation) {
            $this->flash->error("Objet introuvable !");
            $this->response->redirect("recommandation");
            return;
        }

        $values = (array)$recommandation;

        $this->tag->setDefaults($values);

        $recommandationForm = new RecommandationForm();

        if ($this->request->isPost()) {
            $data = $this->request->getPost();

            $recommandation = Recommandation::findFirst($id);

            if ($recommandationForm->isValid($data, $recommandation)) {
                if (!$recommandation->save()) {
                }

                $this->flash->success("Recommandation modifiée avec succès !");
                $this->response->redirect("recommandation");
            }
        }
        $this->view->form = $recommandationForm;
        $this->view->recommandation = $recommandation;
    }
}
}
