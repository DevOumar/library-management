<?php
declare(strict_types=1);

class CasierController extends ControllerBase
{


    public function indexAction(int $id = null)
    {
        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }

        $this-> view ->casiers= Casier::find();
        $casierForm = new CasierForm();

        $this->view->form = $casierForm;

        if($id > 0){

            $casier= Casier::findFirst($id);
            

            $values = (array)$casier;
            
            $this->tag->setDefaults($values);
            
            $casierForm = new CasierForm();
            
            if($this->request->isPost()){
                $data = $this->request->getPost();
                
                $casier = Casier::findFirst($id);
                
                if($casierForm->isValid($data, $casier)){
                    $casier->update_date = date('Y-m-d H:i:s');
                    if(!$casier->save()){

                    }
                    
                    $this->flash->success("Objet modifié avec succès !"); 
                    $this->response->redirect("casier");
                }
            }
            $this->view->form = $casierForm;
            $this->view->casier = $casier;
        }



        
    }


    public function newAction(){

        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }

        if($this->request->isPost()){
            $data = $this->request->getPost();
            $verifCasierExist  = Casier::findFirst(['libelle = :libelle:', 
             'bind' => [
                'libelle' => $data['libelle'],
            ]
        ]);
            $casierForm = new CasierForm();

            if($verifCasierExist){
                $this->flash->error("Le casier ".$data['libelle']." a déjà été ajouté !");
                return $this->response->redirect("casier");
            }
            
            $casier = new Casier();
            if($casierForm->isValid($data, $casier)){
                if(!$casier->save()){
                }
                $this->flash->success("Le casier ".strtoupper($casier->libelle)." a été ajouté avec succès !");
                $this->response->redirect("casier");
            }
        }
        $casierForm = new CasierForm();

        $this->view->form = $casierForm;
    }

    public function deleteAction($id){

        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }


        if($id > 0){
            $elm = Casier::findFirst($id);
            
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
