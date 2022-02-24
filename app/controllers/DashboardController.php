<?php
declare(strict_types=1);

class DashboardController extends ControllerBase
{

    public function indexAction()
    {

    // recupération de tous les livres
        $tbook = Livre::getBook();
        $this->view->tbook = $tbook;
    // affichage total configuratons à la vue
        $this->view->memoires = Memoire::find();
        $this->view->cycles = Cycle::find();
        $this->view->rangers = Ranger::find();
        $this->view->casiers = Casier::find();
        $this->view->auteurs = Auteur::find();
     // récuperation des etudiants par cycle
        $this->view->studentStatByCycle = $this->getFilterStudent();

        $user_id = $this->session->get('id');
        $user = Users::findFirst($user_id);
        $this-> view ->user= $user;

        $logged_user_role = $this->session->get('role');
        // Mes livres empruntés et retournés | professeurs
        $teacherIssueReturn = Emprunt::getTeacherIssueReturn($logged_user_role, $user_id);
        $this->view->teacherIssueReturn = $teacherIssueReturn;

        /// Mes livres empruntés et retournés | étudiants
        $studentIssueReturn = Emprunt::getStudentIssueReturn($logged_user_role, $user_id);
        $this->view->studentIssueReturn = $studentIssueReturn;

        // Mes livres non retournés | professeurs
        $teacherNotReturn = Emprunt::getTeacherNotReturn($logged_user_role, $user_id);
        $this->view->teacherNotReturn = $teacherNotReturn;

        // Mes livres non retournés | étudiants
        $studentNotReturn = Emprunt::getStudentNotReturn($logged_user_role, $user_id);
        $this->view->studentNotReturn = $studentNotReturn;

        // Nombre d'etudiants inscrits
        $studentNumber = Users::getStudentNumber($logged_user_role);
        $this->view->studentNumber = $studentNumber;

         // Nombre professeurs inscrits
        $teacherNumber = Users::getTeacherNumber($logged_user_role);
        $this->view->teacherNumber = $teacherNumber;

        // Liste des 5 derniers étudiants inscrits
        $lastStudents = Users::getLastStudent($logged_user_role);
        $this->view->lastStudents = $lastStudents;
        // Liste des 5 derniers professeurs inscrits
        $lastTeachers = Users::getLastTeacher($logged_user_role);
        $this->view->lastTeachers = $lastTeachers;

        // récuperation Total Livres empruntés | Étudiant
        $builder = $this->modelsManager->createBuilder();
        $req = $builder->columns("e.id, e.user_id, e.id_livre, e.date_emprunt, e.retour_emprunt, e.retour_status, e.delai_livre, e.amende, DATE_FORMAT(e.create_date, '%d/%m/%Y \à %H:%i') as ajoute_le, u.nom, u.prenom, u.role, l.nom_livre, l.isbn, l.id_ranger, l.id_casier, l.nbre_page ")
        ->addfrom("Emprunt", "e")
        ->join('Users', 'e.user_id = u.id', 'u')
        ->join('Livre', 'e.id_livre = l.id', 'l')
        ->where("u.role = 'ETUDIANT'")
        ;

        
        $totalEmpruntEtudiant = $builder->getQuery()->execute();
        $this->view->totalEmpruntEtudiant = $totalEmpruntEtudiant;

        // récuperation Total Livres retournés | Étudiant
        $builder = $this->modelsManager->createBuilder();
        $req = $builder->columns("e.id, e.user_id, e.id_livre, e.date_emprunt, e.retour_emprunt, e.retour_status, e.delai_livre, e.amende, DATE_FORMAT(e.create_date, '%d/%m/%Y \à %H:%i') as ajoute_le, u.nom, u.prenom, u.role, l.nom_livre, l.isbn, l.id_ranger, l.id_casier, l.nbre_page ")
        ->addfrom("Emprunt", "e")
        ->join('Users', 'e.user_id = u.id', 'u')
        ->join('Livre', 'e.id_livre = l.id', 'l')
        ->where("u.role = 'ETUDIANT' AND e.retour_status = 1 ")
        ;
        $totalEmpruntRetounerEtudiant = $builder->getQuery()->execute();
        $this->view->totalEmpruntRetounerEtudiant = $totalEmpruntRetounerEtudiant;

        // récuperation Total Livres empruntés | Professeur
        $builder = $this->modelsManager->createBuilder();
        $req = $builder->columns("e.id, e.user_id, e.id_livre, e.date_emprunt, e.retour_emprunt, e.retour_status, e.delai_livre, e.amende, DATE_FORMAT(e.create_date, '%d/%m/%Y \à %H:%i') as ajoute_le, u.nom, u.prenom, u.role, l.nom_livre, l.isbn, l.id_ranger, l.id_casier, l.nbre_page ")
        ->addfrom("Emprunt", "e")
        ->join('Users', 'e.user_id = u.id', 'u')
        ->join('Livre', 'e.id_livre = l.id', 'l')
        ->where("u.role = 'PROFESSEUR'")
        ;

        
        $totalEmpruntProfesseur = $builder->getQuery()->execute();
        $this->view->totalEmpruntProfesseur = $totalEmpruntProfesseur;

        // récuperation Total Livres retournés | Professeur
        $builder = $this->modelsManager->createBuilder();
        $req = $builder->columns("e.id, e.user_id, e.id_livre, e.date_emprunt, e.retour_emprunt, e.retour_status, e.delai_livre, e.amende, DATE_FORMAT(e.create_date, '%d/%m/%Y \à %H:%i') as ajoute_le, u.nom, u.prenom, u.role, l.nom_livre, l.isbn, l.id_ranger, l.id_casier, l.nbre_page ")
        ->addfrom("Emprunt", "e")
        ->join('Users', 'e.user_id = u.id', 'u')
        ->join('Livre', 'e.id_livre = l.id', 'l')
        ->where("u.role = 'PROFESSEUR' AND e.retour_status = 1 ")
        ;
        $totalEmpruntRetounerProfesseur = $builder->getQuery()->execute();
        $this->view->totalEmpruntRetounerProfesseur = $totalEmpruntRetounerProfesseur;


        // Production des livres empruntés | étudiants
        $builder = $this->modelsManager->createBuilder();
        $req = $builder->columns("YEAR(e.create_date) as year, e.retour_status, e.id,
            MONTH(e.create_date) as month_chiffre, 
            MONTHNAME(e.create_date) as month,
            COUNT(e.id) as nbr")
        ->addfrom('Emprunt', 'e')
        ->join('Users', 'e.user_id = u.id', 'u')
        ->where("u.role = 'ETUDIANT' ")
        ->groupBy('year, month, month_chiffre')
        ->orderBy('year asc, month_chiffre ASC');

        // Mes livres empruntés et retournés | étudiants
        if ($this->session->get('role') == 'ETUDIANT') {
            $req->andWhere("retour_status = 1  AND user_id = '" . $user->id . "'");
        }

        $req = $builder->getQuery()->execute();
        $monthArrayFrench = ["mois", "Jan", "Fév", "Mars", "Avr", "Mai", "Juin", "Juil", "Août", "Sept", "Oct", "Nov", "Déc"];
        $rs = array();
        $rs['data'] = [];
        for ($i = 0; $i < count($req); $i++) {
            $rs['labels'][$i] = $monthArrayFrench[$req[$i]->month_chiffre] . " " . $req[$i]->year;
            $rs['data'][$i] = $req[$i]->nbr;
        }
        
        if ($this->session->get('role') == 'ADMINISTRATEUR') {
            $one = [
                "label" => "livres empruntés",
                "borderColor" => '#006E2E',
                "data" => $rs['data'],
                "fill" => false
            ];
        }
        if ($this->session->get('role') == 'ETUDIANT') {
            $one = [
                "label" => "livres empruntés & retournés",
                "borderColor" => '#006E2E',
                "data" => $rs['data'],
                "fill" => false
            ];
        }


        // Production des livres retournés | étudiants
        $builder = $this->modelsManager->createBuilder();
        $req = $builder->columns("YEAR(emp.create_date) as year, 
            MONTH(emp.create_date) as month_chiffre, 
            MONTHNAME(emp.create_date) as month,
            COUNT(emp.id) as nbr")
        ->addfrom('Emprunt', 'emp')
        ->join('Users', 'emp.user_id = u.id', 'u')
        ->where(" emp.retour_status = 1 AND u.role = 'ETUDIANT'")
        ->groupBy('year, month, month_chiffre')
        ->orderBy('year asc, month_chiffre ASC');


        if ($this->session->get('role') == 'ETUDIANT') {
            $req->where("emp.retour_status = 0 AND user_id = '" . $user->id . "'");
           // var_dump($req);exit;
        }



        $req = $builder->getQuery()->execute();
        $monthArrayFrench = ["mois", "Jan", "Fév", "Mars", "Avr", "Mai", "Juin", "Juil", "Août", "Sept", "Oct", "Nov", "Déc"];
        $rs = array();
        $rs['data'] = [];
        

        for ($i = 0; $i < count($req); $i++) {
            $rs['labels'][$i] = $monthArrayFrench[$req[$i]->month_chiffre] . " " . $req[$i]->year;
            $rs['data'][$i] = $req[$i]->nbr;
        }


        if ($this->session->get('role') == 'ADMINISTRATEUR') {
            $two = [
                "label" => "livres retournés",
                "borderColor" => 'rgb(0, 140, 211)',
                "data" => $rs['data'],
                "fill" => false
            ];
        }
        if ($this->session->get('role') == 'ETUDIANT') {
            $two = [
                "label" => "livres non retournés",
                "borderColor" => 'rgb(0, 140, 211)',
                "data" => $rs['data'],
                "fill" => false
            ];
        }
        



        $data = [
            "labels" => $rs['labels'],
            "datasets" => [
                $one,
                $two
            ]
        ];




        $this->view->fiches_graph = json_encode($data);

        // production des professeurs
        $builders = $this->modelsManager->createBuilder();
        $req = $builders->columns("YEAR(e.create_date) as year, e.retour_status, e.id, 
            MONTH(e.create_date) as month_chiffre, 
            MONTHNAME(e.create_date) as month,
            COUNT(e.id) as nbr")
        ->addfrom('Emprunt', 'e')
        ->join('Users', 'e.user_id = u.id', 'u')
        ->where("u.role = 'PROFESSEUR' ")
        ->groupBy('year, month, month_chiffre')
        ->orderBy('year asc, month_chiffre ASC');

        // Mes livres empruntés et retournés | professeurs
        if ($this->session->get('role') == 'PROFESSEUR') {
            $req->andWhere("retour_status = 1  AND user_id = '" . $user->id . "'");
        }

        $req = $builders->getQuery()->execute();
        $monthArrayFrench = ["mois", "Jan", "Fév", "Mars", "Avr", "Mai", "Juin", "Juil", "Août", "Sept", "Oct", "Nov", "Déc"];
        $rs = array();
        $rs['data'] = [];
        for ($i = 0; $i < count($req); $i++) {
            $rs['labels'][$i] = $monthArrayFrench[$req[$i]->month_chiffre] . " " . $req[$i]->year;
            $rs['data'][$i] = $req[$i]->nbr;
        }
        
        if ($this->session->get('role') == 'ADMINISTRATEUR') {
            $one = [
                "label" => "livres empruntés",
                "borderColor" => '#006E2E',
                "data" => $rs['data'],
                "fill" => false
            ];
        }
        if ($this->session->get('role') == 'PROFESSEUR') {
            $one = [
                "label" => "livres empruntés & retournés",
                "borderColor" => '#006E2E',
                "data" => $rs['data'],
                "fill" => false
            ];
        }


        // Production des livres retournés | professeurs
        $builders = $this->modelsManager->createBuilder();
        $req = $builders->columns("YEAR(emp.create_date) as year, 
            MONTH(emp.create_date) as month_chiffre, 
            MONTHNAME(emp.create_date) as month,
            COUNT(emp.id) as nbr, emp.retour_status")
        ->addfrom('Emprunt', 'emp')
        ->join('Users', 'emp.user_id = u.id', 'u')
        ->where(" emp.retour_status = 1 AND u.role = 'PROFESSEUR'")
        ->groupBy('year, month, month_chiffre')
        ->orderBy('year asc, month_chiffre ASC');


        if ($this->session->get('role') == 'PROFESSEUR') {
            $req->where("emp.retour_status = 0 AND user_id = '" . $user->id . "'");
        }



        $req = $builders->getQuery()->execute();
        $monthArrayFrench = ["mois", "Jan", "Fév", "Mars", "Avr", "Mai", "Juin", "Juil", "Août", "Sept", "Oct", "Nov", "Déc"];
        $rs = array();
        $rs['data'] = [];
        

        for ($i = 0; $i < count($req); $i++) {
            $rs['labels'][$i] = $monthArrayFrench[$req[$i]->month_chiffre] . " " . $req[$i]->year;
            $rs['data'][$i] = $req[$i]->nbr;
        }


        if ($this->session->get('role') == 'ADMINISTRATEUR') {
            $two = [
                "label" => "livres retournés",
                "borderColor" => 'rgb(0, 140, 211)',
                "data" => $rs['data'],
                "fill" => false
            ];
        }
        if ($this->session->get('role') == 'PROFESSEUR') {
            $two = [
                "label" => "livres non retournés",
                "borderColor" => 'rgb(0, 140, 211)',
                "data" => $rs['data'],
                "fill" => false
            ];
        }
        



        $data = [
            "labels" => $rs['labels'],
            "datasets" => [
                $one,
                $two
            ]
        ];




        $this->view->fiches_graph2 = json_encode($data);

    }

    // recuperation des cycles pour le construire le dashboard
    private function getFilterStudent()
    {
        $builder = $this->modelsManager->createBuilder();
        $req = $builder->columns("cy.id, cy.libelle cycle,e.id user_id, count(e.id) number")
        ->addfrom("Cycle", "cy")
        ->leftjoin("Users", "e.id_cycle = cy.id",'e')
        ->groupby("cy.id");


        $results = $builder->getQuery()->execute();
        $data = [];
        foreach ($results as $key => $result) {
            $data[] = $result;
        }
        return $data;
    }

}