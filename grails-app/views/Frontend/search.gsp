<%--
  Created by IntelliJ IDEA.
  User: shivamkhandelwal
  Date: 24/04/24
  Time: 5:06 PM
--%>

<%@ page import="first_grails.Resources" %>
<%@ page import="first_grails.Subscription" %>
<%@  page import="first_grails.Topic" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="${assetPath(src: 'Login.css')}" type="text/css">
    <link rel="stylesheet" href="${assetPath(src: 'dash.css')}" type="text/css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<style>
.hidden{
    display: none;
}
</style>
<body>
<asset:javascript src="dashboard.js"/>
<g:if test="${session.user}">
    <g:render template="/templates/navbar"  model="[subscription_Topic:subscription_Topic, curr_user: curr_user]"/>

    <div class="Dash">

        <div class="leftD">
            <div class="userCard" id="userCard">
                <div class="userImg">
                    <img src="${user_img}" alt="user_image" height="90px" width="90px">
                </div>
                <div class="userData">
                    <h2 id="userName">${curr_user?.firstName}</h2>
                    <p id="userEmail">${curr_user?.email}</p>
                    <div class="userS">
                        <div class="S">
                            <p>Subscription</p>
                            <p>${subscriptionCount}</p>
                        </div>
                        <div class="T">
                            <p>Topics</p>
                            <p>${topicCount}</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="Dsubscription">
                <div class="hSub">
                    <p>Trending Topics</p>
                    <a href="#" style="padding-top: 13px; padding-right: 12px;"> View All</a>
                </div>
                <g:render template="/templates/trendingTopics" model="[all_Topics:all_Topics,maxPerPage:maxPerPage,currentPage:currentPage,offset:offset,totalRecords:totalRecords,curr_user:curr_user]" />
            </div>
            <div class="Dsubscription">
                <div class="hSub">
                    <p>Trending Topics</p>
                    <a href="#" style="padding-top: 13px; padding-right: 12px;"> View All</a>
                </div>
                <div id="trending_Topics">
                    <g:render template="/templates/trendingTopics" model="[all_Topics:all_Topics,maxPerPage:maxPerPage,currentPage:currentPage,offset:offset,totalRecords:totalRecords,curr_user:curr_user]" />
                </div>
            </div>
        </div>
        <div class="rightD">
            <div class="topics" style="margin-top: -50px; width: 750px">
                <div class="Recent_share">
                    <h4 style="padding: 4px;">Search Results</h4>
                </div>
                <g:hiddenField name="topPostPage" id="topPostPage" value="${currentPageP}"/>
                <div id="RecentShare">
                    <g:render template="/templates/topPosts" model="[resourceP:resource, currentPageP: currentPageP, totalRecordsP: totalRecordsP, maxPerPageP: maxPerPage]"/>
                </div>
            </div>
        </div>
    </div>


</g:if>
<g:else>
    <g:render template="/templates/errorHandling"/>
</g:else>
</body>
<script>
    var userId = localStorage.getItem('userId');

    function changeColor(element) {
        const logoContainers = document.querySelectorAll('.logo-container');

        logoContainers.forEach(container => {
            container.classList.remove('hovered'); // Remove the 'hovered' class from all logo containers
        });

        element.classList.add('hovered'); // Add 'hovered' class to the parent div of the hovered image
    }

    document.addEventListener('DOMContentLoaded', function () {
        var textarea = document.querySelector('.share_link textarea');
        textarea.addEventListener('click', function () {
            // Set the cursor position to the beginning of the textarea
            textarea.selectionStart = textarea.selectionEnd = 0;
        });
    });

    document.getElementById('userCard').addEventListener('click', function() {
        // Redirect to user profile page
        window.location.href = "${createLink(controller: 'UserProfile', action: 'show', id: userCard)}";
    });


    function showForm(formName) {
        var form = document.forms[formName];
        if (form) {
            form.classList.toggle("hidden");
        } else {
            console.error("Form element with name '" + formName + "' not found.");
        }
    }

    function sendDataToController(selectedVisibility, topicId) {
        $.ajax({
            url: "${createLink(controller: 'Register', action: 'change_topic_mode')}",
            type: "POST",
            data: { selectedVisibility: selectedVisibility, topicId: topicId },
            success: function(response) {
                // Handle success response
                console.log(response);
            },
            error: function(xhr, status, error) {
                // Handle error
                console.error(error);
            }
        });
    }selectedSeriousness

    function sendSeriournessToController(selectedSeriousness, StopicId) {
        $.ajax({
            url: "${createLink(controller: 'Register', action: 'change_seriousness')}",
            type: "POST",
            data: { selectedSeriousness: selectedSeriousness, StopicId: StopicId },
            success: function(response) {
                // Handle success response
                console.log(response);
            },
            error: function(xhr, status, error) {
                // Handle error
                console.error(error);
            }
        });
    }
    function loadNextPageP() {
        let currentPage  = document.getElementById("topPostPage");
        let currentValue = parseInt(currentPage.value);
        let newValue = currentValue + 1;
        currentPage.value = newValue;
        console.log("current page is ", newValue);
        let url = '${createLink(controller: "Register", action: "nextPageP")}?page=' + newValue;
        $.ajax({
            url: url,
            type: 'GET',
            dataType: 'html',
            success: function(response) {
                $('#RecentShare').html(response);
            },
            error: function(xhr, status, error) {
                console.error('Error loading next page:', status, error);
            }
        });
    }
</script>
</html>