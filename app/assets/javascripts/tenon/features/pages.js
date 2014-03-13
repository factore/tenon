Tenon.features.pages = {
  index: function () {
    $('#quick-search').quickSearch({url: '/tenon/pages'});
    Tenon.features.pages.setLiPageIds();
    Tenon.features.nestedLists.setSubpageTitleSize();
  },

  setLiPageIds: function () {
    var $li, $span;
    $.each($('li.subpage, li.top'), function() {
      $li = $(this);
      $span = $li.find('span.item-id');
      $li.attr('id', $span.data('item-id'));
    });
  }
};