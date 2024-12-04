<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit profile</title>
    <link rel="stylesheet" href="${assetPath(src: 'Login.css')}" type="text/css">
    <link rel="stylesheet" href="${assetPath(src: 'dash.css')}" type="text/css">
    <link rel="stylesheet" href="${assetPath(src: 'edit_profile.css')}" type="text/css">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<asset:javascript src="dashboard.js"/>

<body>
<g:if test="${session.user}">
    <g:render template="/templates/navbar"  model="[subscription_Topic:subscriptions, curr_user: user]"/>

%{--    <div class="navbar" style="justify-content: space-evenly;">--}%
%{--        <div>--}%
%{--            <g:link controller="register"  action="dashboard"> <h3>Link Sharing</h3>  </g:link>--}%
%{--        </div>--}%
%{--        <div class="search-container">--}%
%{--            <span class="search-icon">&#128269;</span>--}%
%{--            <input type="text" class="search-input" placeholder="Search...">--}%
%{--            <span class="close-icon">&#10005;</span>--}%
%{--        </div>--}%
%{--        <div class="clogo">--}%
%{--            <img src="${assetPath(src: 'chat-fill.svg')}" alt="chat-fill" onclick="showCard(1)">--}%
%{--            <img src="${assetPath(src: 'envelope.svg')}" alt="envelope" onclick="showCard(2)">--}%
%{--            <img src="${assetPath(src: 'link.svg')}" alt="link" onclick="showCard(3)">--}%
%{--            <img src="${assetPath(src: 'file-earmark-fill.svg')}" alt="file-earmark-fill" onclick="showCard(4)">--}%
%{--        </div>--}%
%{--        <div class="dprofile">--}%
%{--            <img src="${assetPath(src: 'person-fill.svg')}" alt="person-fill" style="height: 30px; width: 30px; padding-top: 6px;">  --}%
%{--            <div class="dropdown">--}%
%{--                <button class="dropbtn nbtn">Dropdown--}%
%{--                    <img src="/Img/caret-down-fill.svg" alt="">--}%
%{--                </button>--}%
%{--                <div class="dropdown-content">--}%
%{--    <g:link controller="Profile">Profile</g:link>--}%
%{--    <g:link controller="user">User</g:link>--}%
%{--    <g:link controller="topic">Topic</g:link>--}%
%{--    <g:link controller="post">Post</g:link>--}%
%{--    <g:link controller="logout">Logout</g:link>--}%
%{--                </div>--}%
%{--            </div>--}%
%{--        </div>--}%
%{--    </div>--}%
%{--    <g:if test="${flash.message || flash.error}">--}%
%{--        <div id="alertMessage" class="alert ${flash.error ? 'alert-danger' : 'alert-success'}">--}%
%{--            ${flash.message ?: flash.error}--}%
%{--        </div>--}%
%{--        <script>--}%
%{--            // Automatically hide the alert after 3 seconds--}%
%{--            setTimeout(function() {--}%
%{--                $('#alertMessage').fadeOut('slow');--}%
%{--            }, 3000);--}%
%{--        </script>--}%
%{--    </g:if>--}%
<div class="Parent">
    <div class="lft">
        <div class="userCard">
            <div class="userImg">
                    <img src="${user.photoURL}" alt="person-circle.svg"  height="90px" width="90px">
            </div>
            <div class="userData">
                <h2 id="userName">Loading Name..</h2>
                <p id="userEmail"> User Email...</p>
                <div class="userS">
                    <div class="S">
                        <p>Subscription</p>
                        <p>${user?.subscriptions?.size()}</p>
                    </div>
                    <div class="T">
                        <p>Topics</p>
                        <p>${user?.topics?.size()}</p>
                    </div>
                </div>
            </div>
            </div>
            <div class="Dsubscription">
                <div class="hSub">
                    <p>Topics</p>
                    <a href="#" style="padding-top: 13px; padding-right: 12px;"> View All</a>
                </div>
                <g:render template="/templates/userSubscriptions" model="[subscription_Topic:subscriptions,curr_user: user]" />

            </div>
            
    </div>
    <div class="rgt">

        <div class="Profile">
            <div class="Profile1"><h4>Profile</h4></div>
            <g:form id="profile_update"  controller="Profile" action="change_profile" enctype="multipart/form-data">
            <div class="cProfile">
                 <div class="name">
                    <p>First name*</p>
                    <input type="text" id="fname" name="firstName" placeholder="Your name.." style="margin-right: 3%;" value="${session.user.firstName}">
                 </div>
                 <div class="name">
                    <p>Last name*</p>
                    <input type="text" id="lname" name="lastName" placeholder="Your Last name.." style="margin-right: 3%;"value="${session.user.lastName}">
                 </div>
                 <div class="name">
                    <p>User name*</p>
                    <input type="text" id="user_name" name="username" placeholder="Your User name.." style="margin-right: 3%;" value="${session.user.username}">
                 </div>
                 <div class="name">
                    <p>Image</p>
                     <div class="form-group">
                         <label for="imageInput">Profile Picture</label>
                         <g:field type="file" id="imageInput" name="photo" accept="image/png, image/jpeg"/>
                         <img id="previewImage" alt="Preview Image" style="display: none;">
                     </div>
                 </div>
                 <div class="name">
                    <p></p>
                    <button style="margin-right: 30%; " type="submit">Update</button>
                 </div>
            </div>
            </g:form>
        </div>


        <div class="Profile" style="margin-top: 4%;">
            <div class="Profile1"><h4>Change Password</h4></div>
<g:form id="passwordForm" controller="Profile" action="change_pass">
    <div class="cProfile">
        <div class="name">
            <p>Password*</p>
            <input type="password" id="pass" name="password" placeholder="Your Password.." style="margin-right: 3%;">
        </div>
        <div class="name">
            <p>Confirm Password*</p>
            <input type="password" id="cpass" name="Confirm_Password" placeholder="Your Confirm Password.." style="margin-right: 3%;">
            <p id="passwordError" style="color: red; display: none;">Passwords do not match.</p>
        </div>
        <div class="name">
            <p></p>
            <button id="updateButton" style="margin-right: 30%; margin-bottom: 3%;">Update</button>
        </div>
    </div>
</g:form>

        </div>
    </div>
</div>




</g:if>
<g:else>
    <g:render template="/templates/errorHandling"/>

</g:else>

</body>
<asset:javascript src="script.js"/>

<script>
 
 var userId = localStorage.getItem('userId');

 fetch('${createLink(controller: "User", action:"details")}?userId=' + userId)
     .then(response =>response.json())
     .then(user =>{
        document.getElementById('userName').textContent = user.username;
        document.getElementById('userEmail').textContent = user.email;
     })
     .catch(error =>{
        console.error('Data is not extracted, Error', error);
     });



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


</script >
</html>