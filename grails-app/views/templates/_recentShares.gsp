                    <g:if test="${resource != null && !resource.empty}">
                        <g:each in="${resource}"  var ="res">
                            <g:if test="${!res.isdeleted}">
                            <div class="card1 ">
                                <div class="image">
                                    <img src="${res.topic.user.photoURL}" alt="p1">
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
                                    <div class="poster_info setting_margin">
                                        <div class="clogo">
                                            <img src="${assetPath(src: 'facebook.svg')}" alt="twitter">
                                            <img src="${assetPath(src: 'twitter.svg')}" alt="twitter">
                                            <img src="${assetPath(src: 'instagram.svg')}" alt="instagram">
                                        </div>
                                        <span class="topic">
                                            <g:link controller="Post" action="show" params="[resId: res.id]">View post</g:link>
                                        </span>
                                    </div>
                                </div>

                            </div>
                            </g:if>
                        </g:each>
                    </g:if>

                    <g:else>
    <p>No resource created</p>
</g:else>

<div class="pagination">


    <g:if test="${totalRecords > maxPerPage * currentPage}">
        <a href="javascript:void(0);" onclick="loadNextPage()">Next</a>
    </g:if>

</div>


                    <script>
                        function loadNextPage() {
                            let currentPage = parseInt('${currentPage}');
                            console.log(${currentPage});
                            console.log("current page is ", currentPage);
                            let nextPage = currentPage + 1;
                            let url = '${createLink(controller: "login", action: "nextPage")}?page=' + nextPage;
                            $.ajax({
                                url: url,
                                type: 'GET',
                                dataType: 'html',
                                success: function(response) {
                                    ${currentPage+=1};
                                    console.log(${currentPage});
                                    $('#recent_share').html(response);
                                },
                                error: function(xhr, status, error) {
                                    console.error('Error loading next page:', status, error);
                                }
                            });
                        }
                    </script>