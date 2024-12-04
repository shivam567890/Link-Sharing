package first_grails

class Topic_showController {
TopicShowService topicShowService;

    def index() { }
    def topic(){

        Topic curr_topic = Topic.findById(params.topicId);
        Users  topic_owner = curr_topic.user;
        Long currentPage = 1;
        Users user = session.user;
        Map result = topicShowService.serviceMethod(curr_topic,topic_owner,currentPage,user);

//        subscription_Topic:subscription_Topic, curr_user: curr_user
        render(view:"../Frontend/topic_show" , model:[topic_Show_Map: result.topic_Show_Map, currentPage: currentPage, totalRecords: result.totalRecords, maxPerPage: result.maxPerPage,totalRecords_Posts: result.totalRecords_Posts, user_img: result.user_img,subscription_Topic : result.topic_Show_Map.sub_topic,curr_user:user]);
    }
    def nextPage(){
         Topic curr_topic = Topic.findById(params.topicId);
        Users  topic_owner = curr_topic.user;
        Long currentPage = 1;
        if(params?.page){
            currentPage= params.page.toLong();
        }

        Map result = topicShowService.serviceMethod(curr_topic,topic_owner,currentPage,session.user);
        println "hello world"  +  currentPage;
        render(template: "/templates/subscribedUsers",  model:[topic_Show_Map:result.topic_Show_Map,currentPage: currentPage, totalRecords: result.totalRecords, maxPerPage: result.maxPerPage]);
    }


    def nextPageResources(){
        Topic curr_topic = Topic.findById(params.topicId);
        Users  topic_owner = curr_topic.user;
        Long currentPage = 1;
        if(params?.page){
            currentPage= params.page.toLong();
        }
        Map result = topicShowService.RestPageResources(curr_topic,topic_owner,currentPage);
        render(template: "/templates/topicPosts",  model:[topic_Show_MapP:result.topic_Show_Map,currentPageP: currentPage, totalRecords_Posts: result.totalRecords_Posts, maxPerPageP: result.maxPerPage]);
    }
}
