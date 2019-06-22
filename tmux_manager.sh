#!/bin/sh

tmux new-session \; \
  send-keys 'gotop' C-m \; \
  split-window -h -p 70 \; \
  send-keys 'htop' C-m \; 
