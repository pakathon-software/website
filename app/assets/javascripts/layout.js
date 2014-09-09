$(document).ready(function() {

  $('.video-action').mouseenter(function(){
    $(this).hide();
    $('.video-action-on-hover').show();
  });

  $('.video-action-on-hover').mouseleave(function(){
    $(this).hide();
    $('.video-action').show();
  });

  $('.video-action-on-hover').click(function(){
    $('.hero-text').hide();
    $('.video-action-on-click').fadeIn();
  });
  
});