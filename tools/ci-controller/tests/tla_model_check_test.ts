// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals, assertStringIncludes } from "./assert.ts";
import {
  parseTlaProfiles,
  type TlaProfile,
  validateProfileInventory,
} from "../src/tla_model_check.ts";

const MODELS_URL = new URL("../../../models/", import.meta.url);

const manifest = JSON.parse(
  await Deno.readTextFile(new URL("TLC-PROFILES.json", MODELS_URL)),
) as unknown;
const profiles = parseTlaProfiles(manifest);
const entries = [...Deno.readDirSync(MODELS_URL)];
const configFiles = entries.filter((entry) =>
  entry.isFile && entry.name.endsWith(".cfg")
).map((entry) => entry.name);
const moduleFiles = entries.filter((entry) =>
  entry.isFile && entry.name.endsWith(".tla")
).map((entry) => entry.name);

Deno.test("TLC manifest covers every TLA config and model module exactly once", () => {
  assertEquals(
    validateProfileInventory(profiles, configFiles, moduleFiles),
    [],
  );
  assertEquals(
    profiles.filter((profile) => profile.kind === "positive").length,
    18,
  );
  assertEquals(
    profiles.filter((profile) => profile.kind === "negative").length,
    22,
  );
});

Deno.test("a new TLA config cannot be silently omitted from the profile suite", () => {
  const errors = validateProfileInventory(
    profiles,
    [...configFiles, "TLA17-NewCandidate.cfg"],
    moduleFiles,
  );
  assert(
    errors.some((error) =>
      error.includes("unregistered TLA config: TLA17-NewCandidate.cfg")
    ),
  );
});

Deno.test("duplicate registrations are rejected", () => {
  const duplicate: TlaProfile[] = [...profiles, profiles[0]];
  const errors = validateProfileInventory(duplicate, configFiles, moduleFiles);
  assert(
    errors.some((error) =>
      error.includes("duplicate profile config: " + profiles[0].config)
    ),
  );
  assert(
    errors.some((error) =>
      error.includes("duplicate profile label: " + profiles[0].label)
    ),
  );
});

Deno.test("a registered profile cannot refer to a missing module", () => {
  const firstModule = profiles[0].module + ".tla";
  const errors = validateProfileInventory(
    profiles,
    configFiles,
    moduleFiles.filter((name) => name !== firstModule),
  );
  assertStringIncludes(
    errors.join("\n"),
    "profile module is missing from models/: " + firstModule,
  );
});

Deno.test("a new TLA model module cannot be silently omitted", () => {
  const errors = validateProfileInventory(
    profiles,
    configFiles,
    [...moduleFiles, "TLA17NewModel.tla"],
  );
  assertStringIncludes(
    errors.join("\n"),
    "TLA model module has no registered profile: TLA17NewModel.tla",
  );
});
