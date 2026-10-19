# SPDX-FileCopyrightText: 2026 K7PL contributors
# SPDX-License-Identifier: CC0-1.0

PYTHON ?= python3
KLEAN_PACKAGE := src/k/.build/klean-output/k7pl2lean

.PHONY: help k-check export-lean proof formal-chain test spec check clean

help:
	@printf '%s\n' 'Targets: k-check, export-lean, proof, formal-chain, test, spec, check, clean'

k-check:
	$(MAKE) -C src/k check

export-lean:
	$(MAKE) -C src/k export-lean
	$(PYTHON) -m unittest discover -s scripts/ci -p test_patch_klean_prelude.py
	$(PYTHON) scripts/ci/patch_klean_prelude.py "$(KLEAN_PACKAGE)/K7PL2Lean/Prelude.lean"
	rm -rf proofs/K7PL2Lean proofs/K7PL2Lean.lean
	cp -a "$(KLEAN_PACKAGE)/K7PL2Lean" proofs/K7PL2Lean
	cp "$(KLEAN_PACKAGE)/K7PL2Lean.lean" proofs/K7PL2Lean.lean
	test "$$(cat proofs/lean-toolchain)" = "$$(cat lean-toolchain)"

proof: export-lean
	$(MAKE) -C proofs proof

formal-chain: proof
	$(MAKE) -C spec/formal-chain build

test:
	lake test
	$(PYTHON) -m pytest tests/python

spec:
	lake exe spec --output _out/spec --with-tex

check: k-check formal-chain test

clean:
	$(MAKE) -C src/k clean
	$(MAKE) -C proofs clean
	$(MAKE) -C spec/formal-chain clean
	rm -rf .lake _out out
