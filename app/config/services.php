<?php
declare(strict_types=1);
use Phalcon\Mvc\View;
use Phalcon\Security\Exception;
use Phalcon\Mvc\View\Engine\Php as PhpEngine;
use Phalcon\Escaper;
use Phalcon\Url as UrlResolver;
use Phalcon\Mvc\View\Engine\Volt as VoltEngine;
use Phalcon\Mvc\Model\Metadata\Memory as MetaDataAdapter;
use Phalcon\Session\Manager as SessionManager;
use Phalcon\Session\Adapter\Stream as SessionAdapter;
use Phalcon\Flash\Session as Flash;
use Phalcon\Logger\Adapter\Syslog as SyslogAdapter;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Events\Manager as EventsManager;
use Dompdf\Dompdf;
use Phalcon\Session\Bag;
use PHPMail\PHPMail;

/**
 * Shared configuration service
 */
$di->setShared('config', function () {
    return include APP_PATH . "/config/config.php";
});

/**
 * The URL component is used to generate all kind of urls in the application
 */
$di->setShared('url', function () {
    $config = $this->getConfig();

    $url = new UrlResolver();
    $url->setBaseUri($config->application->baseUri);

    return $url;
});

/**
 * Setting up volt
 */
$di->setShared('view', function () {
    $config = $this->getConfig();

    $view = new View();
    $view->setDI($this);
    $view->setViewsDir($config->application->viewsDir);

    $view->registerEngines([
        '.volt' => function ($view) {
            $config = $this->getConfig();

            $volt = new VoltEngine($view, $this);

            $volt->setOptions([
                'path' => $config->application->cacheDir,
                'separator' => '_'
            ]);

    $compiler = $volt->getCompiler();
    $compiler->addFunction('in_array', 'in_array');
    $compiler->addFunction('array_reverse', 'array_reverse');
    $compiler->addFunction('round', 'round');
    $compiler->addFunction('ucfirst', 'ucfirst');
    $compiler->addFunction('date', 'date');
    $compiler->addFunction('DateTime', 'DateTime');
    $compiler->addFunction('getSize', 'getSize');
    $compiler->addFunction('strtotime', 'strtotime');
    $compiler->addFunction('strftime', 'strftime');
    $compiler->addFunction('setlocale', 'setlocale');
    $compiler->addFunction('substr', 'substr');
    $compiler->addFunction('strlen', 'strlen');
    $compiler->addFunction('number_format', 'number_format');
    $compiler->addFunction('ceil', 'ceil');
    $compiler->addFunction(' mb_strimwidth', ' mb_strimwidth');
    $compiler->addFunction('strip_tags', 'strip_tags');
    $compiler->addFunction('sprintf', 'sprintf');
    $compiler->addFunction('explode', 'explode');
    $compiler->addFunction('date_diff', 'date_diff');
    $compiler->addFunction('strlen',
        function($resolvedArgs, $exprArgs) use ($compiler) {

        $string= $compiler->expression($exprArgs[0]['expr']);

        $secondArgument = $compiler->expression($exprArgs[1]['expr']);

        return 'substr(' . $string . ', 0 ,' . $secondArgument . ')';
    });
    return $volt;
    },
    '.phtml' => PhpEngine::class
    ]);
    return $view;
});

/**
 * Database connection is created based in the parameters defined in the configuration file
 */
$di->setShared('db', function () {
    $config = $this->getConfig();

    $class = 'Phalcon\Db\Adapter\Pdo\\' . $config->database->adapter;
    $params = [
        'host'     => $config->database->host,
        'username' => $config->database->username,
        'password' => $config->database->password,
        'dbname'   => $config->database->dbname,
        'charset'  => $config->database->charset
    ];

    if ($config->database->adapter == 'Postgresql') {
        unset($params['charset']);
    }

    return new $class($params);
});

$di->set('dispatcher', function () {
    $eventsManager = new EventsManager();

    /**
     * Check if the user is allowed to access certain action using the SecurityPlugin
     */
    $eventsManager->attach('dispatch:beforeExecuteRoute', new SecurityPlugin);

    /**
     * Handle exceptions and not-found exceptions using NotFoundPlugin
     */
    $eventsManager->attach('dispatch:beforeException', new NotFoundPlugin);

    $dispatcher = new Dispatcher();
    $dispatcher->setEventsManager($eventsManager);

    return $dispatcher;
});

/**
 * If the configuration specify the use of metadata adapter use it or use memory otherwise
 */
$di->setShared('modelsMetadata', function () {
    return new MetaDataAdapter();
});

/**
 * Register the session flash service with the Twitter Bootstrap classes
 */
$di->set('flash', function () {
    $escaper = new Escaper();
    $flash = new Flash($escaper);
    $flash->setImplicitFlush(true);
    $flash->setCssClasses([
        'error'   => 'alert alert-danger',
        'success' => 'alert alert-success',
        'notice'  => 'alert alert-info',
        'warning' => 'alert alert-warning'
    ]);

    return $flash;
});

/**
 * Start the session the first time some component request the session service
 */
$di->setShared('session', function () {
    $session = new SessionManager();
    $files = new SessionAdapter([
        'savePath' => sys_get_temp_dir(),
    ]);
    $session->setAdapter($files);
    $session->start();

    return $session;
});

$di->set('messages', function() {
    $messages = new Messages();
    return $messages;
});

$di->setShared('sessionBag', function () {
    return new Bag('bag');
});

$di->set('srv_mpdf', function(){
    return new MMpdf();
});

$di->set('core', function(){
    return new Core();
});

$di->setShared('srv_notif', function () {
    return new Notifications();
});