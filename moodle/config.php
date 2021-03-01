<?php  // Moodle configuration file

unset($CFG);
global $CFG;
$CFG = new stdClass();

$CFG->dbtype    = 'mysqli';
$CFG->dblibrary = 'native';
$CFG->dbhost    = 'db17.rz.uni-potsdam.de';
$CFG->dbname    = 'moodle_educ';
$CFG->dbuser    = 'moodle_educ';
$CFG->dbpass    = trim(file_get_contents("/run/secrets/moodle-db.pass"));
$CFG->prefix    = 'mdl_';
$CFG->dboptions = array (
  'dbpersist' => false,
  'dbport' => '',
  'dbsocket' => false,
  'dbcollation' => 'utf8mb4_general_ci',
);

$CFG->wwwroot   = 'https://learning.educalliance.eu';
$CFG->dataroot  = '/data';
$CFG->admin     = 'admin';

$CFG->directorypermissions = 0777;

// Store sessions in the database. When storing on disk, moodle tries to lock
// session files upon creation which can lead to long waiting times on network
// file systems.
$CFG->session_handler_class = '\core\session\database';

require_once(__DIR__ . '/lib/setup.php');

// There is no php closing tag in this file,
// it is intentional because it prevents trailing whitespace problems!
