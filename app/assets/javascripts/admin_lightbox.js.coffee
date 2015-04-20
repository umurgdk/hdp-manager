window.admin ||= {}

image_extensions = ['jpg', 'jpeg', 'png', 'gif']

throttle = (func, timeout) ->
  timeoutId = null

  return ->
    args = arguments
    clearTimeout(timeoutId)

    timeoutId = setTimeout ->
      func.apply(null, args)
    , timeout


window.admin.Lightbox = class Lightbox
  visible: false
  shadow: true

  constructor: (@element, @content, @shadow = true) ->
    if typeof @content != 'string'
      @loader = @loadDomElement
    else
      @loader = @loadUrl

    # build elements. don't attach to dom
    @build_dom()

    # add event handlers to target element
    @addEventListeners()

    @resizeThrottled = throttle(@resize, 1000)

  show: =>
    return if @visible

    @loader()
    @resize()
    document.body.appendChild(@wrapperEl)

    # window.addEventListener('resize', @resizeThrottled)

    @visible = true

  hide: =>
    return unless @visible

    document.body.removeChild(@wrapperEl)
    @contentEl.removeChild(@realContentEl)
    @realContentEl = null

    window.removeEventListener('resize', @resizeThrottled)

    @visible = false

  loadDomElement: =>
    @contentEl.appendChild(@content)

  loadUrl: =>
    isImageUrl = false

    for ext in image_extensions
      if @content.indexOf(ext) >= 0
        @isImageContent = true
        break

    unless @isImageContent
      @isUrlContent = true

    if @isImageContent
      img = document.createElement('img')
      img.setAttribute('src', @content)
      img.style.display = 'none'

      @realContentEl = img
      @startImageSizeListener()

      @contentEl.classList.add('activeadmin-lightbox-imagecontent')
      @contentEl.appendChild(img)
    else
      iframe = document.createElement('iframe')
      iframe.setAttribute('src', @content)

      @realContentEl = iframe

      @contentEl.classList.add('activeadmin-lightbox-urlcontent')
      @contentEl.appendChild(iframe)

  startImageSizeListener: =>
    intervalId = setInterval =>
      if @realContentEl.width > 0 || @realContentEl.height > 0
        clearInterval(intervalId)
        @realContentEl.style.display = ''
        @resize()
    , 50

  addEventListeners: =>
    @element.addEventListener 'click', (e) =>
      e.preventDefault()
      e.stopPropagation()
      @show()

  resize: =>
    windowWidth = window.innerWidth
    windowHeight = window.innerHeight

    # @wrapperEl.style.width = "#{windowWidth}px"
    # @wrapperEl.style.height = "#{windowHeight}px"

    if @isImageContent
      width = @realContentEl.width
      height = @realContentEl.height

      if width > height
        if width > windowWidth
          @realContentEl.style.width = "#{windowWidth - 40}px"
        else if height > windowHeight
          @realContentEl.style.height = "#{windowHeight - 40}px"
      else
        if height > windowHeight
          @realContentEl.style.height = "#{windowHeight - 40}px"
        else if width > windowWidth
          @realContentEl.style.width = "#{windowWidth - 40}px"
    else
      @realContentEl.style.width = "80%"
      @realContentEl.style.height = "#{windowHeight - 40}px"

    contentWidth = parseInt(@realContentEl.style.width, 10)
    contentHeight = parseInt(@realContentEl.style.height, 10)

    @contentEl.style.height = "#{contentHeight}px"

    if @isImageContent
      @contentEl.style.width = "#{contentWidth}px"
      @contentEl.style.marginTop = "-#{Math.ceil(@realContentEl.offsetHeight / 2)}px"
      @contentEl.style.marginLeft = "-#{Math.ceil(@realContentEl.offsetWidth / 2)}px"
    else
      @contentEl.style.width = "80%"
      @contentEl.style.position = 'relative'
      @contentEl.style.marginLeft = 'auto'
      @contentEl.style.marginRight = 'auto'
      @contentEl.style.marginTop = '20px'

  _close_handler: (e) =>
    e.preventDefault()
    e.stopPropagation()
    @hide()

  _prevent_handler: (e) =>
    e.preventDefault()
    e.stopPropagation()

  build_dom: =>
    @wrapperEl = document.createElement('div')
    @contentEl = document.createElement('div')

    @closeButton = document.createElement('span')

    # configure wrapper
    shadowClass = ''
    shadowClass = 'has-shadow' if @shadow

    @wrapperEl.setAttribute('class', "activeadmin-lightbox-wrapper #{shadowClass}")
    @wrapperEl.addEventListener('click', @_close_handler)

    #configure content
    @contentEl.setAttribute('class', 'activeadmin-lightbox-content')
    @contentEl.addEventListener('click', @_prevent_handler)
    @wrapperEl.appendChild(@contentEl)

    # configure closeButton
    @closeButton.innerHTML = '&times;'
    @closeButton.setAttribute('class', 'activeadmin-lightbox-close-button')
    @closeButton.addEventListener('click', @_close_handler)

    @contentEl.appendChild(@closeButton)
