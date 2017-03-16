#!/bin/bash

if [[ "$CIRCLECI" == 'true' ]]; then
    echo "$CIRCLE_BRANCH"
    exit 0
fi

if [[ "$TRAVIS_PULL_REQUEST" == 'false' ]]; then
    echo "$TRAVIS_BRANCH"
else
    URL="https://api.github.com/repos/$TRAVIS_REPO_SLUG/pulls/$TRAVIS_PULL_REQUEST"
    RESULT=$(curl -X GET -u "$GITHUB_ACCESS_TOKEN":x-oauth-basic "$URL" | jq -r '.head.ref')
    if [[ "$RESULT" == 'null' ]]; then
        TRAVIS_BRANCH=''
    else
        TRAVIS_BRANCH="${RESULT//\"}"
    fi
    echo "$TRAVIS_BRANCH"
fi
