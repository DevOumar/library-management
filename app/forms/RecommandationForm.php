
<?php
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Email;
use Phalcon\Forms\Element\Numeric;
use Phalcon\Forms\Element\Select;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\StringLength;

class RecommandationForm extends Form
{
    public function initialize()
    {

        $nom_livre = new Text('nom_livre', [ "class" => "form-control", "required" => "required" ]);
        $nom_livre->addValidator(
            new PresenceOf(
                [
                    'message' => 'Le nom du livre est obligatoire',
                ]
            )
        );
        $this->add($nom_livre);

        $description = new TextArea('description', [ "class" => "form-control", "required" => "required" ]);
        $description->addValidator(
            new PresenceOf(
                [
                    'message' => 'La description du livre est obligatoire',
                ]
            )
        );
        $this->add($description);

        $nom_auteur = new Text('nom_auteur', [ "class" => "form-control", "required" => "required" ]);
        $nom_auteur->addValidator(
            new PresenceOf(
                [
                    'message' => "Le nom de l'auteur du livre est obligatoire",
                ]
            )
        );
        $this->add($nom_auteur);
    }
}