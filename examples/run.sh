#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_devour_fusion info
PYTHONPATH=src python -m gbt_devour_fusion check --payload '{}'
PYTHONPATH=src python -m gbt_devour_fusion run   --payload '{}'
