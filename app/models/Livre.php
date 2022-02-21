<?php

class Livre extends \Phalcon\Mvc\Model
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
    public $id_auteur;

    /**
     *
     * @var string
     */
    public $nom_livre;

    /**
     *
     * @var integer
     */
    public $id_categorie;

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
    public $isbn;

    /**
     *
     * @var integer
     */
    public $quantite;

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
        $this->setSource("livre");
        $this->hasMany('id', 'Emprunt', 'id_livre', ['alias' => 'Emprunt']);
        $this->belongsTo('id_casier', '\Casier', 'id', ['alias' => 'Casier']);
        $this->belongsTo('id_categorie', '\Categorie', 'id', ['alias' => 'Categorie']);
        $this->belongsTo('id_ranger', '\Ranger', 'id', ['alias' => 'Ranger']);
        $this->belongsTo('id_auteur', '\Auteur', 'id', ['alias' => 'Auteur']);
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Livre[]|Livre|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null): \Phalcon\Mvc\Model\ResultsetInterface
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Livre|\Phalcon\Mvc\Model\ResultInterface|\Phalcon\Mvc\ModelInterface|null
     */
    public static function findFirst($parameters = null): ?\Phalcon\Mvc\ModelInterface
    {
        return parent::findFirst($parameters);
    }

    // recupération de tous les livres
    public static function getBook()
    {

        $tbook = parent::find();
        return $tbook;
    }

// recupération calcul des stocks livres
    public function getQteStock()
    {
        $qte_emprunt = Emprunt::count(["id_livre = :id_livre: AND retour_status = 0 ", 'bind' => ["id_livre" => $this->id]]);
        $this->qte_stock =$this->quantite - ($qte_emprunt) ;
        return $this->qte_stock ;
    }

}
