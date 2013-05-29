$ ->
  (new ConfigureCodeMirror).run()
  (new CreateCodeMirror(editor)).run() for editor in $(".editor")

class ConfigureCodeMirror
  run: ->
    @addEtlLanguage()
    @addEmfaticLanguage()
    @addHutnLanguage()
  
  addEtlLanguage: ->
    CodeMirror.defineMIME "text/x-etl",
      name: "clike"
      atAnnotations: true
      keywords: @words("rule transform to pre post guard extends not delete import for while in and or operation return var throw if new else transaction abort break continue assert assertError")
      atoms: @words("true false null")
  
  addEmfaticLanguage: ->
    CodeMirror.defineMIME "text/x-emfatic",
      name: "clike"
      atAnnotations: true
      keywords: @words("package class attr ref val String Integer Boolean int boolean")
      atoms: @words("true false null")
  
  addHutnLanguage: ->
    CodeMirror.defineMIME "text/x-hutn",
      name: "clike"
      atAnnotations: true
      keywords: @words("package @Spec metamodel nsUri")
      atoms: @words("true false null")
  
  words: (str) ->
    words = {}
    words[word] = true for word in str.split(" ")
    words

class CreateCodeMirror
  constructor: (@original) ->
  
  run: ->
    codeMirroredEditor = CodeMirror(@replacer, @config())
    # Preserve the name of the original editor to 
    # ensure compatibility with form fields
    codeMirroredEditor.display.input.name = @original.name
    codeMirroredEditor
  
  replacer: (codeMirrored) =>
    @original.parentNode.replaceChild codeMirrored, @original
  
  config: =>
    value: @original.value
    theme: "lesser-dark"
    lineNumbers: true
    mode: if $(@original).data("mimeType") then $(@original).data("mimeType") else "text/x-emfatic"
    readOnly: $(@original).data("readOnly")
  