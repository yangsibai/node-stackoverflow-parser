request = require("request")

exports.isStackoverflowQuestion = (url)->
	pattern = /stackoverflow.com\/questions\/\d+/i
	return pattern.test(url)

###
    download page
###
exports.download = (url, cb)->
	request url, (err, response, body)->
		if err
			cb err
		else if response.statusCode isnt 200
			cb new Error("http error,code:#{response.statusCode}")
		else
			cb null, body.toString()

###
    remove attributes
    @param {Object} node
###
exports.trimAttrs = (node)->
	all = node.find("*")
	for n in all
		proAttrs = ['srv']
		if n.name isnt "object" and n.name isnt "embed"
			proAttrs.push 'href'
			proAttrs.push 'width' #TODO:图片的宽度高度应该留一个
		for attr in n.attribs
			$(n).removeAttr(attr) if attr not in proAttrs #TODO:是否可以通过直接 delete 呢

###
    replace relative path with real path
    @param {Object} node
    @param {String} baseUrl
###
exports.pullOutRealPath = (node, baseUrl)->
	if baseUrl
		imgs = node.find('img')
		imgs.each (i, img)->
			realPath = img.attribs['src']
			_.each img.attribs, (value, key)->
				realPath = value if _isUrl(value) and (value isnt realPath or (not realPath))
			img.attribs['src'] = if _isUrl(realPath) then realPath else url.resolve(baseUrl, realPath)

		links = node.find('a')
		links.each (i, link)->
			link.attribs['href'] = url.resolve(baseUrl, link.attribs['href']) if link.attribs['href']

###
    get author info
###
exports.getAuthor = (info)->
	arr = info.split("，")
	return {
	name: arr[0]
	about: arr[1] or ""
	}
