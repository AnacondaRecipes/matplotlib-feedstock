#!/bin/bash
set -ex

export AR=$GCC_AR

$PYTHON -m pip install . --no-deps --no-build-isolation -vv
