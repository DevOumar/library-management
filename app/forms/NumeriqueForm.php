
<?php

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Email;
use Phalcon\Forms\Element\Numeric;
use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Element\File;
use Phalcon\Forms\Element\Date;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\StringLength;

class NumeriqueForm extends Form
{
    public function initialize()
    {

        $nom_livre = new Text('nom_livre', [ "class" => "form-control", "required" => "required" ]);
        $nom_livre->addValidator(
            new PresenceOf(
                [
                    'message' => 'Nom du livre obligatoire',
                ]
            )
        );
        $this->add($nom_livre);

        $description = new TextArea('description', [ "class" => "form-control", "required" => "required" ]);
        $description->addValidator(
            new PresenceOf(
                [
                    'message' => 'Description obligatoire',
                ]
            )
        );
        $this->add($description);


        $nom_auteur = new Text('nom_auteur', [ "class" => "form-control", "required" => "required" ]);
        $nom_auteur->addValidator(
            new PresenceOf(
                [
                    'message' => 'Nom auteur obligatoire',
                ]
            )
        );
        $this->add($nom_auteur);
        

        $photo = new File('photo', [ "id" => "input-file-now", "enctype" => "multipart/form-data", "method"  => "post", "class" => "dropify", "required" => "required"]);
        $this->add($photo);

        $file_livre = new File('file_livre', [ "id" => "input-file-now", "enctype" => "multipart/form-data", "method"  => "post", "class" => "dropify", "required" => "required"]);
        $this->add($file_livre);
        

       
    }
}