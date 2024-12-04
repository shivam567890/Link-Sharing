            <g:if  test="${!topic_Show_Map.topic_subscribers.empty }">  
            <g:each in="${topic_Show_Map.topic_subscribers}" var="subscribers">
                <div class="Border1" style="border: 2px solid black;">
                    <div class="DSubcontent">
                        <div class="userCard" style="border: 0cap;">
                            <div class="userImg">
                                <img src="${topic_Show_Map.subscribers_with_photo[subscribers]}" height="90px" width="90px" alt="user_image">
                            </div>
                            <div class="userData">
                                <h2>${subscribers?.user.firstName}</h2>
                                <div class="userS">
                                    <div class="DId">
                                        <p>@${subscribers?.user.username}</p>
                                        <a href="#">Unsubscribed</a>
                                    </div>
                                    <div class="S">
                                        <p>Subscription</p>
                                        <p>${subscribers?.user?.subscriptions?.size()}</p>
                                    </div>
                                    <div class="T">
                                        <p>Topics</p>
                                        <p>${subscribers?.user?.topics?.size()}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </g:each>
            </g:if>
            <g:else>
               <p> No user subscribed to the topic </p>
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
                            let topicId= parseInt('${ topic_Show_Map.curr_topic.id}');
                            let url = '${createLink(controller: "Topic_show", action: "nextPage")}?page=' + nextPage+ '&topicId=' +topicId;
                            $.ajax({
                                url: url,
                                type: 'GET',
                                dataType: 'html',
                                success: function(response) {
                                    ${currentPage+=1};
                                    console.log(${currentPage});
                                    $('#subscribersListing').html(response);
                                },
                                error: function(xhr, status, error) {
                                    console.error('Error loading next page:', status, error);
                                }
                            });
                        }
                    </script>