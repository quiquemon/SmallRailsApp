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
	function _spanishDate(date) {
		var months = {
			"01": "Enero",
			"02": "Febrero",
			"03": "Marzo",
			"04": "Abril",
			"05": "Mayo",
			"06": "Junio",
			"07": "Julio",
			"08": "Agosto",
			"09": "Septiembre",
			"10": "Octubre",
			"11": "Noviembre",
			"12": "Diciembre"
		};
		
		var dateArray = date.split("-");
		return dateArray[2] + " de " + months[dateArray[1]] + " de " + dateArray[0];
	}

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
	
	function createNewTeam() {
		$("#btnNewTeam").click(function() {
			var button = $(this);
			
			button.prop("disabled", true);
			$("#newTeamBody .alert").remove();
			$("#newTeamBody").prepend(AppUtil.getProgressBar("Estamos validando tus datos. ¡Solo un momento!"));
			
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
					$("#newTeamBody").prepend(AppUtil.renderAlert(response.message, "success"));
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
			$("#updateTeamBody").prepend(AppUtil.getProgressBar("Estamos validando tus datos. ¡Solo un momento!"));
			
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
						$("#updateTeamBody").prepend(AppUtil.renderAlert(response.message, "success", true));
						setTimeout(function() {
							window.location = response.redirect;
						}, 3000);
					}
				}
			});
		});
	}
	
	function findUser() {
		function _renderFoundRunnersList(runners) {
			var html = "";

			runners.forEach(function(e) {
				var panel = "<div class='panel panel-info'>"
					+ "<div class='panel-heading'><b>Runner found!</b></div>"
					+ "<div class='panel-body'>"
					+ "<div class='list-group'>"
					+ "<a class='list-group-item'><span class='glyphicon glyphicon-user'></span> " + e.name + " " + e.lastname + "</a>"
					+ "<a class='list-group-item'><span class='glyphicon glyphicon-list-alt'></span> " + _spanishDate(e.birthday) + "</a>"
					+ "<a class='list-group-item'><span class='glyphicon glyphicon-envelope'></span> " + e.email + "</a>"
					+ "</div>"
					+ "<button class='btn btn-success btnAddUser' id='" + e.id + "'>"
					+ "<span class='glyphicon glyphicon-plus'></span> Add To Team</button>"
					+ "</div></div>";

				html += panel;
			});

			return html;
		}
		
		$("#btnFindUser").click(function() {
			var button = $(this);
			
			button.prop("disabled", true);
			$("#findUserBody").empty();
			$("#findUserBody").append(AppUtil.getProgressBar("Buscando al corredor. ¡Solo un momento!"));
			
			$.get("/find_user/" + TEAM_ID, {
				email: $("#email").val()
			}, function(response) {
				$("#findUserBody").empty();
				button.prop("disabled", false);
				
				if (response.status) {	
					$("#findUserBody").append(AppUtil.renderAlert(response.message, "danger", false));
				} else {
					$("#findUserBody").append(AppUtil.renderAlert(response.message, "success", false));
					$("#findUserBody").append(_renderFoundRunnersList(response.users));
				}
			});
			
		});
	}
	
	function addUser() {
		function _addUserToRunnersList(user) {
			var html = "<a class='list-group-item'>"
				+ user.name + " " + user.lastname + " | <i>" + user.email + "</i>"
				+ "</a>";
			
			$("#runnersList").append(html);
		}
		
		$("#findUserBody").on("click", ".btnAddUser", function() {
			var button = $(this);
			var idUser = button.attr("id");
			var panelBody = $(this.parentElement);
			var panel = $(this.parentElement.parentElement);
			
			button.prop("disabled", true);
			panelBody.append("<br><br>" + AppUtil.getProgressBar("Agregando al usuario a tu equipo. ¡Solo un momento!"));
			
			$.post("/add_to_team", {
				id: TEAM_ID,
				idUser: idUser
			}, function(response) {
				panelBody.children(".progress, br, .alert").remove();
				
				if (response.status) {
					panelBody.append("<br><br>" + _renderUpdateErrors(response.errors));
					button.prop("disabled", false);
				} else {
					panel.remove();
					_addUserToRunnersList(response.user);
					BootstrapDialog.show({
						title: "Usuario agregado",
						message: response.message,
						type: BootstrapDialog.TYPE_SUCCESS,
						buttons: [{
							label: "Cerrar",
							cssClass: "btn-success",
							action: function(dialog) {
								dialog.close();
							}
						}]
					});
				}
			});
		});
	}
	
	function removeFromTeam() {
		$("#removeFromTeamBody").on("click", ".btnRemoveFromTeam", function() {
			function _removeMember(dialog) {
				var removeButton = $(this[0]);
				
				removeButton.prop("disabled", true);
				$(".btn-danger").prop("disabled", true);
				dialog.setMessage(
					message
					+ "<br><br>"
					+ AppUtil.getProgressBar("Removiendo al usuario. ¡Solo un momento!")
				);
				
				$.post("/remove_from_team", {
					id: TEAM_ID,
					idUser: idUser
				}, function(response) {
					if (response.status) {
						removeButton.prop("disabled", false);
						$(".btn-danger").prop("disabled", false);
						dialog.setMessage(message + "<br><br>" + _renderUpdateErrors(response.errors));
					} else {
						dialog.setMessage(message + "<br><br>" + AppUtil.renderAlert(response.message, "success", false));
						setTimeout(function() {
							window.location.reload();
						}, 3000);
					}
				});
			}
			
			var button = $(this);
			var idUser = button.attr("id");
			var message = "Do you really want to remove <b>" + button.attr("user") + "</b> from your team?";
			
			BootstrapDialog.show({
				title: "Remove from team",
				message: message,
				type: BootstrapDialog.TYPE_WARNING,
				closable: false,
				buttons: [{
					label: "Remove",
					cssClass: "btn-warning",
					action: _removeMember
				}, {
					label: "Cancel",
					cssClass: "btn-danger",
					action: function(dialog) {
						dialog.close();
					}
				}]
			});
		});
	}
	
	function deleteTeam() {
		$("#btnDeleteTeam").click(function() {
			function _deleteTeam(dialog) {
				var deleteButton = $(this[0]);
				
				deleteButton.prop("disabled", true);
				$(".btn-primary").prop("disabled", true);
				dialog.setMessage(
					message
					+ "<br><br>"
					+ AppUtil.getProgressBar("Eliminando a tu equipo. ¡Solo un momento!")
				);
		
				$.post("/delete_team", {
					id: idTeam
				}, function(response) {
					if (response.status) {
						deleteButton.prop("disabled", false);
						$(".btn-primary").prop("disabled", false);
						dialog.setMessage(message + "<br><br>" + _renderUpdateErrors(response.errors));
					} else {
						dialog.setMessage(message + "<br><br>" + AppUtil.renderAlert(response.message, "success", false));
						setTimeout(function() {
							window.location = "/teams";
						}, 2000);
					}
				});
			}
			
			var idTeam = $(this).attr("id-team");
			var message = "Are you sure you want to delete this team? <b>You won't be able to undo this action.</b>";
			
			BootstrapDialog.show({
				title: "Delete Team",
				message: message,
				type: BootstrapDialog.TYPE_DANGER,
				closable: false,
				buttons: [{
					label: "Delete",
					cssClass: "btn-danger",
					action: _deleteTeam
				}, {
					label: "Cancel",
					cssClass: "btn-primary",
					action: function(dialog) {
						dialog.close();
					}
				}]
			});
		});
	}
	
	return {
		createNewTeam: createNewTeam,
		updateTeam: updateTeam,
		findUser: findUser,
		addUser: addUser,
		removeFromTeam: removeFromTeam,
		deleteTeam: deleteTeam
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
		TeamController.findUser();
		TeamController.addUser();
		TeamController.removeFromTeam();
		TeamController.deleteTeam();
	}
});