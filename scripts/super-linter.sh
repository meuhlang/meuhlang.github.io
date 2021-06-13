#!/usr/bin/env sh

set -o errexit
set -o nounset

_container() {
  if comand -v docker > /dev/null 2>&1; then
    docker "$@"
  elif command -v podman > /dev/null 2>&1; then
    podman "$@"
  else
    echo "No linux containers implementations found." >&2
    return 1
  fi
}

main() {
  cd "$(dirname "$0")/.."

  _container run \
    --env FILTER_REGEX_EXCLUDE=site/docs/about/license.md \
    --env RUN_LOCAL=true \
    --env VALIDATE_CSS=false \
    --env VALIDATE_JAVASCRIPT_ES=false \
    --env VALIDATE_JAVASCRIPT_STANDARD=false \
    --mount "type=bind,src=${PWD},dst=/tmp/lint,z" \
    github/super-linter:v4
}

main "$@"
