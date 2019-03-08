#!/usr/bin/env bash

set -e

function generatePhpSiteConfigs()
{
    PHP_SITES=(${PHP_SITES})
    local PHP_TMPL_FILE=/etc/nginx/sites-templates/php-site.conf.tmpl
    for SITE in ${PHP_SITES[@]} ; do
        generateConfig ${PHP_TMPL_FILE} ${SITE}
    done
}

function generateStaticSiteConfigs()
{
    STATIC_SITES=(${STATIC_SITES})
    local STATIC_TMPL_FILE=/etc/nginx/sites-templates/static-site.conf.tmpl
    for SITE in ${STATIC_SITES[@]} ; do
        generateConfig ${STATIC_TMPL_FILE} ${SITE}
    done
}

function generateConfig()
{
    local TMPL_FILE=${1}
    local SITE=${2}
    local SITE_CONFIG=/etc/nginx/sites-enabled/${SITE}.conf
    echo "Generating site config for ${SITE}."
    cat ${TMPL_FILE} > ${SITE_CONFIG}
    sed -ri \
        -e "s!\{SUBDOMAIN\}!${SITE}!g" \
        ${SITE_CONFIG}
}

# Generate each sit's nginx config file.
generatePhpSiteConfigs
generateStaticSiteConfigs

nginx -g "daemon off;"
