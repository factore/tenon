class Tenon.features.tenonContent.WrappedSizing
  constructor: (@$container) ->
    $(document).on('click', '.image-controls.wrapped-image [data-column-resize-operation]', @_changeSize)

  _changeSize: (e) =>
    e.preventDefault()
    e.stopImmediatePropagation() # prevent closure of controls
    @$button = $(e.currentTarget)
    operation = @$button.data('column-resize-operation')
    @$column = @_getColumn()
    $.each @_words, (i, word) =>
      @["_#{operation}From"](word, i + 1) and false if @$column.hasClass(word)

    # Let the other classes know the size has changed
    @$column.on 'transitionend MSTransitionEnd webkitTransitionEnd oTransitionEnd', =>
      @$column.trigger('tenon.content.column_resized')

  _increaseFrom: (word, num) =>
    unless num >= @_words.length - 1
      newClass = @_numberToWord(num + 1)
      @_setSizes(word, newClass)

  _decreaseFrom: (word, num) =>
    unless num <= 2
      newClass = @_numberToWord(num - 1)
      @_setSizes(word, newClass)

  _setSizes: (oldColumn, newColumn, oldSibling, newSibling) =>
    # Resize the columns
    @$column.removeClass(oldColumn).addClass(newColumn)

    # Save the values
    @$column.find('input[name$="[size]"]').val(newColumn)

  _getColumn: =>
    @$button
      .closest('.image-controls')
      .data('image')
      .closest(@_wordClasses())

  _words: [
    'one', 'two', 'three', 'four', 'five', 'six',
    'seven', 'eight', 'nine', 'ten', 'eleven', 'twelve'
  ]

  _wordToNumber: (word)   => @_words.indexOf(word) + 1
  _numberToWord: (number) => @_words[number - 1]
  _wordClasses: => _.map(@_words, (word) -> ".#{word}").join(',')
