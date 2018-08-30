$(document).on("turbolinks:load", function() {
  $("#datepicker1").datetimepicker({
    format: "YYYY/MM/DD",
    minDate: moment().subtract(0, "days").millisecond(0).second(0).minute(0).hour(0),
    useCurrent: false,
    showClear: true,
    showClose: true
  });
  $("#datepicker1").on("dp.change", function (e) {
    form = document.querySelector(".datepick-box");
    $("#id_room").val($("#room_id").val());
    Rails.fire(form, "submit");
  });

  $("#datetimepicker").datetimepicker({
    format: "YYYY/MM/DD hh:mm A",
    minDate: moment().subtract(0, "days").millisecond(0).second(0).minute(0).hour(0),
    sideBySide: true,
    showClose: true,
    showClear: true,
    toolbarPlacement: "bottom",
    ignoreReadonly: true,
    stepping: 5
  });
  $("#datetimepicker").on("dp.hide", function (e) {
    $("#error_explanation").empty();
    var room_id = $("#screening_room_id").val();
    var movie_id = $("#screening_movie_id").val();
    var datetime = $('#datetimepicker').data("DateTimePicker").date()
    if (datetime == null) {
      date = null;
    } else {
      var date = datetime.format("YYYY/MM/DD");
      $("#screening_screening_start").val(datetime.format("YYYY/MM/DD hh:mm A"));
    }
    $.ajax({
      dataType: "script",
      data: {
        "screening": {
          "room_id": room_id
        },
        "date": date,
        "movie_id": movie_id
      },
      url: "/admin/screenings/new",
      type: "GET",
      success: function(res) {
        eval(res);
      }
    });
  });

  $("#room_id").on("change", function() {
    form = document.querySelector(".datepick-box");
    $("#id_room").val($("#room_id").val());
    Rails.fire(form, "submit");
  });

  $("#screening_room_id").on("change", function() {
    $("#datetimepicker").data("DateTimePicker").clear();
  });
});
