<?php
declare(strict_types=1);

class FiliereController extends ControllerBase
{


    public function indexAction(int $id = null)
    {
        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }

        $this-> view ->filieres = Filiere::find();
        $filiereForm = new FiliereForm();

        $this->view->form = $filiereForm;

        if($id > 0){

            $filiere= Filiere::findFirst($id);

            $values = (array)$filiere;
            
            $this->tag->setDefaults($values);
            
            $filiereForm = new FiliereForm();
            
            if($this->request->isPost()){
                $data = $this->request->getPost();
                
                $filiere = Filiere::findFirst($id);
                
                if($filiereForm->isValid($data, $filiere)){
                    $filiere->update_date = date('Y-m-d H:i:s');
                    if(!$filiere->save()){

                    }
                    
                    $this->flash->success("Objet modifié avec succès !"); 
                    $this->response->redirect("filiere");
                }
            }
            $this->view->form = $filiereForm;
            $this->view->filiere = $filiere;
        }



        
    }


    public function newAction(){

        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }

        if($this->request->isPost()){
            $data = $this->request->getPost();
            $verifFiliereExist  = Filiere::findFirst(['libelle = :libelle:', 
             'bind' => [
                'libelle' => $data['libelle'],
            ]
        ]);
            $filiereForm = new FiliereForm();

            if($verifFiliereExist){
                $this->flash->error("La filière ".$data['libelle']." a déjà été ajoutée !");
                return $this->response->redirect("filiere");
            }
            
            $filiere = new Filiere();
            if($filiereForm->isValid($data, $filiere)){
                if(!$filiere->save()){

                }
                $this->flash->success("La filière ".strtoupper($filiere->libelle)." a été ajoutée avec succès !");
                $this->response->redirect("filiere");
            }
        }
        $filiereForm = new FiliereForm();

        $this->view->form = $filiereForm;
    }

    public function deleteAction($id){

        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }


        if($id > 0){
            $elm = Filiere::findFirst($id);
            
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
