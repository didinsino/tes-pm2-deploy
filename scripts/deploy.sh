#!/bin/bash

set -e

# Load common PATH locations
export PATH=$PATH:/home/ti-didin/.bun/bin:/home/ti-didin/.nvm/versions/node/v24.4.0/bin

if [ -z "bun" ]; then
  echo "ERROR: bun tidak ditemukan di PATH"
  exit 1
fi

if [ -z "pm2" ]; then
  echo "ERROR: pm2 tidak ditemukan di PATH"
  exit 1
fi

APP_NAME="my-hono-app"

echo ">>> Installing dependencies..."
bun install

echo ">>> Starting / Reloading PM2..."
if pm2 list | grep -q "$APP_NAME"; then
  pm2 restart $APP_NAME
else
  pm2 start bun --name $APP_NAME --interpreter bun -- run src/index.ts
fi

pm2 save

echo ">>> Deploy selesai!"