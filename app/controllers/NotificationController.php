<?php
declare(strict_types=1);

class NotificationController extends ControllerBase
{
    
    public function indexAction()
    {

        if($this->session->get('role') == "ADMINISTRATEUR"){
            $notifications = Notification::find(['read = false AND admin = true']);
        }
         else{
             $notifications = Notification::find(['read = true AND admin = true AND user_id = ?0', 'bind' =>[$this->session->get('id')], 'limit' => 10]);
         }

        $this->view->notifs = $notifications;
    }
    }
