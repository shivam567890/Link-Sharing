package first_grails
import org.hibernate.criterion.CriteriaSpecification

class SearchController {
    RegisterService registerService;
    SearchService searchService
    def index() {

        String searchTerm = params.searchTerm;
        Long userId = session.user_id;
        Users user = Users.findById(userId)
        Map result = registerService.dashboard(userId);
        Long currentPageP =1;
        def SearchResult = searchService.PaginatedSearch(result.l,searchTerm,user);
//         List<Resources> demo = result.l;
//        List<Resources>search_posts = []
//        if(searchTerm.length() > 0) {
//            String lowercasesearchTerm = searchTerm.toLowerCase();
//            demo.each { it ->
//                if (it.description.contains(searchTerm) || (it.topic.name.toLowerCase() == lowercasesearchTerm)) {
//                    search_posts.add(it);
//                }
//            }
//        }else if(user.admin ==false && searchTerm.length() == 0){
//            search_posts= demo;
//        }
//        Long totalRecordsP = search_posts.size();
//       println "total Records : " + totalRecordsP;
//        Long offset = 0;
//        Long maxPerPage = 3;
//        List<Resources> PaginatedSearchResult = registerService.PaginatePosts(search_posts,offset,maxPerPage);
        render(view: "../Frontend/search", model: [subscriptionCount: result.subscriptionCount, topicCount: result.topicCount,all_Topics:result.topics,resource: SearchResult[0],subscription_Topic: result.sub_topic, curr_user:result.user,user_img: result.user_img,maxPerPage:SearchResult[2],currentPage:result.currentPage,offset:result.offset,totalRecords:result.totalRecords,currentPageP: currentPageP,totalRecordsP:SearchResult[3], searchTerm: searchTerm])
    }

    def nextPageP(){

        Users user = session.user;
        Map result = registerService.nextPageP(params, user);
        render(template: '/templates/topPosts', model: [resourceP: result.paginatedSubscriptions, currentPageP: result.currentPage, totalRecordsP: result.totalRecordsP,maxPerPageP: result.maxPerPage]);

    }


      def ajaxSearch(){
            println params ;
              println "dsihfshfehgfdgfd";
            List<Topic> dummyTopic = Topic.list();
             Users user = session.user;
          Topic curr_topic = Topic.findById(params.curr_topicId.toLong())
//          List<Topic>topics=  registerService.SortedTopic(dummyTopic);
//          def all = registerService.allPosts(topics, user);

          List<Resources> l = [];
          curr_topic.resources.each{it->
              if(it.isdeleted == false && it.description.contains(params.search)){
                  l.add(it);
              }
          }
          Long totalRecordsP = l.size();
          Map topic_Show_MapP = [
                  topic_posts: l,
                  curr_topic: curr_topic
          ]
          Long currentPageP=1;
//          topic_Show_MapP: topic_Show_Map, currentPageP: currentPage, totalRecords_Posts: totalRecords_Posts, maxPerPageP: maxPerPage
         render (template: "/templates/topicPosts" , model: [topic_Show_MapP:topic_Show_MapP,currentPageP:currentPageP,totalRecords_Posts: totalRecordsP,maxPerPageP:5])
      }

}
