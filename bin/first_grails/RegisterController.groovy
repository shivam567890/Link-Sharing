package first_grails
import org.hibernate.criterion.Order
import org.hibernate.criterion.CriteriaSpecification
import org.hibernate.criterion.*
import org.springframework.web.multipart.MultipartFile

class RegisterController {
 RegisterService registerService;
    def index() {
    }

    def error(){
        render " Due to some error, account not created."
    }
 def dashboard(Long userId) {
   if(session.user_id == null){
       Long maxPerPage = 2
       Long currentPage = 1;
       Long currentPageP = 1;
       Long offset = (currentPage - 1) * maxPerPage
       List<Resources> resource = Resources.createCriteria().list(max: maxPerPage, offset: offset){
           eq("isdeleted", false)
           order("lastUpdated","desc")
       }
       Long totalRecords = Resources.countByIsdeleted(false)
       List<Resources>  res_shares = resource;
       render (view : "../Frontend/login", model:[resource: resource, currentPage: currentPage, totalRecords: totalRecords,res_shares:res_shares, maxPerPage: maxPerPage,currentPageP: currentPageP]);
   }else{
       userId = session.user_id;
      Users user = Users.findById(userId)
       Map result = registerService.dashboard(userId);
       Long currentPageP =1;
       render(view: "../Frontend/dashboard", model: [subscriptionCount: result.subscriptionCount, topicCount: result.topicCount,all_Topics:result.topics,resource: result.paginatedSubscriptions,subscription_Topic: result.sub_topic, curr_user:result.user,user_img: result.user_img,maxPerPage:result.maxPerPage,currentPage:result.currentPage,offset:result.offset,totalRecords:result.totalRecords,currentPageP: currentPageP,totalRecordsP:result.totalRecordsP,maxPerPageP:result.maxPerPageP])
       }
}

    def nextPage() {
        Long currentPage = 1;
        Long totalRecords = params.totalRecords.toLong();
        if(params?.page){
            currentPage= params.page.toLong();
        }
        Users curr_user = session.user;
        Map result = registerService.nextPage(currentPage,totalRecords,curr_user);

        render(template: '/templates/trendingTopics', model: [all_Topics: result.topics, currentPage: result.currentPage, totalRecords: result.totalRecords,maxPerPage: result.maxPerPage,curr_user : result.curr_user]);
    }
    def nextPageP(){
        Users user = session.user;

        Map result = registerService.nextPageP(params, user);
//        Long totalRecordsP = 0;
//            Long maxPerPage = 2
//            Long currentPage = 1;
//            if(params?.page){
//                currentPage= params.page.toLong();
//            }
//            println "value of current page is :" + currentPage;
//            Long offset = (currentPage - 1) * maxPerPage
//        List<Topic> topics =  Topic.list();
//        List<Resources> l = []
//        List<Resources> new_posts= [];
//        topics.each{ it->
//            if(Subscription.findByTopicAndUser(it,user) && it.resources.size() && it.visibility == Topic.Visibility.Public){
//                def reso = it.resources;
//                reso.each{ it1->
//                    new_posts.add([it1]);
//                }
//            }
//        }
//        new_posts.each{  resource->
//            List<ReadingItem> readingItemlist = ReadingItem.findAllByResource(resource);
//            Boolean flag=0;
//            readingItemlist.each{it->
//                if(it.user==user && it.isRead){
//                    flag=1;
//                }
//            }
//            if(!flag){
//                l.add([resource]);
//                totalRecordsP++;
//            }
//        }
//        l = l.flatten();
//        List<Resources> paginatedSubscriptions;
//
//        int endIndex = Math.min(offset + maxPerPage, l.size());
//
//        if (offset < l.size()) {
//            paginatedSubscriptions = l.subList(Math.toIntExact(offset), Math.toIntExact(endIndex));
//        } else {
//            paginatedSubscriptions = Collections.emptyList();
//        }
        println "program reaches here fine!"
        render(template: '/templates/topPosts', model: [resourceP: result.paginatedSubscriptions, currentPageP: result.currentPage, totalRecordsP: result.totalRecordsP,maxPerPageP: result.maxPerPage]);
    }
    def create_user() {
        try {
            Users user = new Users(params)
            println params;
            println "user image format check" + params.photo;
            user.save(flush: true, failOnError: true)
            def userId = user.id
             session.user_id = user.id
             session.user = user;
            // Set user ID in localStorage
            render(template: '/register/setLocalStorage', model: [userId: userId])
        }catch (Exception e) {
            String exceptionMessage = e.toString()

            List<String> words = exceptionMessage.split(/\s+/)

            List<String> slicedWords = words.take(50)

            String slicedMessage = slicedWords.join(' ')

            render(template: '/templates/errorHandling', model: [msg: slicedMessage]);

        }
    }

    def is_read(){

        Resources res= Resources.findById(params.resId);
        Users user= Users.findById(session.user_id);
        ReadingItem readingItem  = new ReadingItem(resource: res, user: user, isRead: true);
        readingItem.save(flush:true);
        Long userId = session.user.id;
        redirect(action:"dashboard", params: [userId: userId]);
    }

    def change_topic_name(){
        Topic topic = Topic.findById(params.topicId);
        topic.name = params.new_topic_name;
        topic.save(flush:true);
        flash.message = "Topic name changed successfully!"
        Long userId= session.user.id;
        redirect(action: "dashboard",params: [userId:userId]);
    }

    def change_topic_mode(){
        Topic curr_topic = Topic.findById(params.topicId);
        curr_topic.visibility = params.selectedVisibility;
        curr_topic.save(flush:true);
        flash.message = "Visibility mode changed!"
        Long userId= session.user.id;
        redirect(action:"dashboard",params: [userId: userId]);
    }

    def change_seriousness(){
        Subscription curr_sub = Subscription.findById(params.StopicId);
        curr_sub.seriousness = params.selectedSeriousness;
        curr_sub.save(flush:true);
        println params;
        flash.message = "Seriousness changed!"
        Long userId= session.user.id;
        redirect(action:"dashboard",params: [userId: userId]);
    }

    def toDelete(){
        Topic topic = Topic.findById(params.id);

        println "topic id that has deleted:" + topic.id;

      def res=  Resources.findAllByTopic(topic);
        res.each{ it->
            it.isdeleted =1;
        }
        Resources.saveAll(res);
        topic.isdeleted=true;
        topic.save(flush:true);
        Long userId= session.user.id;
        redirect(action: "dashboard",params: [userId: userId] );
    }
}
