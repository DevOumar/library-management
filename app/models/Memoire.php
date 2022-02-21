<?php

class Memoire extends \Phalcon\Mvc\Model
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
    public $nom_memoire;

    /**
     *
     * @var integer
     */
    public $id_filiere;

    /**
     *
     * @var integer
     */
    public $id_cycle;

    /**
     *
     * @var integer
     */
    public $id_categorie;

    /**
     *
     * @var integer
     */
    public $id_auteur;

    /**
     *
     * @var integer
     */
    public $id_casier;

    /**
     *
     * @var integer
     */
    public $id_ranger;

    /**
     *
     * @var integer
     */
    public $nbre_page;

    /**
     *
     * @var string
     */
    public $date_soutenance;

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
        $this->setSource("memoire");
        $this->belongsTo('id_cycle', '\Cycle', 'id', ['alias' => 'Cycle']);
        $this->belongsTo('id_categorie', '\Categorie', 'id', ['alias' => 'Categorie']);
        $this->belongsTo('id_auteur', '\Auteur', 'id', ['alias' => 'Auteur']);
        $this->belongsTo('id_casier', '\Casier', 'id', ['alias' => 'Casier']);
        $this->belongsTo('id_ranger', '\Ranger', 'id', ['alias' => 'Ranger']);
        $this->belongsTo('id_filiere', '\Filiere', 'id', ['alias' => 'Filiere']);
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Memoire[]|Memoire|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null): \Phalcon\Mvc\Model\ResultsetInterface
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Memoire|\Phalcon\Mvc\Model\ResultInterface|\Phalcon\Mvc\ModelInterface|null
     */
    public static function findFirst($parameters = null): ?\Phalcon\Mvc\ModelInterface
    {
        return parent::findFirst($parameters);
    }

}
