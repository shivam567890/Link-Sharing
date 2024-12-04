
<%@ page import="first_grails.Resources" %>
<%@ page import="first_grails.Subscription" %>
<%@  page import="first_grails.Topic" %>
<style>
.hidden{
    display: none;
  }
.SubInfo{
    display: flex;
    justify-content: space-between;
}
.SubInfoRight{
    margin-right: 5px;
}
</style>

<g:if test="${subscription_Topic}">
    <g:set var="num" value="${1}" />
    <g:each in="${subscription_Topic}" var="StopicData">
        <g:if test="${!StopicData.topic.isdeleted}">
            <div class="Border1" style="border: 2px solid black;">
                <div class="DSubcontent">
                    <div class="userCard" style="border: 0cap;">
                        <div class="userImg">
                            <img src="${StopicData.topic.user.photoURL}" alt="person-circle.svg" height="90px" width="90px">
                        </div>
                        <div class="userData">

                            <h2>${StopicData?.topic?.name}</h2>
                            <g:form id="myFormS${num++}" name="myFormS${num++}"  class="hidden" controller="Register"  action="change_topic_name" >
                                <g:hiddenField name="topicId" value="${StopicData.topic.id}"/>
                                <g:if test="${StopicData.topic.user == curr_user }">
                                    <div class="hidden_form">
                                        <input type="text" placeholder="${StopicData.topic.name}" name="${StopicData.topic.name}" style="width: 150px;">
                                        <button type="submit" class="btn mr-1" >Save</button>
                                        <button id="cancelBtn" type="button" class="btn" onclick="showForm('myFormS${num - 1}')">Cancel</button>
                                    </div>
                                </g:if>
                            </g:form>
                            <div class="userS">
                                <div class="DId">
                                    <p>${StopicData?.topic?.user?.username}</p>
                                    <g:link controller="SubandUnsub" action="unsubscribe" params="[topicId: StopicData.topic.id, cuser: curr_user.id]">unsubscribe</g:link>
                                </div>
                                <div class="S">
                                    <p>Subscription</p>
                                    <p>${StopicData?.topic?.subscriptions?.size()}</p>
                                </div>
                                <div class="T">
                                    <p>Post</p>
                                    <p>${Resources.findAllByTopicAndIsdeleted(StopicData.topic,false).size()}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="SubInfo">
                    <div class="SubInfoLeft">

                      <g:if test="${dont_show == null}">
                    <g:select id="seriournessSub_${StopicData.id}" from="['Serious', 'Casual','Very_serious']" name="selectedSeriousness"
                              value="${StopicData.seriousness}"
                              onchange="sendSeriournessToController(this.value, ${StopicData.id})"
                              style="height: 30px; width: 140px;" />
                    <g:if test="${StopicData.topic.user == curr_user}">
                        <g:select id="visiblitySub_${StopicData.topic.id}" from="['Public', 'Private']" name="selectedVisibility"
                                  value="${StopicData.topic.visibility}"
                                  onchange="sendDataToController(this.value, ${StopicData.topic.id})"
                                  style="height: 30px; width: 140px;" />
                    </g:if>
                      </g:if>
                    </div>
                    <div class="SubInfoRight">
                    <div class="modal fade" id="exampleModalLabelForMail${StopicData.topic.id}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabelMail">Modal title</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
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

                                                    <option value="${StopicData.topic.id}" >${StopicData.topic.name} (${StopicData.topic.user.username})</option>

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

                    <button type="button" class="btn" data-toggle="modal" data-target="#exampleModalLabelForMail${StopicData.topic.id}" style="padding: 0px;width: 24px">
                        <img src="${assetPath(src: 'envelope.svg')}" alt="envelope" >
                    </button>
                    <g:if test="${StopicData.topic.user == curr_user }">
                        <div class="modal fade" id="exampleModalDeletetopic${StopicData.topic.id}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        Are you sure you want to delete Title?
                                    </div>
                                    <g:form controller="register" action="toDelete" params="${[id:StopicData.topic.id]}">
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                            <button type="submit" class="btn btn-primary">Yes</button>
                                        </div>
                                    </g:form>
                                </div>
                            </div>
                        </div>
                        <button id="showFormBtn" type="button" class="btn" onclick="showForm('myFormS${num - 1}')" style="padding: 0px"> <img src="${assetPath(src: 'pencil-square.svg')}" alt="edit" >   </button>
                        <button type="button" class="btn" data-toggle="modal" data-target="#exampleModalDeletetopic${StopicData.topic.id}" style="padding: 0px">
                            <img src="${assetPath(src: 'trash-fill.svg')}" alt="trash-fill">    </button>
                    </g:if>
                    </div>
                </div>
            </div>
        </g:if>
    </g:each>
</g:if>
<g:else>
    <p>No subscriptions</p>
</g:else>

%{--<g:if test="${flash.message || flash.error}">--}%
%{--    <div id="alertMessage" class="alert ${flash.error ? 'alert-danger' : 'alert-success'}">--}%
%{--        ${flash.message ?: flash.error}--}%
%{--    </div>--}%
%{--    <script>--}%
%{--        // Automatically hide the alert after 3 seconds--}%
%{--        setTimeout(function() {--}%
%{--            $('#alertMessage').fadeOut('slow');--}%
%{--        }, 3000);--}%
%{--    </script>--}%
%{--</g:if>--}%


<script>

    function showForm(formName) {
        let form = document.forms[formName];
        if (form) {
            form.classList.toggle("hidden");
        } else {
            console.error("Form element with name '" + formName + "' not found.");
        }
    }
</script>