(function($){
 $.fn.tenonTwoLevelSort = function(options) {

    var defaults = {
      subSelector: '.subpages',
      topSelector: 'li:not(.subpage)',
      topClass: 'top',
      subClass: 'subpage',
      promoteSelector: '.promote',
      itemArray: 'item_list[]'
    };

    var options = $.extend(defaults, options);

    return this.each(function() {
      var obj = $(this);
      options.callbackPath = obj.data('reorder-path');
      obj.sortable({ items: options.topSelector, update: function(event, ui) { updateTopOrder(this); } });
      $('ul', obj).sortable({ connectWith: options.subSelector, update: function(event, ui) { updateSubpageOrder(this); } });


      $(options.promoteSelector, obj).click(function(e) {
        e.preventDefault();
        page = $(this).closest('li');
        page.remove().appendTo(obj).addClass(options.topClass).removeClass(options.subClass);
        var ul = $('<ul />').addClass(options.subSelector).append("<li class='placeholder'></li>");
        page.append(ul);
        $(this).parent().remove();

        updateTopOrder(obj);
      });


      function showValues(object) {
        var arr = new Array;
        $(object).children().each(function() {
          arr.push($(this).data('record-id'));
        });
        return arr;
      }

      function updateTopOrder(object) {
        var data = {};
        data[options.itemArray] = showValues(object);
        $.ajax({type: "POST", url: options.callbackPath, data: data});
      }

      function updateSubpageOrder(object) {
        Tenon.features.nestedLists.setSubpageTitleSize();
        var data = {parent_id: $(object).closest('li').data('record-id')};
        data[options.itemArray] = showValues(object);
        $.ajax({type: "POST", url: options.callbackPath, data: data});
      }

    });
 };
})(jQuery);