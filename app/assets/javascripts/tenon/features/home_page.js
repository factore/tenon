Tenon.features.home_page = {
  // animate the main button icons on hover:
  init: function () {
    $("#index-buttons").on("mouseover", ".home-button", function() {
      $(this).children(".image").animate({opacity:0.5}, 500, function() {});
    }).on("mouseleave", ".home-button", function() {
      $(this).children(".image").animate({opacity:1}, 500, function() {});
    });
  }
}
