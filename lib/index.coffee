util = require("./util")
cheerio = require("cheerio")

exports.parse = (url, cb)->
	if url
		if util.isStackoverflowQuestion(url)
			_parse url, cb
		else
			cb new Error("url #{url} isn't a stackoverflow question page.")
	else
		cb new Error("must supply a url")

_parse = (url, cb)->
	util.download url, (err, content)->
		return cb(err) if err
		$ = cheerio.load(content)

		title = $("#question-header .question-hyperlink").text().trim()
		question = $(".question .post-text").html().trim()

		tags = []
		tagElements = $(".post-taglist .post-tag")
		tagElements.each (i, el)->
			tags.push $(el).text().trim()

		answersArr = []
		answers = $(".answercell")
		answers.each ()->
			node = $(this)
			answerDetail = node.find(".post-text")
			util.trimAttrs(answerDetail)

			answersArr.push
				content: answerDetail.html().trim()

		article =
			title: title
			question: question
			tags: tags
			answers: answersArr

		cb null, article
