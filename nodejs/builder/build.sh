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
    echo "Executing npm run test..."
    npm-wrapper run test
fi
if test $? -eq 0
then
    cp -r ${SRC_PKG} ${DEPLOY_PKG}
else
  printf "Build failed.\n"
  printf "Contents of source package:\n"
  find .
  printf "---\nContents of functionCode.js:\n---\n"
  cat functionCode.js
  printf "---\nContents of test.js:\n---\n"
  cat test.js
fi