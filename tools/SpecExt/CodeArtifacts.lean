-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Std.Data.HashMap
import Lean.DocString.Syntax
import VersoManual

open Lean Elab
open Lean.Doc.Syntax
open Verso.Doc Elab
open Verso.Genre Manual
open Verso.ArgParse
open Std (HashMap)

namespace SpecExt.CodeArtifacts

/-- Configuration shared by the extractable K and Python code blocks. -/
structure CodeArtifactConfig where
  file : String

/--
The output target is required: generated artifacts must never be implicitly written to
a developer-maintained source file.
-/
section
variable {m : Type → Type}
  [Monad m] [MonadInfoTree m] [MonadResolveName m] [MonadEnv m] [MonadError m]
  [MonadLiftT CoreM m] [MonadLog m] [AddMessageContext m] [MonadOptions m]

meta instance : FromArgs CodeArtifactConfig m where
  fromArgs :=
    CodeArtifactConfig.mk <$>
      .named `file (ValDesc.string.as "repository-relative generated file") false
end

/--
Stores the code payload in the document tree while preserving normal code rendering.
The payload is consumed by the pre-render extraction pass in SpecMain.
-/
block_extension Block.savedCode (target : String) (language : String) (source : String) where
  data := .arr #[.str target, .str language, .str source]
  traverse _ _ _ := pure none
  toTeX := some fun _ goB _ _ contents => contents.mapM goB
  toHtml := some fun _ goB _ _ contents => contents.mapM goB

/-- An executable K definition whose contents are extracted during the Verso build. -/
@[code_block]
meta def k7plK : CodeBlockExpanderOf CodeArtifactConfig
  | { file }, code => do
    let source := code.getVersoCodeBlock
    ``(Block.other
      (Block.savedCode $(quote file) $(quote ("k" : String)) $(quote source))
      #[Block.code $(quote source)])

/-- An executable Python script whose contents are extracted during the Verso build. -/
@[code_block]
meta def pythonScript : CodeBlockExpanderOf CodeArtifactConfig
  | { file }, code => do
    let source := code.getVersoCodeBlock
    ``(Block.other
      (Block.savedCode $(quote file) $(quote ("python" : String)) $(quote source))
      #[Block.code $(quote source)])

private def allowedTarget (language target : String) : Bool :=
  let components := target.splitOn "/"
  let safeComponents := components.all fun component =>
    !component.isEmpty && component != "." && component != ".."
  let safeSeparators := !target.startsWith "/" && !target.contains '\\'
  let expectedExtension :=
    match language with
    | "k" => target.endsWith ".k"
    | "python" => target.endsWith ".py"
    | _ => false
  safeComponents && safeSeparators &&
    target.startsWith "src/k/.build/generated/" && expectedExtension

private def withFinalNewline (source : String) : String :=
  if source.endsWith "\n" then source else source ++ "\n"

mutual
  private partial def collectPart (text : Part Manual) :
      StateT (HashMap String String) (Except String) Unit := do
    let .mk _ _ _ intro subParts := text
    for b in intro do collectBlock b
    for p in subParts do collectPart p

  private partial def collectBlock (block : Block Manual) :
      StateT (HashMap String String) (Except String) Unit := do
    match block with
    | .other which contents => do
      if which.name == ``Block.savedCode then
        match which.data with
        | .arr #[.str target, .str language, .str source] => do
          if !allowedTarget language target then
            throw s!"Refusing unsafe or unsupported code-artifact target '{target}' (language '{language}')."
          if (← get).contains target then
            throw s!"Duplicate code-artifact target '{target}'."
          let source := withFinalNewline source
          modify fun saved => saved.insert target source
        | other =>
          throw s!"Malformed code-artifact metadata: {other.compress}"
      for child in contents do collectBlock child
    | .concat bs | .blockquote bs =>
      for b in bs do collectBlock b
    | .ol _ lis =>
      for li in lis do
        for b in li.contents do collectBlock b
    | .ul lis =>
      for li in lis do
        for b in li.contents do collectBlock b
    | .dl dis =>
      for di in dis do
        for b in di.desc do collectBlock b
    | .para .. | .code .. => pure ()
end

/--
Extract marked blocks after Verso has elaborated them. Every target is validated before any
file is written, and the dedicated generated directory is the only directory cleared.
-/
def extractArtifacts (text : Part Manual) : IO UInt32 := do
  let collected := (collectPart text).run {}
  match collected with
  | .error message =>
    IO.eprintln s!"Verso code-artifact extraction failed: {message}"
    return 1
  | .ok (_, files) => do
    if files.toList.isEmpty then
      IO.eprintln "Verso code-artifact extraction found no marked code blocks."
      return 1
    let root ← IO.currentDir
    if !(← (root / "spec/Spec.lean").pathExists) then
      IO.eprintln "Code-artifact extraction must be run from the K7PL repository root."
      return 2
    let generatedDir := root / "src/k/.build/generated"
    if ← generatedDir.isDir then IO.FS.removeDirAll generatedDir
    for (target, contents) in files.toList do
      let destination := root / target
      if let some parent := destination.parent then
        IO.FS.createDirAll parent
      IO.FS.writeFile destination contents
    IO.println s!"Extracted {files.toList.length} code-artifact file(s) into {generatedDir}"
    return 0

end SpecExt.CodeArtifacts
