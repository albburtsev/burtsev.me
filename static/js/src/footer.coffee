icon = document.querySelector '.js-footer-icon'
list = document.querySelector '.js-footer-list'
isHidden = 'is-hidden'

icon.addEventListener 'click', () ->
	className = list.className
	if className.indexOf(isHidden) is -1
		className += ' ' + isHidden
	else
		className = className.replace(isHidden, '')

	list.className = className
	return false
