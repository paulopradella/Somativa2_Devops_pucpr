#!/bin/sh
BOT_URL="https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage"
PARSE_MODE="Markdown"
MESSAGE=""
case $TRAVIS_BUILD_STAGE_NAME in
  "test-sast")
    MESSAGE+="*Travis CI SAST Scan #${TRAVIS_BUILD_NUMBER} (${TRAVIS_BUILD_ID}) for ${TRAVIS_REPO_SLUG}*\n\n"
    MESSAGE+="*Status*: SAST Scan completed"
    ;;
  "deploy")
    MESSAGE+="*Travis CI Deployment #${TRAVIS_BUILD_NUMBER} (${TRAVIS_BUILD_ID}) for ${TRAVIS_REPO_SLUG}*\n\n"
    MESSAGE+="*Status*: Deployment completed"
    ;;
  *)
    MESSAGE+="*Travis CI Build #${TRAVIS_BUILD_NUMBER} (${TRAVIS_BUILD_ID}) for ${TRAVIS_REPO_SLUG}*\n\n"
    MESSAGE+="*Commit Message*: ${TRAVIS_COMMIT_MESSAGE}\n"
    MESSAGE+="*Commit Author*: ${TRAVIS_COMMIT_AUTHOR}\n"
    MESSAGE+="*Commit Email*: ${TRAVIS_COMMIT_AUTHOR_EMAIL}\n\n"
    if [ $TRAVIS_TEST_RESULT -eq 0 ]; then
      MESSAGE+="*Status*: Succeeded"
      if [ "$TRAVIS_BUILD_STAGE_NAME" = "deploy" ] && [ "$TRAVIS_BRANCH" = "master" ]; then
        MESSAGE+="\n*Type*: Deployment to production"
      fi
    else
      MESSAGE+="*Status*: Failed"
    fi
    ;;
esac
if [ "$TRAVIS_EVENT_TYPE" = "pull_request" ]; then
  MESSAGE+="\n*Type*: Pull Request"
fi
MESSAGE+="\n*Log*: ${TRAVIS_BUILD_WEB_URL}"
if [ $TRAVIS_TEST_RESULT -eq 0 ] && [ "$TRAVIS_BUILD_STAGE_NAME" != "deploy" ]; then
  curl -s -X POST ${BOT_URL} -d chat_id=${TELEGRAM_CHAT_ID} -d text="${MESSAGE}" -d parse_mode=${PARSE_MODE}
fi
