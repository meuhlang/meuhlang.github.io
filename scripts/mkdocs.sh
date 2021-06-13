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

  if command -v mkdocs > /dev/null 2>&1; then
    cd site
    exec mkdocs "$@"
  fi

  _container build \
    --tag local/meuhlang.github.io/mkdocs:latest \
    - < ./scripts/mkdocs.Dockerfile

  _container run \
    --mount "type=bind,src=${PWD}/site,dst=/work,ro,z" \
    --workdir /work \
    --network host \
    local/meuhlang.github.io/mkdocs:latest \
    mkdocs "$@"
}

main "$@"