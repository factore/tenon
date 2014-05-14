class Tenon.features.Medium
  constructor: ($el = $('.editable-text')) ->
    Tenon.mediumEditor = new MediumEditor $('.editable-text'),

  opts:
    placeholder: ''
    cssClasses:
      placeholder: 'medium-placeholder'
    forcePlainText: true
    firstHeader: 'h3'
    secondHeader: 'h4'
    buttons: ['bold', 'italic', 'underline', 'anchor', 'header1', 'header2', 'quote', 'unorderedlist', 'orderedlist']
    buttonLabels: 'fontawesome'