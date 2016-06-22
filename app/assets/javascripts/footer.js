
/*  FOOTER SCROLLSPY  */
  (function(){
    $footer = $('footer');

    $(window).scroll(footerCuCu);
    $(window).resize(footerCuCu);
    footerCuCu();

    function footerCuCu(){
      var fheight = $footer.outerHeight();
      var wheight = $(window).height();

      if(wheight>fheight){
        $('body').css('margin-bottom',fheight);
        var scroll = $(window).scrollTop()+wheight;
        var fscroll = scroll - ($(document).outerHeight(true)-fheight);
        $footer.addClass('fixed');
        if(fscroll >= 0){
          $footer.removeClass('transparent');
        }
        else{
          $footer.addClass('transparent');
        }
      }
      else{
        $footer.removeClass('fixed').removeClass('transparent');
        $('body').css('margin-bottom',0);
      }     


    }
  })($);
