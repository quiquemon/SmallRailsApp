// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//=require jquery-3.1.1.min.js
//=require bootstrap.min.js
//=require bootstrap-dialog.min.js
//=require bootstrap-datepicker.min.js
//=require_tree .

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
			button.prop("disabled", false);
			BootstrapDialog.show({
				title: "Sign Up response",
				message: "<pre>" + JSON.stringify(response, null, 4) + "</pre>"
			});
		});
	});
}

function login() {
	$("#btnLogin").click(function() {
		
	});
}

$(document).ready(function() {
	// Opciones del DatePicker
	$(".datetimepicker").datepicker({
		format: "yyyy-mm-dd",
		todayHighlight: true,
		autoclose: true,
		startDate: "1900-01-01",
		endDate: new Date()
	});
	
	cancelButton();
	signUp();
	login();
});