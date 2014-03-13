Tenon.features.nestedLists = {
  setSubpageTitleSize: function () {
    $.each($('li.subpage'), function() {
      var parentSize = $(this).parents('li.subpage').length,
        setWidth = 300 - (parentSize * 10) + 'px',
        padding = parentSize * 10;
      $(this).find('div.item-title').css({width: setWidth, paddingLeft: padding + 'px'});
    });
  }
}