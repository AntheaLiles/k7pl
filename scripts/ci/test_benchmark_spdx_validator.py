#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Tests for the repeated SPDX validator timing summarizer."""

from __future__ import annotations

import unittest

from benchmark_spdx_validator import summarize_samples, validate_repetitions


class BenchmarkSummaryTests(unittest.TestCase):
    def test_min_median_max_are_computed_for_each_timing(self) -> None:
        samples = [
            {"processWallMs": 14, "wrapperElapsedMs": 9, "validatorElapsedMs": 6},
            {"processWallMs": 10, "wrapperElapsedMs": 5, "validatorElapsedMs": 4},
            {"processWallMs": 12, "wrapperElapsedMs": 7, "validatorElapsedMs": 5},
        ]
        summary = summarize_samples(samples)
        self.assertEqual(summary["processWallMs"], {"minMs": 10.0, "medianMs": 12.0, "maxMs": 14.0})
        self.assertEqual(summary["wrapperElapsedMs"], {"minMs": 5.0, "medianMs": 7.0, "maxMs": 9.0})
        self.assertEqual(summary["validatorElapsedMs"], {"minMs": 4.0, "medianMs": 5.0, "maxMs": 6.0})

    def test_summary_requires_repeated_samples(self) -> None:
        with self.assertRaisesRegex(ValueError, "at least two samples"):
            summarize_samples([])

    def test_sample_metric_must_be_numeric(self) -> None:
        with self.assertRaisesRegex(ValueError, "missing a numeric processWallMs"):
            summarize_samples([{"processWallMs": "slow"}, {"processWallMs": "fast"}])

    def test_repetition_count_is_bounded(self) -> None:
        self.assertEqual(validate_repetitions(5), 5)
        with self.assertRaisesRegex(ValueError, "between 2 and 25"):
            validate_repetitions(1)
        with self.assertRaisesRegex(ValueError, "between 2 and 25"):
            validate_repetitions(26)


if __name__ == "__main__":
    unittest.main()
