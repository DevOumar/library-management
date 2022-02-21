<?php

class Recommandation extends \Phalcon\Mvc\Model
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
    public $nom_livre;

    /**
     *
     * @var string
     */
    public $nom_auteur;

    /**
     *
     * @var string
     */
    public $description;

    

    /**
     *
     * @var integer
     */
    public $user_id;


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
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->setSchema("BIBLIOS");
        $this->setSource("recommandation");
        $this->belongsTo('user_id', '\Users', 'id', ['alias' => 'Users']);
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Recommandation[]|Recommandation|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null): \Phalcon\Mvc\Model\ResultsetInterface
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Recommandation|\Phalcon\Mvc\Model\ResultInterface|\Phalcon\Mvc\ModelInterface|null
     */
    public static function findFirst($parameters = null): ?\Phalcon\Mvc\ModelInterface
    {
        return parent::findFirst($parameters);
    }

    public function getRecommanderPar(){
        $recommande_par = null;
        switch ($this->recommande_par) {

            case 0:
            //LOGIQUE PROFESSEUR
            $recommande_par = Users::findFirst($this->recommande_par);
            break;
            
            default:
            //LOGIQUE ETUDIANT
            $recommande_par = Users::findFirst($this->recommande_par);
            break;
        }

        return $recommande_par;
    }

}
