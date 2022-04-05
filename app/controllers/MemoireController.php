<?php
declare(strict_types=1);

class MemoireController extends ControllerBase
{


    public function indexAction()
    {

        $this-> view ->memoires= Memoire::find();

    }


    public function newAction(){

        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }

        

        if($this->request->isPost()){
            $data = $this->request->getPost();
            $memoire = new Memoire();
            $memoireForm = new MemoireForm();
            if($memoireForm->isValid($data, $memoire)){

                if(!$memoire->save()){

                }

                $this->flash->success("Mémoire ".strtoupper($memoire->nom_memoire)." ajouté avec succès !");
                $this->response->redirect("memoire");
            }
        }
        $memoireForm = new MemoireForm();

        $this->view->form = $memoireForm;
    }



    public function detailsAction($id = null){

        if ($id == null || !is_numeric($id)) {
         $this->flash->error("Objet introuvable !");
         $this->response->redirect("memoire");
         return;

     }



     if($id > 0){
        $memoire = Memoire::findFirst($id);

        if(!$memoire){
            $this->flash->error("Objet introuvable !"); 
            $this->response->redirect("memoire");

            return;
        }

        $this->view->memoire = $memoire;

    }else{
        $this->flash->error("Erreur de requête !"); 
        $this->response->redirect("memoire");

    }
}


public function editAction($id = null){

    if ($this->session->role != "ADMINISTRATEUR") {
        $this->response->redirect("errors/show403");
        return;
    }

    if ($id == null || !is_numeric($id)) {
       $this->flash->error("Objet introuvable !");
       $this->response->redirect("memoire");
       return;

   }

    if ($id == null) {
        $this->response->redirect("errors/show403");
        return;
    }

    if($id > 0){

        $memoire = Memoire::findFirst($id);
        if(!$memoire){
            $this->flash->error("Objet introuvable !"); 
            $this->response->redirect("memoire");
            return;
        }

        $values = (array)$memoire;

        $this->tag->setDefaults($values);

        $memoireForm = new MemoireForm();

        if($this->request->isPost()){
            $data = $this->request->getPost();

            $memoire = Memoire::findFirst($id);

            if($memoireForm->isValid($data, $memoire)){
                if(!$memoire->save()){

                }

                $this->flash->success("Objet modifié avec succès !"); 
                $this->response->redirect("memoire");
            }
        }
        $this->view->form = $memoireForm;
        $this->view->memoire = $memoire;
    }

}


public function deleteAction($id){

    if ($this->session->role != "ADMINISTRATEUR") {
        $this->response->redirect("errors/show403");
        return;
    }

    if($id > 0){
        $elm = Memoire::findFirst($id);

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
