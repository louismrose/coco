# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  load(editor) for editor in $(".editor")
  
load = (editor) ->
  replacer = (elt) ->
    editor.parentNode.replaceChild elt, editor
  
  config =
    value: editor.value
    mode: "javascript"
    theme: "lesser-dark"
    lineNumbers: true
  
  config.readOnly = true if $(editor).data("readOnly")
  # config.readOnly = true if editor.data("readOnly")
  
  codeMirroredEditor = CodeMirror(replacer, config)
  
  # Preserve the name of the original editor to 
  # ensure compatibility with form fields
  codeMirroredEditor.display.input.name = editor.name