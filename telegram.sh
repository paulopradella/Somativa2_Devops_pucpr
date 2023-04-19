#!/bin/bash

# Define as variáveis de ambiente do Travis
MESSAGE="Travis build $TRAVIS_BUILD_NUMBER of $TRAVIS_REPO_SLUG/$TRAVIS_BRANCH@$TRAVIS_COMMIT by $TRAVIS_COMMIT_AUTHOR_EMAIL: $TRAVIS_COMMIT_MESSAGE"

# Envia a mensagem para o Telegram usando o token do bot e o chat ID
curl -s -X POST https://api.telegram.org/bot$TELEGRAM_TOKEN/sendMessage \
  -d chat_id=$TELEGRAM_CHAT_ID \
  -d text="$MESSAGE"
