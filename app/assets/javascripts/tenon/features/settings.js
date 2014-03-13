Tenon.features.settings = {
  initVideoFeeds: function () {
    var self = Tenon.features.settings,
        select = "#settings_video_feed_source";
    self.$video = $("#video");

    // Display the form right away if selected
    $(select).find("option:selected").val() === "" ? "" : self.displayFeedForm($(select).find("option:selected").val());

    // Display the selected form
    self.$video.on("change", select, function () {
      $(this).val() === "" ? "" : self.displayFeedForm($(this).val());
    });
  },

  displayFeedForm: function (display) {
    var self = Tenon.features.settings,
        baseHeight = 100,
        height;

    self.$video
      .find(".hide").slideUp().end()
      .find("#" + display).slideDown();
  }
}
