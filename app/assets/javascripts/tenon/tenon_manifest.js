//= require jquery
//= require jquery_ujs

// -- Plugins, in alphabetical order
//= require backstretch
//= require bootstrap
//= require bootstrap.collapse
//= require bootstrap.modal
//= require bootstrap.tabs
//= require canvasjs.min
//= require cocoon
//= require imagesloaded
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require jquery.debounce
//= require jquery.equalHeights
//= require jquery.hoverIntent
//= require jquery.Jcrop
//= require jquery.mousewheel
//= require jquery.radioSlider
//= require jquery.twoLevelSort
//= require jquery.ui.sortable
//= require medium-editor
//= require ./medium_customizations
//= require select2
//= require uri

// -- Plugins that need to be loaded in order
//= require moment
//= require bootstrap.datetimepicker

//= require lodash
//= require underscore.string
//= require underscore.inflection


// -- Tenon things, don't mess with the order
//= require ./tenon
//= require ./tenon_dispatcher
//= require_tree ./templates
//= require_tree ./controllers
//= require_tree ./features
//= require tenon_addons
//= require_self


$(function() {
  Tenon.init();
});
