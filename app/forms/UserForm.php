
<?php

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Email;
use Phalcon\Forms\Element\Password;
use Phalcon\Forms\Element\Numeric;
use Phalcon\Forms\Element\Check;
use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Element\File;
use Phalcon\Forms\Element\Date;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\StringLength;
use Phalcon\Security\Random;

class UserForm extends Form
{
    public function initialize()
    {

        $matricule = new Text('matricule', ["class" => "form-control", "name" => "matricule", "id" => "matricule", "value" => $this->generateCodeMatricule(), 'title' => 'Cette valeur est générée automatiquement et n\'est pas modifiable', "readonly" => "readonly"]);
        $this->add($matricule);

        $nom = new Text('nom', ["class" => "form-control", "required" => "required", "name" => "nom", "placeholder" => "Nom"]);
        $nom->addValidator(
            new PresenceOf(
                [
                    'message' => 'Nom de l\'étudiant obligatoire',
                ]
            )
        );
        $this->add($nom);

        $prenom = new Text('prenom', ["class" => "form-control", "required" => "required", "name" => "prenom", "placeholder" => "Prénom"]);
        $prenom->addValidator(
            new PresenceOf(
                [
                    'message' => 'Prénom de l\'étudiant obligatoire',
                ]
            )
        );
        $this->add($prenom);

        $pseudo = new Text('pseudo', ["class" => "form-control", "required" => "required", "name" => "pseudo", "placeholder" => "Pseudo"]);
        $pseudo->addValidator(
            new PresenceOf(
                [
                    'message' => 'Pseudo de l\'étudiant obligatoire',
                ]
            )
        );
        $this->add($pseudo);

        $id_cycle = new Select('id_cycle', Cycle::find(), [
            "data-placeholder" => "Choisir....", "class" => "form-control select2", "style" => "width: 100%;", "useEmpty" => true, "emptyText" => "Choisir votre cycle", "id" => "id_cycle", "using" => ["id", "libelle"]
        ]);
        $this->add($id_cycle);

        $id_filiere = new Select('id_filiere', Filiere::find(), [
            "data-placeholder" => "Choisir....", "class" => "form-control select2", "style" => "width: 100%;", "useEmpty" => true, "emptyText" => "Choisir votre filière", "id" => "id_filiere", "using" => ["id", "libelle"]
        ]);
        $this->add($id_filiere);

        $email = new Email('email', ["class" => "form-control", "required" => "required", "name" => "email", "placeholder" => "E-mail", "onBlur" => "getinfos()", "id" => "email"]);
        $email->addValidator(
            new PresenceOf(
                [
                    'message' => "L'email est obligatoire",
                ]
            )
        );
        $this->add($email);

        $photo = new File('photo', ["id" => "input-file-now", "enctype" => "multipart/form-data", "method"  => "post", "class" => "dropify"]);
        $this->add($photo);

        $telephone = new Numeric('telephone', ["class" => "form-control", "required" => "required", "name" => "telephone", "id" => "telephone", "placeholder" => "+22376767676"]);
        $telephone->addValidator(
            new PresenceOf(
                [
                    'message' => 'Le téléphone portable est obligatoire',
                ]
            )
        );
        $this->add($telephone);

        $role = new Select('role', ["ETUDIANT" => "Étudiant", "PROFESSEUR" => "Professeur", "ADMINISTRATEUR" => "Administrateur"], ["class" => "form-control", "required" => "required", "class" => "form-control select2", "style" => "width: 100%;", "useEmpty" => true, "emptyText" => "Choisir votre rôle"]);

        $this->add($role);

        $password = new Password('password', ["class" => "form-control", "required" => "required", "name" => "password", "id" => "current-password", "placeholder" => "Mot de passe"]);

        $this->add($password);

        $con_password = new Password('con_password', ["class" => "form-control", "required" => "required", "name" => "con_password", "id" => "con-password", "placeholder" => "Retapez votre mot de passe", "onkeyup" => "verif();"]);

        $this->add($con_password);

        $status = new Select('status', ["1" => "Activé", "0" => "Désactivé"], ["class" => "form-control", "required" => "required", "useEmpty" => true, "emptyText" => "Choisir"]);

        $this->add($status);
    }

    private function generateCodeMatricule()
    {

        $random = new Random();

        return strtoupper('mae-') . strtoupper($random->base62(8));
    }
}
