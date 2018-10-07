#!/usr/bin/env bash

sudo apt install youtube-dl ffmpeg -y
bundle install
chmod +x spotify_dl
mkdir ~/.spotify_downloader
cp -r src/ ~/.spotify_downloader
cp Gemfile ~/.spotify_downloader
cp spotify_dl ~/.spotify_downloader
echo 'export PATH="$HOME/.spotify_downloader:$PATH"' >> ~/.bashrc
source ~/.bashrc
