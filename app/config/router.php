<?php

$router = $di->getRouter();

// Define your routes here
$router->addGet(
	'/',
	'accueil::index'
);


$router->addGet(
	'/logout',
	'user::connexion'
);


$router->handle($_SERVER['REQUEST_URI']);
