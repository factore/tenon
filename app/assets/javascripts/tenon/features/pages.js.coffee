class Tenon.features.Pages
  index: ->
    $("#quick-search").quickSearch url: "/tenon/pages"
    Tenon.features.pages.setLiPageIds()
    Tenon.features.nestedLists.setSubpageTitleSize()

  setLiPageIds: ->
    $li = undefined
    $span = undefined
    $.each $("li.subpage, li.top"), ->
      $li = $(this)
      $span = $li.find("span.item-id")
      $li.attr "id", $span.data("item-id")

