class Tenon.features.tenonContent.CaptionToggler
  constructor: (@$container) ->
    $(document).off('click.caption-toggle')
    $(document).on(
      'click.caption-toggle',
      '.image-controls .toggle-caption',
      @_toggleCaption
    )

  _toggleCaption: (e) =>
    e.preventDefault()
    $image = $(e.currentTarget).closest('.image-controls').data('image')
    $captionField = $image.find('[data-image-caption]')
    $captionField.toggle()
    $input = $image.find('input[name$="[show_caption]"]')
    $input.val(if $input.val() == "t" then "f" else "t")
    $image.trigger('tenon.content.column_resized')
