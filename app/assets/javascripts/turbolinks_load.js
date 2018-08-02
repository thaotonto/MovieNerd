$(document).on("turbolinks:load", function() {
  if ($("#admin_room_show_data").length != 0) {
    admin_show_room();
  }
  else if ($("#room_show_data").length != 0) {
    select_seats();
  }
  else if ($("#create_room_data").length != 0) {
    var $room_data = $("#create_room_data");
    create_room($room_data);
    change_room_listener($room_data);
  }
});

function reset_seat_area($room_data) {
  var i18n_screen = $room_data.data("i18n_screen");
  $("#seat-partial").html("<div id='seat-map'><div class='front'>" +
    i18n_screen + "</div></div>");
  $("#legend-partial").html("<div id='legend'></div>");
}
