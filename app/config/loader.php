<?php

$loader = new \Phalcon\Loader();


/**
 * We're a registering a set of directories taken from the configuration file
 */

// Register some namespaces
$loader->registerNamespaces(
    [
       'App\Forms'  => APP_PATH .'/forms/',
    ]
);

// Register some classes
$loader->registerClasses(
    [
        'Mail' => APP_PATH. '/library/Mail/Mail.php'
    ]
);
$loader->registerDirs(
    [
        $config->application->controllersDir,
        $config->application->modelsDir,
        $config->application->formsDir,
        $config->application->pluginsDir,
        $config->application->servicesDir,
    ]
    );

   $loader ->registerFiles([APP_PATH.'/vendor/autoload.php']);
   

$loader->register();
