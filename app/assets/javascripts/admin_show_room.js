function admin_show_room () {
  var $room_data = $("#admin_room_show_data");

  var sc = $("#seat-map").seatCharts({
    map: $room_data.data("map"),
    naming : {
      top : false,
      getLabel : function (character, row, column) {
        return column;
      }
    },
    legend : {
      node : $("#legend"),
      items : []
    },
    click: function () {
      return this.style();
    }
  });
}
