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
	_rubucon = $ '.js-rubicon'
	_menu = $ '.js-menu'

	rubuconValue = 0

	_win.on 'resize', ()->
		rubuconValue = _rubucon.offset().top
	_win.trigger 'resize'

	_doc.on 'scroll', throttle ()->
			scrollTop = _doc.scrollTop()
			_menu.toggleClass 'is-fixed', scrollTop > rubuconValue
		, 50