#!/bin/bash
git remote add dokku ${DEPLOY_REPO_URI}
git push dokku master:master