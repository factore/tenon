class Tenon.features.tenonContent.EmbeddedContentModalHandler
  constructor: (@$link, @$el, @$template) ->
    @hiddenField = @$link.parent().next('.embed-code-field')
    @textArea = @$el.find('#embed_code')
    @textArea.val(@hiddenField.val())
    @$el.find('.update-embed-code').on('click', @updateEmbedCode)

  updateEmbedCode: (e) =>
    e.preventDefault()
    @hiddenField.val(@textArea.val())
    @$link.siblings('.embed').html(@textArea.val())
    @$template.modal('hide')