<?php
declare(strict_types=1);

class AuteurController extends ControllerBase
{


    public function indexAction(int $id = null)
    {
        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }
        
        
        $this-> view ->auteurs= Auteur::find();
        $auteurForm = new AuteurForm();

        $this->view->form = $auteurForm;

        if($id > 0){

            $auteur= Auteur::findFirst($id);

            $values = (array)$auteur;
            
            $this->tag->setDefaults($values);
            
            $auteurForm = new AuteurForm();
            
            if($this->request->isPost()){
                $data = $this->request->getPost();
                
                $auteur = Auteur::findFirst($id);
                
                if($auteurForm->isValid($data, $auteur)){
                    $auteur->update_date = date('Y-m-d H:i:s');
                    if(!$auteur->save()){

                    }
                    
                    $this->flash->success("Objet modifié avec succès !"); 
                    $this->response->redirect("auteur");
                }
            }
            $this->view->form = $auteurForm;
            $this->view->auteur = $auteur;
        }



        
    }


    public function newAction(){

        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }

        if($this->request->isPost()){
            $data = $this->request->getPost();
            $verifAuteurExist  = Auteur::findFirst(['nom_auteur = :nom_auteur:', 
               'bind' => [
                'nom_auteur' => $data['nom_auteur'],
            ]
        ]);
            $auteurForm = new AuteurForm();

            if($verifAuteurExist){
                $this->flash->error("L'auteur ".$data['nom_auteur']." a déjà été ajouté !");
                return $this->response->redirect("auteur");
            }
            
            $auteur = new Auteur();
            if($auteurForm->isValid($data, $auteur)){
                if(!$auteur->save()){
                }
                $this->flash->success("L'auteur ".strtoupper($auteur->nom_auteur)." a été ajouté avec succès !");
                $this->response->redirect("auteur");
            }
        }
        $auteurForm = new AuteurForm();

        $this->view->form = $auteurForm;
    }

    public function deleteAction($id){

        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }


        if($id > 0){
            $elm = Auteur::findFirst($id);
            
            if(!$elm){
                echo 0;exit();
            }
            
            if ($this->request->isAjax()) {
                if (!$elm->delete()) {
                    echo 0;exit();
                }
                else{
                    echo 1;exit();
                }
            }
            echo 0;exit();
        }
        
        echo 0;exit;
    }


    
}
