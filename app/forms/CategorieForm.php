
<?php

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Email;
use Phalcon\Forms\Element\Numeric;
use Phalcon\Forms\Element\Select;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\StringLength;

class CategorieForm extends Form
{
    public function initialize()
    {

        $libelle = new Text('libelle', [ "class" => "form-control", "required" => "required"]);
        $libelle->addValidator(
            new PresenceOf(
                [
                    'message' => 'Le nom de la catégorie est obligatoire',
                ]
            )
        );
        $this->add($libelle);
        $status = new Select( 'status', ["1" => "Activé", "0" => "Désactivé"], [ "class" => "form-control", "required"=> "required", "useEmpty" => true, "emptyText" => "Choisir" ]);
        
        $this->add($status);
    }
}