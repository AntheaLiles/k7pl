// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/** Component registry: loading and validation of .github/ci/components.yaml. */

import {
  asList,
  asRecord,
  asString,
  asStringList,
  parseYaml,
  type YamlValue,
} from "./yaml.ts";

export const CLAIM_CLASSES = ["execution", "verification", "proof"] as const;
export type ClaimClass = (typeof CLAIM_CLASSES)[number];

// D2 slice 1: impact surfaces a component change may trigger. The
// first seven are the legacy classifier's surfaces; the last five
// are derivation targets declared in the registry. Since cutover C3
// the derived classifier decides all thirteen (impact job,
// derived_event.ts); since cutover C4 it is the only classifier.
export const IMPACT_SURFACES = [
  "full",
  "docs_links",
  "spec_check",
  "spec_build",
  "lean_build",
  "python_tests",
  "tracking_views",
  "axiom_audit",
  "k_compile",
  "k_examples",
  "klean_export",
  "tla_model_check",
] as const;
export type ImpactSurface = (typeof IMPACT_SURFACES)[number];

export interface Stage {
  id: string;
  component: string;
  requires: string[];
  allowedClaimClasses: ClaimClass[];
  requiredClaimClasses: ClaimClass[];
}

/** A file or directory a component reads outside its own roots.
 * `surfaces` restricts which of the component's impact surfaces
 * the input triggers; null means all of them. A plain string in
 * YAML is equivalent to { path, surfaces: null }. */
export interface ReadInput {
  path: string;
  surfaces: ImpactSurface[] | null;
}

export interface Component {
  id: string;
  name: string;
  roots: string[];
  excludes: string[];
  buildCommand: string;
  checkCommand: string;
  cacheDeterminants: string[];
  dependsOn: string[];
  requiredChecks: string[];
  impactSurfaces: ImpactSurface[];
  readInputs: ReadInput[];
  allowedClaimClasses: ClaimClass[];
  notes: string[];
}

export interface Registry {
  version: number;
  toolchains: { id: string; version: string; source: string }[];
  components: Component[];
  stages: Stage[];
  componentById: Map<string, Component>;
  stageById: Map<string, Stage>;
}

function isClaimClass(value: string): value is ClaimClass {
  return (CLAIM_CLASSES as readonly string[]).includes(value);
}

function claimClassList(value: YamlValue, what: string): ClaimClass[] {
  return asStringList(value, what).map((item) => {
    if (!isClaimClass(item)) {
      throw new Error(`${what}: unknown claim class ${JSON.stringify(item)}`);
    }
    return item;
  });
}

function optionalStringList(
  record: Record<string, YamlValue>,
  key: string,
  what: string,
): string[] {
  const value = record[key];
  if (value === undefined || value === null) return [];
  return asStringList(value, `${what}.${key}`);
}

function isImpactSurface(value: string): value is ImpactSurface {
  return (IMPACT_SURFACES as readonly string[]).includes(value);
}

function impactSurfaceList(value: YamlValue, what: string): ImpactSurface[] {
  return asStringList(value, what).map((item) => {
    if (!isImpactSurface(item)) {
      throw new Error(
        `${what}: unknown impact surface ${JSON.stringify(item)}`,
      );
    }
    return item;
  });
}

function readInputList(value: YamlValue, what: string): ReadInput[] {
  if (value === undefined || value === null) return [];
  return asList(value, what).map((item, i) => {
    if (typeof item === "string") return { path: item, surfaces: null };
    const rec = asRecord(item, `${what}[${i}]`);
    const surfacesValue = rec["surfaces"];
    return {
      path: asString(rec["path"], `${what}[${i}].path`),
      surfaces: surfacesValue === undefined || surfacesValue === null
        ? null
        : impactSurfaceList(surfacesValue, `${what}[${i}].surfaces`),
    };
  });
}

function loadRegistry(text: string): Registry {
  const doc = asRecord(parseYaml(text), "registry");
  const version = doc["version"];
  if (typeof version !== "number" || version !== 1) {
    throw new Error("registry: version must be 1");
  }
  const toolchains = asList(doc["toolchains"] ?? [], "registry.toolchains").map(
    (item, i) => {
      const rec = asRecord(item, `registry.toolchains[${i}]`);
      return {
        id: asString(rec["id"], `registry.toolchains[${i}].id`),
        version: String(rec["version"]),
        source: asString(rec["source"], `registry.toolchains[${i}].source`),
      };
    },
  );
  const components: Component[] = asList(
    doc["components"],
    "registry.components",
  ).map((item, i) => {
    const rec = asRecord(item, `registry.components[${i}]`);
    return {
      id: asString(rec["id"], `registry.components[${i}].id`),
      name: asString(rec["name"], `registry.components[${i}].name`),
      roots: asStringList(rec["roots"], `registry.components[${i}].roots`),
      excludes: optionalStringList(
        rec,
        "excludes",
        `registry.components[${i}]`,
      ),
      buildCommand:
        rec["build_command"] === null || rec["build_command"] === undefined
          ? ""
          : asString(
            rec["build_command"],
            `registry.components[${i}].build_command`,
          ),
      checkCommand:
        rec["check_command"] === null || rec["check_command"] === undefined
          ? ""
          : asString(
            rec["check_command"],
            `registry.components[${i}].check_command`,
          ),
      cacheDeterminants: optionalStringList(
        rec,
        "cache_determinants",
        `registry.components[${i}]`,
      ),
      dependsOn: optionalStringList(
        rec,
        "depends_on",
        `registry.components[${i}]`,
      ),
      requiredChecks: optionalStringList(
        rec,
        "required_checks",
        `registry.components[${i}]`,
      ),
      impactSurfaces: impactSurfaceList(
        rec["impact_surfaces"],
        `registry.components[${i}].impact_surfaces`,
      ),
      readInputs: readInputList(
        rec["read_inputs"],
        `registry.components[${i}].read_inputs`,
      ),
      allowedClaimClasses: claimClassList(
        rec["allowed_claim_classes"],
        `registry.components[${i}].allowed_claim_classes`,
      ),
      notes: optionalStringList(rec, "notes", `registry.components[${i}]`),
    };
  });
  const stages: Stage[] = asList(doc["stages"], "registry.stages").map(
    (item, i) => {
      const rec = asRecord(item, `registry.stages[${i}]`);
      return {
        id: asString(rec["id"], `registry.stages[${i}].id`),
        component: asString(
          rec["component"],
          `registry.stages[${i}].component`,
        ),
        requires: optionalStringList(rec, "requires", `registry.stages[${i}]`),
        allowedClaimClasses: claimClassList(
          rec["allowed_claim_classes"],
          `registry.stages[${i}].allowed_claim_classes`,
        ),
        requiredClaimClasses: claimClassList(
          rec["required_claim_classes"] ?? [],
          `registry.stages[${i}].required_claim_classes`,
        ),
      };
    },
  );

  const componentById = new Map<string, Component>();
  for (const component of components) {
    if (componentById.has(component.id)) {
      throw new Error(`registry: duplicate component id ${component.id}`);
    }
    componentById.set(component.id, component);
  }
  const stageById = new Map<string, Stage>();
  for (const stage of stages) {
    if (stageById.has(stage.id)) {
      throw new Error(`registry: duplicate stage id ${stage.id}`);
    }
    stageById.set(stage.id, stage);
  }
  return { version, toolchains, components, stages, componentById, stageById };
}

function existsOnDisk(root: string, path: string): boolean {
  try {
    Deno.statSync(`${root}/${path}`);
    return true;
  } catch {
    return false;
  }
}

/**
 * Validate a registry against itself and against the repository
 * tree. Returns a list of error strings; an empty list means valid.
 * Checks: unique ids, known dependency/component/stage references,
 * acyclic component dependencies, acyclic stage requirements, and
 * every declared root, exclude, and cache determinant existing on
 * disk (relative to repoRoot).
 */
export function validateRegistry(
  registry: Registry,
  repoRoot: string,
): string[] {
  const errors: string[] = [];
  // Lookups are derived from the component/stage lists, not from
  // the maps carried by the registry object, so that a registry
  // assembled in memory (tests, future callers) is checked as
  // given rather than as previously indexed.
  const componentById = new Map(registry.components.map((c) => [c.id, c]));
  const stageById = new Map(registry.stages.map((s) => [s.id, s]));
  for (const component of registry.components) {
    for (const dep of component.dependsOn) {
      if (!componentById.has(dep)) {
        errors.push(`component ${component.id}: unknown dependency ${dep}`);
      }
    }
    for (
      const path of [
        ...component.roots,
        ...component.excludes,
        ...component.cacheDeterminants,
        ...component.readInputs.map((input) => input.path),
      ]
    ) {
      if (!existsOnDisk(repoRoot, path)) {
        errors.push(`component ${component.id}: path does not exist: ${path}`);
      }
    }
    if (component.roots.length === 0) {
      errors.push(`component ${component.id}: no roots`);
    }
    if (component.impactSurfaces.length === 0) {
      errors.push(`component ${component.id}: no impact_surfaces`);
    }
    for (const surface of component.impactSurfaces) {
      if (!isImpactSurface(surface)) {
        errors.push(
          `component ${component.id}: unknown impact surface ${surface}`,
        );
      }
    }
    for (const input of component.readInputs) {
      for (const surface of input.surfaces ?? []) {
        if (!component.impactSurfaces.includes(surface)) {
          errors.push(
            `component ${component.id}: read input ${input.path} triggers surface ${surface}, which is not one of its impact_surfaces`,
          );
        }
      }
    }
    for (const surface of new Set(component.impactSurfaces)) {
      if (component.impactSurfaces.filter((s) => s === surface).length > 1) {
        errors.push(
          `component ${component.id}: duplicate impact surface ${surface}`,
        );
      }
    }
  }
  // Acyclic component dependencies (DFS).
  const visiting = new Set<string>();
  const visited = new Set<string>();
  const visitComponent = (id: string, chain: string[]): void => {
    if (visited.has(id)) return;
    if (visiting.has(id)) {
      errors.push(`component dependency cycle: ${[...chain, id].join(" -> ")}`);
      return;
    }
    visiting.add(id);
    const component = componentById.get(id);
    if (component) {
      for (const dep of component.dependsOn) {
        visitComponent(dep, [...chain, id]);
      }
    }
    visiting.delete(id);
    visited.add(id);
  };
  for (const component of registry.components) visitComponent(component.id, []);

  for (const stage of registry.stages) {
    if (!componentById.has(stage.component)) {
      errors.push(`stage ${stage.id}: unknown component ${stage.component}`);
    }
    for (const req of stage.requires) {
      if (!stageById.has(req)) {
        errors.push(`stage ${stage.id}: unknown required stage ${req}`);
      }
    }
    for (const required of stage.requiredClaimClasses) {
      if (!stage.allowedClaimClasses.includes(required)) {
        errors.push(
          `stage ${stage.id}: required claim class ${required} is not allowed for this stage`,
        );
      }
    }
    const component = componentById.get(stage.component);
    if (component) {
      for (const allowed of stage.allowedClaimClasses) {
        if (!component.allowedClaimClasses.includes(allowed)) {
          errors.push(
            `stage ${stage.id}: claim class ${allowed} is not allowed for component ${stage.component}`,
          );
        }
      }
    }
  }
  // Acyclic stage requirements.
  const sVisiting = new Set<string>();
  const sVisited = new Set<string>();
  const visitStage = (id: string, chain: string[]): void => {
    if (sVisited.has(id)) return;
    if (sVisiting.has(id)) {
      errors.push(`stage requirement cycle: ${[...chain, id].join(" -> ")}`);
      return;
    }
    sVisiting.add(id);
    const stage = stageById.get(id);
    if (stage) {
      for (const req of stage.requires) visitStage(req, [...chain, id]);
    }
    sVisiting.delete(id);
    sVisited.add(id);
  };
  for (const stage of registry.stages) visitStage(stage.id, []);
  return errors;
}

export function loadRegistryFile(path: string): Registry {
  return loadRegistry(Deno.readTextFileSync(path));
}
