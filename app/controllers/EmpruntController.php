<?php

declare(strict_types=1);

use \Mpdf\Mpdf as MMpdf;

class EmpruntController extends ControllerBase
{

 public function indexAction($type = null)
 {

    if ($this->session->role != "ADMINISTRATEUR" && $type == null) {
        $this->response->redirect("errors/show403");
        return;
    }

    $user_id = $this->session->get('id');
    $user = Users::findFirst($user_id);


        // Total livre non retourné partie dashboard
    if ($type == "non-retourne") {
        if ($this->session->get('role') == "ETUDIANT") {
            $user =  Users::findFirst($user_id);

            $this->view->emprunts = Emprunt::find(["retour_status = 0 AND user_id = '" . $user->id . "'"]);
        } elseif($this->session->get('role') == "PROFESSEUR") {
            $user =  Users::findFirst($user_id);
            $this->view->emprunts = Emprunt::find(["retour_status = 0 AND user_id = '" . $user->id . "'"]);

        }

    }else{
        $this->view->emprunts = Emprunt::find();
    } 

        // Total livre emprunté partie dashboard
    if ($type == "livres_empruntes") {
        if ($this->session->get('role') == "ETUDIANT") {
            $user =  Users::findFirst($user_id);

            $this->view->emprunts = Emprunt::find(["retour_status = 1 AND user_id = '" . $user->id . "'"]);
        } elseif($this->session->get('role') == "PROFESSEUR") {
            $user =  Users::findFirst($user_id);

            $this->view->emprunts = Emprunt::find(["retour_status = 1 AND user_id = '" . $user->id . "'"]);
        }

    }


}



public function totalAction($filter = null)
{
    if ($this->session->role != "ADMINISTRATEUR") {
        $this->response->redirect("errors/show403");
        return;
    }

    $today = date('Y-m-d');
    $mois = $this->mois($today);
    $builder = $this->modelsManager->createBuilder();
    $req = $builder->columns("e.id, e.user_id, e.id_livre, e.date_emprunt, e.retour_emprunt, e.retour_status, e.delai_livre, e.amende, DATE_FORMAT(e.create_date, '%d/%m/%Y \à %H:%i') as ajoute_le, u.nom, u.prenom, u.role, u.matricule, l.nom_livre, l.isbn, l.id_ranger, l.id_casier, l.nbre_page ")
    ->addfrom("Emprunt", "e")
    ->join('Users', 'e.user_id = u.id', 'u')
    ->join('Livre', 'e.id_livre = l.id', 'l');

    if ($filter == "livres_empruntes_etudiant") {
        $req->where("u.role = 'ETUDIANT' ");
    }
    if ($filter == "livres_retournes_etudiant") {
        $req->andWhere("u.role = 'ETUDIANT' AND e.retour_status = 1 ");

    }
    if ($filter == "livres_empruntes_professeur") {
        $req->where("u.role = 'PROFESSEUR' ");
    }
    if ($filter == "livres_retournes_professeur") {
        $req->andWhere("u.role = 'PROFESSEUR' AND e.retour_status = 1 ");
        
    }
    $emprunt_jour = $builder->getQuery()->execute();
    $this->view->emprunt_jour = $emprunt_jour;


}


public function historiqueAction()
{

    $date_filter = "";
    if ($this->request->isPost()) {
        $start_date_filter = $this->request->getPost('start_date') ? $this->request->getPost('start_date') : "";
        $end_date_filter = $this->request->getPost('end_date') ? $this->request->getPost('end_date') : "";
        $date_filter_chosen_label = $this->request->getPost("date_filter_chosen_label");
        if (strlen($start_date_filter) == 10 && strlen($end_date_filter) == 10) {
            $date_filter = "&start_date={$start_date_filter}&end_date={$end_date_filter}";
            $this->view->start_date = $start_date_filter;
            $this->view->end_date = $end_date_filter;
            $this->view->date_filter_chosen_label = $date_filter_chosen_label;
        }
    }


    $user_id = $this->session->get('id');
    $user = Users::findFirst($user_id);
    $builder = $this->modelsManager->createBuilder();
    $req = $builder->columns("e.id, e.user_id, e.id_livre, e.date_emprunt, e.retour_emprunt, e.retour_status, e.delai_livre, e.amende, DATE_FORMAT(e.create_date, '%d/%m/%Y \à %H:%i') as ajoute_le, u.nom, u.prenom, u.role, u.matricule, l.nom_livre, l.isbn, l.id_ranger, l.id_casier, l.nbre_page ")
    ->addfrom("Emprunt", "e")
    ->join('Users', 'e.user_id = u.id', 'u')
    ->join('Livre', 'e.id_livre = l.id', 'l');


    if($this->session->get('role') == 'ADMINISTRATEUR'){
        $req->where("DATE_FORMAT(e.create_date,'%Y-%m-%d') BETWEEN '".$start_date_filter."' AND '".$end_date_filter."'");
    }

    if($this->session->get('role') == 'ETUDIANT'){
        $req->where("DATE_FORMAT(e.create_date,'%Y-%m-%d') BETWEEN '".$start_date_filter."' AND '".$end_date_filter."' AND user_id = '" . $user->id . "'");
    }

    if($this->session->get('role') == 'PROFESSEUR'){
        $req->where("DATE_FORMAT(e.create_date,'%Y-%m-%d') BETWEEN '".$start_date_filter."' AND '".$end_date_filter."' AND user_id = '" . $user->id . "'");
    }

    $emprunt_filter_etudiant = $builder->getQuery()->execute();
    $this->view->emprunt_filter_etudiant = $emprunt_filter_etudiant;

}

public function newAction()
{
    if ($this->session->role != "ADMINISTRATEUR") {
        $this->response->redirect("errors/show403");
        return;
    }

    $empruntForm = new EmpruntForm();

    if ($this->request->isPost()) {
        $data = $this->request->getPost();
        
        $verifEmpruntExist  = Emprunt::findFirst([
            'user_id = :user_id:',
            'bind' => [
                'user_id' => $data['user_id'],
            ]
        ]);
            // On recupere le nombre d'emprunt
        $emprunts_non_retourne = Emprunt::count(['retour_status = 0  AND user_id = :user_id:', 'bind' => ['user_id' => $data['user_id']]]);

        if ($emprunts_non_retourne >= 2) {

            $this->flash->error("Désolé, vous avez déjà deux livres non retournés !");
            $this->tag->setDefaults($data);
            $this->view->form = $empruntForm;
            $this->view->disable();
            $this->view->partial('emprunt/new');
            return;
        }

        $emprunt = new Emprunt();
        if ($empruntForm->isValid($data, $emprunt)) {
            $emprunt->retour_status = 0;
            $emprunt->id_livre = $emprunt->id_livre;

            if (!$emprunt->save()) {

            }
            $this->flash->success("L'emprunt du livre [ " . ($emprunt->getLivre()->nom_livre) . " ]  est effectué avec succès !");
            $this->response->redirect("emprunt");
        }
    }
    $empruntForm = new EmpruntForm();

    $this->view->form = $empruntForm;
}

public function detailsAction($id = null){

    if ($id == null || !is_numeric($id)) {
       $this->flash->error("Objet introuvable !");
       $this->response->redirect("emprunt");
       return;

   }

   $user_id = $this->session->get('id');
   $user = Users::findFirst($user_id);

   if($id > 0){
    $emprunt = Emprunt::findFirst($id);

    if(!$emprunt ){

        $this->response->redirect("errors/show404");

        return;
    }

    if ($this->session->role != "ADMINISTRATEUR") {
        if ($user_id !== $emprunt->user_id) {
            $this->response->redirect("errors/show403");
            return;
        }
    }


    $this->view->emprunt = $emprunt;

}else{
    $this->flash->error("Erreur de requête !"); 
    $this->response->redirect("emprunt");

}
}


public function editAction($id = null)
{

    if ($this->session->role != "ADMINISTRATEUR") {
        $this->response->redirect("errors/show403");
        return;
    }

    if ($id == null || !is_numeric($id)) {
       $this->flash->error("Objet introuvable !");
       $this->response->redirect("emprunt");
       return;

   }

    if ($id == null) {

        $this->response->redirect("errors/show403");
        return;
    }


    if ($id > 0) {

        $emprunt = Emprunt::findFirst($id);
        if (!$emprunt) {
            $this->flash->error("Objet introuvable !");
            $this->response->redirect("emprunt");
            return;
        }

        $values = (array)$emprunt;

        $this->tag->setDefaults($values);

        $empruntForm = new EmpruntForm();

        if ($this->request->isPost()) {
            $data = $this->request->getPost();

            $emprunt = Emprunt::findFirst($id);

            if ($empruntForm->isValid($data, $emprunt)) {
                $emprunt->retour_status = 1;
                $emprunt->retour_emprunt = date('Y-m-d H:i:s');
                $emprunt->amende = $emprunt->amende;

                if (!$emprunt->save()) {
                }

                $this->flash->success("Livre retourné avec succès !");
                $this->response->redirect("emprunt");
            }
        }
        $this->view->form = $empruntForm;
        $this->view->emprunt = $emprunt;
    }
}


public function notifierAction()
{
    if ($this->session->role != "ADMINISTRATEUR") {
        $this->response->redirect("errors/show403");
        return;
    }

    $data = $this->request->getPost();
    $userForm = new UserForm();
    $emprunts_non_retourne = Emprunt::find('retour_status = 0');

    $sendingMail = 0;

    foreach ($emprunts_non_retourne as $key => $emprunt) {
        $date1 = new DateTime("now");
        $date2 = new DateTime($emprunt->delai_livre . ' 23:59:59.999999');

        if ($date1 > $date2) {
            $user = $emprunt->getUsers();
            $mail = new Mail();
            $email = $user->email;
            $params = [
                'nom' => $user->nom,
                'prenom' => $user->prenom,
                'nom_livre' => $emprunt->getLivre()->nom_livre,
                'isbn' => $emprunt->getLivre()->isbn,
                'date_emprunt' => $emprunt->date_emprunt

            ];
            $mail->send($email, 'retarduser-emprunt', $params);
            $sendingMail++;
        }
    }

    if ($sendingMail == 0) {
        $this->flash->error("Notification non envoyée. Aucun délai expiré trouvé !");
        $this->response->redirect("emprunt");
        return;
    }

    $this->flash->success("Notification envoyée avec succès !");
    $this->response->redirect("emprunt");
}


public function pdfAction($id)
{

    $emprunt = Emprunt::findFirst($id);
    if (!$emprunt) {
        $this->flash->error("Objet introuvable !");
        $this->response->redirect("emprunt");
        return;
    }
    $this->response->setHeader('Cache-Control', 'max-age=0');
    $this->response->setHeader('Content-Type', 'application/pdf');
    $this->response->setHeader('Content-Disposition', 'filename="Facture_' . date('d-m-Y') . '.pdf"');
    $this->view->disable();
    $user_id = $this->session->get('id');
    $user = Users::findFirst($user_id);
    $emprunt = Emprunt::findFirst($id);
    if ($this->session->role != "ADMINISTRATEUR") {
        if ($user_id !== $emprunt->user_id) {
            $this->response->redirect("errors/show403");
            return;
        }
    }
    $pdf = $this->view->getRender("emprunt", "pdf", ['emprunt' => $emprunt]);
    $mpdf = new  MMpdf();
        // $mpdf->AddPage('L');
    $pdf = mb_convert_encoding($pdf, 'UTF-8', 'UTF-8');
    $mpdf->WriteHTML($pdf);
    $mpdf->Output();
}

public function verifStockAction($id)
{
    if ($this->session->role != "ADMINISTRATEUR") {
        $this->response->redirect("errors/show403");
        return;
    }

    if ($this->request->isAjax()) {
        $livre = Livre::findFirst($id);
        $livre->getQteStock();

        return json_encode((array)$livre);
    }
}

public function infosAction()
{
    if ($this->session->role != "ADMINISTRATEUR") {
        $this->response->redirect("errors/show403");
        return;
    }
    if ($this->request->isPost()) {
        $data = $this->request->getPost();

        $verifUserExist  = Users::findFirst([
            'matricule = :matricule:',
            'bind' => [
                'matricule' => $data['matricule'],
            ]
        ]);

        if (isset($verifUserExist)) {
           echo json_encode(["error" => false,
            "user"=> $verifUserExist]);
       }else{
        echo json_encode(["error" => true]);
    }
}}

public function deleteAction($id)
{
    if ($this->session->role != "ADMINISTRATEUR") {
        $this->response->redirect("errors/show403");
        return;
    }

    if ($id > 0) {
        $elm = Emprunt::findFirst($id);

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