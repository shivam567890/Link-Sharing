<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="${assetPath(src: 'Login.css')}" type="text/css">

    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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

<g:if test="${flash.message || flash.error}">
    <div id="alertMessage" class="alert ${flash.error ? 'alert-danger' : 'alert-success'}">
        ${flash.message ?: flash.error}
    </div>
    <script>
        // Automatically hide the alert after 3 seconds
        setTimeout(function() {
            $('#alertMessage').fadeOut('slow');
        }, 3000);
    </script>
</g:if>
    <div class="box">
        <div class="row">
            <div class="col-md-7 left">

                <div class="topics">
                    <div class="Recent_share">
                        <h4 style="padding: 4px;">Recent Share</h4>
                    </div>
                    <div id="recent_share">
                        <g:render template="/templates/recentShares" ></g:render>
                    </div>

                </div>
                <div class="topics">
                    <div class="top_topics">
                        <div style="display: flex; align-items: center;">
                            <h4 style="padding: 4px;">Top shares</h4>
                        </div>

                    </div>
                    <g:hiddenField name="topPostPage" id="topPostPage" value="${currentPageP}"/>
                    <div id="top_Posts">
                    <g:render template="/templates/topPosts" model="[resourceP: paginatedTopics, currentPageP: currentPageP, totalRecordsP: totalRecords, maxPerPageP: maxPerPage,ratingMap:ratingMap]" />
                    </div>
                </div>
            </div>
            <div class="col-md-5 login-form-2">
                <div class="login-logo">
                    <!-- <img src="https://image.ibb.co/n7oTvU/logo_white.png" alt=""/> -->
                </div>
                <h2 class="Login_form">Login Form</h2>
                <g:form name="loginForm" controller="login" action="loginUser">
                <div class="form-group"  >
                    <input type="text" name="email" class="form-control" placeholder="Your Email *" value="" />
                </div>
                <div class="form-group">
                    <input type="password" name="password" class="form-control" placeholder="Your Password *" value="" />
                </div>password
                <div class="form-group">
                    <input type="submit" class="btnSubmit" value="Login" />
                </div>
                <div class="form-group">
                    <g:link controller="login" action="forgetPass">Forget Password?</g:link>
                    <h6>Don't have account?</h6>
                    <g:link controller="Register" action="registerPage">  Register Now!!</g:link>
                </div>
                </g:form>
            </div>
        </div>
    </div>
</body>
<script>
    function loadNextPageP() {
        %{--let currentPage = parseInt('${currentPageP}');--}%
        let currentPage  = document.getElementById("topPostPage");
        let currentValue = parseInt(currentPage.value);
        let newValue = currentValue + 1;
        currentPage.value = newValue;
        console.log(${newValue});
        console.log("current page is ", newValue);
        let url = '${createLink(controller: "Login", action: "topPosts")}?page=' + newValue;
        $.ajax({
            url: url,
            type: 'GET',
            dataType: 'html',
            success: function(response) {
                $('#top_Posts').html(response);
            },
            error: function(xhr, status, error) {
                console.error('Error loading next page:', status, error);
            }
        });
    }
</script>
</html>