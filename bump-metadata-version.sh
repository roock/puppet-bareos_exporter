#!/bin/bash

sed -i '' -E "s/\"version\": \".*\"/\"version\": \"$1\"/" metadata.json

