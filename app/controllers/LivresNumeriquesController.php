<?php

declare(strict_types=1);

use Phalcon\Paginator\Adapter\QueryBuilder;

class LivresNumeriquesController extends ControllerBase
{

    public function indexAction()
    {

        $currentPage = isset($_GET['page']) ? (int) $_GET['page'] : 0;
        $builder = $this->modelsManager->createBuilder();
        $req = $builder->columns("n.id, n.nom_livre, n.nom_auteur, n.description, n.photo, n.file_livre, n.create_date")
        ->addfrom("Numerique", "n");
        $paginator = new QueryBuilder(
            [
                "builder" => $req,
                "limit"   => 10,
                "page"    => $currentPage,
            ]
        );

        $paginate = $paginator->paginate();

        //var_dump($paginate);exit;
        $this->view->paginate = $paginate;

        $this->view->numeriques = Numerique::find();
    }

    public function newAction()
    {

        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }

        $numeriqueForm = new NumeriqueForm();
        if ($this->request->isPost()) {
            $data = $this->request->getPost();
            $numerique = new Numerique();

            if ($numeriqueForm->isValid($data, $numerique)) {
                $numerique->create_date = date('Y-m-d H:i:s');

                if ($this->request->hasFiles() == true) {

                    $files = $this->request->getUploadedFiles();
                    $uploadDirPhoto = FILES_IMAGELIVRE_UPLOAD_DIR;
                    $uploadDirLivre = FILES_LIVRE_UPLOAD_DIR;
                    $extensions = ['jpg', 'png', 'jpeg'];
                    foreach ($files as $key => $file) {



                        if ($file->getSize() > 10000000) {
                            $this->flash->error('Oops! Fichier trop volumineux, la taille maximale acceptée est 10Mo');
                            $this->response->redirect("livres-numeriques");
                            return;
                        }
                        if ($file->getName() != null && $file->getName() != "") {
                            if ($numerique->photo != null && file_exists($uploadDirPhoto . $numerique->photo)) {
                                unlink($uploadDirPhoto . $numerique->photo);
                            }

                            $filename   = uniqid() . '_' . date('d-m-Y') . '.' . $file->getExtension();
                            // Move the file into the application

                            if (in_array(strtolower($file->getExtension()), $extensions)) {
                                $file->moveTo(
                                    $uploadDirPhoto . $filename
                                );
                                $numerique->photo     = $filename;
                            } elseif (in_array(strtolower($file->getExtension()), ["pdf","docx"])) {
                                $file->moveTo(
                                    $uploadDirLivre . $filename
                                );
                                $numerique->file_livre     = $filename;
                            }
                        }
                    }
                }

                if (!$numerique->save()) {

                }
                $this->flash->success("Livre numérique est ajouté avec succès !");
                $this->response->redirect("livres-numeriques");
            } else {

            }
        }

        $this->view->form = $numeriqueForm;
        $this->view->numerique = $numerique;
    }

    public function editAction($id){

        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }

        if($id > 0){

            $numerique= Numerique::findFirst($id);
            if(!$numerique){
                $this->flash->error("Objet introuvable !"); 
                $this->response->redirect("livres-numeriques");
                return;
            }

            $values = (array)$numerique;
            
            $this->tag->setDefaults($values);
            
            $numeriqueForm = new NumeriqueForm();
            
            if($this->request->isPost()){
                $data = $this->request->getPost();
                
                $numerique = Numerique::findFirst($id);
                
                if($numeriqueForm->isValid($data, $numerique)){
                    if(!$numerique->save()){

                    }
                    
                    $this->flash->success("Objet modifié avec succès !"); 
                    $this->response->redirect("livres-numeriques");
                }
            }
            $this->view->form = $numeriqueForm;
            $this->view->numerique = $numerique;
        }
        
    }

    public function detailsAction($id){

        if($id > 0){
         $numerique = Numerique::findFirst($id);

         if(!$numerique){
             $this->flash->error("Objet introuvable !"); 
             $this->response->redirect("livres-numeriques");

             return;
         }

         $this->view->numerique = $numerique;

     }else{
         $this->flash->error("Erreur de requête !"); 
         $this->response->redirect("livres-numeriques");

     }
 }

 public function deleteAction($id)
 {

    if ($this->session->role != "ADMINISTRATEUR") {
        $this->response->redirect("errors/show403");
        return;
    }

    if ($id > 0) {
        $elm = Numerique::findFirst($id);

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
}
