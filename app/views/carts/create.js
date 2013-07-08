<% if flash[:alert] %>
  $('.alert-error').removeClass('animated shake');
  $(".alert-error").html("<strong>Error!</strong> <%= flash[:alert] %>");
  $('.alert-error').show("normal", function(){
    $('.alert-error').addClass('animated shake');
  })
<% else %>
  $('.booking-status .total-book').html("<%= @cart.cart_items.count %>");
  $('.ac_cart tbody').html("<%= escape_javascript(render "home/booking_detail") %>");
  $('.alert-error').hide();
  $('.alert-success').removeClass('animated fadeInDown');
  $(".alert-success").html("<strong>Success!</strong> Your requested room has been added, please Check Out to lock the room!");
  $('.alert-success').show("normal", function(){
    $('.alert-error').addClass('animated shake');
    $('.alert-success').removeClass('animated shake');
  })
<% end %>