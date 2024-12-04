<div class="navbar" style="justify-content: space-evenly;">
    <div>
        <g:link controller="register"  action="dashboard"> <h3>Link Sharing</h3>  </g:link>
    </div>
    <div class="search-container">
        <g:form controller="Search" action="index">
            <span class="search-icon">&#128269;</span>
            <input type="text" class="search-input" name="searchTerm" placeholder="Search...">
            <span class="close-icon">&#10005;</span>
        </g:form>

    </div>
    <div class="clogo">
        <%-- <div class="logo-container" onmouseover="changeColor(this)"> <img src="${assetPath(src: 'chat-fill.svg')}" alt="chat-fill" onclick="showCard(1)"></div>
      <div class="logo-container" onmouseover="changeColor(this)">   <img src="${assetPath(src: 'envelope.svg')}" alt="envelope" onclick="showCard(2)">  </div>
       <div class="logo-container" onmouseover="changeColor(this)">  <img src="${assetPath(src: 'link.svg')}" alt="link" onclick="showCard(3)">  </div>
       <div class="logo-container" onmouseover="changeColor(this)">  <img src="${assetPath(src: 'file-earmark-fill.svg')}" alt="file-earmark-fill" onclick="showCard(4)">  </div> --%>
        <button type="button" class="btn btn-outline-light  "  data-toggle="modal" data-target="#exampleModalTopic" data-whatever="@mdo"><img src="${assetPath(src: 'chat-fill.svg')}" alt="chat-fill"  style="width: 35px ; height: 35px"></button>
        <button type="button" class="btn btn-outline-light " data-toggle="modal" data-target="#exampleModal" data-whatever="@fat">  <img src="${assetPath(src: 'envelope.svg')}" alt="envelope" style="width: 35px ; height: 35px" >
        </button>
        <button type="button" class="btn btn-outline-light" data-toggle="modal" data-target="#exampleModalLinkR" data-whatever="@getbootstrap"> <img src="${assetPath(src: 'link.svg')}" alt="link" style="width: 40px ; height: 40px">
        </button>
        <button type="button" class="btn btn-outline-light" data-toggle="modal" data-target="#exampleModalDocumentR" data-whatever="@getbootstrap"> <img src="${assetPath(src: 'file-earmark-fill.svg')}" alt="file-earmark-fill" style="width: 35px ; height: 35px">
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
                    <g:form controller="Topic" action="create_Topic" id="topicForm">
                        <g:hiddenField name="userId" value="${session.userId}"/>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="recipient-name" class="col-form-label"> Topic Name :</label>
                                <input type="text" class="form-control" id="recipient-nameTopic" name="name" maxlength="256">
                                <div id="name-error" class="error" style="color: red;"></div> <!-- Error message container -->
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
                            <button class="btn btn-primary" type="submit" id="submitButton">Send</button>
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
                    <g:form controller="DocumentResource" action="documentRes" enctype="multipart/form-data">
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
                                <textarea rows="3" cols="27" name="description" style="margin-left: 0px">
                                </textarea>
                            </div>
                            <div class="share_link topic_select">
                                <label for="Topic">
                                    <h5>Topic* :</h5>
                                </label>
                                <select name="topic" id="topics1">
                                    <g:if test="${subscription_Topic.size()}">
                                        <g:each in="${subscription_Topic}" var="sTopic">
                                            <option value="${sTopic.topic.name}">${sTopic.topic.name} (${sTopic.user.username})</option>
                                        </g:each>
                                    </g:if>
                                </select>
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
                        <h5 class="modal-title" id="exampleModalLinkR">Link Resource</h5>
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
                                <select name="topic" id="topics1">
                                    <g:if test="${subscription_Topic.size()}">
                                        <g:each in="${subscription_Topic}" var="sTopic">
                                            <option value="${sTopic.topic.name}">${sTopic.topic.name} (${sTopic.user.username})</option>
                                        </g:each>
                                    </g:if>
                                </select>
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
                        <h5 class="modal-title" id="exampleModalLabel">Share Through Mail</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <g:form controller="Mail" action="SendMail">
%{--                        <g:hiddenField name="sender_emailId" value="${curr_user.email}"/>--}%
%{--                        <g:hiddenField name="from" value="linksharing068@gmail.com"/>--}%
%{--                        <g:hiddenField name="subject" value="linksharing068@gmail.com"/>--}%
%{--                        <g:hiddenField name="body" value="linksharing068@gmail.com"/>--}%

                        <div class="modal-body">
                            <div class="form-group">
                                <label for="recipient-name" class="col-form-label">Email* :</label>
                                <input type="email" class="form-control" id="recipient-name" name="to">
                            </div>
                            <div class="form-group">
                                <label for="message-text" class="col-form-label">Topic:</label>
                                %{--                        <input type="text" class="form-control" id="recipient-name" name="topic">--}%
                                <select name="topic" id="topics">

                                    <g:if test="${subscription_Topic.size()}">
                                        <g:each in="${subscription_Topic}" var="sTopic">
                                            <option value="${sTopic.topic.id}">${sTopic.topic.name} (${sTopic.topic.user.username})</option>
                                        </g:each>
                                    </g:if>

                                </select>
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
        <img src="${assetPath(src: 'person-fill.svg')}" alt="person-fill" style="height: 30px; width: 30px;">
        <div class="dropdown">
            <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="background-color: #007bff; color: white;">
                ${curr_user?.firstName}
            </button>
            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <g:link controller="Profile"  class="dropdown-item">Profile</g:link>
                <g:if test="${session.user.admin}"  class="dropdown-item"> <g:link controller="admin" class="dropdown-item">Users</g:link>  </g:if>
                <g:link controller="Logout"  class="dropdown-item">Logout</g:link>
            </div>
        </div>


    </div>
    </div>
</div>
<g:if test="${flash.message}">
    <div id="alertMessage" class="alert alert-success">
        ${flash.message}
    </div>
    <script>
        // Automatically hide the alert after 3 seconds
        setTimeout(function() {
            $('#alertMessage').fadeOut('slow');
        }, 2000);
    </script>
</g:if>



<script>


    $(document).ready(function() {
        $('#recipient-nameTopic').on('input', function() {
            var inputLength = $(this).val().length;
            if (inputLength > 256) {
                $('#name-error').text('Character length must be less than 256.');
                $('#submitButton').prop('disabled', true); // Disable the submit button
            } else {
                $('#name-error').text('');
                $('#submitButton').prop('disabled', false); // Enable the submit button
            }
        });
    });
</script>