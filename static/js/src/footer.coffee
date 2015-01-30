jQuery ($) ->
	'strict mode'

	_doc = $ document
	_body = $ 'body'
	_icon = $ '.js-footer-icon'
	_list = $ '.js-footer-list'
	isHidden = 'is-hidden'

	_icon.click ()->
		_list.toggleClass isHidden
		if not _list.hasClass isHidden
			_body.stop()
			_body.animate(scrollTop: _doc.height(), 200)

		return false
