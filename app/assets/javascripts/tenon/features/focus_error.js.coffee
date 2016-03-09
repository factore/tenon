class Tenon.features.FocusError
  constructor: ->
    $(document).on('click', '[data-focus-error]', @focusFirstError)

  focusFirstError: (e) ->
    e.preventDefault()
    $field = $('.input-block__field-with-errors:first')
    $('html, body').animate {scrollTop: $field.offset().top - 100}, 250, ->
      $field.find('input, select, textarea').focus()

