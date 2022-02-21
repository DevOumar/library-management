<?php

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Email;
use Phalcon\Forms\Element\Password;
use Phalcon\Forms\Element\Numeric;
use Phalcon\Forms\Element\Select;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\StringLength;

class ResetPasswordForm extends Form
{
    public function initialize()
    {

        $old_password = new Password('old_password', [ "class" => "form-control", "required" => "required" ]);
        $old_password->addValidator(
            new PresenceOf(
                [
                    'message' => 'Le champ mot de passe actuel est obligatoire.',
                ]
            )
        );
        $this->add($old_password);

        $new_password = new Password('new_password', [ "class" => "form-control", "required" => "required", "id" => "new_password"]);
        $new_password->addValidator(
            new PresenceOf(
                [
                    'message' => 'Le champ nouveau mot de passe est obligatoire.',
                ]
            )
        );
        $this->add($new_password);

        $con_password = new Password('con_password', [ "class" => "form-control","required" => "required", "onkeyup" => "verif();", "id" => "con_password" ]);
        $con_password->addValidator(
            new PresenceOf(
                [
                    'message' => 'Le champ confirmation mot de passe est obligatoire.',
                ]
            )
        );
        $this->add($con_password);

        
    }
}