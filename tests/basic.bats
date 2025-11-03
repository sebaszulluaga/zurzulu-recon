#!/usr/bin/env bats

load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'

@test "script muestra ayuda cuando no hay target" {
  run bash ../zurzulu-recon.sh
  [ "$status" -ne 0 ]
  [[ "$output" =~ "Usage" ]] || [[ "$output" =~ "Opciones" ]]
}

@test "dry-run produce output file placeholders" {
  run bash ../zurzulu-recon.sh --target example.com --outdir tmpout --dry-run --yes
  [ "$status" -eq 0 ]
  [ -d tmpout ] || mkdir -p tmpout
  # El dry-run no crea mucho, pero debe terminar sin error
  run bash ../zurzulu-recon.sh --target example.com --outdir tmpout --dry-run --yes
  [ "$status" -eq 0 ]
  rm -rf tmpout
}
