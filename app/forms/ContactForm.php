
<?php

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Email;
use Phalcon\Forms\Element\Password;
use Phalcon\Forms\Element\Numeric;
use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Element\Date;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\StringLength;

class ContactForm extends Form
{
    public function initialize()
    {

        $nom_complet = new Text('nom_complet', [ "class" => "form-control", "required" => "required" ]);
        $nom_complet->addValidator(
            new PresenceOf(
                [
                    'message' => 'Nom complet obligatoire',
                ]
            )
        );
        $this->add($nom_complet);

        $email = new Email('email', [ "class" => "form-control", "required" => "required" ]);
        $email->addValidator(
            new PresenceOf(
                [
                    'message' => "L'email est obligatoire",
                ]
            )
        );
        $this->add($email);

        $telephone = new Text('telephone', [ "class" => "form-control", "required" => "required" ]);
        $telephone->addValidator(
            new PresenceOf(
                [
                    'message' => 'Le telephone portable est obligatoire',
                ]
            )
        );
        $this->add($telephone);

         $message = new TextArea('message', [ "class" => "form-control", "required" => "required" ]);
        
        $this->add($message);
       
    }
}