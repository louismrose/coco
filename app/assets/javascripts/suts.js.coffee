# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  load(editor) for editor in $(".editor")
  
load = (editor) ->
  myCodeMirror = CodeMirror((elt) ->
    editor.parentNode.replaceChild elt, editor
  ,
    value: editor.value
    mode: "javascript"
    theme: "lesser-dark"
    lineNumbers: true
  )