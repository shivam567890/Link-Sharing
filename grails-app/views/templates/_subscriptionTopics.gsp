<g:if test="${subscription_Topic}">

    <g:each in="${subscription_Topic}" var="StopicData">

        <div class="Border1" style="border: 2px solid black;">
            <div class="DSubcontent">
                <div class="userCard" style="border: 0cap;">
                    <div class="userImg">
                        <img src="${assetPath(src: 'person-circle.svg')}" alt="person-circle.svg" height="90px" width="90px">
                    </div>
                    <div class="userData">
                        <h2>${StopicData?.topic?.name}</h2>
                        <div class="userS">
                            <div class="DId">
                                <p>${StopicData?.topic?.user?.username}</p>
                                <a href="#">Unsubscribed</a>
                            </div>
                            <div class="S">
                                <p>Subscription</p>
                                <p>${StopicData?.topic?.subscriptions?.size()}</p>
                            </div>
                            <div class="T">
                                <p>Post</p>
                                <p>${StopicData?.topic?.resources?.size()}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="SubInfo">
                <select id="dropdown-menu">
                    <option value="" disabled selected>Serious</option>
                    <option value="option1">Option 1</option>
                    <option value="option2">Option 2</option>
                    <option value="option3">Option 3</option>
                </select>
                <select id="dropdown-menu">
                    <option value="" disabled selected>Private</option>
                    <option value="option1">Option 1</option>
                    <option value="option2">Option 2</option>
                    <option value="option3">Option 3</option>
                </select>
                <img src="${assetPath(src: 'envelope.svg')}" alt="envelope" style="margin-left: 40px;">
                <img src="${assetPath(src: 'link.svg')}" alt="link">
                <img src="${assetPath(src: 'trash-fill.svg')}" alt="trash-fill">
            </div>
        </div>
    </g:each>
</g:if>
<g:else>
    <p>No subscriptions</p>
</g:else>

<div class="pagination">
    <g:if test="${totalRecords_Posts > maxPerPageP * currentPageP}">
        <a href="javascript:void(0);" onclick="loadNextPageP()">Next</a>
    </g:if>

</div>




<script>
    function loadNextPageP() {
        let currentPage = parseInt('${currentPageP}');
        console.log(${currentPageP});
        console.log("current page is ", currentPage);
        let nextPage = currentPage + 1;
        let url = '${createLink(controller: "Login", action: "topPosts")}?page=' + nextPage;
        $.ajax({
            url: url,
            type: 'GET',
            dataType: 'html',
            success: function(response) {
                console.log(${currentPageP});
                $('#top_Posts').html(response);
            },
            error: function(xhr, status, error) {
                console.error('Error loading next page:', status, error);
            }
        });
    }
</script>