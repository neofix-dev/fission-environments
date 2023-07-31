#!/bin/sh
cd ${SRC_PKG}
if [[ -n "$NPM_TOKEN" ]] && [[ -n "$NPM_REGISTRY" ]]; then
    npm-wrapper set //${NPM_REGISTRY}/:_authToken ${NPM_TOKEN}
fi
if [[ -d "node_modules" ]]; then
    [[ -d "node_modules/.bin" ]] && chmod +x node_modules/.bin/*
    echo "Executing npm run build..."
    npm-wrapper run build
  else
    echo "Executing npm install..."
    npm-wrapper install --no-audit --omit-dev --no-fund --no-progress --prefer-offline
fi
test $? -eq 0 && cp -r ${SRC_PKG} ${DEPLOY_PKG}
