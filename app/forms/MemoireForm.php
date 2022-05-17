
<?php

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Email;
use Phalcon\Forms\Element\Numeric;
use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Element\Date;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\StringLength;

class MemoireForm extends Form
{
    public function initialize()
    {

        $nom_memoire = new Text('nom_memoire', [ "class" => "form-control", "required" => "required" ]);
        $nom_memoire->addValidator(
            new PresenceOf(
                [
                    'message' => 'Nom du memoire est obligatoire',
                ]
            )
        );
        $this->add($nom_memoire);

         $id_categorie = new Select( 'id_categorie', $this->getCategorieStatus(), [ "data-placeholder" => "Choisir....", "class" => "form-control select2", "style" => "width: 100%;", "useEmpty" => true, "emptyText" => "Choisir", "required" => "required", "id" => "id_categorie", "using" => ["id", "libelle"]
        ]);
        $this->add($id_categorie);

        $id_filiere = new Select( 'id_filiere', Filiere::find(), [ "data-placeholder" => "Choisir....", "class" => "form-control select2", "style" => "width: 100%;", "useEmpty" => true, "emptyText" => "Choisir", "required" => "required",  "id" => "id_filiere", "using" => ["id", "libelle"]
        ]);
        $this->add($id_filiere);

        $id_cycle = new Select( 'id_cycle', ["3" => "LICENCE", "4" => "MASTER"], [ "data-placeholder" => "Choisir....", "class" => "form-control select2", "style" => "width: 100%;", "useEmpty" => true, "emptyText" => "Choisir votre cycle", "required" => "required", "id" => "id_cycle", "using" => ["id", "libelle"]
        ]);
        $this->add($id_cycle);

         $id_casier = new Select( 'id_casier', Casier::find(), [ "data-placeholder" => "Choisir....", "class" => "form-control select2", "style" => "width: 100%;", "useEmpty" => true, "emptyText" => "Choisir", "required" => "required", "id" => "id_casier", "using" => ["id", "libelle"]
        ]);
        $this->add($id_casier);

         $id_ranger = new Select( 'id_ranger', Ranger::find(), [ "data-placeholder" => "Choisir....", "class" => "form-control select2", "style" => "width: 100%;", "useEmpty" => true, "emptyText" => "Choisir", "required" => "required", "id" => "id_ranger", "using" => ["id", "libelle"]
        ]);
        $this->add($id_ranger);
         $nbre_page = new Numeric('nbre_page', [ "class" => "form-control", "required" => "required" ]);
        $this->add($nbre_page);
         $id_auteur = new Select( 'id_auteur', Auteur::find(), [ "data-placeholder" => "Choisir....", "class" => "form-control select2", "style" => "width: 100%;", "useEmpty" => true, "emptyText" => "Choisir", "required" => "required", "id" => "id_auteur", "using" => ["id", "nom_auteur"]
        ]);
        $this->add($id_auteur);
         $date_soutenance = new Date('date_soutenance', [ "class" => "form-control" , "min" => date('Y-m-d', strtotime(date('Y-m-d'). ' - 15 year')), "required" => "required"]);
        $this->add($date_soutenance);

       
    }
    private function getCategorieStatus(){

        return Categorie::find(['status = true']);
    }
}