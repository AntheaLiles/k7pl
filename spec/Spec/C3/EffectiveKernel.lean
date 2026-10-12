-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

import Mathlib.Algebra.Order.Ring.Basic
import Mathlib.Algebra.Order.Ring.NNRat
import Mathlib.Algebra.Order.Ring.WithTop
import Mathlib.Data.ENat.Lattice

/-!
## Noyau Lean exécutable des règles C3 (fragment projeté)

Ce noyau appartient à la source de la spécification : il est une racine de la bibliothèque
Lake `Spec`, si bien que `lake build Spec` compile ces définitions. Il est tenu hors des
modules Verso du document : importer Mathlib y rendrait ambiguë la directive de lemme de
`SpecExt`, homonyme de la commande `lemma` de Mathlib. Les contextes du jugement ci-dessous représentent
explicitement l'observation d'usage π_U ; ils ne prétendent pas implémenter
la composition complète ⊠, la consommation de budget ou la transformation
d'effet ψ. La flèche conserve néanmoins le grade complet à quatre
coordonnées, et App ne projette ce grade que pour mettre le contexte d'argument
à l'échelle. Les règles non présentes dans ce fragment restent non formalisées.
-/

set_option linter.unusedVariables false

namespace K7pl.Spec.C3.EffectiveKernel

universe uVar uMono uLevel uEffect uLayer

/-- Portée normative d'usage : rationnels non négatifs et usage non borné. -/
abbrev Usage := WithTop ℚ≥0

/-- Le grade complet : usage, coordonnée monotone, niveau et budget. -/
structure Grade (Monotonicity : Type uMono) (Level : Type uLevel) where
  usage : Usage
  monotonicity : Monotonicity
  level : Level
  budget : ℕ∞

/-- π_U observe uniquement la composante d'usage du grade complet. -/
def piU {Monotonicity : Type uMono} {Level : Type uLevel}
    (r : Grade Monotonicity Level) : Usage :=
  r.usage

/-- Scale_Usage agit sur l'usage et conserve les trois autres coordonnées. -/
def scaleUsage {Monotonicity : Type uMono} {Level : Type uLevel}
    (a : Usage) (r : Grade Monotonicity Level) : Grade Monotonicity Level :=
  { r with usage := a * r.usage }

@[simp] theorem scaleUsage_usage {Monotonicity : Type uMono} {Level : Type uLevel}
    (a : Usage) (r : Grade Monotonicity Level) :
    (scaleUsage a r).usage = a * r.usage := rfl

@[simp] theorem scaleUsage_monotonicity {Monotonicity : Type uMono} {Level : Type uLevel}
    (a : Usage) (r : Grade Monotonicity Level) :
    (scaleUsage a r).monotonicity = r.monotonicity := rfl

@[simp] theorem scaleUsage_level {Monotonicity : Type uMono} {Level : Type uLevel}
    (a : Usage) (r : Grade Monotonicity Level) :
    (scaleUsage a r).level = r.level := rfl

@[simp] theorem scaleUsage_budget {Monotonicity : Type uMono} {Level : Type uLevel}
    (a : Usage) (r : Grade Monotonicity Level) :
    (scaleUsage a r).budget = r.budget := rfl

theorem scaleUsage_one {Monotonicity : Type uMono} {Level : Type uLevel}
    (r : Grade Monotonicity Level) :
    scaleUsage (1 : Usage) r = r := by
  cases r
  simp [scaleUsage]

theorem scaleUsage_comp {Monotonicity : Type uMono} {Level : Type uLevel}
    (a b : Usage) (r : Grade Monotonicity Level) :
    scaleUsage a (scaleUsage b r) = scaleUsage (a * b) r := by
  cases r
  simp [scaleUsage, mul_assoc]

/-- Type grammar for the executable core fragment. -/
inductive ValueType where
  | base : String → ValueType
  | unit : ValueType
  | tensor : ValueType → ValueType → ValueType
  deriving DecidableEq, Repr

/-- The value grammar for Var, Pair and the unit value. -/
inductive Value (Var : Type uVar) where
  | var : Var → Value Var
  | unit : Value Var
  | pair : Value Var → Value Var → Value Var
  deriving DecidableEq, Repr

/-- The computation grammar for Ret, Lam and App.
Lam carries its elaborated full grade explicitly. -/
inductive Computation (Var : Type uVar) (Monotonicity : Type uMono) (Level : Type uLevel) where
  | ret : Value Var → Computation Var Monotonicity Level
  | lam : Var → ValueType → Grade Monotonicity Level →
      Computation Var Monotonicity Level → Computation Var Monotonicity Level
  | app : Computation Var Monotonicity Level → Value Var →
      Computation Var Monotonicity Level
  | let1 : Computation Var Monotonicity Level → Var →
      Computation Var Monotonicity Level → Computation Var Monotonicity Level

/-- Computation types include effect-return and graded function types. -/
inductive ComputationType (Effect : Type uEffect) (Monotonicity : Type uMono) (Level : Type uLevel) where
  | returned : Effect → ValueType → ComputationType Effect Monotonicity Level
  | arrow : Grade Monotonicity Level → ValueType →
      ComputationType Effect Monotonicity Level → Effect →
      ComputationType Effect Monotonicity Level

/-- A type environment is distinct from its quantitative usage context. -/
abbrev TypeEnv (Var : Type uVar) := Var → Option ValueType

/-- The usage observation of a typing context: π_U at each binding. -/
abbrev UsageContext (Var : Type uVar) := Var → Usage

/-- Effect-indexed observation of context composition; kept explicit to preserve
the layer-specific meaning of the normative context operator. -/
abbrev ContextComposition (Var : Type uVar) (Effect : Type uEffect)
    (Layer : Type uLayer) :=
  Layer → Effect → UsageContext Var → UsageContext Var → UsageContext Var

def emptyTypeEnv {Var : Type uVar} : TypeEnv Var := fun _ => none

def zeroContext {Var : Type uVar} : UsageContext Var := fun _ => 0

def addContext {Var : Type uVar}
    (left right : UsageContext Var) : UsageContext Var :=
  fun x => left x + right x

/-- Pointwise scaling uses the usage projection, not the complete grade. -/
def scaleContext {Var : Type uVar}
    (r : Usage) (context : UsageContext Var) : UsageContext Var :=
  fun x => r * context x

def singletonContext {Var : Type uVar} [DecidableEq Var] (x : Var) : UsageContext Var :=
  fun y => if y = x then 1 else 0

def eraseContext {Var : Type uVar} [DecidableEq Var]
    (x : Var) (context : UsageContext Var) : UsageContext Var :=
  fun y => if y = x then 0 else context y

def extendTypeEnv {Var : Type uVar} [DecidableEq Var]
    (env : TypeEnv Var) (x : Var) (A : ValueType) : TypeEnv Var :=
  fun y => if y = x then some A else env y

@[simp] theorem addContext_assoc {Var : Type uVar}
    (Γ Δ Θ : UsageContext Var) :
    addContext (addContext Γ Δ) Θ = addContext Γ (addContext Δ Θ) := by
  funext x
  simp [addContext, add_assoc]

@[simp] theorem scaleContext_add {Var : Type uVar}
    (r : Usage) (Γ Δ : UsageContext Var) :
    scaleContext r (addContext Γ Δ) =
      addContext (scaleContext r Γ) (scaleContext r Δ) := by
  funext x
  simp [scaleContext, addContext, mul_add]

@[simp] theorem scaleContext_comp {Var : Type uVar}
    (r s : Usage) (Γ : UsageContext Var) :
    scaleContext r (scaleContext s Γ) = scaleContext (r * s) Γ := by
  funext x
  simp [scaleContext, mul_assoc]

@[simp] theorem eraseContext_singleton {Var : Type uVar} [DecidableEq Var]
    (x : Var) :
    eraseContext x (singletonContext x) = zeroContext := by
  funext y
  by_cases h : y = x <;> simp [eraseContext, singletonContext, zeroContext, h]

/-- The value rules in the current executable fragment. -/
inductive ValueTyping {Var : Type uVar} [DecidableEq Var]
    (env : TypeEnv Var) :
    UsageContext Var → Value Var → ValueType → Prop where
  | var {x A} (lookup : env x = some A) :
      ValueTyping env (singletonContext x) (.var x) A
  | unit :
      ValueTyping env zeroContext .unit .unit
  | pair {Γ Δ v w A B}
      (left : ValueTyping env Γ v A)
      (right : ValueTyping env Δ w B) :
      ValueTyping env (addContext Γ Δ) (.pair v w) (.tensor A B)

/-- Effective resource-sensitive rules Ret, Lam and App on π_U.
The effect carrier and composition operation are explicit parameters; no
algebraic laws for effects are assumed by this inductive definition.
The type environment is an index, not a parameter, because Lam and Let extend it
in their premises. -/
inductive ComputationTyping {Var : Type uVar} [DecidableEq Var]
    {Effect : Type uEffect} {Monotonicity : Type uMono} {Level : Type uLevel}
    {Layer : Type uLayer} (layer : Layer)
    (contextCombine : ContextComposition Var Effect Layer)
    (effectOne : Effect) (effectMul : Effect → Effect → Effect) :
    TypeEnv Var → UsageContext Var → Computation Var Monotonicity Level →
    ComputationType Effect Monotonicity Level → Effect → Prop where
  | ret {env : TypeEnv Var} {Γ value A}
      (typedValue : ValueTyping env Γ value A) :
      ComputationTyping layer contextCombine effectOne effectMul env Γ (.ret value)
        (.returned effectOne A) effectOne
  | lam {env : TypeEnv Var} {Γ x A r body C ε}
      (fresh : env x = none)
      (boundUsage : Γ x = piU r)
      (typedBody : ComputationTyping layer contextCombine effectOne effectMul
        (extendTypeEnv env x A) Γ body C ε) :
      ComputationTyping layer contextCombine effectOne effectMul env (eraseContext x Γ)
        (.lam x A r body) (.arrow r A C ε) effectOne
  | app {env : TypeEnv Var} {Γ Δ function argument r A C ε₀ ε}
      (typedFunction : ComputationTyping layer contextCombine effectOne effectMul env Γ function
        (.arrow r A C ε) ε₀)
      (typedArgument : ValueTyping env Δ argument A) :
      ComputationTyping layer contextCombine effectOne effectMul env
        (contextCombine layer ε₀ Γ (scaleContext (piU r) Δ))
        (.app function argument) C (effectMul ε₀ ε)
  | let1 {env : TypeEnv Var} {Γ₁ Γ₂ x A first body C ε₁ ε₂}
      (fresh : env x = none)
      (typedFirst : ComputationTyping layer contextCombine effectOne effectMul env Γ₁ first
        (.returned ε₁ A) ε₁)
      (boundUsage : Γ₂ x = 1)
      (typedBody : ComputationTyping layer contextCombine effectOne effectMul
        (extendTypeEnv env x A) Γ₂ body C ε₂) :
      ComputationTyping layer contextCombine effectOne effectMul env
        (contextCombine layer ε₁ Γ₁ (eraseContext x Γ₂))
        (.let1 first x body) C (effectMul ε₁ ε₂)

/-- A typed identity computation exists for every effect algebra and base type.
This exercises the actual Var, Ret and Lam constructors in the kernel. -/
theorem identityComputationTypable
    {Var : Type uVar} [DecidableEq Var]
    {Effect : Type uEffect} {Monotonicity : Type uMono} {Level : Type uLevel}
    {Layer : Type uLayer} (layer : Layer)
    (contextCombine : ContextComposition Var Effect Layer)
    (effectOne : Effect) (effectMul : Effect → Effect → Effect)
    (x : Var) (A : ValueType) (m : Monotonicity) (ℓ : Level)
    (β : ℕ∞) :
    ComputationTyping layer contextCombine effectOne effectMul emptyTypeEnv zeroContext
      (.lam x A ({ usage := 1, monotonicity := m, level := ℓ, budget := β })
        (.ret (.var x)))
      (.arrow ({ usage := 1, monotonicity := m, level := ℓ, budget := β })
        A (.returned effectOne A) effectOne) effectOne := by
  have bodyTyping :
      ComputationTyping layer contextCombine effectOne effectMul
        (extendTypeEnv emptyTypeEnv x A) (singletonContext x)
        (.ret (.var x) : Computation Var Monotonicity Level)
        (.returned effectOne A) effectOne :=
    ComputationTyping.ret (ValueTyping.var (by simp [extendTypeEnv]))
  have lambdaTyping :
      ComputationTyping layer contextCombine effectOne effectMul emptyTypeEnv
        (eraseContext x (singletonContext x))
        (.lam x A ({ usage := 1, monotonicity := m, level := ℓ, budget := β })
          (.ret (.var x)))
        (.arrow ({ usage := 1, monotonicity := m, level := ℓ, budget := β })
          A (.returned effectOne A) effectOne) effectOne :=
    ComputationTyping.lam (by rfl) (by simp [singletonContext, piU]) bodyTyping
  rw [eraseContext_singleton] at lambdaTyping
  exact lambdaTyping


/-- A concrete `Let` derivation: bind the unit value and return the bound variable.
The context-composition operator remains layer/effect-indexed; this theorem
does not assume it is pointwise addition. -/
theorem letUnitTypable
    {Var : Type uVar} [DecidableEq Var]
    {Effect : Type uEffect} {Monotonicity : Type uMono} {Level : Type uLevel}
    {Layer : Type uLayer} (layer : Layer)
    (contextCombine : ContextComposition Var Effect Layer)
    (effectOne : Effect) (effectMul : Effect → Effect → Effect)
    (x : Var) :
    ComputationTyping layer contextCombine effectOne effectMul emptyTypeEnv
      (contextCombine layer effectOne zeroContext
        (eraseContext x (singletonContext x)))
      (.let1 (.ret .unit) x (.ret (.var x)) : Computation Var Monotonicity Level)
      (.returned effectOne .unit) (effectMul effectOne effectOne) :=
  ComputationTyping.let1 (by rfl) (ComputationTyping.ret ValueTyping.unit)
    (by simp [singletonContext])
    (ComputationTyping.ret (ValueTyping.var (by simp [extendTypeEnv])))


/-- A concrete application derivation for the identity function applied to unit.
This exercises the effective App constructor while retaining the layer/effect-indexed
context-composition contract instead of silently replacing it by addition. -/
theorem applicationOfIdentityTypable
    {Var : Type uVar} [DecidableEq Var]
    {Effect : Type uEffect} {Monotonicity : Type uMono} {Level : Type uLevel}
    {Layer : Type uLayer} (layer : Layer)
    (contextCombine : ContextComposition Var Effect Layer)
    (effectOne : Effect) (effectMul : Effect → Effect → Effect)
    (x : Var) (m : Monotonicity) (ℓ : Level) (β : ℕ∞) :
    let r : Grade Monotonicity Level :=
      { usage := 1, monotonicity := m, level := ℓ, budget := β }
    ComputationTyping layer contextCombine effectOne effectMul emptyTypeEnv
      (contextCombine layer effectOne zeroContext (scaleContext (piU r) zeroContext))
      (.app (.lam x .unit r (.ret (.var x))) .unit)
      (.returned effectOne .unit) (effectMul effectOne effectOne) :=
  ComputationTyping.app
    (identityComputationTypable layer contextCombine effectOne effectMul x .unit m ℓ β)
    ValueTyping.unit

end K7pl.Spec.C3.EffectiveKernel
