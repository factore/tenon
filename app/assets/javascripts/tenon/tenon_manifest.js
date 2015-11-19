//= require jquery
//= require jquery_ujs
//= require materialize

// -- Plugins, in alphabetical order
//= require backstretch
//= require bootstrap
//= require bootstrap.collapse
//= require bootstrap.modal
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
//= require react_ujs
//= require select2
//= require uri



// -- Plugins that need to be loaded in order
//= require moment
//= require bootstrap.datetimepicker

//= require lodash
//= require underscore.string

// -- Tenon things, don't mess with the order
//= require ./tenon
//= require ./tenon_dispatcher
//= require_tree ./templates
//= require_tree ./controllers
//= require_tree ./features
//= require_self
//= require ./components
//= require tenon_addons

// -- custom components
//= require_tree ./components/resource-index/components/default
//= require_tree ./components/resource-index/components/custom

$(function() {
  Tenon.init();
});
