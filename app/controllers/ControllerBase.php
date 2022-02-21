<?php
declare(strict_types=1);

use Phalcon\Mvc\Controller;

class ControllerBase extends Controller
{
    // Implement common logic
    public function initialize(){
        
        // affichage photo de profil de l'étudiant
        $user_id = $this->session->get('id');
        $user = Users::findFirst($user_id);
        $this-> view ->user= $user;

        // affichage mot de passe
        $this-> view ->user_id = $this->session->get('id');

        // affichage notification
        $user_role =$this->session->get('role');
        

        if($this->session->get('role') == "ADMINISTRATEUR"){
            $notifications = Notification::find(['read = false AND admin = true', 'limit' => 10]);
        }else{
            $notifications = Notification::find(['read = false AND admin = false AND user_id = ?0', 'bind' =>[$this->session->get('id')], 'limit' => 10]);
        }

        $this->view->notifications = $notifications;
        $this->view->notifs = $notifications;
    }

    public function semaine($date){
        $dds = [];
        $nbDay = date('N', strtotime($date));
        $monday = new DateTime($date);
        $sunday = new DateTime($date);
        $monday->modify('-'.($nbDay-1).' days');
        $sunday->modify('+'.(7-$nbDay).' days');
        $dds['first']   = $monday->format('Y-m-d');
        $dds['last']    = $sunday->format('Y-m-d');

        return $dds;
    }

    public function mois($date){
        $mois = [];
        $date = new DateTime($date);
        $date->modify('first day of this month');
        $firstday= $date->format('Y-m-d');
        $date->modify('last day of this month');
        $lastday= $date->format('Y-m-d');

        $mois['first']   = $firstday;
        $mois['last']    = $lastday;

        return $mois;
    }
}
