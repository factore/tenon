class Tenon.features.QuickSearch
  constructor: ->
    @$content = $('.toolbox #quick-search-container')
    @$toggle = $('#quick-search-toggle')
    @openClass = 'open'
    @$field = $('#quick-search')

    # listeners
    $(document).on('keyup', '#quick-search', $.debounce(500, @_submitSearch))

    @$toggle.on('click', @toggleNav)
    # $(document).on('click', '.nav-holder.mobile-open a', @_closeNav)

  _submitSearch: (e) =>
    @$list = $(@$field.data('record-list'))
    params = {q: @$field.val()}
    new Tenon.features.RecordList(@$list, params: params, clear: true)

  toggleNav: (e) =>
    e.preventDefault()
    @$toggle.find('i').toggleClass('fa-search fa-times')
    if @$toggle.hasClass(@openClass)
      @_closeNav()
    else
      @_openNav()

  _closeNav: () =>
    @$field.val('').keyup() # clear quick search and submit it when closing the toolbox
    @$toggle.removeClass(@openClass)
    $('header').css('border-bottom-width', '1px')
    @$content.removeClass(@openClass)

  _openNav: () =>
    @$toggle.addClass(@openClass)
    $('header').css('border-bottom-width', '0px')
    @$content.addClass(@openClass)
    @$content.find('input')[0].focus()
