Tenon.features.Editor =
  reinitInline: ->
    for key in Object.keys(CKEDITOR.instances)
      instance = CKEDITOR.instances[key]
      instance.destroy() if instance?.editable()?.isInline()
    CKEDITOR.inlineAll()

  watchChanges: ->
    updateElement = (el) ->
      $el = $(el)
      $el.next('input[type=hidden]').val($el.html())

    for key in Object.keys(CKEDITOR.instances)
      instance = CKEDITOR.instances[key]
      if instance?.editable()?.isInline()
        # Watch changes via Source
        instance.on 'mode', ->
          editable = instance.editable()
          editable.attachListener editable, 'input', (e) ->
            updateElement(e.editor.element.$)

        # Watch changes in the main editor
        instance.on 'change', (e) ->
          updateElement(e.editor.element.$)
