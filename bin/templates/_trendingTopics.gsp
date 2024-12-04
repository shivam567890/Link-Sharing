<%@ page import="first_grails.Subscription" %>
<%@ page import="first_grails.Resources" %>
<style>
.hidden{
    display: none;
}
.hidden_form{
    display: flex;
}
</style>
<g:if test="${all_Topics!= null}">
    <g:set var="num" value="${1}" />
    <g:each in="${all_Topics}"  var="topicData">
        <g:if test="${topicData.isdeleted==null || !topicData.isdeleted}">
            <div class="Border1" style="border: 2px solid black;">
                <div class="DSubcontent">

                    <div class="userCard" style="border: 0cap;">
                        <div class="userImg">
                            <img src="${topicData.user.photoURL}" alt="person-circle.svg"  height="90px" width="90px">
                        </div>

                        <div class="userData">
                            <g:link controller= "Topic_show" action="topic" params="[topicId: topicData.id]">
                                <h2>${topicData?.name} </h2>
                            </g:link>
                            <g:form id="myForm${num++}" name="myForm${num++}"  class="hidden" controller="Register"  action="change_topic_name" >
                                <g:hiddenField name="topicId" value="${topicData.id}"/>
                                <g:if test="${(topicData.user.id == curr_user.id ) || (curr_user.admin == true)}">
                                    <div class="hidden_form">
                                   <input type="text" placeholder="${topicData.name}" name="${topicData.name}" style="width: 150px;">
                                        <button type="submit" class="btn">Save</button>
                                    <button id="cancelBtn" type="button" class="btn" onclick="showForm('myForm${num - 1}')">Cancel</button>
                                    </div>
                                </g:if>
                            </g:form>
                            <div class="userS">
                                <div class="DId">
                                    <p>  ${topicData?.user.username} </p>

                                    <g:if test="${Subscription?.findByTopicAndUser(topicData,curr_user)!=null}">
                                        <g:link controller="SubandUnsub" action="unsubscribe" params="[topicId: topicData.id, cuser: curr_user.id]">unsubscribe</g:link>
                                    </g:if>
                                    <g:else>
                                        <g:link controller="SubandUnsub" action="subscribe" params="[topicId: topicData.id, cuser: curr_user.id]">subscribe</g:link>
                                    </g:else>

                                </div>
                                <div class="S">
                                    <p>Subscription</p>
                                    <p>${topicData?.subscriptions?.size()}</p>
                                </div>
                                <div class="T">
                                    <p>Post</p>
                                    <g:if test="${topicData != null}">
                                        <p>${Resources.findAllByTopicAndIsdeleted(topicData,false).size()}</p>
                                    </g:if>
                                    <g:else>
                                        <p> 0 </p>
                                    </g:else>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="SubInfo">
                    <g:set var="Subscriber" value="${Subscription.findByUserAndTopic(curr_user,topicData)}" />

                    <g:if test="${Subscriber != null}">
                        <g:select id="seriournessSub_${topicData.id}" from="['Serious', 'Casual','Very_serious']" name="selectedSeriousness"
                                  value="${Subscriber.seriousness}"
                                  onchange="sendSeriournessToController(this.value, ${Subscriber.id})"
                                  style="height: 30px; width: 140px;" />
                    </g:if>
                    <g:if test="${(topicData.user.id == curr_user.id) || (curr_user.admin == true)}">
                        <g:select id="visiblitySub_${topicData.id}" from="['Public', 'Private']" name="selectedVisibility"
                                  value="${topicData.visibility}"
                                  onchange="sendDataToController(this.value, ${topicData.id})"
                                  style="height: 30px; width: 140px;" />
                    </g:if>
                    <g:if test="${(topicData.user.id == curr_user.id)|| (curr_user.admin == true)  }">
                        <img src="${assetPath(src: 'envelope.svg')}" alt="envelope" style="margin-left: 40px;">
                        <div class="modal fade" id="exampleModalDelete${topicData.id}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                                    <g:form controller="register" action="toDelete" params="${[id:topicData.id]}">
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                            <button type="submit" class="btn btn-primary">Yes</button>
                                        </div>
                                    </g:form>
                                </div>
                            </div>
                        </div>
                        <button id="showFormBtn" type="button" class="btn" onclick="showForm('myForm${num - 1}')" style="padding: 0px"> <img src="${assetPath(src: 'pencil-square.svg')}" alt="edit" >   </button>
                        <button type="button" class="btn" data-toggle="modal" data-target="#exampleModalDelete${topicData.id}" style="padding: 0px">
                            <img src="${assetPath(src: 'trash-fill.svg')}" alt="trash-fill">    </button>
                    </g:if>

                </div>
            </div>
        </g:if>
    </g:each>
</g:if>
<g:else>
    <p>No Trending Topic</p>
</g:else>

<div class="pagination">


    <g:if test="${totalRecords > maxPerPage * currentPage}">
        <a href="javascript:void(0);" onclick="loadNextPage()">Next</a>
    </g:if>

</div>

<script>

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
    }

    function sendSeriousnessToController(selectedSeriousness, StopicId) {
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


    function loadNextPage() {
        let currentPage = parseInt('${currentPage}');
        console.log(${currentPage});
        console.log("current page is ", currentPage);
        let nextPage = currentPage + 1;
        let totalRecords = parseInt('${totalRecords}');
        let url = '${createLink(controller: "Register", action: "nextPage")}?page=' + nextPage + '&totalRecords=' + totalRecords;
        $.ajax({
            url: url,
            type: 'GET',
            dataType: 'html',
            success: function(response) {
                ${currentPage+=1};
                console.log(${currentPage});
                $('#trending_Topics').html(response);
            },
            error: function(xhr, status, error) {
                console.error('Error loading next page:', status, error);
            }
        });
    }
</script>