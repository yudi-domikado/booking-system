dismissButton = "<a href=\"#\" class=\"close\" data-dismiss=\"alert\">&times;</a>";
$('.alert').stop();
<% if @cart_item.errors.present? %>
  errorAddCart = dismissButton + "<strong>Error!</strong> <%= flash[:alert] %>"
  $('.alert-error').removeClass('animated shake');
  $(".alert-error").html( errorAddCart );
  $('.alert-error').show("normal", function(){
    $('.alert-error').addClass('animated shake');
    $('.alert').delay(10000).slideUp("slow");
  })
<% else %>
  successAddCart = dismissButton + "<strong>Success!</strong> Your requested room has been added, please Check Out to lock the room!"
  $('.booking-status .total-book').html("<%= @cart.cart_items.count %>");
  $('.ac_cart tbody').html("<%= escape_javascript(render "home/booking_detail") %>");
  $('.alert-error').hide();
  $('.alert-success').removeClass('animated fadeInDown');
  $(".alert-success").html( successAddCart );
  $('.alert-success').show("normal", function(){
    $('.alert-error').addClass('animated shake');
    $('.alert-success').removeClass('animated shake');
    $('.alert').delay(10000).slideUp("slow");
  })
<% end %>