<?php

if (!function_exists('getenv_docker')) {
    function getenv_docker($env, $default)
    {
        if ($fileEnv = getenv($env . '_FILE')) {
            return rtrim(file_get_contents($fileEnv), "\r\n");
        } else if (($val = getenv($env)) !== false) {
            return $val;
        } else {
            return $default;
        }
    }
}

define('DB_NAME', getenv_docker('WORDPRESS_DB_NAME', 'wordpress'));
define('DB_USER', getenv_docker('WORDPRESS_DB_USER', 'example username'));
define('DB_PASSWORD', getenv_docker('WORDPRESS_DB_PASSWORD', 'example password'));
define('DB_HOST', getenv_docker('WORDPRESS_DB_HOST', 'mysql'));
define('DB_CHARSET', getenv_docker('WORDPRESS_DB_CHARSET', 'utf8'));
define('DB_COLLATE', getenv_docker('WORDPRESS_DB_COLLATE', ''));

define('AUTH_KEY',         'YQN! V Z;+p#H4D|2XU|/S|vnyDsKew-6]|X~Zfd0u.A%ZU?;1=(ZnOlx+%es<MW');
define('SECURE_AUTH_KEY',  '%f3vHp+Mb2+-m wqQBXjJte}vc*zd)#Jz;&[|--{7-TM#U)r.O~SG*]bQ+eKb=+5');
define('LOGGED_IN_KEY',    '--4h37Z-rrZQv5XFxkS=F*yAr[FYlMMgC_#n?rDFw+!VO}j@Uz_S#_!5l^neCYto');
define('NONCE_KEY',        'D9K@M71gRYs;!{rj0dEPs5^he#@v3x@})l.uYx4s9@ *|][x,d0}gfdkSMh#Yrwr');
define('AUTH_SALT',        '6hVUy qU7=fmWUo>J]5/heZD0fEdxGa;&pzxF~o{_9*>u^j2Ux Y2i?y?t#2;JUf');
define('SECURE_AUTH_SALT', '?}w$/4_|H$SpfqwR<`+.4%*qSTGyQ-=fNVzG~wSh?j;^w/>NU5toisY{sl{yG(%D');
define('LOGGED_IN_SALT',   'KQy-#you,>]-{R@]wqQn>5)RU3DgPT2zmo-!7(mv@R#=;DY|d|_i:6c?a(?6XsuE');
define('NONCE_SALT',       'Y2|zNYk5v=y.@4w_}1r#xC bPjoK&,nXcXeCbiOs-0(BTyjJ2}J+n*D+Z1H+;hA:');

$table_prefix = getenv_docker('WORDPRESS_TABLE_PREFIX', 'wp_');

define('WP_DEBUG', !!getenv_docker('WORDPRESS_DEBUG', ''));

if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && strpos($_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false) {
    $_SERVER['HTTPS'] = 'on';
}

if ($configExtra = getenv_docker('WORDPRESS_CONFIG_EXTRA', '')) {
    eval($configExtra);
}

if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}

require_once ABSPATH . 'wp-settings.php';
