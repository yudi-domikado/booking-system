$('.booking-status .total-book').html("<%= @cart.cart_items.count %>");
$('.ac_cart tbody').html("<%= escape_javascript(render "home/booking_detail") %>");