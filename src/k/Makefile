# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0

PYTHON ?= python3
KOMPILE ?= kompile
KRUN ?= krun
DENO ?= deno
KLEAN ?= klean
K_BACKEND ?= llvm
DEFINITION := .build/kompiled
BOUNDARY_DEFINITION := .build/native-boundary-kompiled
GENERATED_DIR := .build/generated
K_SOURCE := $(GENERATED_DIR)/semantics.k
BOUNDARY_SOURCE := $(GENERATED_DIR)/models/native-boundary.k
PYTHON_CHECK := $(GENERATED_DIR)/check_k_examples.py
EXAMPLES := ../../tests/examples
KLEAN_OUTPUT := .build/klean-output

.PHONY: all extract-code kompile run-example check boundary-kompile boundary-check export-lean clean
all: check boundary-check

# Verso remains the editable source. Generated K/Python files live under ignored .build/.
extract-code:
	cd ../.. && lake exe spec --extract-code-only

kompile: extract-code
	mkdir -p .build
	$(KOMPILE) $(K_SOURCE) --backend $(K_BACKEND) --main-module K7PL --syntax-module K7PL-SYNTAX --output-definition $(DEFINITION)

run-example: kompile
	$(KRUN) --definition $(DEFINITION) $(EXAMPLES)/add.k7

check: kompile
	$(PYTHON) $(PYTHON_CHECK) --definition "$(DEFINITION)" --examples "$(EXAMPLES)" --krun "$(KRUN)"

# This separately compiled model is non-normative and is not exported by the default KLean pipeline.
boundary-kompile: extract-code
	mkdir -p .build
	test -s "$(BOUNDARY_SOURCE)"
	$(KOMPILE) "$(BOUNDARY_SOURCE)" --backend $(K_BACKEND) --main-module K7OS-NATIVE-BOUNDARY --syntax-module K7OS-NATIVE-BOUNDARY-SYNTAX --output-definition "$(BOUNDARY_DEFINITION)"

boundary-check: boundary-kompile
	$(DENO) run --allow-read --allow-run=krun ../../tools/ci-controller/src/os_boundary_check.ts "$(CURDIR)/$(BOUNDARY_DEFINITION)" "$(KRUN)" "$(CURDIR)/../../tests/examples/native-boundary"

export-lean: kompile
	rm -rf $(KLEAN_OUTPUT)
	mkdir -p $(KLEAN_OUTPUT)
	$(KLEAN) "$(CURDIR)/$(DEFINITION)" k7pl2lean --library K7PL2Lean --output "$(CURDIR)/$(KLEAN_OUTPUT)"

clean:
	rm -rf .build
