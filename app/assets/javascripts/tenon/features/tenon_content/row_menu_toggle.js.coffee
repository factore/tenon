class Tenon.features.tenonContent.RowMenuToggle
  constructor: (@$container) ->
    $(document).on('click', @hideMenu)
    @$container.on('click', 'a.toggle-tn-tc-menu', @showMenu)

  showMenu: (e) =>
    e.preventDefault();
    e.stopImmediatePropagation(); # Stops this click from doing the hide
    $link = $(e.currentTarget)
    $link.next('.menu').toggle()

  hideMenu: => @$container.find('.menu').hide()