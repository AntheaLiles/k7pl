# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Executable finite-model regressions for the C-05 cost-aggregator audit.

These tests model finite level families over an illustrative extended-natural
chain. They are not a Lean formalisation, do not test suprema over genuinely
infinite families, and do not decide whether normative Cost_Budget is total.
"""

from __future__ import annotations

import unittest
from itertools import chain, combinations
from typing import TypeAlias


class _Omega:
    def __repr__(self) -> str:
        return "ω"


OMEGA = _Omega()
NInf: TypeAlias = int | _Omega
Family: TypeAlias = list[tuple[NInf, NInf]]


def valid_value(value: object) -> bool:
    return value is OMEGA or (isinstance(value, int) and not isinstance(value, bool) and value >= 0)


def validate_family(family: list[tuple[object, object]]) -> None:
    for level, pair in enumerate(family):
        if not isinstance(pair, tuple) or len(pair) != 2:
            raise TypeError(f"level {level}: expected a (work, depth) pair")
        if not valid_value(pair[0]) or not valid_value(pair[1]):
            raise ValueError(f"level {level}: coordinates must be in N ∪ {{ω}}")


def leq(left: NInf, right: NInf) -> bool:
    if right is OMEGA:
        return True
    if left is OMEGA:
        return False
    return left <= right


def ext_add(left: NInf, right: NInf) -> NInf:
    if left is OMEGA or right is OMEGA:
        return OMEGA
    return left + right


def ext_max(left: NInf, right: NInf) -> NInf:
    return right if leq(left, right) else left


def sup(values: list[NInf]) -> NInf:
    # The model convention for the empty supremum is bottom = 0.
    if not values:
        return 0
    result: NInf = 0
    for value in values:
        result = ext_max(result, value)
    return result


def all_subsets(values: list[NInf]):
    return chain.from_iterable(combinations(values, size) for size in range(len(values) + 1))


def work_aggregate(family: Family) -> NInf:
    """Finite-index instance of sup over all finite-subset work sums."""
    validate_family(family)
    sums = [0]
    for subset in all_subsets([work for work, _depth in family]):
        total: NInf = 0
        for value in subset:
            total = ext_add(total, value)
        sums.append(total)
    return sup(sums)


def depth_aggregate(family: Family) -> NInf:
    """Pointwise depth supremum for a finite-index instance."""
    validate_family(family)
    return sup([depth for _work, depth in family])


def candidate_cost(family: Family) -> NInf:
    """Total max candidate in this model only, not normative Cost_Budget."""
    return ext_max(work_aggregate(family), depth_aggregate(family))


def pointwise_leq(left: Family, right: Family) -> bool:
    if len(left) != len(right):
        raise ValueError("families must use the same finite level carrier")
    return all(
        leq(w1, w2) and leq(s1, s2)
        for (w1, s1), (w2, s2) in zip(left, right)
    )


def compose_sequence(left: Family, right: Family) -> Family:
    if len(left) != len(right):
        raise ValueError("families must use the same finite level carrier")
    return [
        (ext_add(w1, w2), ext_add(s1, s2))
        for (w1, s1), (w2, s2) in zip(left, right)
    ]


def compose_parallel(left: Family, right: Family) -> Family:
    if len(left) != len(right):
        raise ValueError("families must use the same finite level carrier")
    return [
        (ext_add(w1, w2), ext_max(s1, s2))
        for (w1, s1), (w2, s2) in zip(left, right)
    ]


class CostAggregatorModelTests(unittest.TestCase):
    def test_finite_work_depth_and_scalar_upper_bound(self) -> None:
        family: Family = [(2, 5), (3, 1)]
        self.assertEqual(work_aggregate(family), 5)
        self.assertEqual(depth_aggregate(family), 5)
        self.assertEqual(candidate_cost(family), 5)
        self.assertTrue(leq(work_aggregate(family), candidate_cost(family)))
        self.assertTrue(leq(depth_aggregate(family), candidate_cost(family)))

    def test_empty_level_carrier_exposes_when_counterexample(self) -> None:
        empty: Family = []
        # Under sup(empty)=0, the only empty-indexed family has zero candidate cost.
        self.assertEqual(work_aggregate(empty), 0)
        self.assertEqual(depth_aggregate(empty), 0)
        self.assertEqual(candidate_cost(empty), 0)
        # Therefore Cost(kappa_omega)=omega needs a nonempty level carrier
        # (or a separately justified alternative convention).
        self.assertIsNot(candidate_cost(empty), OMEGA)

    def test_explicit_infinite_coordinate_produces_omega(self) -> None:
        self.assertIs(work_aggregate([(OMEGA, 0)]), OMEGA)
        self.assertIs(depth_aggregate([(0, OMEGA)]), OMEGA)
        self.assertIs(candidate_cost([(OMEGA, 1)]), OMEGA)
        self.assertIs(candidate_cost([(1, OMEGA)]), OMEGA)

    def test_increasing_finite_prefixes_are_only_bounded_witnesses(self) -> None:
        # Each executable input is finite; these tests do not compute an infinite supremum.
        for size in (1, 2, 8, 32):
            self.assertEqual(work_aggregate([(1, 0)] * size), size)
            self.assertEqual(depth_aggregate([(0, n) for n in range(1, size + 1)]), size)

    def test_pointwise_monotonicity(self) -> None:
        smaller: Family = [(0, 0), (2, 1), (3, 4)]
        larger: Family = [(1, 2), (4, 3), (OMEGA, OMEGA)]
        self.assertTrue(pointwise_leq(smaller, larger))
        self.assertTrue(leq(work_aggregate(smaller), work_aggregate(larger)))
        self.assertTrue(leq(depth_aggregate(smaller), depth_aggregate(larger)))
        self.assertTrue(leq(candidate_cost(smaller), candidate_cost(larger)))

    def test_maximal_scalar_is_minimal_common_upper_bound(self) -> None:
        family: Family = [(2, 6), (5, 1)]
        work = work_aggregate(family)
        depth = depth_aggregate(family)
        candidate = candidate_cost(family)
        self.assertEqual(candidate, max(work, depth))
        for scalar in (candidate, OMEGA):
            self.assertTrue(leq(work, scalar))
            self.assertTrue(leq(depth, scalar))
            self.assertTrue(leq(candidate, scalar))
        for too_small in range(0, int(candidate)):
            self.assertFalse(leq(work, too_small) and leq(depth, too_small))

    def test_zero_family(self) -> None:
        zero: Family = [(0, 0), (0, 0), (0, 0)]
        self.assertEqual(work_aggregate(zero), 0)
        self.assertEqual(depth_aggregate(zero), 0)
        self.assertEqual(candidate_cost(zero), 0)

    def test_sequence_work_additive_depth_only_subadditive(self) -> None:
        left: Family = [(0, 1), (0, 0)]
        right: Family = [(0, 0), (0, 1)]
        combined = compose_sequence(left, right)
        self.assertEqual(work_aggregate(combined), ext_add(work_aggregate(left), work_aggregate(right)))
        self.assertEqual(depth_aggregate(combined), 1)
        self.assertEqual(ext_add(depth_aggregate(left), depth_aggregate(right)), 2)
        self.assertLess(depth_aggregate(combined), ext_add(depth_aggregate(left), depth_aggregate(right)))

        left_with_work: Family = [(1, 2), (3, 0)]
        right_with_work: Family = [(4, 1), (2, 5)]
        seq = compose_sequence(left_with_work, right_with_work)
        self.assertEqual(work_aggregate(seq), ext_add(work_aggregate(left_with_work), work_aggregate(right_with_work)))
        self.assertTrue(
            leq(depth_aggregate(seq), ext_add(depth_aggregate(left_with_work), depth_aggregate(right_with_work)))
        )
        self.assertTrue(
            leq(candidate_cost(seq), ext_add(candidate_cost(left_with_work), candidate_cost(right_with_work)))
        )

    def test_parallel_work_additive_depth_is_max(self) -> None:
        left: Family = [(1, 1), (3, 0)]
        right: Family = [(4, 0), (2, 7)]
        parallel = compose_parallel(left, right)
        self.assertEqual(work_aggregate(parallel), ext_add(work_aggregate(left), work_aggregate(right)))
        self.assertEqual(depth_aggregate(parallel), ext_max(depth_aggregate(left), depth_aggregate(right)))
        self.assertTrue(
            leq(candidate_cost(parallel), ext_add(candidate_cost(left), candidate_cost(right)))
        )

    def test_omega_arithmetic_and_common_carrier_requirement(self) -> None:
        self.assertIs(ext_add(OMEGA, 0), OMEGA)
        self.assertIs(ext_add(7, OMEGA), OMEGA)
        self.assertIs(ext_max(7, OMEGA), OMEGA)
        with self.assertRaises(ValueError):
            pointwise_leq([(1, 2)], [(1, 2), (0, 0)])

    def test_invalid_coordinates_are_outside_the_stated_carrier(self) -> None:
        with self.assertRaises(ValueError):
            work_aggregate([(-1, 0)])  # negative work is not in N ∪ {omega}
        with self.assertRaises(ValueError):
            depth_aggregate([(0, 1.5)])  # a non-integer depth is not in N ∪ {omega}
        with self.assertRaises(TypeError):
            work_aggregate([(0, 1, 2)])  # malformed temporal pair


if __name__ == "__main__":
    unittest.main()
