(function(window){
  // define PT
  var PT = function() {
    this.pubkey = {};

    this.encrypt = function(password, exp, mod) {
      setMaxDigits(130);
      var key = new RSAKeyPair(exp, "", mod);
      var result = encryptedString(key, encodeURIComponent(password));
      return result;
    };
  }

  // init PT object with access handle pt
  if (!window.pt) {
    window.pt = new PT();
  }

  // start exec
  $.ajax({
    url: "/api/ptrest/loginpubkey",
    type: "GET",
    contentType: "application/json",
    dataType: "json",
    success: function(data) {
      if(data.status === "success") {
        pt.pubkey.mod = data.content.module;
        pt.pubkey.exp = data.content.exponent;

        console.log("Modulus: " + pt.pubkey.mod);
        console.log("Exponent: " + pt.pubkey.exp);
        console.log("Encrypt word \"abc\": " +
          pt.encrypt("abc", pt.pubkey.exp, pt.pubkey.mod));
      }
    },
    error: console.log("Error: loginpukey GET request.")
  });

  $('#loginButton').on('click', function(){
    var encpw = pt.encrypt(
      $('#password').val(),
      pt.pubkey.exp,
      pt.pubkey.mod
    );
    console.log("User Password enctrypted: " + encpw);

    // set the form values
    $('#password').val(encpw);
    $('#publicKey').val(pt.pubkey.mod);

    // submit the login form
    $('#loginForm').submit();
  });
})(window);
