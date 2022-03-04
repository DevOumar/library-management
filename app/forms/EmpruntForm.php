<?php

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Email;
use Phalcon\Forms\Element\Date;
use Phalcon\Forms\Element\Numeric;
use Phalcon\Forms\Element\Select;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\StringLength;

class EmpruntForm extends Form
{
    public function initialize()
    {

        $user_id = new Text('user_id', [ "class" => "form-control", "required" => "required","hidden"=>'true', "id" => "user_id" ]);
        $user_id->addValidator(
            new PresenceOf(
                [
                    'message' => 'Le user_id obligatoire',
                ]
            )
        );
        $this->add($user_id);

        $amende = new Numeric('amende', [ "class" => "form-control" ]);
        
        $this->add($amende);

        $isbn = new Text('isbn', [ "class" => "form-control" ]);
        $this->add($isbn);
        $delai_livre = new Text('delai_livre', [ "class" => "form-control", "value" => date("d-m-Y",strtotime("+15 days"))]);
        $this->add($delai_livre);
        
        $id_livre = new Select( 'id_livre', Livre::find(), [ "data-placeholder" => "Choisir...", "class" => "form-control select2", "style" => "width: 100%;", "useEmpty" => true, "emptyText" => "Choisir...", "required" => "required", "id" => "id_livre", "using" => ["id", "nom_livre"]
        ]);
        $this->add($id_livre);
    }
}