var price = 10;
$(document).ready(function() {
  var $cart = $("#selected-seats"),
  $counter = $("#counter"),
  $total = $("#total");

  var sc = $("#seat-map").seatCharts({
    map: [
      "aaaaaa",
      "_aa_aa",
      "aaaaaa",
      "a_aaaa",
      "aaaa_a",
      "aaaaaa",
    ],
    naming : {
      top : false,
      getLabel : function (character, row, column) {
        return column;
      }
    },
    legend : {
      node : $("#legend"),
      items : [
        ["a", "available", "Available"],
        ["a", "unavailable", "Sold"],
        ["a", "selected", "Selected"]
      ]
    },
    click: function () {
      if (this.status() == "available") {
        $("<li>Row"+(this.settings.row+1)+" Seat"+this.settings.label+"</li>")
          .attr("id", "cart-item-"+this.settings.id)
          .data("seatId", this.settings.id)
          .appendTo($cart);

        $counter.text(sc.find("selected").length+1);
        $total.text(recalculateTotal(sc)+price);

        return "selected";
      } else if (this.status() == "selected") {
          $counter.text(sc.find("selected").length-1);
          $total.text(recalculateTotal(sc)-price);

          $("#cart-item-"+this.settings.id).remove();
          return "available";
      } else if (this.status() == "unavailable") {
        return "unavailable";
      } else {
        return this.style();
      }
    }
  });
  sc.get(["1_2", "4_4","4_5","6_6","6_7","8_5","8_6","8_7","8_8", "10_1", "10_2"]).status("unavailable");

});

function recalculateTotal(sc) {
  var total = 0;
  sc.find("selected").each(function () {
    total += price;
  });

  return total;
}
