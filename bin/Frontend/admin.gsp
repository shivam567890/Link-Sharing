<%--
  Created by IntelliJ IDEA.
  User: shivamkhandelwal
  Date: 12/04/24
  Time: 10:36 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>admin page</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="${assetPath(src: 'admin.css')}" type="text/css">
    <link rel="stylesheet" href="${assetPath(src: 'Login.css')}" type="text/css">
    <link rel="stylesheet" href="${assetPath(src: 'dash.css')}" type="text/css">
</head>
<style>
table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

td, th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;
}

tr:nth-child(even) {
    background-color: #dddddd;
}
</style>
<body>
<div class="navbar" style="justify-content: space-evenly;">
    <div>
        <g:link controller="register"  action="dashboard"> <h3>Link Sharing</h3>  </g:link>
    </div>
    <div class="search-container">
        <span class="search-icon">&#128269;</span>
        <input type="text" class="search-input" placeholder="Search...">
        <span class="close-icon">&#10005;</span>
    </div>
    <div class="clogo">
        <%-- <div class="logo-container" onmouseover="changeColor(this)"> <img src="${assetPath(src: 'chat-fill.svg')}" alt="chat-fill" onclick="showCard(1)"></div>
      <div class="logo-container" onmouseover="changeColor(this)">   <img src="${assetPath(src: 'envelope.svg')}" alt="envelope" onclick="showCard(2)">  </div>
       <div class="logo-container" onmouseover="changeColor(this)">  <img src="${assetPath(src: 'link.svg')}" alt="link" onclick="showCard(3)">  </div>
       <div class="logo-container" onmouseover="changeColor(this)">  <img src="${assetPath(src: 'file-earmark-fill.svg')}" alt="file-earmark-fill" onclick="showCard(4)">  </div> --%>
        <button type="button" class="btn "  data-toggle="modal" data-target="#exampleModalTopic" data-whatever="@mdo"><img src="${assetPath(src: 'chat-fill.svg')}" alt="chat-fill" ></button>
        <button type="button" class="btn " data-toggle="modal" data-target="#exampleModal" data-whatever="@fat">  <img src="${assetPath(src: 'envelope.svg')}" alt="envelope" >
        </button>
        <button type="button" class="btn" data-toggle="modal" data-target="#exampleModalLinkR" data-whatever="@getbootstrap"> <img src="${assetPath(src: 'link.svg')}" alt="link">
        </button>
        <button type="button" class="btn" data-toggle="modal" data-target="#exampleModalDocumentR" data-whatever="@getbootstrap"> <img src="${assetPath(src: 'file-earmark-fill.svg')}" alt="file-earmark-fill">
        </button>
        <div class="modal fade" id="exampleModalTopic" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Create Topic</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <g:form controller="Topic" action="create_Topic">
                        <g:hiddenField name="userId" value="${session.userId}"/>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="recipient-name" class="col-form-label"> Topic Name :</label>
                                <input type="text" class="form-control" id="recipient-name" name="name">
                            </div>
                            <div class="form-group">
                                <label for="message-text" class="col-form-label">Visibility:</label>
                                <select name="visibility" id="visibility" class="dropdown dropdownw">
                                    <option value="Public">Public</option>
                                    <option value="Private">Private</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button class="btn btn-primary" type="submit">Send </button>
                        </div>
                    </g:form>
                </div>
            </div>
        </div>

        <div class="modal fade" id="exampleModalDocumentR" tabindex="-1" role="dialog" aria-labelledby="exampleModalDocumentR" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalDocumentR">Share Document</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <g:form controller="LinkResource" action="CreateLink">
                        <g:hiddenField name="userId" value="${session.userId}"/>
                        <div class="share_info"  >
                            <div class="share_link">
                                <label for="link">
                                    <h5>Document*</h5>
                                </label>
                                <div class="browse_file" style="margin-left: 85px" >
                                    <input type="file" id="fileInput" accept="image/*,.pdf,.doc,.docx,.txt" name="documentResource"  size="35">
                                </div>
                            </div>
                            <div class="share_link">
                                <label for="Description">
                                    <h5>Description* :</h5>
                                </label>
                                <textarea rows="3" cols="28" name="description">
                                </textarea>
                            </div>
                            <div class="share_link">
                                <label for="Topic">
                                    <h5>Topic* :</h5>
                                </label>
                                <input type="text" id="topicInput" name="topic">
                            </div>
                            <div class="pop_btn">
                                <button> Share</button>
                                <button id="cancelButton"> Cancel</button>
                            </div>
                        </div>
                    </g:form>
                </div>
            </div>
        </div>
        <div class="modal fade" id="exampleModalLinkR" tabindex="-1" role="dialog" aria-labelledby="exampleModalLinkR" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLinkR">New message</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <g:form controller="LinkResource" action="CreateLink">
                        <g:hiddenField name="userId" value="${session.userId}"/>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="recipient-name" class="col-form-label">url* :</label>
                                <input type="text" class="form-control" id="recipient-name" name="url">
                            </div>
                            <div class="form-group">
                                <label for="message-text" class="col-form-label">Description:</label>
                                <textarea class="form-control" id="message-text" name=description></textarea>
                            </div>
                            <div class="form-group">
                                <label for="message-text" class="col-form-label">Topic:</label>
                                <input type="text" class="form-control" id="recipient-name" name="topic">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button class="btn btn-primary" type="submit">Send message</button>
                        </div>
                    </g:form>
                </div>
            </div>
        </div>
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">New message</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <g:form controller="LinkResource" action="CreateLink">
                        <g:hiddenField name="userId" value="${session.userId}"/>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="recipient-name" class="col-form-label">url* :</label>
                                <input type="text" class="form-control" id="recipient-name" name="url">
                            </div>
                            <div class="form-group">
                                <label for="message-text" class="col-form-label">Description:</label>
                                <textarea class="form-control" id="message-text" name=description></textarea>
                            </div>
                            <div class="form-group">
                                <label for="message-text" class="col-form-label">Topic:</label>
                                <input type="text" class="form-control" id="recipient-name" name="topic">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button class="btn btn-primary" type="submit">Send message</button>
                        </div>
                    </g:form>
                </div>
            </div>
        </div>
    </div>
    <div class="dprofile">
        <img src="${assetPath(src: 'person-fill.svg')}" alt="person-fill" style="height: 30px; width: 30px; padding-top: 6px;">
        <div class="dropdown">
            <button class="dropbtn nbtn">Dropdown
                <img src="/Img/caret-down-fill.svg" alt="">
            </button>
            <div class="dropdown-content">
                <g:link controller="Profile">Profile</g:link>
                <g:link controller="user">User</g:link>
                <g:link controller="topic">Topic</g:link>
                <g:link controller="post">Post</g:link>
                <g:link controller="Logout">Logout</g:link>
            </div>

        </div>
    </div>
</div>
<div class="border" >
    <div class="heading">
        <div class="leftU">
            <h5>Users</h5>
        </div>
        <div class="rightU">
            <div class="usertype">
                <select>
                    <option value="" disabled selected>Serious</option>
                    <option value="option1">Option 1</option>
                    <option value="option2">Option 2</option>
                    <option value="option3">Option 3</option>
                </select>
            </div>
            <div class="search-container sc">
                <span class="search-icon">&#128269;</span>
                <input type="text" class="search-input" placeholder="Search...">
                <span class="close-icon">&#10005;</span>
            </div>
            <div class="btn">
                <button class="chng">Search</button>
            </div>
        </div>
    </div>
    <div class="table1">
        <table>
            <tr>
                <th>Id</th>
                <th>Username</th>
                <th>Email</th>
                <th>firstname</th>
                <th>Lastname</th>
                <th>Active</th>
                <th>Manage</th>
            </tr>
            <g:if test="${users.size()}">
                <g:each in="${users}" var="curr_user">
            <tr>
                <td>${curr_user.id}</td>
                <td>${curr_user.username}</td>
                <td>${curr_user.email}</td>
                <td>${curr_user.firstName}</td>
                <td>${curr_user.lastName}</td>
                <td>
                    <g:if test="${curr_user.active}">
                          Yes
                    </g:if>
                    <g:else>
                        No
                    </g:else>
                </td>
                <td>
                    <g:if test="${curr_user.active}">
                        <g:form controller="Admin" action="deactivate">
                            <g:hiddenField name="userId" value="${curr_user.id}" />
                            <button type="submit" style="border: none; background: none; outline: none; cursor: pointer;color: blue;">Deactivate</button>
                        </g:form>

                    </g:if>
                    <g:else>
                        <g:form controller="Admin" action="activate">
                            <g:hiddenField name="userId" value="${curr_user.id}" />
                            <button type="submit" style="border: none; background: none; outline: none; cursor: pointer;color: blue;">Activate</button>
                        </g:form>
                    </g:else>
                </td>
            </tr>
                </g:each>
            </g:if>

        </table>
    </div>
</div>
</body>
</html>