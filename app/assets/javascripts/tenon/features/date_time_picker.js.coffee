class Tenon.features.DateTimePicker
  constructor: ->
    @$els = $("[data-behaviour~='datetime-picker']")
    @format = "MMM. DD, YYYY [at] hh:mm A Z"
    $.each(@$els, @_formatDate)
    @_enableDateTimePicker()
    @_setupUnfocus()

  _formatDate: (i, el) =>
    $el = $(el)
    if $el.val() != '' && $el.val().match(/^\d{4}\-\d{2}\-\d{2}.*$/)
      railsFormat = "YYYY-MM-DD HH:mm:ss ZZ"
      reformatted = moment($el.val(), railsFormat).format(@format)
      $(el).val(reformatted)

  _enableDateTimePicker: =>
    @$els.datetimepicker
      pick12HourFormat: true,
      pickSeconds: false,
      format: @format

  # Blur the element when it's focused, preventing a soft-keyboard
  # from appearing
  _setupUnfocus: =>
    @$els.attr('readonly', true)