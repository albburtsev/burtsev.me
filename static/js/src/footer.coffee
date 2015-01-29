jQuery ($) ->
	'strict mode'

	_icon = $ '.js-footer-icon'
	_list = $ '.js-footer-list'
	isHidden = 'is-hidden'

	_icon.click ()->
		_list.toggleClass isHidden
		# todo: smooth scroll when list opening
		return false
