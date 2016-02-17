$.ajaxSetup({
  dataType: 'json',
  'beforeSend' : function(xhr){
    xhr.setRequestHeader("Accept", "application/json");
  }
});

var Tenon = {

  features: {},
  helpers: {},

  init: function() {
    Tenon.refreshed = true;

    // setup generic loader
    Tenon.$genericLoader = $('.generic-loader');

    // init pickadate
    $('[data-behavior=datepicker]').pickadate();
    $('[data-behavior=timepicker]').pickatime();

    Tenon.features.fileSelectWidget.init();
    new Tenon.features.I18nFields();
    new Tenon.features.Flash();
    new Tenon.features.AssetCropping();
    new Tenon.features.AssetDetachment();
    new Tenon.features.CocoonHooks();
    new Tenon.features.ItemVersionAutosave();
    Tenon.modals = new Tenon.features.ModalWindows();
    new Tenon.features.ModalForms();
    new Tenon.features.ProtectChanges();
    new Tenon.features.SortableNestedFields();
    new Tenon.features.tenonContent.Base();
    new Tenon.features.GenericClassToggler();
    new Tenon.features.ToggleMainNav();
    new Tenon.features.NavItemToggle();
    new Tenon.features.Expandable();
  }
};
