
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
            <div class="userCard">
                <div class="userImg">
                    <img src="${curr_user.photoURL}" alt="person-circle.svg"  height="90px" width="90px">
                </div>
                <div class="userData">
                    <h2 id="userName">Loading Name...</h2>
                    <p id="userEmail">Loading Email Id...</p>
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
                    <p>Subscription</p>
                    <a href="#" style="padding-top: 13px; padding-right: 12px;"> View All</a>
                </div>
                <g:render template="/templates/userSubscriptions" model="[subscription_Topic:subscription_Topic,curr_user: curr_user]" />



            </div>


            <div class="Dsubscription">
                <div class="hSub">
                    <p>Trending Topics</p>
                    <a href="#" style="padding-top: 13px; padding-right: 12px;"> View All</a>
                </div>
                <g:render template="/templates/trendingTopics" model="[all_Topics:all_Topics, currentPage: currentPage, totalRecords: totalRecords,maxPerPage: maxPerPage]" />
            </div>
        </div>
        <div class="rightD">
            <div class="topics" style="margin-top: -50px;">
                <div class="Recent_share">
                    <h4 style="padding: 4px;">Recent Share</h4>
                </div>
            <g:if test="${resource != null && !resource.empty}">
            <g:each in="${resource}"  var ="res">
                <div class="card1 ">
                    <div class="image">
                        <img src="https://louisville.edu/enrollmentmanagement/images/person-icon/image" alt="p1">
                    </div>
                    <div class="content">
                        <div class="poster_info">
                            <span class="name_id">${res?.user?.username} |  ${res?.user?.email}</span>
                            <span class="topic"> ${res?.topic?.name}</span>
                        </div>
                        <div class="post_content">Description : ${res.description}
                        </div>
                        <div class="poster_info setting_margin">
                            <div class="clogo">
                                <a href="https://www.facebook.com/" target="_blank"><img src="${assetPath(src: 'facebook.svg')}" alt="facebook">
                                </a>
                                <a href="https://www.instagram.com/" target="_blank"><img src="${assetPath(src: 'instagram.svg')}" alt="instagram"></a>
                                 <a href="https://www.twitter.com/" target="_blank"><img src="${assetPath(src: 'twitter.svg')}" alt="twitter"></a>

                            </div>
                            <span class="topic">
                                <a href="#">Download</a>
                                <a href = "${createLink(absolute:true, uri:"${res.url}")}" target="_blank">View Full Site</a>
                                <g:link controller ="Register" action="is_read" params="[resId:res.id]"> Mark as read </g:link>
                                <g:link controller="Post" action="show" params="[resId: res.id]">View post</g:link>
                            </span>
                        </div>
                    </div>

                </div>
%{--                </g:if>--}%
            </g:each>
            </g:if>
            <g:else>
            <p>No resource created</p>
             </g:else>

            </div>
           



        </div>
    </div>
</g:if>
</body>

<script>
    // Check if userId is stored in localStorage
    var userId = localStorage.getItem('userId');
    console.log("helloWorld, userId is: " , userId);
    // AJAX request to fetch user details
    fetch('${createLink(controller: "User", action: "details")}?userId=' + userId)
        .then(response => response.json())
        .then(user => {
            // Update UI with user details
            console.log(user.username);
            console.log("user email id : ", user.email);
            document.getElementById('userName').textContent = user.username;
            document.getElementById('userEmail').textContent = user.email;
        })
        .catch(error => {
            console.error('Data is not extracted, Error:', error);
        });

  // change the div colour
// JavaScript function to change the background color of the parent div when the mouse hovers over the child image
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

</script>
</html>