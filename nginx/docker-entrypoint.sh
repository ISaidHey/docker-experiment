#!/usr/bin/env bash

set -e

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

function generateSiteConfigs()
{
    PHP_SITES=(${PHP_SITES})
    STATIC_SITES=(${STATIC_SITES})

    local PHP_TMPL_FILE=/etc/nginx/site-templates/php-site.conf.tmpl
    local STATIC_TMPL_FILE=/etc/nginx/site-templates/static-site.conf.tmpl

    # TODO This folder should already be made...
    mkdir /etc/nginx/sites-enabled

    for SITE in ${PHP_SITES[@]} ; do
        generateConfig ${PHP_TMPL_FILE} ${SITE}
    done

    for SITE in ${STATIC_SITES[@]} ; do
        generateConfig ${STATIC_TMPL_FILE} ${SITE}
    done
}

generateSiteConfigs

nginx -g "daemon off;"
