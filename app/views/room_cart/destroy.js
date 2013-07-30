<% if @cart_item %>
	$('.booking-status .total-book').html("<%= @cart.room_items.count %>");
	$('.ac_cart tbody .cart_item_<%= @cart_item.id %>').fadeOut("slow", function(){
		$('.ac_cart tbody').html("<%= escape_javascript(render "home/booking_detail") %>");
	})
	if(Number($(".total-book").html()) > 0){
    $(".btn-chk-out").show();
  }
<% end %>