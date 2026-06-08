#!/bin/bash

set -e  # stop jika ada error

# Load PATH
export PATH=$PATH:/home/ti-didin/.bun/bin:/usr/local/bin

BUN=/home/ti-didin/.bun/bin/bun
PM2=/home/ti-didin/.nvm/versions/node/v24.4.0/bin/pm2
APP_NAME="my-hono-app"

echo ">>> Installing dependencies..."
$BUN install

echo ">>> Starting / Reloading PM2..."
if $PM2 list | grep -q "$APP_NAME"; then
  $PM2 restart $APP_NAME
else
  $PM2 start $BUN --name $APP_NAME --interpreter none -- run src/index.ts
fi

$PM2 save

echo ">>> Deploy selesai!"