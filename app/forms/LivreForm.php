
<?php

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Email;
use Phalcon\Forms\Element\Numeric;
use Phalcon\Forms\Element\Select;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\StringLength;

class LivreForm extends Form
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

         $id_categorie = new Select( 'id_categorie', $this->getCategorieStatus(), [ "data-placeholder" => "Choisir....", "class" => "form-control select2", "style" => "width: 100%;", "useEmpty" => true, "emptyText" => "Choisir", "required" => "required", "id" => "id_categorie", "using" => ["id", "libelle"]
        ]);
        $this->add($id_categorie);

        $id_auteur = new Select( 'id_auteur', Auteur::find(), [ "data-placeholder" => "Choisir....", "class" => "form-control select2", "style" => "width: 100%;", "useEmpty" => true, "id" => "categories", "emptyText" => "Choisir", "required" => "required", "id" => "id_auteur", "using" => ["id", "nom_auteur"]
        ]);
        $this->add($id_auteur);

         $id_casier = new Select( 'id_casier', Casier::find(), [ "data-placeholder" => "Choisir....", "class" => "form-control select2", "style" => "width: 100%;", "useEmpty" => true, "emptyText" => "Choisir", "required" => "required", "id" => "id_casier", "using" => ["id", "libelle"]
        ]);
        $this->add($id_casier);

         $id_ranger = new Select( 'id_ranger', Ranger::find(), [ "data-placeholder" => "Choisir....", "class" => "form-control select2", "style" => "width: 100%;", "useEmpty" => true, "emptyText" => "Choisir", "required" => "required", "id" => "id_ranger", "using" => ["id", "libelle"]
        ]);
        $this->add($id_ranger);
         $nbre_page = new Text('nbre_page', [ "class" => "form-control" ]);
        $this->add($nbre_page);
         $isbn = new Text('isbn', [ "class" => "form-control" ]);
        $this->add($isbn);
         $quantite = new Text('quantite', [ "class" => "form-control" ]);
        $this->add($quantite);

    }
    private function getCategorieStatus(){

        return Categorie::find(['status = true']);
    }
}