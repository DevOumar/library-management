<?php

class Notifications extends Phalcon\Mvc\Controller{

    public function add($message, $url, $admin = false){
        
        $notification = new Notification();
        $notification->message = $message;
        $notification->url = $url;
        $notification->admin = $admin;
        $notification->user_id = $this->session->get('id');
       
        $notification->save();
    }
}