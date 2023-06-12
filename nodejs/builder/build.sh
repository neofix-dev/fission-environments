#!/bin/sh
cd ${SRC_PKG}
if [[ -n "$NPM_TOKEN" ]] && [[ -n "$NPM_REGISTRY" ]]; then
    npm-wrapper set //${NPM_REGISTRY}/:_authToken ${NPM_TOKEN}
fi
npm-wrapper install --no-audit --omit-dev --no-fund && cp -r ${SRC_PKG} ${DEPLOY_PKG}
