class Tenon.features.tenonContent.ColumnSizing
  constructor: (@$container) ->
    $(document).on('click', '.image-controls.column-image [data-column-resize-operation]', @_changeSize)

  _changeSize: (e) =>
    e.preventDefault()
    e.stopImmediatePropagation()
    operation = $(e.currentTarget).data('column-resize-operation')
    @$column = $(e.currentTarget)
      .closest('.image-controls')
      .data('image')
      .closest(@_wordClasses())
    @$sibling = @$column.siblings()

    # Resize the columns
    $.each @_words, (i, word) =>
      @["_#{operation}From"](word, i + 1) and false if @$column.hasClass(word)

    # Let the other classes know the size has changed
    @$column.on 'transitionend MSTransitionEnd webkitTransitionEnd oTransitionEnd', =>
      @$column.trigger('tenon.content.column_resized');

  _increaseFrom: (word, num) =>
    unless num >= @_words.length - 1
      siblingClass = @_numberToWord(@_words.length - num)
      newSiblingClass = @_numberToWord(@_words.length - num - 1)
      newClass = @_numberToWord(num + 1)
      @_setSizes(word, newClass, siblingClass, newSiblingClass)

  _decreaseFrom: (word, num) =>
    unless num <= 1
      siblingClass = @_numberToWord(@_words.length - num)
      newSiblingClass = @_numberToWord(@_words.length - num + 1)
      newClass = @_numberToWord(num - 1)
      @_setSizes(word, newClass, siblingClass, newSiblingClass)

  _setSizes: (oldColumn, newColumn, oldSibling, newSibling) =>
    # Resize the columns
    @$column.removeClass(oldColumn).addClass(newColumn)
    @$sibling.removeClass(oldSibling).addClass(newSibling)

    # Save the values
    @$column.find('input[name$="[size]"]').val(newColumn)
    @$sibling.find('input[name$="[size]"]').val(newSibling)

  _words: [
    'one', 'two', 'three', 'four', 'five', 'six',
    'seven', 'eight', 'nine', 'ten', 'eleven', 'twelve'
  ]

  _wordToNumber: (word)   => @_words.indexOf(word) + 1
  _numberToWord: (number) => @_words[number - 1]
  _wordClasses: => _.map(@_words, (word) -> ".#{word}").join(',')
