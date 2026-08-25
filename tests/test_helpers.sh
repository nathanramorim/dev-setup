#!/usr/bin/env bash
# Helpers de asserção para os testes em tests/*.sh (bash puro, sem framework externo).

TESTS_RUN=0
TESTS_FAILED=0

_test_report() {
  local status="$1" name="$2"
  TESTS_RUN=$((TESTS_RUN + 1))
  if [[ "$status" == "ok" ]]; then
    echo "  ok   - $name"
  else
    TESTS_FAILED=$((TESTS_FAILED + 1))
    echo "  FAIL - $name"
  fi
}

assert_eq() {
  local expected="$1" actual="$2" name="$3"
  if [[ "$expected" == "$actual" ]]; then
    _test_report ok "$name"
  else
    _test_report fail "$name"
    echo "       esperado: $expected"
    echo "       obtido:   $actual"
  fi
}

assert_contains() {
  local haystack="$1" needle="$2" name="$3"
  if [[ "$haystack" == *"$needle"* ]]; then
    _test_report ok "$name"
  else
    _test_report fail "$name"
    echo "       esperava conter: $needle"
    echo "       saída:           $haystack"
  fi
}

assert_true() {
  local exit_code="$1" name="$2"
  if [[ "$exit_code" == "0" ]]; then
    _test_report ok "$name"
  else
    _test_report fail "$name"
    echo "       exit code esperado 0, obtido $exit_code"
  fi
}

assert_file_absent() {
  local path="$1" name="$2"
  if [[ ! -e "$path" ]]; then
    _test_report ok "$name"
  else
    _test_report fail "$name"
    echo "       arquivo NÃO deveria existir: $path"
  fi
}

test_suite_summary() {
  echo
  echo "$TESTS_RUN teste(s), $TESTS_FAILED falha(s)"
  [[ "$TESTS_FAILED" -eq 0 ]]
}
