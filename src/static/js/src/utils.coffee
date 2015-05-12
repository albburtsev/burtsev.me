'use script'

utils = {}

utils.debounce = (fn, delay, context)->
	timer = null
	context = context or this
	delay = delay or 100

	return ()->
		args = arguments
		clearTimeout timer
		timer = setTimeout ()->
			fn.apply context, args
		, delay

window.utils = utils;
