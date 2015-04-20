youtube_open_regex = /watch\?v=(.*)/
youtube_short_regex = /youtu\.be\/(.*)/

video_provider_regexes = [
  {provider: 'youtube', regex: youtube_open_regex},
  {provider: 'youtube', regex: youtube_short_regex}
]

window.admin ||= {}

window.admin.VideoPlayer = class VideoPlayer
  constructor: (element) ->
    @element = element
    @videoUrl = @element.getAttribute('rel')

    @parseVideoUrl()

  parseVideoUrl: =>
    for provider_regex in video_provider_regexes
      match = @videoUrl.match(provider_regex.regex)

      if match.length > 1
        @videoProvider = provider_regex.provider
        @videoId = match[1]

        return

    throw "Video can't parsed: #{@videoUrl}"

  embedVideoPlayer: =>
    videoEmbedders = {
      youtube: @embedYoutubePlayer
    }

    videoEmbedders[@videoProvider]()

  embedYoutubePlayer: =>
    iframe_url = "https://www.youtube.com/embed/#{@videoId}?fs=1"

    iframe = document.createElement('iframe')
    iframe.setAttribute('frameborder', 0)
    iframe.setAttribute('allowfullscreen', 1)
    iframe.src = iframe_url
    iframe.width = 400
    iframe.height = 300

    @element.appendChild(iframe)
