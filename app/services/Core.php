<?php

/**
 * Description of Api
 *
 * @author placan
 */
class Core{
    public static function convertChiffreEnLettre($value){
        $fmt = new NumberFormatter('fr', NumberFormatter::SPELLOUT);
        
        return $fmt->format($value);
    }
}