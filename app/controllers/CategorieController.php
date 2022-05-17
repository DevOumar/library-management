<?php
declare(strict_types=1);

class CategorieController extends ControllerBase
{


    public function indexAction(int $id = null)
    {

        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }

        $this-> view ->categories= Categorie::find();
        $categorieForm = new CategorieForm();

        $this->view->form = $categorieForm;

        if($id > 0){

            $categorie= Categorie::findFirst($id);

            $values = (array)$categorie;
            
            $this->tag->setDefaults($values);
            
            $categorieForm = new CategorieForm();
            
            if($this->request->isPost()){
                $data = $this->request->getPost();
                
                $categorie = Categorie::findFirst($id);
                
                if($categorieForm->isValid($data, $categorie)){
                    $categorie->update_date = date('Y-m-d H:i:s');
                    if(!$categorie->save()){

                    }
                    
                    $this->flash->success("Objet modifié avec succès !"); 
                    $this->response->redirect("categorie");
                }
            }
            $this->view->form = $categorieForm;
            $this->view->categorie = $categorie;
        }



        
    }


    public function newAction(){

        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }

        if($this->request->isPost()){
            $data = $this->request->getPost();
            $verifCategorieExist  = Categorie::findFirst(['libelle = :libelle:', 
               'bind' => [
                'libelle' => $data['libelle'],
            ]
        ]);
            $categorieForm = new CategorieForm();

            if($verifCategorieExist){
                $this->flash->error("La catégorie ".$data['libelle']." a déjà été ajoutée !");
                return $this->response->redirect("categorie");
            }
            
            $categorie = new Categorie();
            if($categorieForm->isValid($data, $categorie)){
                $categorie->status = 1;
                if(!$categorie->save()){
                   
                }
                $this->flash->success("La catégorie ".strtoupper($categorie->libelle)." a été ajoutée avec succès !");
                $this->response->redirect("categorie");
            }
        }

        $categorieForm = new CategorieForm();
        $this->view->form = $categorieForm;

    }

    public function updateStatusAction($id)
    {   
        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }

        $categorie = Categorie::findFirst($id);

        if($categorie->status == true){
            $categorie->status = false;
            $categorie->save();
            
            echo 1;exit;
        }
        else{
            $categorie->status = true;
            $categorie->save();
            echo 1;exit;
        }

        echo 0;exit;

    }

    public function deleteAction($id){

        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }


        if($id > 0){
            $elm = Categorie::findFirst($id);
            
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
