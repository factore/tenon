class Tenon.features.tenonContent.CaptionToggler
  constructor: (@$container) ->
    $(document).on('click', '.image-controls .toggle-caption', @_toggleCaption)

  _toggleCaption: (e) =>
    e.preventDefault();
    $image = $(e.currentTarget).closest('.image-controls').data('image');
    $image.find('.caption').toggle();
    $input = $image.siblings('input[name$="[show_caption]"]')
    $input.val(if $input.val() == "t" then "f" else "t")
    $image.trigger('tenon.content.column_resized')