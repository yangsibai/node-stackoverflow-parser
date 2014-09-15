parser = require("../lib/index")
should = require("should")
_ = require("underscore")

describe "parser test", ()->
	it "should parse ok", (done)->
		try
			url = "http://stackoverflow.com/questions/244777/can-i-comment-a-json-file"
			parser.parse url, (err, article)->
				should.not.exist(err)
				article.title.should.be.a.String.and.be.exactly("Can I comment a JSON file?")
				article.tags.should.matchEach (it)->
					it.should.be.a.String.and.not.be.empty
				article.answers.should.be.an.Array
				article.answers.should.matchEach (it)->
					it.content.should.be.a.String.and.not.be.empty
				done()
		catch e
			console.dir e
