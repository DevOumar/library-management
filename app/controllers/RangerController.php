<?php
declare(strict_types=1);

class RangerController extends ControllerBase
{


    public function indexAction(int $id = null)
    {

        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }

        $this-> view ->rangers= Ranger::find();
        $rangerForm = new RangerForm();

        $this->view->form = $rangerForm;

        if($id > 0){

            $ranger= Ranger::findFirst($id);

            $values = (array)$ranger;
            
            $this->tag->setDefaults($values);
            
            $rangerForm = new RangerForm();
            
            if($this->request->isPost()){
                $data = $this->request->getPost();
                
                $ranger = Ranger::findFirst($id);
                
                if($rangerForm->isValid($data, $ranger)){
                    $ranger->update_date = date('Y-m-d H:i:s');
                    if(!$ranger->save()){

                    }
                    
                    $this->flash->success("Objet modifié avec succès !"); 
                    $this->response->redirect("ranger");
                }
            }
            $this->view->form = $rangerForm;
            $this->view->ranger = $ranger;
        }



        
    }


    public function newAction(){

        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }

        if($this->request->isPost()){
            $data = $this->request->getPost();
            $verifRangerExist  = Ranger::findFirst(['libelle = :libelle:', 
             'bind' => [
                'libelle' => $data['libelle'],
            ]
        ]);
            $rangerForm = new RangerForm();

            if($verifRangerExist){
                $this->flash->error("La rangée ".$data['libelle']." a déjà été ajoutée !");
                return $this->response->redirect("ranger");
            }
            
            $ranger = new Ranger();
            if($rangerForm->isValid($data, $ranger)){
                if(!$ranger->save()){
                }
                $this->flash->success("La rangée ".strtoupper($ranger->libelle)." a été ajoutée avec succès !");
                $this->response->redirect("ranger");
            }
        }
        $rangerForm = new RangerForm();

        $this->view->form = $rangerForm;
    }

    public function deleteAction($id){

        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }


        if($id > 0){
            $elm = Ranger::findFirst($id);
            
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
