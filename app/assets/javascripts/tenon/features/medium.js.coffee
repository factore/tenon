class Tenon.features.Medium
  constructor: ->
    Tenon.mediumEditor = new MediumEditor $('.editable-text'),
      placeholder: ''
      cssClasses:
        placeholder: 'medium-placeholder'
      forcePlainText: true
      firstHeader: 'h1'
      secondHeader: 'h2'
      buttons: ['bold', 'italic', 'underline', 'anchor', 'header1', 'header2', 'quote', 'unorderedlist', 'orderedlist']