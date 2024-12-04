
<%@ page import="first_grails.Resources" %>
<%@ page import="first_grails.Subscription" %>
<%@  page import="first_grails.Topic" %>
<style>
.hidden{
    display: none;
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
                                    <input type="text" placeholder="Enter New Topic Name" name="new_topic_name">
                                    <button type="submit" class="btn">Save</button>
                                    <button id="cancelBtn" type="button" class="btn" onclick="showForm('myFormS${num - 1}')">Cancel</button>
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
                    <g:if test="${StopicData.topic.user == curr_user }">
                        <img src="${assetPath(src: 'envelope.svg')}" alt="envelope" style="margin-left: 40px;">
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
        </g:if>
    </g:each>
</g:if>
<g:else>
    <p>No subscriptions</p>
</g:else>




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