# DocPad Configuration File
# http://docpad.org/docs/config

# Define the DocPad Configuration
docpadConfig = {
	templateData:
		site:
			title: 'Alexander Burtsev: frontend-developer &amp; traveler'

		getTitle: ()->
			if @document.title then "#{@document.title} — #{@site.title}" else @site.title

	collections:
		slides: ->
			@getCollection("html").findAllLive({isSlide:true})
}

# Export the DocPad Configuration
module.exports = docpadConfig
