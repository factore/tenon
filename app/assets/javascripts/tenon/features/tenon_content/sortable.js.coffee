class Tenon.features.tenonContent.Sortable
  constructor: ($container) ->
    $container.on 'cocoon:after-insert', (e) =>
      @_updateListOrders($(e.currentTarget))

    dragOpts =
      moves: (el, source, handle) ->
        $(el).is('.tn-tc-row') && $(handle).is('[data-drag-anchor]')

    drake = dragula([$container[0]], dragOpts)
    drake.on('drop', @_reordered)

  _reordered: (el, target) =>
    $list = $(target)
    @_updateListOrders($list)

  _updateListOrders: ($list) =>
    $.each $list.find('.tn-tc-row'), (i, row) ->
      $(row).find('input[name*=list_order]').val(i)
