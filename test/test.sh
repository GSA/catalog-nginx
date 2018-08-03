#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

host=nginx

function test_http () {
  local url="$1"
  local expected="$2"

  echo -n "http test $url..."
  local actual=$(curl --fail --silent "$url")
  echo "done"

  echo -n "assert $expected = $actual..."
  [ "$expected" != "$actual" ] && return 1
  echo "done"
}

test_http "http://$host/" "app"
test_http "http://$host/csw" "csw"
test_http "http://$host/csw-all" "csw-all"
