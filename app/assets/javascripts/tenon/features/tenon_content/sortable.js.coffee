class Tenon.features.tenonContent.Sortable
  constructor: ($container) ->
    $container.sortable
      update: @_reordered
      handle: '.drag-anchor'
      placeholder: 'sortable-placeholder tn-tc-row'
      start: (e, ui) -> ui.placeholder.height(ui.item.height())

    $container.on 'cocoon:after-insert', (e) =>
      @_updateListOrders($(e.currentTarget))

  _reordered: (event, ui) =>
    $list = $(ui.item).closest('.tenon-content')
    @_updateListOrders($list)

  _updateListOrders: ($list) =>
    $.each $list.find('.tn-tc-row'), (i, row) ->
      $(row).find('input[name*=list_order]').val(i)
