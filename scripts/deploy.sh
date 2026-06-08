#!/bin/bash

set -e

# Load common PATH locations
export PATH=$PATH:/home/ti-didin/.bun/bin:/usr/local/bin:/usr/bin

# Ambil path dinamis
BUN=$(which bun)
PM2=$(which pm2)

# Validasi
if [ -z "$BUN" ]; then
  echo "ERROR: bun tidak ditemukan di PATH"
  exit 1
fi

if [ -z "$PM2" ]; then
  echo "ERROR: pm2 tidak ditemukan di PATH"
  exit 1
fi

echo ">>> Menggunakan BUN  : $BUN"
echo ">>> Menggunakan PM2  : $PM2"

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