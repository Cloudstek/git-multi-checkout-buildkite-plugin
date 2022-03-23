#!/usr/bin/env bash

docker run -it --rm -v "$PWD:/plugin:ro" --tmpfs "/workspace" buildkite/plugin-tester
