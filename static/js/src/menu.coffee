jQuery ($)->
	'strict mode'

	_win = $ window
	_doc = $ document
	_body = $ 'html,body'
	_menu = $ '.js-menu'
	_links = $ 'a', _menu
	_rubucon = $ '.js-rubicon'

	# Show menu after scroll down
	rubuconValue = 0
	scrollDuration = 200 # ms

	_win.on 'resize vpchange', ()->
		rubuconValue = _rubucon.offset().top
	_win.trigger 'vpchange'

	_doc.on 'scroll', utils.throttle ()->
			scrollTop = _doc.scrollTop()
			_menu.toggleClass 'is-fixed', scrollTop > rubuconValue
		, 50

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

	# Router: https://github.com/flatiron/director#api-documentation
	router = Router()
	router.configure
		html5history: true

	router.on '*', (path)->
		scrollTo path

	router.init()

	# todo: scrollspy
