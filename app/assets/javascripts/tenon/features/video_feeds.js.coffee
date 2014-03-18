class Tenon.features.videoFeeds
  constructor: ->
    $(".tenon_submenu.video_feeds").on "click", "#pull-video-feed", ->
      $("#thinking").fadeIn 300
