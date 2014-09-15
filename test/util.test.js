// Generated by CoffeeScript 1.7.1
(function() {
  var should, util;

  should = require("should");

  util = require("../lib/util");

  describe("util test", function() {
    it("url should be a stackoverflow question page", function() {
      var url;
      url = "http://stackoverflow.com/questions/2094666/pointers-in-c-when-to-use-the-ampersand-and-the-asterisk";
      return util.isStackoverflowQuestion(url).should.be.ok;
    });
    return it("url should not be a st question page", function() {
      var url;
      url = "http://stackoverflow.com/tags";
      return util.isStackoverflowQuestion(url).should.be.not.ok;
    });
  });

}).call(this);

//# sourceMappingURL=util.test.map