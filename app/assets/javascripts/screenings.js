$(document).on("turbolinks:load", function() {
  $(document).on("click",".datepick-box",function(){
    $("#datepicker").datepicker("show");
  });
  $("#datepicker").datepicker({
    dateFormat : "yy-mm-dd",
    minDate: 0,
    onSelect: function(date, instance) {
      $("#datepick").val(date);
      form = document.querySelector(".datepick-box");
      Rails.fire(form, "submit");
    }
  });
});
