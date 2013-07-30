var Menu;

$(document).ready(function() {
  // $ac_background = $('#ac_background'),
  // $ac_bgimage   = $ac_background.find('.ac_bgimage'),
  // $ac_loading   = $ac_background.find('.ac_loading'),
  
  // $ac_content   = $('#ac_content'),
  // $title      = $ac_content.find('h1'),
  // $menu     = $ac_content.find('.ac_menu'),
  // $mainNav    = $menu.find('ul:first'),
  // $menuItems    = $mainNav.children('li'),
  // totalItems    = $menuItems.length,
  // $ItemImages   = new Array();
  
  // $menuItems.each(function(i) {
  //   $ItemImages.push($(this).children('a:first').attr('href'));
  // });
  // $ItemImages.push($ac_bgimage.attr('src'));
      
  var menu_header = function(document, window){
    var self = {
        ac_background : $('#ac_background'),
        ac_content    : $('#ac_content'),
        ItemImages    : [],

        ac_bgimage    : null,
        ac_loading    : null,
        title         : null,
        menu          : null,
        mainNav       : null,
        menuItems     : null,
        totalItems    : null,
        ac_cart       : null,
        bookig_status : null,
        

        collectMenu: function(){
          self.ac_bgimage    = self.ac_background.find('.ac_bgimage');
          self.ac_loading    = self.ac_background.find('.ac_loading');
          self.title         = self.ac_content.find('h1');
          self.menu          = self.ac_content.find('.ac_menu');
          self.mainNav       = self.menu.find('ul:first');
          self.menuItems     = self.mainNav.children('li');
          self.totalItems    = self.menuItems.length; 
          self.ac_cart       = $(".ac_cart");
          self.bookig_status = $(".booking-status");

          self.menuItems.each(function(i) {
            self.ItemImages.push($(this).children('a:first').attr('href'));
          });
          self.ItemImages.push(self.ac_bgimage.attr('src'));
        },

        Event: {
          CLICK_MENU  : 'click.Menu',
          RESIZE_MENU : 'resize.Menu'
        },

        init: function() {
          self.collectMenu();
          self.loadPage();
          self.initWindowEvent();
        },

        loadPage: function() {
          self.ac_loading.show();
          $.when(self.loadImages()).done(function(){
            $.when(self.showBGImage()).done(function(){
              self.ac_loading.hide();
              $.when(self.slideOutMenu()).done(function(){
                $.when(self.toggleMenuItems('up')).done(function(){
                  self.initEventsSubMenu();
                });
              });
            });
          });
        },

        showBGImage: function() {
          return $.Deferred(
            function(dfd) {
              self.adjustImageSize(self.ac_bgimage);
              self.ac_bgimage.fadeIn(1000, dfd.resolve);
            }
          ).promise();
        },

      slideOutMenu: function() {
        var new_w = self.ac_content.width() - self.title.outerWidth(true)
        return $.Deferred(
          function(dfd) {
            self.menu.stop().animate({
              width : new_w + 'px'
            }, 700, dfd.resolve);
          }
        ).promise();
      },

      toggleMenuItems: function(dir) {
        return $.Deferred(
          function(dfd) {
            self.menuItems.each(function(i) {
              var $el_title = $(this).children('a:first'), marginTop, opacity, easing;
              if(dir === 'up'){
                marginTop = '0px';
                opacity   = 1;
                easing    = 'easeOutBack';
              }
              else if(dir === 'down'){
                marginTop = '60px';
                opacity   = 0;
                easing    = 'easeInBack';
              }
              $el_title.stop().animate({ marginTop: marginTop, opacity: opacity}, 200 + i * 200 , easing, 
                        function(){
                          if(i === self.totalItems - 1)
                            dfd.resolve();
                        });
            });
          }
        ).promise();
      },

      initEventsSubMenu: function() {
        self.menuItems.each(function(i) {
          var $item   = $(this),
          $el_title = $item.children('a:first'),
          el_image  = $el_title.attr('href'),
          $sub_menu = $item.find('.ac_subitem'),
          $ac_close = $sub_menu.find('.ac_close');
          $cart_close = self.ac_cart.find('.ac_close')
          
          $el_title.bind(self.Event.CLICK_MENU, function(e) {
            $.when(self.toggleMenuItems('down')).done(function(){
              self.openSubMenu($item, $sub_menu, el_image);
            });
            return false;
          });

          $ac_close.bind(self.Event.CLICK_MENU, function(e) {
            self.closeSubMenu($sub_menu);
            return false;
          });

          self.bookig_status.bind(self.Event.CLICK_MENU, function(e) {
            self.openBooking();
            return false;
          });

          $cart_close.bind(self.Event.CLICK_MENU, function(e) {
            self.closeBooking();
            return false;
          });

        });
      },

      openSubMenu: function($item, $sub_menu, el_image) {
        $sub_menu.addClass("active")
        $sub_menu.stop()
                 .animate({
                    height    : '375px',
                    marginTop : '-200px'
                  }, 400, function() {
                    self.showItemImage(el_image);
                });
      },

      showItemImage: function(source) {
        if(self.ac_bgimage.attr('src') === source)
          return false;
            
        var $itemImage = $('<img src="'+source+'" alt="Background" class="ac_bgimage"/>');
        $itemImage.insertBefore(self.ac_bgimage);
        self.adjustImageSize($itemImage);
        self.ac_bgimage.fadeOut(1500, function() {
          $(this).remove();
          self.ac_bgimage = $itemImage;
        });
        $itemImage.fadeIn(1500);
      },

      closeSubMenu: function($sub_menu, $callback) {
        $sub_menu.removeClass("active")
        $sub_menu.stop()
        .animate({
          height    : '0px',
          marginTop : '0px'
        }, 400, function() {
          //show items
          if($callback){
            Menu[$callback]();
          }else{
            self.toggleMenuItems('up');
          }
          
        });
      },

      openBooking: function(){
        if($(".ac_subitem.active").length){
          self.closeSubMenu($(".ac_subitem.active"), "showBookingDetail");
        }else if(!self.ac_cart.hasClass("active")){
          $.when(self.toggleMenuItems('down')).done(function(){
            self.showBookingDetail();
          });
        }
      },

      closeBooking: function(){
        self.ac_cart.removeClass("active");
        self.ac_cart.stop()
        .animate({
          height    : '0px',
          marginTop : '0px'
        }, 400, function() {
          self.toggleMenuItems('up');
        });
      },

      showBookingDetail: function(){
        self.ac_cart.addClass("active");
        self.ac_cart.stop()
                 .animate({
                    height    : '375px',
                    marginTop : '-200px'
                  }, 400, function() {
                    self.showItemImage(self.ac_background.attr("image-default"));
                });
      },

      initWindowEvent: function() {
        $(window).bind(self.Event.RESIZE_MENU , function(e) {
          self.adjustImageSize(self.ac_bgimage);
          var new_w = self.ac_content.width() - self.title.outerWidth(true);
          self.menu.css('width', new_w + 'px');
        });
      },

      adjustImageSize: function($img) {
        var w_w = $(window).width(),
        w_h = $(window).height(),
        r_w = w_h / w_w,
        i_w = $img.width(),
        i_h = $img.height(),
        r_i = i_h / i_w,
        new_w,new_h,
        new_left,new_top;
          
        if(r_w > r_i){
          new_h = w_h;
          new_w = w_w;
          // new_h = w_h;
          // new_w = w_h / r_i;
        }
        else{
          new_h = w_w * r_i;
          new_w = w_w;
        }
          
        $img.css({
          width : new_w + 'px',
          height  : new_h + 'px',
          left  : (w_w - new_w) / 2 + 'px',
          top   : (w_h - new_h) / 2 + 'px'
        });
      },

      loadImages: function() {
          return $.Deferred(
          function(dfd) {
            var total_images  = self.ItemImages.length,
            loaded = 0;
            for(var i = 0; i < total_images; ++i){
              $('<img/>').load(function() {
                ++loaded;
                if(loaded === total_images)
                  dfd.resolve();
              }).attr('src' , self.ItemImages[i]);
            }
          }
        ).promise();
      }
    };
      
    return self;
  };

  Menu = menu_header(document, window);
  Menu.init();
});