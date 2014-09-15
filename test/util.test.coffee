should = require("should")
util = require("../lib/util")

describe "util test", ()->
	it "url should be a stackoverflow question page", ()->
		url = "http://stackoverflow.com/questions/2094666/pointers-in-c-when-to-use-the-ampersand-and-the-asterisk"
		util.isStackoverflowQuestion(url).should.be.ok
	it "url should not be a st question page", ()->
		url = "http://stackoverflow.com/tags"
		util.isStackoverflowQuestion(url).should.be.not.ok