class Tenon.features.SortableNestedFields
  constructor: ->
    $lists = $('.nested-field-list.sortable')
    $lists
      .sortable(update: @_doUpdate)
      .on('cocoon:after-insert', -> $(this).sortable('refresh'))

  _doUpdate: (event, ui) ->
    $list = $(ui.item).closest('ul')
    $.each $list.find('li'), (i, li) ->
      $(li).find('input[name*=list_order]').val(i)