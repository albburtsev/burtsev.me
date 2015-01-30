jQuery ($)->
	'strict mode'

	throttle = (fn, delay, context)->
		timer = null
		context = context or this
		delay = delay or 100

		return ()->
			if ( timer )
				return

			timer = setTimeout ()->
				timer = null
			, delay
			fn.apply context, arguments

	_win = $ window
	_doc = $ document
	_body = $ 'body'
	_menu = $ '.js-menu'
	_links = $ 'a', _menu
	_rubucon = $ '.js-rubicon'

	rubuconValue = 0
	scrollDuration = 200 # ms

	_win.on 'resize vpchange', ()->
		rubuconValue = _rubucon.offset().top
	_win.trigger 'vpchange'

	_doc.on 'scroll', throttle ()->
			scrollTop = _doc.scrollTop()
			_menu.toggleClass 'is-fixed', scrollTop > rubuconValue
		, 50

	# todo: scrollspy
	# todo: hash navigation

	_links.click (e)->
		_a = $ e.target
		id = _a.attr('href').substr 1
		_slide = $ '#' + id
		top = _slide.offset().top

		if _links.get(0) isnt e.target
			top -= _menu.height()

		_body.animate
			scrollTop: top
		, scrollDuration

		return false
