var IndexController = (function() {
	function _renderSignUpErrors(errors) {
		var html =
			"<div class='col-sm-12'>"
			+ "<strong>Ocurrieron algunos errores al tratar de registrarte:</strong><br><br>"
			+ "<div class='list-group'>";

		for (var key in errors) {
			if (errors.hasOwnProperty(key)) {
				errors[key].forEach(function(error) {
					html += "<a class='list-group-item'>" + error + "</a>";
				});
			}
		}

		return html + "</div></div>";
	}

	function cancelButton() {
		$(".btnCancel").click(function() {
			$(".close").click();
		});
	}

	function signUp(){
		$("#btnSignUp").click(function() {
			var button = $(this);
			var html =
				"<div class='progress'>"
				+ "<div class='progress-bar progress-bar-striped active' style='width:100%'>"
				+ "Estamos validando tus datos. ¡Solo un momento!"
				+ "</div>";

			button.prop("disabled", true);
			$("#signUpButtonRow").prepend(html);
			$.post("/sign_up", {
				name: $("#name").val(),
				lastname: $("#lastname").val(),
				birthday: $("#birthday").val(),
				email: $("#email").val(),
				password: $("#password").val(),
				newsletter: $("#newsletter").val()
			}, function(response) {
				if (response.status) {
					button.prop("disabled", false);
					$("#signUpButtonRow .progress").remove();

					BootstrapDialog.show({
						title: "Datos incorrectos",
						message: _renderSignUpErrors(response.errors),
						type: BootstrapDialog.TYPE_DANGER,
						buttons: [{
							label: "Cerrar",
							icon: "glyphicon glyphicon-remove",
							cssClass: "btn-danger",
							action: function(dialog) {
								dialog.close();
							}
						}]
					});
				} else {
					setTimeout(function() {
						window.location = "/dashboard";
					}, 2000);
				}
			});
		});
	}

	function login() {
		$("#btnLogin").click(function() {
			var button = $(this);
			var html =
				"<div class='progress'>"
				+ "<div class='progress-bar progress-bar-striped active' style='width:100%'>"
				+ "Estamos validando tus datos. ¡Solo un momento!"
				+ "</div>";

			button.prop("disabled", true);
			$("#loginButtonRow").prepend(html);
			$.post("/login", {
				email: $("#emailLogin").val(),
				password: $("#passwordLogin").val()
			}, function(response) {
				if (response.status) {
					button.prop("disabled", false);
					$("#loginButtonRow .progress").remove();

					BootstrapDialog.show({
						title: "Error al iniciar sesión.",
						message: response.error,
						type: BootstrapDialog.TYPE_DANGER,
						buttons: [{
							label: "Cerrar",
							icon: "glyphicon glyphicon-remove",
							cssClass: "btn-danger",
							action: function(dialog) {
								dialog.close();
							}
						}]
					});
				} else {
					setTimeout(function() {
						window.location = "/dashboard";
					}, 1000);
				}
			});
		});
	}
	
	return {
		cancelButton: cancelButton,
		signUp: signUp,
		login: login
	};
})();

var DashboardController = (function() {
	var progressHtml =
		"<div class='progress'>"
		+ "<div class='progress-bar progress-bar-striped active' style='width:100%'>"
		+ "Estamos validando tus datos. ¡Solo un momento!"
		+ "</div>";
	
	function _renderUpdateErrors(errors) {
		var html =
			"<div class='alert alert-danger alert-dismissable'>"
			+ "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>"
			+ "Ocurrieron algunos errores al momento de actualizar:"
			+ "<ul>";

		for (var key in errors) {
			if (errors.hasOwnProperty(key)) {
				errors[key].forEach(function(error) {
					html += "<li><b>" + error + "</b></li>";
				});
			}
		}

		return html + "</ul></div>";
	}
	
	function _renderUpdateSuccessMessage(message) {
		return "<div class='alert alert-success alert-dismissable'>"
			+ "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>"
			+ message
			+ "</div>";
	}
	
	function updateProfile() {
		$("#btnUpdatePersonalInfo").click(function() {
			var button = $(this);
			
			button.prop("disabled", true);
			$("#updatePersonalInfoPanelBody .alert").remove();
			$("#updatePersonalInfoPanelBody").prepend(progressHtml);
			
			$.post("/update_profile", {
				name: $("#name").val(),
				lastname: $("#lastname").val(),
				birthday: $("#birthday").val(),
				email: $("#email").val(),
				newsletter: $("#newsletter").val()
			}, function(response) {
				button.prop("disabled", false);
				$("#updatePersonalInfoPanelBody .progress").remove();
				$("#updatePersonalInfoPanelBody").prepend(
					response.status
					? _renderUpdateErrors(response.errors)
					: _renderUpdateSuccessMessage(response.message)
				);
			});
		});
	}
	
	function updatePassword() {
		$("#btnUpdatePassword").click(function() {
			var button = $(this);
			
			button.prop("disabled", true);
			$("#updatePasswordPanelBody .alert").remove();
			$("#updatePasswordPanelBody").prepend(progressHtml);
			
			$.post("/update_password", {
				oldPassword: $("#oldPassword").val(),
				newPassword: $("#newPassword").val()
			}, function(response) {
				button.prop("disabled", false);
				$("#updatePasswordPanelBody .progress").remove();
				$("#updatePasswordPanelBody").prepend(
					response.status
					? _renderUpdateErrors(response.errors)
					: _renderUpdateSuccessMessage(response.message)
				);
			});
		});
	}
	
	return {
		updateProfile: updateProfile,
		updatePassword: updatePassword
	};
})();

var TeamController = (function() {
	var progressHtml =
		"<div class='progress'>"
		+ "<div class='progress-bar progress-bar-striped active' style='width:100%'>"
		+ "Estamos validando tus datos. ¡Solo un momento!"
		+ "</div>";

	function _renderUpdateErrors(errors) {
		var html =
			"<div class='alert alert-danger alert-dismissable'>"
			+ "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>"
			+ "Ocurrieron algunos errores al momento de actualizar:"
			+ "<ul>";

		for (var key in errors) {
			if (errors.hasOwnProperty(key)) {
				errors[key].forEach(function(error) {
					html += "<li><b>" + error + "</b></li>";
				});
			}
		}

		return html + "</ul></div>";
	}
	
	function _renderUpdateSuccessMessage(message) {
		return "<div class='alert alert-success alert-dismissable'>"
			+ "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>"
			+ message
			+ "</div>";
	}
	
	function createNewTeam() {
		$("#btnNewTeam").click(function() {
			var button = $(this);
			
			button.prop("disabled", true);
			$("#newTeamBody .alert").remove();
			$("#newTeamBody").prepend(progressHtml);
			
			$.post("/new_team", {
				name: $("#name").val(),
				description: $("#description").val(),
				memberNumber: $("#members").val()
			}, function(response) {
				$("#newTeamBody .progress").remove();
				
				if (response.status) {
					button.prop("disabled", false);
					$("#newTeamBody").prepend(_renderUpdateErrors(response.errors));
				} else {
					$("#newTeamBody").prepend(_renderUpdateSuccessMessage(response.message));
					setTimeout(function() {
						window.location = "/teams";
					}, 3000);
				}
			});
		});
	}
	
	function updateTeam() {
		$("#btnUpdateTeam").click(function() {
			var button = $(this);
			
			button.prop("disabled", true);
			$("#updateTeamBody .alert").remove();
			$("#updateTeamBody").prepend(progressHtml);
			
			$.post("/update_team", {
				name: $("#name").val(),
				description: $("#description").val(),
				memberNumber: $("#members").val(),
				id: TEAM_ID
			}, function(response) {
				$("#updateTeamBody .progress").remove();
				
				if (response.hasOwnProperty("status")) {
					if (response.status) {
						button.prop("disabled", false);
						$("#updateTeamBody").prepend(_renderUpdateErrors(response.errors));
					} else {
						$("#updateTeamBody").prepend(_renderUpdateSuccessMessage(response.message));
						setTimeout(function() {
							window.location = response.redirect;
						}, 3000);
					}
				}
			});
		});
	}
	
	return {
		createNewTeam: createNewTeam,
		updateTeam: updateTeam
	};
})();

$(document).ready(function() {
	if (CONTROLLER_NAME === "index") {
		IndexController.cancelButton();
		IndexController.signUp();
		IndexController.login();
	} else if (CONTROLLER_NAME === "dashboard") {
		DashboardController.updateProfile();
		DashboardController.updatePassword();
	} else if (CONTROLLER_NAME === "team") {
		TeamController.createNewTeam();
		TeamController.updateTeam();
	}
});