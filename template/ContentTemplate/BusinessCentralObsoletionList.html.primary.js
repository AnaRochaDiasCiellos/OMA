var common = require('./BusinessCentral.common.js');
var extension = require('./BusinessCentralObsoletionList.extension.js');

exports.transform = function (model) {
	model._op_templateFilename = 'BusinessCentralObsoletionList';

	if (extension) {
		model = extension.preTransform(model);
	}

	if (common) {
		model = common.copyMetadataToModel(model);
	}

	model._disableNextArticle = true;

	if (extension) {
		model = extension.postTransform(model);
	}

	return model;
};
