exports.copyMetadataToModel = copyMetadataToModel;

function copyMetadataToModel(model) {
	if (model.hasOwnProperty("metadata")) {
		for (let key in model.metadata) {
			model[key] = model.metadata[key];
		}
	}

	return model;
}
