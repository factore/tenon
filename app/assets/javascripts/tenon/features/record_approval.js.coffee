class Tenon.features.RecordApproval
  constructor: ->
    $(document).on 'click', 'a.approve, a.unapprove', @_toggleRecordApproval

  _toggleRecordApproval: (e) =>
    e.preventDefault()
    @$link = $(e.currentTarget)
    @_startIconLoad()
    @_setTooltip('Loading...')
    $.getJSON(@$link.attr('href'))
      .done(@_finishToggle)
      .fail((data)=> console.log(data))

  _finishToggle:  =>
    console.log('fired')
    @$link.toggleClass('unapprove approve')
    if @$link.hasClass('approve')
      @_setTooltip('Approve')
      @$link.find('i').toggleClass('fa-spin fa-gear fa-thumbs-up')
    else
      @_setTooltip('Unapprove')
      @$link.find('i').toggleClass('fa-spin fa-gear fa-thumbs-down')

  _startIconLoad: =>
    @$link.find('i')
      .removeClass('fa-thumbs-up fa-thumbs-down')
      .addClass('fa-spin fa-gear')

  _setTooltip: (tooltip) =>
    @$link
      .tooltip('hide')
      .attr('data-original-title', tooltip)
      .tooltip('fixTitle')
      .tooltip('show')