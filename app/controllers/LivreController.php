<?php
declare(strict_types=1);

class LivreController extends ControllerBase
{
    private $srv_notif;

    public function initialize(){
        parent::initialize();
        $this->srv_notif = $this->di->get('srv_notif');
    }

    public function indexAction()
    {


        $livres = Livre::find();
        $this-> view->livres = $livres;


    }

    public function newAction(){

        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }


        if($this->request->isPost()){
            $data = $this->request->getPost();
            $verifLivreExist  = Livre::findFirst(['nom_livre = :nom_livre:', 
               'bind' => [
                'nom_livre' => $data['nom_livre'],
            ]
        ]);
            $livreForm = new LivreForm();

            if($verifLivreExist){
                $this->flash->error("Livre ".$data['nom_livre']." déjà ajouté !");
                $this->tag->setDefaults($data);
                $this->view->form = $livreForm;
                $this->view->disable();
                $this->view->partial('livre/new'); 
                return;
            }

            $livre = new Livre();
            if($livreForm->isValid($data, $livre)){

                if(!$livre->save()){
                }

                // Service de notification
                $message = "Un nouveau livre [".$livre->nom_livre."] a été ajouté par [".$this->session->get('pseudo')."]";
                $url = "livre/details/".$livre->id;
                $admin = true;
                $this->srv_notif->add($message, $url, $admin);

                $this->flash->success("Livre ".strtoupper($livre->nom_livre)." ajouté avec succès !");
                $this->response->redirect("livre");

            }
        }
        $livreForm = new LivreForm();

        $this->view->form = $livreForm;
    }

    public function deleteAction($id){

        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }


        if($id > 0){
            $elm = Livre::findFirst($id);

            if(!$elm){
                echo 0;exit();
            }

            if ($this->request->isAjax()) {
                if (!$elm->delete()) {
                    echo 0;exit();
                }
                else{

                    // Service de notification
                    $message = "Livre [".$elm->nom_livre."] a été supprimé par [".$this->session->get('pseudo')."]";
                    $url = null;
                    $admin = true;
                    $this->srv_notif->add($message, $url, $admin);
                    echo 1;exit();

                    
                }
            }
            echo 0;exit();
        }

        echo 0;exit;
    }

    public function detailsAction($id){



        if($id > 0){
            $livre = Livre::findFirst($id);

            if(!$livre){
                $this->flash->error("Objet introuvable !"); 
                $this->response->redirect("livre");

                return;
            }

            if($notification_id > 0){
                $notification = Notification::findFirst($notification_id);

                $notification->read = true;
                $notification->save();
            }

            $this->view->livre = $livre;
        }else{
            $this->flash->error("Erreur de requête !"); 
            $this->response->redirect("livre");

        }

    }

    public function searchAction(){



        $query = strtolower(trim($this->request->get('query')));
        $livres = [];
        if(strlen($query) > 2 ){
            $builder = $this->modelsManager->createBuilder();
            $req = $builder->columns("l.id, l.nom_livre, l.nbre_page, l.isbn, l.quantite, DATE_FORMAT(l.create_date,'%d/%m/%Y \à %H:%i') as create_date, c.nom_auteur as auteur, ca.libelle as categorie, ra.libelle as ranger, caa.libelle as casier")
            ->addfrom("Livre", "l")
            ->join('Auteur', 'l.id_auteur = c.id', 'c')
            ->join('Categorie', 'l.id_categorie = ca.id', 'ca')
            ->join('Ranger', 'l.id_ranger = ra.id', 'ra')
            ->join('Casier', 'l.id_casier = caa.id', 'caa')
            ->where('LCASE(l.nom_livre) LIKE "%'.$query.'%" OR LCASE(l.isbn) LIKE "%'.$query.'%" OR LCASE(l.nbre_page) LIKE "%'.$query.'%" OR LCASE(l.nbre_page) LIKE "%'.$query.'%" OR LCASE(l.quantite) LIKE "%'.$query.'%" OR "%'.$query.'%"')
            ;

            $livres = $builder->getQuery()->execute();
        }

        $this->view->results = $livres;
        $this->view->query = $query;

    }


    public function editAction($id){

        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }


        if($id > 0){

            $livre = Livre::findFirst($id);
            if(!$livre){
                $this->flash->error("Objet introuvable !"); 
                $this->response->redirect("livre");
                return;
            }

            $values = (array)$livre;

            $this->tag->setDefaults($values);

            $livreForm = new LivreForm();

            if($this->request->isPost()){
                $data = $this->request->getPost();

                $livre = Livre::findFirst($id);

                if($livreForm->isValid($data, $livre)){
                    if(!$livre->save()){

                    }

                    // Service de notification
                    $message = "Livre [".$livre->nom_livre."] a été modifié par [".$this->session->get('pseudo')."]";
                    $url = "livre/details/".$livre->id;
                    $admin = true;
                    $this->srv_notif->add($message, $url, $admin);

                    $this->flash->success("Objet modifié avec succès !"); 
                    $this->response->redirect("livre");
                }
            }
            $this->view->form = $livreForm;
            $this->view->livre = $livre;
        }

    }

}
