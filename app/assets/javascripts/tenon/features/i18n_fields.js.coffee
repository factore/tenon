class Tenon.features.I18nFields
  constructor: ->
    @$i18nFields = $('.i18n')
    $('[data-i18n-lang]').on('click', @switchActiveFields)
    @_detabifyInactiveFields()

  switchActiveFields: (e) =>
    $a = $(e.currentTarget)
    $active = @$i18nFields.filter(".#{$a.data('i18n-lang')}")
    @$i18nFields.removeClass('active')
    $active.addClass('active')
    @_detabifyInactiveFields()
    @_toggleActiveLink($a)

  _toggleActiveLink: ($a) =>
    $li = $a.closest('li')
    $li.siblings().removeClass('active')
    $li.addClass('active')

  _detabifyInactiveFields: =>
    tags = 'input, select, textarea'
    $('.i18n:not(.active)').find(tags).attr('tabindex', '-1')
    $('.i18n.active').find(tags).attr('tabindex', '')
