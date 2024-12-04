<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Page</title>
    <link rel="stylesheet" href="${assetPath(src: 'Login.css')}" type="text/css">
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<asset:javascript src="script.js"/>

</head>
<body>
<div class="navbar">
    <div>
        <a href="#" class="nav-link"><h4>Link Sharing</h4></a>
    </div>
    <div class="search-container">
        <span class="search-icon">&#128269;</span>
        <input type="text" class="search-input" placeholder="Search...">
        <span class="close-icon">&#10005;</span>
    </div>
</div>
  <div class="full_screen" style="width: 90%; align-items: center;justify-content: center; margin: 0 auto">
    <div class="row">
        <div class="col-md-6">
            <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-registration/draw1.webp"
                 class="img-fluid" alt="Sample image" style="height: 70%;width: 90%;align-items: center;justify-content: center;margin-top: 30%">
        </div>
        <div class="col-md-6 login-form-2">

            <h2 style="padding-bottom: 10px;">Registration Form</h2>
            <g:form name="register" controller="register" action="create_user" enctype="multipart/form-data">

                <div class="form-group">
                    <label for="firstName">First name *</label>
                    <g:textField class="form-control" name="firstName" id="firstName" placeholder="First name *" value="${params.firstName}" />
                </div>
                <div class="form-group">
                    <label for="lastName">Last name *</label>
                    <g:textField class="form-control" name="lastName" id="lastName" placeholder="Last name *" value="${params.lastName}" />
                </div>
                <div class="form-group">
                    <label for="email">Your Email *</label>
                    <g:textField class="form-control" name="email" id="email" placeholder="Your Email *" value="${params.email}" />
                </div>
                <div class="form-group">
                    <label for="username">Username *</label>
                    <g:textField class="form-control" name="username" id="username" placeholder="Username *" value="${params.username}" />
                </div>
                <div class="form-group">
                    <label for="password">Password *</label>
                    <g:passwordField class="form-control" name="password" id="pass" placeholder="Password *" />
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirm password *</label>
                    <g:passwordField class="form-control" name="confirmPassword" id="cpass" placeholder="Confirm password *" />
                    <p id="passwordError" style="color: red; display: none;">Passwords do not match.</p>
                </div>
                <div class="form-group">
                    <label for="imageInput">Profile Picture</label>
                    <input type="file" id="imageInput" name="photo" accept="image/png, image/jpeg">
                    <img id="previewImage" alt="Preview Image" style="display: none;">
                </div>
                <div class="form-group">
                    <input type="submit" class="btnSubmit" value="Register" />
                </div>
            </g:form>
        </div>
    </div>

  </div>

</body>
%{--<body>--}%
%{--    <div class="navbar">--}%
%{--        <div>--}%
%{--          <a href="#" class="nav-link"><h4>Link Sharing</h4></a>--}%
%{--        </div>--}%
%{--        <div class="search-container">--}%
%{--          <span class="search-icon">&#128269;</span>--}%
%{--          <input type="text" class="search-input" placeholder="Search...">--}%
%{--          <span class="close-icon">&#10005;</span>--}%
%{--        </div>--}%
%{--      </div>--}%
%{--    <div class="box">--}%
%{--        <div class="row" >--}%
%{--            <div class="col-md-10 col-lg-6 col-xl-7 d-flex align-items-center order-1 order-lg-2">--}%

%{--                <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-registration/draw1.webp"--}%
%{--                     class="img-fluid" alt="Sample image">--}%

%{--            </div>--}%
%{--            <div class="col-md-5 login-form-2">--}%
%{--                <div class="login-logo">--}%
%{--                    <img src="https://image.ibb.co/n7oTvU/logo_white.png" alt=""/>--}%
%{--                   <%-- <img src="${assetPath(src: 'https://image.ibb.co/n7oTvU/logo_white.png')}" alt="instagram"> --%>--}%

%{--                </div>--}%
%{--                <h2 style="padding-bottom: 10px;">Registration Form</h2>--}%
%{--<g:form name="register" controller="register" action="create_user" enctype="multipart/form-data">--}%
%{--    <div class="form-group">--}%
%{--        <label for="firstName">First name *</label>--}%
%{--        <g:textField class="form-control" name="firstName" id="firstName" placeholder="First name *" value="${params.firstName}" />--}%
%{--    </div>--}%
%{--    <div class="form-group">--}%
%{--        <label for="lastName">Last name *</label>--}%
%{--        <g:textField class="form-control" name="lastName" id="lastName" placeholder="Last name *" value="${params.lastName}" />--}%
%{--    </div>--}%
%{--    <div class="form-group">--}%
%{--        <label for="email">Your Email *</label>--}%
%{--        <g:textField class="form-control" name="email" id="email" placeholder="Your Email *" value="${params.email}" />--}%
%{--    </div>--}%
%{--    <div class="form-group">--}%
%{--        <label for="username">Username *</label>--}%
%{--        <g:textField class="form-control" name="username" id="username" placeholder="Username *" value="${params.username}" />--}%
%{--    </div>--}%
%{--    <div class="form-group">--}%
%{--        <label for="password">Password *</label>--}%
%{--        <g:passwordField class="form-control" name="password" id="pass" placeholder="Password *" />--}%
%{--    </div>--}%
%{--    <div class="form-group">--}%
%{--        <label for="confirmPassword">Confirm password *</label>--}%
%{--        <g:passwordField class="form-control" name="confirmPassword" id="cpass" placeholder="Confirm password *" />--}%
%{--        <p id="passwordError" style="color: red; display: none;">Passwords do not match.</p>--}%
%{--    </div>--}%
%{--    <div class="form-group">--}%
%{--        <label for="imageInput">Profile Picture</label>--}%
%{--        <input type="file" id="imageInput" name="photo" accept="image/png, image/jpeg">--}%
%{--        <img id="previewImage" alt="Preview Image" style="display: none;">--}%
%{--    </div>--}%
%{--    <div class="form-group">--}%
%{--        <input type="submit" class="btnSubmit" value="Register" />--}%
%{--    </div>--}%
%{--</g:form>--}%

%{--            </div>--}%
%{--        </div>--}%
%{--    </div>--}%
%{--    --}%
%{--</body>--}%

<script>

    const passInput = document.getElementById('pass');
    const cpassInput = document.getElementById('cpass');
    const updateButton = document.getElementById('updateButton');
    const passwordForm = document.getElementById('passwordForm');
    const passwordError = document.getElementById('passwordError');

    // Function to check if passwords match
    function checkPasswordMatch() {
        if (passInput.value !== cpassInput.value) {
            passwordError.style.display = 'block';
            updateButton.disabled = true;
        } else {
            passwordError.style.display = 'none';
            updateButton.disabled = false;
        }
    }

    // Add event listener to confirm password input
    cpassInput.addEventListener('input', checkPasswordMatch);

    // Add event listener to Update button
    updateButton.addEventListener('click', function() {
        if (passInput.value === cpassInput.value) {
            // Submit the form if passwords match
            passwordForm.submit();
        }
    });
</script>

</html>