<?php
define('DB_NAME', 'your_wordpress_database');
define('DB_USER', 'your_wordpress_user');
define('DB_PASSWORD', 'your_wordpress_password');
define('DB_HOST', 'your_wordpress_host');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

define('AUTH_KEY',         'd:$q|^w-_q)YlKT7*HD%~m_{C!O5,0m$Z:Up^C^CKYI330(X$(Im5{U@<]+XoF03');
define('SECURE_AUTH_KEY',  'Qp)q:+F+mW$LsYP_~q1*B%2<63A3SHuPbqa&K#|7e2Y@@|}waE%zZuyEU+Kf9dfK');
define('LOGGED_IN_KEY',    '7E`uI%O9fgmYrV.dg0DpngsOvz*- R=1s&_kTa6K)v+C|TsiaNQtk=(yIPr~`:.&');
define('NONCE_KEY',        '+A|IsZq8iD; -8|x~Fr>ns,-G@2Yfrw8+/sABh ]WM4)LJiQVsx)S8aq 3j.s$%,');
define('AUTH_SALT',        'LTuQJIUi|P%/[v.sf+:G:jg^#-}q1Px)u,VVjv^*T$ *r+Om`wZ+jJ7Kj|es0E+&');
define('SECURE_AUTH_SALT', 'SQD]aDhELok,I!UXj;OLq-&}Qfx|BOC_z<?Gt#a)qCvrWuc-e2(Z,-N]gU`heuUo');
define('LOGGED_IN_SALT',   'r/ln|vb{^Qn.lcDW~p5l|hT:Y^-;X8(r+%W<!VRHk-5B4@W9K0KXTK$OVWp7}Ow,');
define('NONCE_SALT',       '3Nbp.fH=g;Uovh#,@pGC~fw-I.u!JSjq_^tLAx2hB>i5h3Hr+){e:D@[+,9Ql {i');

$table_prefix = 'wp_';
define('WP_DEBUG', false);
if (!defined('ABSPATH')) {
    define('ABSPATH', dirname(__FILE__) . '/');
}
require_once(ABSPATH . 'wp-settings.php');
