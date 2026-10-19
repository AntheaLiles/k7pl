# SPDX-FileCopyrightText: 2026 K7PL contributors
# SPDX-License-Identifier: CC0-1.0

KOMPILE ?= kompile
KRUN ?= krun
KLEAN ?= klean
K_BACKEND ?= llvm
DEFINITION := .build/kompiled
EXAMPLES := ../../tests/examples
KLEAN_OUTPUT := .build/klean-output

.PHONY: all kompile run-example check export-lean clean
all: check

kompile:
	mkdir -p .build
	$(KOMPILE) semantics.k --backend $(K_BACKEND) --main-module K7PL --syntax-module K7PL-SYNTAX --output-definition $(DEFINITION)

run-example: kompile
	$(KRUN) --definition $(DEFINITION) $(EXAMPLES)/add.k7

check: kompile
	@set -eu; \
	output="$$($(KRUN) --definition $(DEFINITION) $(EXAMPLES)/add.k7)"; \
	printf '%s\n' "$$output"; \
	printf '%s\n' "$$output" | grep -Eq '(^|[^[:digit:]])6([^[:digit:]]|$$)' || { echo "add example did not reduce to 6" >&2; exit 1; }; \
	output="$$($(KRUN) --definition $(DEFINITION) $(EXAMPLES)/select.k7)"; \
	printf '%s\n' "$$output"; \
	printf '%s\n' "$$output" | grep -Eq '(^|[^[:digit:]])3([^[:digit:]]|$$)' || { echo "select example did not reduce to 3" >&2; exit 1; }

export-lean: kompile
	rm -rf $(KLEAN_OUTPUT)
	mkdir -p $(KLEAN_OUTPUT)
	$(KLEAN) "$(CURDIR)/$(DEFINITION)" k7pl2lean --library K7PL2Lean --output "$(CURDIR)/$(KLEAN_OUTPUT)"

clean:
	rm -rf .build
