class Tenon.features.SidebarActiveLinks
  constructor: ->
    $('.sidebar nav.list-toggles').on('click', 'a', @_setActiveByClick)
    # @_setActiveByUrl()
    $(window).on('popstate', @_setActiveByUrl)

  _setActiveByUrl: =>
    query = window.location.search
    uri = window.location.pathname + query
    $nav = $(".sidebar nav.list-toggles")
    $activeLink = $nav.find("a[href='#{uri}'], a[href='#{query}']")
    @_setActive($activeLink)


  _setActiveByClick: (e) => @_setActive($(e.currentTarget))

  _setActive: ($link) =>
    $link.closest('li')
      .addClass('active')
      .siblings().removeClass('active')