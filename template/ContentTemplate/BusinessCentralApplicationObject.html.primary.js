var common = require('./BusinessCentral.common.js');
var extension = require('./BusinessCentralApplicationObject.extension.js');

exports.transform = function (model) {
	model._op_templateFilename = 'BusinessCentralApplicationObject';

	if (extension) {
		model = extension.preTransform(model);
	}

	if (common) {
		model = common.copyMetadataToModel(model);
	}

	model._disableNextArticle = true;

	if (model.baseKind) {
		switch (model.baseKind) {
			case '.NET Package':
				model.isDotNetPackage = true;
				break;
			case 'Codeunit':
				model.isCodeunit = true;
				break;
			case 'ControlAddIn':
				model.isControlAddIn = true;
				break;
			case 'Enum':
				model.isEnum = true;
				break;
			case 'Interface':
				model.isInterface = true;
				break;
			case 'Module':
				model.isModule = true;
				break;
			case 'Page':
				model.isPage = true;
				break;
			case 'PermissionSet':
				model.isPermissionSet = true;
				break;
			case 'Profile':
				model.isProfile = true;
				break;
			case 'Report':
				model.isReport = true;
				break;
			case 'Query':
				model.isQuery = true;
				break;
			case 'Table':
				model.isTable = true;
				break;
			case 'XmlPort':
				model.isXmlPort = true;
				break;
		}
	}

	updateChildren(model);

	if (extension) {
		model = extension.postTransform(model);
	}

	return model;
};

function updateChildren(model) {
	updateMemberDetails(model.events);
	updateMemberDetails(model.enumValues);
	updateMemberDetails(model.integrationEvents);
	updateMemberDetails(model.methods);
	updateObsoletion(model);
}

function updateMemberDetails(members) {
	if (members) {
		members.forEach(element => {
			element.commentId = element.commentId || null;
			element.examples = element.examples || "";
			element.remarks = element.remarks || "";
			element.summary = element.summary || "";
			element.description = element.description || "";
			updateSyntax(element.syntax);
			updateObsoletion(element);
		});
	}
}

function updateSyntax(syntax) {
	if (syntax) {
		if (syntax.signatures) {
			syntax.declaration = syntax.signatures.join('\n') + '\n' + syntax.content;
		} else {
			syntax.declaration = syntax.content;
		}
		updateParameters(syntax.parameters);
		updateReturn(syntax.return);
	}
}

function updateParameters(parameters) {
	if (parameters) {
		parameters.description = parameters.description || null;
		updateTypeClass(parameters.parameterType);
	}
}

function updateReturn(returnObj) {
	if (returnObj) {
		returnObj.description = returnObj.description || null;
		updateTypeClass(returnObj.returnType);
	}
}

function updateTypeClass(typeClass) {
	if (typeClass) {
		typeClass.name = typeClass.name || null;
		typeClass.uid = typeClass.uid || null;
	}
}

function updateObsoletion(element) {
	if (element.obsoletion) {
		if (element.obsoletion.state === 'pending') {
			element.obsoletion.isPending = true;
		}
	} else {
		element.obsoletion = null;
	}
}
