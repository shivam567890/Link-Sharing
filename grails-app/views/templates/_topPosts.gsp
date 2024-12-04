<g:if test="${resourceP != null && !resourceP.empty}">
    <g:each in="${resourceP}"  var ="res">
        <g:if test="${!res.isdeleted}">
            <div class="card1 ">
                <div class="image">
%{--                    <img src="https://louisville.edu/enrollmentmanagement/images/person-icon/image" alt="p1">--}%
                    <img src="${res.topic.user.photoURL}" alt="person-circle.svg"  height="90px" width="90px"  >

                </div>
                <div class="content">
                    <div class="poster_info">
                        <%
                            def currentTime = new Date()
                        %>

                        <span class="name_id">${res?.user?.username} |  ${res?.user?.email} | ${(new Date().time - res.lastUpdated.time) / 60000} minutes</span>
                        <span class="topic"> ${res?.topic?.name}</span>
                    </div>
                    <div class="post_content">Description : ${res.description}
                    </div>
                    <g:if test="${ratingMap}">
                        <div class="post_content" style="margin-top: 2px"> Average Rating : ${ratingMap[res]}</div>
                    </g:if>
                    <div class="poster_info setting_margin">
                        <div class="clogo">
                            <a href="https://www.facebook.com/" target="_blank"><img src="${assetPath(src: 'facebook.svg')}" alt="facebook">
                            </a>
                            <a href="https://www.instagram.com/" target="_blank"><img src="${assetPath(src: 'instagram.svg')}" alt="instagram"></a>
                            <a href="https://www.twitter.com/" target="_blank"><img src="${assetPath(src: 'twitter.svg')}" alt="twitter"></a>
                        </div>
                        <span class="topic">
                            <g:if test="${session.user != null}">


                            <g:if test="${res.url == null}">
                                <g:link  controller="DocumentResource" action="downloadFile" params="[fileId: res.id]" target="_blank">Download File</g:link>
                            </g:if>
                            <g:else>
                                <a href = "${createLink(absolute:true, uri:"${res.url}")}" target="_blank">View Full Site</a>
                            </g:else>
                            <g:link controller ="Register" action="is_read" params="[resId:res.id]"> Mark as read </g:link>
                            <g:link controller="Post" action="show" params="[resId: res.id]">View post</g:link>
                            </g:if>
                            <g:else>
                                <g:link controller="Post" action="show" params="[resId: res.id]">View post</g:link>
                            </g:else>
                        </span>
                    </div>
                </div>

            </div>
        </g:if>
    </g:each>
</g:if>
<g:else>
    <p>No Resource present, please create some resource.</p>
</g:else>
<div class="pagination">
    <g:if test="${totalRecordsP > maxPerPageP * currentPageP}">
        <a href="javascript:void(0);" onclick="loadNextPageP()">Next</a>
    </g:if>

</div>


%{--<script>--}%

%{--    <g:if test="${resourceP != null && !resourceP.empty}">--}%
%{--    $(document).ready(function() {--}%
%{--        // If resource has data, apply CSS to another div--}%
%{--        $('#RecentShare').addClass('recent_shares');--}%
%{--    });--}%
%{--    </g:if>--}%

%{--    <g:else>--}%
%{--    $(document).ready(function() {--}%
%{--        // If resource is empty or null, apply different CSS to another div--}%
%{--        $('#anotherDiv').addClass('recent_shares');--}%
%{--    });--}%
%{--    </g:else>--}%
%{--</script>--}%

%{--<script>--}%
%{--    function loadNextPageP() {--}%
%{--        let currentPage = parseInt('${currentPageP}');--}%
%{--        console.log(${currentPageP});--}%
%{--        console.log("current page is ", currentPage);--}%
%{--        let nextPage = currentPage + 1;--}%
%{--        let url = '${createLink(controller: "Login", action: "topPosts")}?page=' + nextPage;--}%
%{--        $.ajax({--}%
%{--            url: url,--}%
%{--            type: 'GET',--}%
%{--            dataType: 'html',--}%
%{--            success: function(response) {--}%
%{--                console.log(${currentPageP});--}%
%{--                $('#top_Posts').html(response);--}%
%{--            },--}%
%{--            error: function(xhr, status, error) {--}%
%{--                console.error('Error loading next page:', status, error);--}%
%{--            }--}%
%{--        });--}%
%{--    }--}%
%{--</script>--}%