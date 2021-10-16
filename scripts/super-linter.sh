#!/usr/bin/env sh

set -o errexit
set -o nounset

main() {
  cd "$(dirname "$0")/.."

  docker run \
    --env RUN_LOCAL=true \
    --mount "type=bind,src=${PWD},dst=/tmp/lint" \
    github/super-linter:v4.8.1
}

main "$@"
