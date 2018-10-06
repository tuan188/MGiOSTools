# coding=utf-8

from .str_helpers import lower_first_letter
from .pb import pasteboard_write
from .command import Command

class APICommand(Command):
	def __init__(self, api_name):
		super(APICommand, self).__init__()
		self.api_name = api_name

	def create_api(self):
		output = API(self.api_name).create_api()
		pasteboard_write(output)
		print("The result has been copied to the pasteboard.")


class API(object):
	def __init__(self, api_name):
		super(API, self).__init__()
		self.api_name = api_name

	def create_api(self):
		name = self.api_name
		var_name = lower_first_letter(name)
		content = "// MARK: - {}\n".format(name)
		content += "extension API {\n"
		content += "    func {}(_ input: {}Input) -> Observable<{}Output> {{\n".format(var_name, name, name)
		content += "        return request(input)\n"
		content += "    }\n\n"
		content += "    final class {}Input: APIInput {{\n".format(name)
		content += "        init() {\n"
		content += "            super.init(urlString: API.Urls.{},\n".format(var_name)
		content += "                       parameters: nil,\n"
		content += "                       requestType: .get,\n"
		content += "                       requireAccessToken: true)\n"
		content += "        }\n    }\n\n"
		content += "    final class {}Output: APIOutput {{\n".format(name)
		content += "        override func mapping(map: Map) {\n"
		content += "            super.mapping(map: map)\n"
		content += "        }\n    }\n}\n"
		return content