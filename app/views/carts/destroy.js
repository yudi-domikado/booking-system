<% if @cart_item %>
	$('.booking-status .total-book').html("<%= @cart.cart_items.count %>");
	$('.ac_cart tbody .cart_item_<%= @cart_item.id %>').fadeOut("slow", function(){
		$('.ac_cart tbody').html("<%= escape_javascript(render "home/booking_detail") %>");
	})
<% end %>