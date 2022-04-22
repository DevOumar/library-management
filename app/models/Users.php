<?php

use Phalcon\Validation;
use Phalcon\Validation\Validator\Email as EmailValidator;

class Users extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     */
    public $id;

    /**
     *
     * @var string
     */
    public $matricule;

    /**
     *
     * @var string
     */
    public $nom;

    /**
     *
     * @var string
     */
    public $prenom;

    /**
     *
     * @var string
     */
    public $initials;

    /**
     *
     * @var string
     */
    public $pseudo;

    /**
     *
     * @var integer
     */
    public $id_cycle;

    /**
     *
     * @var integer
     */
    public $id_filiere;

    /**
     *
     * @var string
     */
    public $email;

    /**
     *
     * @var integer
     */
    public $telephone;

    /**
     *
     * @var string
     */
    public $role;

    /**
     *
     * @var string
     */
    public $photo;

    /**
     *
     * @var integer
     */
    public $status;

    /**
     *
     * @var string
     */
    public $token_activation;

    /**
     *
     * @var string
     */
    public $password;

    /**
     *
     * @var string
     */
    public $datelastlogin;

    /**
     *
     * @var string
     */
    public $datepreviouslogin;

    /**
     *
     * @var string
     */
    public $create_date;

    /**
     *
     * @var string
     */
    public $update_date;

    /**
     * Validations and business logic
     *
     * @return boolean
     */
    public function validation()
    {
        $validator = new Validation();

        $validator->add(
            'email',
            new EmailValidator(
                [
                    'model'   => $this,
                    'message' => 'Please enter a correct email address',
                ]
            )
        );

        return $this->validate($validator);
    }

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->setSchema("BIBLIOS");
        $this->setSource("users");
        $this->hasMany('id', 'Emprunt', 'user_id', ['alias' => 'Emprunt']);
        $this->hasMany('id', 'Notification', 'user_id', ['alias' => 'Notification']);
        $this->hasMany('id', 'Recommandation', 'user_id', ['alias' => 'Recommandation']);
        $this->belongsTo('id_cycle', '\Cycle', 'id', ['alias' => 'Cycle']);
        $this->belongsTo('id_filiere', '\Filiere', 'id', ['alias' => 'Filiere']);
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Users[]|Users|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null): \Phalcon\Mvc\Model\ResultsetInterface
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Users|\Phalcon\Mvc\Model\ResultInterface|\Phalcon\Mvc\ModelInterface|null
     */
    public static function findFirst($parameters = null): ?\Phalcon\Mvc\ModelInterface
    {
        return parent::findFirst($parameters);
    }

// Nombre d'etudiants inscrits
    public static function getStudentNumber($role = "ADMINISTRATEUR")
    {
        $studentNumber = [];
        if ($role === "ADMINISTRATEUR") {
            $studentNumber = parent::find("role = 'ETUDIANT' ");
        }
        return $studentNumber;
    }

    // Nombre professeurs inscrits
    public static function getTeacherNumber($role = "ADMINISTRATEUR")
    {
        $teacherNumber = [];
        if ($role === "ADMINISTRATEUR") {
            $teacherNumber = parent::find("role = 'PROFESSEUR' ");
        }
        return $teacherNumber;
    }

    // Récuperation de la liste des 5 derniers etudiants inscrits
    public static function getLastStudent($role = "ADMINISTRATEUR")
    {
        $listStudent = [];
        if ($role === "ADMINISTRATEUR") {
            $listStudent = parent::find(["role = 'ETUDIANT' ",
                'order' => ' id DESC', 'limit' => 5
            ]);
        }
        return $listStudent;
    }

    // Récuperation de la liste des 5 derniers professeurs inscrits
    public static function getLastTeacher($role = "ADMINISTRATEUR")
    {
        $listTeachers = [];
        if ($role === "ADMINISTRATEUR") {
            $listTeachers = parent::find(["role = 'PROFESSEUR' ",
                'order' => ' id DESC', 'limit' => 5
            ]);
        }
        return $listTeachers;
    }

}