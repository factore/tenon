class Tenon.features.SortableNestedFields
  constructor: ->
    $lists = $('.nested-field-list.sortable')
    $.each $lists, (i, list) =>
      $list = $(list)
      $list
        .sortable(
          update: @_doUpdate
          cancel: ':input,button,[contenteditable]'
          handle: $list.data('sortable-handle')
        )
        .on('cocoon:after-insert', -> $(this).sortable('refresh'))

  _doUpdate: (event, ui) ->
    $list = $(ui.item).closest('ul')
    $.each $list.find('li'), (i, li) ->
      $(li).find('input[name*=list_order]').val(i)