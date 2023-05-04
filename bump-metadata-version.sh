#!/usr/bin/env bash

sed "s/\"version\": \".*\"/\"version\": \"$1\"/" -i'' metadata.json

