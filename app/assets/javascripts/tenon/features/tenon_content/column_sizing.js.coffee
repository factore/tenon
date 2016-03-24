class Tenon.features.tenonContent.ColumnSizing
  constructor: (@$container) ->
    @totalColumns = 12
    @maxColumnSize = 11
    $(document).off('click.column-sizing')
    $(document).on(
      'click.column-sizing',
      '.image-controls.column-image [data-column-resize-operation]',
      @_changeSize
    )

  _changeSize: (e) =>
    e.preventDefault()
    e.stopImmediatePropagation()
    operation = $(e.currentTarget).data('column-resize-operation')
    @$column = $(e.currentTarget)
      .closest('.image-controls')
      .data('image')
      .closest('.tn-tc-piece')
    @$sibling = @$column.siblings()

    # Resize the columns
    classList = @$column.get(0).classList.toString()
    regex = /.*inner(\d+).*/g
    currentColumnSize = regex.exec(classList)[1] # Returns eg. "6" for "inner6"
    @["_#{operation}From"](currentColumnSize)

    # Let the other classes know the size has changed
    @$column.on 'transitionend MSTransitionEnd webkitTransitionEnd oTransitionEnd', =>
      @$column.trigger('tenon.content.column_resized');

  _increaseFrom: (num) =>
    num = parseInt(num)
    unless num >= @maxColumnSize
      oldSiblingSize = @totalColumns - num
      newSiblingSize = @totalColumns - num - 1
      oldSize = num
      newSize = num + 1
      @_setSizes(oldSize, newSize, oldSiblingSize, newSiblingSize)

  _decreaseFrom: (num) =>
    num = parseInt(num)
    unless num <= 1
      oldSiblingSize = @totalColumns - num
      newSiblingSize = @totalColumns - num + 1
      oldSize = num
      newSize = num - 1
      @_setSizes(oldSize, newSize, oldSiblingSize, newSiblingSize)

  _setSizes: (oldSize, newSize, oldSiblingSize, newSiblingSize) =>
    # Resize the columns
    @$column
      .removeClass("inner#{oldSize}")
      .addClass("inner#{newSize}")
    @$sibling
      .removeClass("inner#{oldSiblingSize}")
      .addClass("inner#{newSiblingSize}")

    # Save the values
    @$column.find('input[name$="[size]"]').val(newSize)
    @$sibling.find('input[name$="[size]"]').val(newSiblingSize)
