# SPDX-FileCopyrightText: 2026 K7PL contributors
# SPDX-License-Identifier: CC0-1.0

PYTHON ?= python3
KOMPILE ?= kompile
KRUN ?= krun
KLEAN ?= klean
K_BACKEND ?= llvm
DEFINITION := .build/kompiled
GENERATED_DIR := .build/generated
K_SOURCE := $(GENERATED_DIR)/semantics.k
PYTHON_CHECK := $(GENERATED_DIR)/check_k_examples.py
EXAMPLES := ../../tests/examples
KLEAN_OUTPUT := .build/klean-output

.PHONY: all extract-code kompile run-example check export-lean clean
all: check

# Verso remains the editable source. Generated K/Python files live under ignored .build/.
extract-code:
	cd ../.. && $(PYTHON) scripts/extract_verso_code.py

kompile: extract-code
	mkdir -p .build
	$(KOMPILE) $(K_SOURCE) --backend $(K_BACKEND) --main-module K7PL --syntax-module K7PL-SYNTAX --output-definition $(DEFINITION)

run-example: kompile
	$(KRUN) --definition $(DEFINITION) $(EXAMPLES)/add.k7

check: kompile
	$(PYTHON) $(PYTHON_CHECK) --definition "$(DEFINITION)" --examples "$(EXAMPLES)" --krun "$(KRUN)"

export-lean: kompile
	rm -rf $(KLEAN_OUTPUT)
	mkdir -p $(KLEAN_OUTPUT)
	$(KLEAN) "$(CURDIR)/$(DEFINITION)" k7pl2lean --library K7PL2Lean --output "$(CURDIR)/$(KLEAN_OUTPUT)"

clean:
	rm -rf .build
