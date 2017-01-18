var AppUtil = (function() {
	function getProgressBar(message) {
		return "<div class='progress'>"
			+ "<div class='progress-bar progress-bar-striped active' style='width:100%'>"
			+ message
			+ "</div></div>";
	}
	
	function renderAlert(message, alertType, closable) {
		return "<div class='alert alert-" + alertType + (closable ? " alert-dismissable" : "") + "'>"
			+ (closable ? "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>" : "")
			+ message + "</div>";
	}
	
	function renderErrors(message, errors) {
		var html = "<div class='alert alert-danger alert-dismissable'>"
			+ "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>"
			+ message
			+ "<ul>";
			
		return html + errors.map(function(e) {
			return "<li><b>" + e + "</b></li>";
		}).join("") + "</ul></div>";
	}
	
	return {
		getProgressBar: getProgressBar,
		renderAlert: renderAlert,
		renderErrors: renderErrors
	};
})();