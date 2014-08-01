class Tenon.features.FocusFirstField
  constructor: ->
    $firstField = $($(".main-content form input[type!='hidden'], .main-content form select, .main-content form textarea")[0])
    $firstField.focus()

    if $firstField.is('input[type=text], textarea')
      length = $firstField.val().length
      $firstField[0].setSelectionRange(length, length)