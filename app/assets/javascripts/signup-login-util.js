function renderSignUpErrors(errors) {
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
		
		button.prop("disabled", true);
		$.post("/sign_up", {
			name: $("#name").val(),
			lastname: $("#lastname").val(),
			birthday: $("#birthday").val(),
			email: $("#email").val(),
			password: $("#password").val(),
			newsletter: $("#newsletter").val()
		}, function(response) {
			if (response.errors) {
				button.prop("disabled", false);
				BootstrapDialog.show({
					title: "Datos incorrectos",
					message: renderSignUpErrors(response.errors),
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
				
			}
		});
	});
}

function login() {
	$("#btnLogin").click(function() {
		var button = $(this);
		
		button.prop("disabled", true);
		$.post("/login", {
			email: $("#emailLogin").val(),
			password: $("#passwordLogin").val()
		}, function(response) {
			button.prop("disabled", false);
			BootstrapDialog.show({
				title: "Log in response",
				message: "<pre>" + JSON.stringify(response, null, 4) + "</pre>"
			});
		});
	});
}

$(document).ready(function() {
	cancelButton();
	signUp();
	login();
});