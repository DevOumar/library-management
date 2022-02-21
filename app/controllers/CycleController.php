<?php
declare(strict_types=1);

class CycleController extends ControllerBase
{


    public function indexAction(int $id = null)
    {
        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }

        $this-> view ->cycles= Cycle::find();
        $cycleForm = new CycleForm();

        $this->view->form = $cycleForm;

        if($id > 0){

            $cycle= Cycle::findFirst($id);

            $values = (array)$cycle;
            
            $this->tag->setDefaults($values);
            
            $cycleForm = new CycleForm();
            
            if($this->request->isPost()){
                $data = $this->request->getPost();
                
                $cycle = Cycle::findFirst($id);
                
                if($cycleForm->isValid($data, $cycle)){
                    $cycle->update_date = date('Y-m-d H:i:s');
                    if(!$cycle->save()){

                    }
                    
                    $this->flash->success("Objet modifié avec succès !"); 
                    $this->response->redirect("cycle");
                }
            }
            $this->view->form = $cycleForm;
            $this->view->cycle = $cycle;
        }



        
    }


    public function newAction(){

        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }

        if($this->request->isPost()){
            $data = $this->request->getPost();
            $verifCycleExist  = Cycle::findFirst(['libelle = :libelle:', 
             'bind' => [
                'libelle' => $data['libelle'],
            ]
        ]);
            $cycleForm = new CycleForm();

            if($verifCycleExist){
                $this->flash->error("Le cycle ".$data['libelle']." a déjà été ajouté !");
                return $this->response->redirect("cycle");

            }
            
            $cycle = new Cycle();
            if($cycleForm->isValid($data, $cycle)){
                if(!$cycle->save()){
                }
                $this->flash->success("Le cycle ".strtoupper($cycle->libelle)." a été ajouté avec succès !");
                $this->response->redirect("cycle");
            }
        }
        $cycleForm = new CycleForm();

        $this->view->form = $cycleForm;
    }

    public function deleteAction($id){

        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }


        if($id > 0){
            $elm = Cycle::findFirst($id);
            
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
