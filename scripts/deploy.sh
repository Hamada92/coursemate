#!/bin/bash
git remote add dokku ${DEPLOY_REPO_URI}:${DOMAIN}
git push dokku master:master
ssh ${DEPLOY_REPO_URI} run ${DOMAIN} rake db:migrate