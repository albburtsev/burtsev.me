# DocPad Configuration File
# http://docpad.org/docs/config

fingerprint = require('./fingerprint').fp

# Define the DocPad Configuration
docpadConfig = {
	templateData:
		site:
			title: 'Alexander Burtsev: frontend-developer &amp; traveler'

		contacts:
			mail:
				value: 'albburtsev@gmail.com'
				link: 'mailto:albburtsev@gmail.com'
				icon: 'email6'
				special: true
			tel:
				value: '+7 (916) 006-48-54'
				link: 'tel:+79160064854'
				icon: 'phone72'
				special: true
			skype:
				value: 'albburtsev'
				link: 'skype:albburtsev'
				icon: 'social6'
				special: true
				delim: true
			habr:
				value: 'Habrahabr'
				link: '//habrahabr.ru/users/bur/'
				icon: 'hotel75'
			github:
				value: 'Github'
				link: '//github.com/albburtsev'
				icon: 'github13'
				delim: true
			foursquare:
				value: 'Foursquare'
				link: '//foursquare.com/user/46356854'
				icon: 'check59'
			fb:
				value: 'Facebook'
				link: '//www.facebook.com/albburtsev'
				icon: 'facebook29'
			instagram:
				value: 'Instagram'
				link: '//instagram.com/albburtsev/'
				icon: 'photos12'
			youtube:
				value: 'Youtube'
				link: '//www.youtube.com/user/albburtsev'
				icon: 'youtube17'
			google:
				value: 'Google+'
				link: '//plus.google.com/u/0/112730589178585282928/posts'
				icon: 'social5'
			twitter:
				value: 'Twitter'
				link: '//twitter.com/albburtsev'
				icon: 'social19'

		projectsScreenshotPath: '/build/i/screenshots/'
		projects:
			rememba:
				url: '//rememba.ru/'
				title: 'Rememba'
				screenshot: 'rememba.png'
				caption: 'Application for expanding vocabulary'
				text: 'My contribution: frontend code of application (Backbone/Marionette) and tests (CasperJS/PhantonCSS).'
			edox:
				url: '//edox.ru/'
				title: 'Edox Russia'
				screenshot: 'edox.png'
				caption: 'Edox watches in Russia'
				text: 'My contribution: frontend (HTML/CSS, jQuery) and backend (CMS Correct).'
			gc:
				url: '//www.gcwatches.ru/'
				title: 'GC Watches'
				screenshot: 'gc.png'
				caption: 'GC Watches in Russia'
				text: 'My contribution: frontend (HTML/CSS, jQuery) and backend (CMS Correct).'
			treewt:
				url: '//3waytalk.com/'
				title: '3waytalk'
				screenshot: '3waytalk.png'
				caption: 'Connects you to an interpreter'
				text: 'My contribution: WebRTC client (based on sip.js), audio players (SoundManager), dashboard, etc.'

		poweredBy:[
			['Common sense', '//github.com/albburtsev/burtsev.me']
			['DocPad', '//docpad.org/']
			['CoffeeScript', '//coffeescript.org/']
			['Stylus', '//learnboost.github.io/stylus/']
			['Grunt', '//gruntjs.com/']
			['Bower', '//bower.io/']
		]

		fingerprint: fingerprint

		getTitle: ()->
			if @document.title then "#{@document.title} — #{@site.title}" else @site.title

	collections:
		slides: ->
			@getCollection("html").findAllLive({isSlide:true}, [date:1])
}

# Export the DocPad Configuration
module.exports = docpadConfig
