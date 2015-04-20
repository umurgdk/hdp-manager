#= require active_admin/base
#= require admin_lightbox
#= require admin_videoplayer

$ ->
  $('[admin_lightbox]').each ->
    new admin.Lightbox(this, $(this).attr('admin_lightbox'))

  $('.video-player').each ->
    new admin.VideoPlayer(this).embedVideoPlayer()
