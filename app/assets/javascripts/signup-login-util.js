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
	
	function _renderUpdateErrors() {
		var html =
			"<div class='col-sm-12'>"
			+ "<strong>Ocurrieron algunos errores al momento de actualizar:</strong><br><br>"
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
	
	function updateProfile() {
		$("#btnUpdatePersonalInfo").click(function() {
			var button = $(this);
			
			button.prop("disabled", true);
			$("#updatePersonalInfoPanelBody").prepend(progressHtml);
			$.post("/update_profile", {
				
			}, function(response) {
				button.prop("disabled", false);
			});
		});
	}
	
	function updatePassword() {
		$("#btnUpdatePassword").click(function() {
			var button = $(this);
			
			button.prop("disabled", true);
			$("#updatePasswordPanelBody").prepend(progressHtml);
			$.post("/update_password", {
				
			}, function(response) {
				button.prop("disabled", false);
			});
		});
	}
	
	return {
		updateProfile: updateProfile,
		updatePassword: updatePassword
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
	}
});