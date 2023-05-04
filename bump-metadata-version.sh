#!/usr/bin/env bash

bash --version

set -x

sed -i '' -E "s/\"version\": \".*\"/\"version\": \"$1\"/" metadata.json

