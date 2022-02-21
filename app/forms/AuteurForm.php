
<?php

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Email;
use Phalcon\Forms\Element\Numeric;
use Phalcon\Forms\Element\Select;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\StringLength;

class AuteurForm extends Form
{
    public function initialize()
    {

        $nom_auteur = new Text('nom_auteur', [ "class" => "form-control", "required" => "required" ]);
        $nom_auteur->addValidator(
            new PresenceOf(
                [
                    'message' => 'Le nom est obligatoire',
                ]
            )
        );
        $this->add($nom_auteur);
    }
}