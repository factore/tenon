class Tenon.features.tenonContent.PopOut
  constructor: ->
    $(document).on('click', 'a.tn-tc-pop-out', @popOut)
    $(document).on('click', 'a.tn-tc-pop-out-close', @close)
    $(document).on('click', '.tn-tc-wrap a[data-size]', @resize)

  popOut: (e) =>
    e.preventDefault()
    $link = $(e.currentTarget)
    $template = $(JST['tenon/templates/tenon_content/popped_out']())
    $wrap = $link.closest('.tn-tc-main-actions').next('.tn-tc-wrap')
    $wrap.find('.tn-tc-pop-out-close').data('place', $link)
    $wrap.appendTo($template.find('.tn-tc-sizer'))
    $template.appendTo('body')
    $wrap.find('a[data-size]:first').trigger('click')
    $template.removeClass('hidden')
    $wrap.trigger('tenon.content.popped')

  resize: (e) =>
    e.preventDefault()
    $link = $(e.currentTarget)
    @_setActive($link)
    $wrap = $link.closest('.tn-tc-wrap')
    $wrap.css('width', $link.data('size') + 'px')
    @_setMobile($link, $wrap)
    $wrap.trigger('tenon.content.resized')

  close: (e) =>
    e.preventDefault()
    $link = $(e.currentTarget)
    $link.closest('.tn-tc-wrap')
      .css('width', '')
      .removeClass('mobile-breakpoint')
      .insertAfter($link.data('place').closest('.tn-tc-main-actions'))
      .trigger('tenon.content.popped')
    $('.tn-tc-popped-out').remove()

  _setActive: ($link) =>
    $('a[data-size]').removeClass('btn-primary').addClass('btn-white')
    $link.removeClass('btn-white').addClass('btn-primary')

  _setMobile: ($link, $wrap) =>
    if $link.data('mobile')
      $wrap.addClass('mobile-breakpoint')
    else
      $wrap.removeClass('mobile-breakpoint')
