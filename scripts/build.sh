#!/bin/bash

DIR="/home/${USER}/.local/lib/python3.9/site-packages/"

cd stable-diffusion-webui
git pull
cd ..

if [ ! -d "$DIR" ]; then
  mkdir -p "$DIR"
  echo "Папка $DIR была успешно создана."
else
  echo "Папка $DIR уже существует."
fi