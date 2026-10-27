# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0

PYTHON ?= python3
DENO ?= deno
KOMPILE ?= kompile
KRUN ?= krun
KAST ?= kast
KLEAN ?= klean
K_BACKEND ?= llvm
LEXICON := ../../lexicon
DEFINITION := .build/kompiled
BOUNDARY_DEFINITION := .build/native-boundary-kompiled
LAYERS_DEFINITION := .build/layers-kompiled
BALANCE_DEFINITION := .build/balance-kompiled
GENERATED_DIR := .build/generated
K_SOURCE := $(LEXICON)/lexicon.k
BOUNDARY_SOURCE := $(LEXICON)/models/native-boundary.k
LAYERS_SOURCE := $(LEXICON)/syntax/refusals.k
BALANCE_SOURCE := $(LEXICON)/syntax/balance.k
PYTHON_CHECK := $(GENERATED_DIR)/check_k_examples.py
EXAMPLES := ../../tests/examples
KLEAN_OUTPUT := .build/klean-output

.PHONY: all extract-code kompile run-example check boundary-kompile boundary-check layers-kompile balance-kompile layers-check export-lean clean
all: check boundary-check layers-check

# The K sources live in lexicon/, which the Verso K blocks display. Verso still generates the
# Python checker under ignored .build/, and checks that every K file of lexicon/ is displayed.
extract-code:
	cd ../.. && lake exe spec --extract-code-only

kompile:
	mkdir -p .build
	$(KOMPILE) $(K_SOURCE) --backend $(K_BACKEND) --main-module LEXICON --syntax-module LEXICON --output-definition $(DEFINITION)

run-example: kompile
	$(KRUN) --definition $(DEFINITION) $(EXAMPLES)/add.k7

check: kompile extract-code
	$(PYTHON) $(PYTHON_CHECK) --definition "$(DEFINITION)" --examples "$(EXAMPLES)" --krun "$(KRUN)"

# This separately compiled model is non-normative and is not exported by the default KLean pipeline.
boundary-kompile:
	mkdir -p .build
	test -s "$(BOUNDARY_SOURCE)"
	$(KOMPILE) "$(BOUNDARY_SOURCE)" --backend $(K_BACKEND) --main-module NATIVE-BOUNDARY --syntax-module NATIVE-BOUNDARY --output-definition "$(BOUNDARY_DEFINITION)"

boundary-check: boundary-kompile
	$(DENO) run --allow-read --allow-run=krun ../../tools/ci-controller/src/os_boundary_check.ts "$(CURDIR)/$(BOUNDARY_DEFINITION)" "$(KRUN)" "$(CURDIR)/../../tests/examples/native-boundary"

# The grammar of the layers reads texts with a Bison parser; its rules emit the code and the
# message of each refused inclusion of delimiters.
layers-kompile:
	mkdir -p .build
	$(KOMPILE) "$(LAYERS_SOURCE)" --backend $(K_BACKEND) --main-module REFUSALS --syntax-module TOKENS --gen-bison-parser --output-definition "$(LAYERS_DEFINITION)"

# The balance reader reads a text as a stream of delimiters, so that delimiters that do not pair
# are reported with their lines instead of failing to parse.
balance-kompile:
	mkdir -p .build
	$(KOMPILE) "$(BALANCE_SOURCE)" --backend $(K_BACKEND) --main-module BALANCE --syntax-module SCANNER --gen-bison-parser --output-definition "$(BALANCE_DEFINITION)"

# Checks the listings of the specification and the .k7 files with both readers, which must agree,
# the codes and messages that K emits against annex A, the lexical probes of tests/lexical/ and
# the glyphs of the reader against the table of chapter 1.
layers-check: layers-kompile balance-kompile
	cd ../.. && $(DENO) run --allow-read --allow-write --allow-run tools/layer-check/src/main.ts check --definition "src/k/$(LAYERS_DEFINITION)" --balance "src/k/$(BALANCE_DEFINITION)" --krun "$(KRUN)" --kast "$(KAST)"

export-lean: kompile
	rm -rf $(KLEAN_OUTPUT)
	mkdir -p $(KLEAN_OUTPUT)
	$(KLEAN) "$(CURDIR)/$(DEFINITION)" k7pl2lean --library K7PL2Lean --output "$(CURDIR)/$(KLEAN_OUTPUT)"

clean:
	rm -rf .build
