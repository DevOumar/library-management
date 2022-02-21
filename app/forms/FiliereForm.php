
<?php

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Email;
use Phalcon\Forms\Element\Numeric;
use Phalcon\Forms\Element\Select;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\StringLength;

class FiliereForm extends Form
{
    public function initialize()
    {

        $libelle = new Text('libelle', [ "class" => "form-control", "required" => "required" ]);
        $libelle->addValidator(
            new PresenceOf(
                [
                    'message' => 'Le nom de la filière est obligatoire',
                ]
            )
        );
        $this->add($libelle);
         $id_cycle = new Select( 'id_cycle', Cycle::find(), [ "data-placeholder" => "Choisir....", "class" => "form-control select2", "style" => "width: 100%;", "useEmpty" => true, "emptyText" => "Choisir", "required" => "required", "id" => "id_cycle", "using" => ["id", "libelle"]
        ]);
        $this->add($id_cycle);
    }
}