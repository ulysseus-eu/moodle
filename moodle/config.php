<?php  // Moodle configuration file

unset($CFG);
global $CFG;
$CFG = new stdClass();

$CFG->dbtype    = 'mariadb';
$CFG->dblibrary = 'native';
$CFG->dbhost    = 'bdd2ulysseus.univ-cotedazur.fr';
$CFG->dbname    = 'moodle';
$CFG->dbuser    = 'moodleuser';
$CFG->dbpass    = trim(file_get_contents("/run/secrets/moodle-db.pass"));
$CFG->prefix    = 'mdl_';
$CFG->dboptions = array (
  'dbpersist' => 0,
  'dbport' => 3306,
  'dbsocket' => '',
  'dbcollation' => 'utf8mb4_unicode_ci',
);

$CFG->wwwroot   = 'https://ulysseus.eu/learn';
$CFG->dataroot  = '/var/www/moodledata';
$CFG->admin     = 'admin';

$CFG->directorypermissions = 0777;
// $CFG->reverseproxy = true;
$CFG->sslproxy = true;

// Store sessions in the database. When storing on disk, moodle tries to lock
// session files upon creation which can lead to long waiting times on network
// file systems.
$CFG->session_handler_class = '\core\session\database';

require_once(__DIR__ . '/lib/setup.php');

// There is no php closing tag in this file,
// it is intentional because it prevents trailing whitespace problems!
