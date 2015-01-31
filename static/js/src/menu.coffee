jQuery ($)->
	'strict mode'

	_win = $ window
	_doc = $ document
	_body = $ 'html,body'
	_menu = $ '.js-menu'
	_links = $ 'a', _menu
	_rubucon = $ '.js-rubicon'

	# Show menu after scroll down
	# Rubicon — it's a horizontal line. Menu shows when rubicon isn't visible after scroll
	rubuconValue = 0
	scrollDuration = 200 # ms
	scrollDelay = 100 # ms
	viewports = {}

	_win.on 'resize vpchange', ()->
		checkSlides()
		rubuconValue = _rubucon.offset().top

	_doc.on 'scroll', utils.throttle ()->
			_menu.toggleClass 'is-fixed', _doc.scrollTop() > rubuconValue
			scrollSpy()
		, scrollDelay

	# Scroll page to given slide
	scrollTo = (path)->
		_slide = $ '#' + path
		top = _slide.offset().top
		top -= _menu.height()
		top = parseInt top, 10

		if path is 'about'
			top = 0

		_body.animate
			scrollTop: top
		, scrollDuration

	# Scroll page and update route after click into menu item	
	_links.click (e)->
		_link = $ e.target
		id = _link.attr('href').substr 1
		router.setRoute id

		return false

	# Scrollspy
	checkSlides = ()->
		$('[data-slide]').each ->
			_this = $ this
			key = _this.data 'slide'
			viewports[key] =
				top: _this.offset().top
				height: _this.height()

	cmpMinValue = (i, j)->
		if i[1] > j[1]
			return -1
		else if i[1] < j[1]
			return 1
		return 0

	scrollSpy = ()->
		wvp =
			height: _win.height()
			top: _doc.scrollTop()
		intersections = []

		$.each viewports, (key, vp)->
			value = 0
			if vp.top > wvp.top and vp.top < wvp.top + wvp.height
				value = Math.min vp.height, wvp.height - (vp.top - wvp.top)
			else if vp.top < wvp.top and vp.top + vp.height > wvp.top
				value = Math.min wvp.height, vp.top + vp.height - wvp.top
			intersections.push [key, Math.max 0, value]

		intersections.sort(cmpMinValue)
		key = intersections[0][0]
		_links.removeClass 'is-active'
		_links.filter("[href='##{key}']").addClass 'is-active'

	# Init viewport and rubicon calculations
	_win.trigger 'vpchange'

	# Router: https://github.com/flatiron/director#api-documentation
	router = Router()
	router.configure
		html5history: true

	router.on '*', (path)->
		scrollTo path

	router.init()
