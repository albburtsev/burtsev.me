'use script'

utils = {}

utils.throttle = (fn, delay, context)->
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

window.utils = utils;
