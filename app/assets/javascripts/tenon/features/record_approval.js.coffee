class Tenon.features.RecordApproval
  constructor: ->
    $(document).on 'click', 'a.approve, a.unapprove', @_toggleRecordApproval

  _toggleRecordApproval: (e) =>
    e.preventDefault()
    @$link = $(e.currentTarget)
    @_startIconLoad()
    @_setTooltip('Loading...')
    $.get @$link.attr('href'), @_finishToggle

  _finishToggle:  =>
    @$link.toggleClass('unapprove approve')
    if @$link.hasClass('approve')
      @_setTooltip('Approve')
      @$link.find('i').toggleClass('fa fa-spin fa fa-gear fa fa-thumbs-up')
    else
      @_setTooltip('Unapprove')
      @$link.find('i').toggleClass('fa fa-spin fa fa-gear fa fa-thumbs-down')

  _startIconLoad: =>
    @$link.find('i')
      .removeClass('fa fa-thumbs-up fa fa-thumbs-down')
      .addClass('fa fa-spin fa fa-gear')

  _setTooltip: (tooltip) =>
    @$link
      .tooltip('hide')
      .attr('data-original-title', tooltip)
      .tooltip('fixTitle')
      .tooltip('show')