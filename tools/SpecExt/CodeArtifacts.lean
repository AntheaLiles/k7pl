-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Std.Data.HashMap
import Lean.DocString.Syntax
import VersoManual

open Lean Elab
open Lean.Doc.Syntax
open Verso Doc Elab
open Verso Genre Manual
open Verso.ArgParse
open Std (HashMap)

namespace SpecExt.CodeArtifacts

/-- Configuration of the extractable Python code blocks. -/
structure CodeArtifactConfig where
  file : String

/-- Configuration of a `K` block: the file of `lexicon/` that it displays. -/
structure LexiconFileConfig where
  file : String

/-
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

meta instance : FromArgs LexiconFileConfig m where
  fromArgs :=
    LexiconFileConfig.mk <$>
      .named `file (ValDesc.string.as "repository-relative file of lexicon/") false
end

/-
Stores the code payload in the document tree while preserving normal code rendering.
The payload is consumed by the pre-render extraction pass in SpecMain.
-/
block_extension Block.savedCode (target : String) (language : String) (source : String) where
  data := .arr #[.str target, .str language, .str source]
  traverse _ _ _ := pure none
  toTeX := some fun _ goB _ _ contents => do
    let rendered ← contents.mapM goB
    pure <| .seq rendered
  toHtml := some fun _ goB _ _ contents => do
    let rendered ← contents.mapM goB
    pure <| Verso.Output.Html.fromArray rendered

/-
Records, in the document tree, the file of `lexicon/` that a `K` block displays. The extraction
pass checks that every K file of `lexicon/` is displayed exactly once.
-/
block_extension Block.lexiconFile (path : String) where
  data := .str path
  traverse _ _ _ := pure none
  toTeX := some fun _ goB _ _ contents => do
    let rendered ← contents.mapM goB
    pure <| .seq rendered
  toHtml := some fun _ goB _ _ contents => do
    let rendered ← contents.mapM goB
    pure <| Verso.Output.Html.fromArray rendered

/-- Whether `path` names a K file of `lexicon/` without leaving it. -/
def lexiconPath (path : String) : Bool :=
  let components := path.splitOn "/"
  let safeComponents := components.all fun component =>
    !component.isEmpty && component != "." && component != ".."
  safeComponents && !path.contains '\\' &&
    path.startsWith "lexicon/" && path.endsWith ".k"

/--
A K definition of `lexicon/`, the home of the project's K sources. The block stays empty: it
displays the named file, read when the document is elaborated, so the file is the only copy.
-/
@[code_block]
meta def K : CodeBlockExpanderOf LexiconFileConfig
  | { file }, code => do
    unless lexiconPath file do
      throwError s!"A K block displays a K file of lexicon/, not '{file}'."
    unless code.getString.trimAscii.isEmpty do
      throwError s!"The K block of '{file}' must stay empty: it displays the file."
    let source ← IO.FS.readFile file
    ``(Verso.Doc.Block.other
      (Block.lexiconFile $(quote file))
      #[Verso.Doc.Block.code $(quote source)])

/-- An executable Python script whose contents are extracted during the Verso build. -/
@[code_block]
meta def pythonScript : CodeBlockExpanderOf CodeArtifactConfig
  | { file }, code => do
    let source := code.getString
    ``(Verso.Doc.Block.other
      (Block.savedCode $(quote file) $(quote ("python" : String)) $(quote source))
      #[Verso.Doc.Block.code $(quote source)])

private def allowedTarget (language target : String) : Bool :=
  let components := target.splitOn "/"
  let safeComponents := components.all fun component =>
    !component.isEmpty && component != "." && component != ".."
  let safeSeparators := !target.startsWith "/" && !target.contains '\\'
  let expectedExtension :=
    match language with
    | "python" => target.endsWith ".py"
    | _ => false
  safeComponents && safeSeparators &&
    target.startsWith "src/k/.build/generated/" && expectedExtension

private def withFinalNewline (source : String) : String :=
  if source.endsWith "\n" then source else source ++ "\n"

/-- What the extraction pass gathers from the document. -/
private structure Collected where
  /-- Generated files, by repository-relative target. -/
  files : HashMap String String := {}
  /-- Files of `lexicon/` displayed by `K` blocks, in document order. -/
  displayed : Array String := #[]

mutual
  private partial def collectPart (text : Part Manual) :
      StateT Collected (Except String) Unit := do
    let .mk _ _ _ intro subParts := text
    for b in intro do collectBlock b
    for p in subParts do collectPart p

  private partial def collectBlock (block : Verso.Doc.Block Manual) :
      StateT Collected (Except String) Unit := do
    match block with
    | .other which contents => do
      if which.name == ``Block.savedCode then
        match which.data with
        | .arr #[.str target, .str language, .str source] => do
          if !allowedTarget language target then
            throw s!"Refusing unsafe or unsupported code-artifact target '{target}' (language '{language}')."
          if (← get).files.contains target then
            throw s!"Duplicate code-artifact target '{target}'."
          let source := withFinalNewline source
          modify fun c => { c with files := c.files.insert target source }
        | other =>
          throw s!"Malformed code-artifact metadata: {other.compress}"
      if which.name == ``Block.lexiconFile then
        match which.data with
        | .str path => do
          if (← get).displayed.contains path then
            throw s!"The K file '{path}' is displayed by more than one K block."
          modify fun c => { c with displayed := c.displayed.push path }
        | other =>
          throw s!"Malformed K block metadata: {other.compress}"
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

/-- The K files of `lexicon/`, as repository-relative paths, in a stable order. -/
private partial def lexiconFiles (root : System.FilePath) : IO (Array String) := do
  let rec walk (dir : System.FilePath) (rel : String) : IO (Array String) := do
    let mut found := #[]
    for entry in ← dir.readDir do
      let path := s!"{rel}/{entry.fileName}"
      if ← entry.path.isDir then
        found := found ++ (← walk entry.path path)
      else if entry.fileName.endsWith ".k" then
        found := found.push path
    return found
  let dir := root / "lexicon"
  if !(← dir.isDir) then return #[]
  return (← walk dir "lexicon").qsort (· < ·)

/--
Extract marked blocks after Verso has elaborated them, and check that the `K` blocks display
every K file of `lexicon/`. Every target is validated before any file is written, and the
dedicated generated directory is the only directory cleared.
-/
def extractArtifacts (text : Part Manual) : IO UInt32 := do
  let collected := (collectPart text).run {}
  match collected with
  | .error message =>
    IO.eprintln s!"Verso code-artifact extraction failed: {message}"
    return 1
  | .ok (_, { files, displayed }) => do
    if files.toList.isEmpty then
      IO.eprintln "Verso code-artifact extraction found no marked code blocks."
      return 1
    let root ← IO.currentDir
    if !(← (root / "spec/Spec.lean").pathExists) then
      IO.eprintln "Code-artifact extraction must be run from the K7PL repository root."
      return 2
    let missing := (← lexiconFiles root).filter (!displayed.contains ·)
    if !missing.isEmpty then
      IO.eprintln s!"K files of lexicon/ displayed by no K block of the specification: {missing.toList}"
      return 1
    let generatedDir := root / "src/k/.build/generated"
    if ← generatedDir.isDir then IO.FS.removeDirAll generatedDir
    for (target, contents) in files.toList do
      let destination := root / target
      if let some parent := destination.parent then
        IO.FS.createDirAll parent
      IO.FS.writeFile destination contents
    IO.println s!"Extracted {files.toList.length} code-artifact file(s) into {generatedDir}"
    IO.println s!"The K blocks display the {displayed.size} K file(s) of lexicon/"
    return 0

end SpecExt.CodeArtifacts
