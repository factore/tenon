//= require jquery
//= require jquery_ujs

// -- Plugins, in alphabetical order
//= require bootstrap
//= require bootstrap.modal
//= require canvasjs.min
//= require cocoon
//= require imagesloaded
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require jquery.debounce
//= require jquery.equalHeights
//= require jquery.Jcrop
//= require jquery.mousewheel
//= require jquery.twoLevelSort
//= require jquery.ui.sortable
//= require date_picker/picker
//= require date_picker/picker.date
//= require pickadate/picker.time
//= require rails.validations
//= require number-to-words
//= require tenon/rails.validations
//= require react_ujs
//= require uri

// -- Plugins that need to be loaded in order
//= require moment
//= require lodash
//= require underscore.string

// -- Tenon things, don't mess with the order
//= require ./tenon
//= require_tree ./templates
//= require_tree ./features
//= require_self
//= require ./components
//= require tenon_addons

// -- custom react components
//= require_tree ./components/shared
//= require_tree ./components/resource-index/components/default
//= require_tree ./components/resource-index/components/custom

/* global Tenon */
$(function() {
  Tenon.init();
});
