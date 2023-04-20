#!/bin/sh

# Set the bot URL
BOT_URL="https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage"

# Set the formatting for the message. Can be either "Markdown" or "HTML"
PARSE_MODE="Markdown"

# Define the message text
MESSAGE=""

# Check the Travis CI build phase
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
    # Add the commit message and author details
    MESSAGE+="*Commit Message*: ${TRAVIS_COMMIT_MESSAGE}\n"
    MESSAGE+="*Commit Author*: ${TRAVIS_COMMIT_AUTHOR}\n"
    MESSAGE+="*Commit Email*: ${TRAVIS_COMMIT_AUTHOR_EMAIL}\n\n"
    # Check if the build passed or failed and add the status to the message
    if [ $TRAVIS_TEST_RESULT -eq 0 ]; then
      MESSAGE+="*Status*: Build succeeded"
    else
      MESSAGE+="*Status*: Build failed"
    fi
    ;;
esac

# Add the URL to the build log to the message
MESSAGE+="\n*Log*: ${TRAVIS_BUILD_WEB_URL}"

# Send the message to the bot
curl -s -X POST ${BOT_URL} -d chat_id=${TELEGRAM_CHAT_ID} -d text="${MESSAGE}" -d parse_mode=${PARSE_MODE}
