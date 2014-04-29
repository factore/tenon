class Tenon.features.RecordBooleanToggle
  constructor: ->
    $(document).on 'click', 'a.toggle', @_toggleRecordBoolean

  _toggleRecordBoolean: (e) =>
    e.preventDefault()
    @$link = $(e.currentTarget)
    @trueIcon = 'fa-' + @$link.data('trueicon')
    @falseIcon = 'fa-' + @$link.data('falseicon')
    @trueTooltip = @$link.data('truetooltip')
    @falseTooltip = @$link.data('falsetooltip')
    @_startIconLoad()
    @_setTooltip('Loading...')
    $.getJSON(@$link.attr('href'))
      .done(@_finishToggle)
      .fail((data)-> console.log(data))

  _finishToggle:  =>
    @$link.toggleClass('true false')
    if @$link.hasClass('true')
      @_setTooltip(@trueTooltip)
      @$link.find('i').toggleClass('fa-spin fa-gear ' + @trueIcon)
    else
      @_setTooltip(@falseTooltip)
      @$link.find('i').toggleClass('fa-spin fa-gear ' + @falseIcon)

  _startIconLoad: =>
    @$link.find('i')
      .removeClass(@trueIcon + ' ' + @falseIcon)
      .addClass('fa-spin fa-gear')

  _setTooltip: (tooltip) =>
    @$link
      .tooltip('hide')
      .attr('data-original-title', tooltip)
      .tooltip('fixTitle')
      .tooltip('show')
