<?php

class Emprunt extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     */
    public $id;

    /**
     *
     * @var integer
     */
    public $user_id;

    /**
     *
     * @var integer
     */
    public $id_livre;

    /**
     *
     * @var string
     */
    public $date_emprunt;

    /**
     *
     * @var string
     */
    public $retour_emprunt;

    /**
     *
     * @var integer
     */
    public $retour_status;

    /**
     *
     * @var string
     */
    public $delai_livre;

    /**
     *
     * @var integer
     */
    public $amende;

    /**
     *
     * @var string
     */
    public $create_date;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->setSchema("BIBLIOS");
        $this->setSource("emprunt");
        $this->belongsTo('id_livre', '\Livre', 'id', ['alias' => 'Livre']);
        $this->belongsTo('user_id', '\Users', 'id', ['alias' => 'Users']);
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Emprunt[]|Emprunt|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null): \Phalcon\Mvc\Model\ResultsetInterface
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Emprunt|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    

    // Mes livres empruntés et retournés | professeur
    public static function getTeacherIssueReturn($role = "PROFESSEUR", $user_id)
    {
        $teacherIssueReturn = [];
        if ($role === "PROFESSEUR") {
            $user =  Users::findFirst($user_id);
            $teacherIssueReturn = parent::find([
                "retour_status = 1 AND user_id = '" . $user->id . "'"
            ]);
        }
        return $teacherIssueReturn;
    }
    // Mes livres empruntés et retournés | étudiant
    public static function getStudentIssueReturn($role = "ETUDIANT", $user_id)
    {
        $studentIssueReturn = [];
        if ($role === "ETUDIANT") {

            $user = Users::findFirst($user_id);
            $studentIssueReturn = parent::find([
                "retour_status = 1 AND user_id = '" .$user->id. "'"
            ]);

        }
        return $studentIssueReturn;
    }

    // Mes livres non retournés | professeur
    public static function getTeacherNotReturn($role = "PROFESSEUR", $user_id)
    {
        $teacherNotReturn = [];
        if ($role === "PROFESSEUR") {
            $user =  Users::findFirst($user_id);
            $teacherNotReturn = parent::find([
                "retour_status = 0 AND user_id = '" . $user->id . "'"
            ]);
        }
        return $teacherNotReturn;
    }

    // Mes livres non retournés | étudiant
    public static function getStudentNotReturn($role = "ETUDIANT", $user_id)
    {
        $studentNotReturn = [];
        if ($role === "ETUDIANT") {
            $user =  Users::findFirst($user_id);
            $studentNotReturn = parent::find([
                "retour_status = 0 AND user_id = '" . $user->id . "'"
            ]);
        }
        return $studentNotReturn;
    }

}
