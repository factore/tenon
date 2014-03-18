class Tenon.features.i18n
  constructor: ->
    $("#current_language").on("change", @_switchLanguage)

  _switchLanguage: ->
    val = $(this).val()
    $(".i18n").css position: "absolute"
    $("." + val).css position: "static"
    $("#current_language").val val

