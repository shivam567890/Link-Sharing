package first_grails

import grails.gorm.transactions.Transactional
import org.hibernate.criterion.CriteriaSpecification


@Transactional
class RegisterService {

    def serviceMethod() {

    }

    def dashboard(Long userId) {
        Users user = Users.findById(userId)
        Users curr_user = user;
        def subscriptionCount = Subscription.createCriteria().get {
            projections {
                count()
            }
            createAlias('topic', 't')
            eq('user.id', userId)
            eq('t.isdeleted', false)
        }
        def topicCount = Topic.createCriteria().get {
            projections {
                count()
            }
            eq('user.id', userId)
            eq('isdeleted', false)
        }

        List<Subscription> sub_topic = Subscription.createCriteria().list{
            eq("user" , user)
        }
           sub_topic.sort({ subscription1 , subscription2 ->
               Long latest1 = 0, latest2 = 0;
               subscription1.topic.resources.each { it1 ->
                   if (it1.isdeleted == false) {
                       latest1 = Math.max(latest1, it1.lastUpdated.time);
                   }
               }
                   subscription2.topic.resources.each{it2->
                       if(it2.isdeleted == false){
                           latest2 = Math.max(latest2 , it2.lastUpdated.time);
                       }
                   }
                   (latest2 <=> latest1)
           })

        List<Topic> dummytopics = Topic.list();
        List<Topic> topics = SortedTopic(dummytopics);

        def all = allPosts(topics, user);
        List<Resources> l = all[0];
        Long totalRecordsP = all[1];
        String user_img = curr_user.photoURL;
        println topics.size();


        int maxPerPage = 3
        Long maxPerPageP = 3
        Long currentPage = 1;
        int offset = (currentPage - 1) * maxPerPage;
        Long totalRecords = topics.size();
//        topics = Topic.createCriteria().list(max: maxPerPage, offset: offset) {
//            eq('isdeleted', false)
//            createAlias('user', 'u') // Alias for joining User table
//            eq('u.active', true)
//        }
         println "total topics" + topics.size();
        int endIndex = Math.min(offset + maxPerPage, topics.size());
        List<Topic> paginatedTopics = topics.subList(offset, endIndex);
        println "total topics after pagincation : " + paginatedTopics.size();
        List<Resources> paginatedSubscriptions = PaginatePosts(l, offset, maxPerPageP);

        Map mp = [
                subscriptionCount     : subscriptionCount,
                topicCount            : topicCount,
                topics                : paginatedTopics,
                l                     : l,
                sub_topic             : sub_topic,
                user                  : user,
                user_img              : user_img,
                maxPerPage            : maxPerPage,
                currentPage           : currentPage,
                offset                : offset,
                totalRecords          : totalRecords,
                paginatedSubscriptions: paginatedSubscriptions,
                totalRecordsP         : totalRecordsP,
                maxPerPageP  :           maxPerPageP
        ]
        return mp;
    }
    List<Topic> SortedTopic(List<Topic>topics){
        List <Topic> dp = [];
        topics.each{it->
            if(it.user.active == true){
                dp.add(it);
            }
        }
        topics = dp;
        println topics.name;


        topics.sort({ t1, t2 ->
            Long ResourcecountT1 = 0;
            t1.resources.each{r1->
                if(r1.isdeleted == false){
                    ResourcecountT1++;
                }
            }
            Long ResourcecountT2 = 0;
            t2.resources.each{r2->
                if(r2.isdeleted == false){
                    ResourcecountT2++;
                }
            }
            (ResourcecountT2 <=> ResourcecountT1)
        })
          return topics;
    }
    List<Resources> PaginatePosts(List<Resources> l, Long offset, Long maxPerPage) {
        List<Resources> paginatedSubscriptions;

        int endIndex = Math.min(offset + maxPerPage, l.size());

        if (offset < l.size()) {
            paginatedSubscriptions = l.subList(Math.toIntExact(offset), Math.toIntExact(endIndex));
        } else {
            paginatedSubscriptions = Collections.emptyList();
        }
        return paginatedSubscriptions;
    }

    List<Resources> allPosts(List<Topic> topics, Users user) {
        List<Resources> l = []
        List<Resources> new_posts = [];
        Long totalRecordsP = 0;
        topics.each { it ->
            if (Subscription.findByTopicAndUser(it, user) && it.resources.size() && it.visibility == Topic.Visibility.Public) {
                def reso = it.resources;
                reso.each { it1 ->
                    new_posts.add([it1]);
                }
            }
        }
        new_posts.each { resource ->
            List<ReadingItem> readingItemlist = ReadingItem.findAllByResource(resource);
            Boolean flag = 0;
            readingItemlist.each { it ->
                if (it.user == user && it.isRead) {
                    flag = 1;
                }
            }
            if (!flag) {
                l.add([resource]);
                totalRecordsP++;
            }
        }

        l = l.flatten();
        return [l, totalRecordsP];
    }

    def nextPage(Long currentPage, Long totalRecords, Users curr_user) {
        int maxPerPage = 3
        int offset = (currentPage - 1) * maxPerPage
        List<Topic> topics = Topic.list();
        List <Topic> dp = [];
        topics.each{it->
            if(it.user.active == true){
                dp.add(it);
            }
        }
        topics = dp;
       println "chcekingihsg.."
        topics.sort({ t1, t2 ->
            Long ResourcecountT1 = 0;
            t1.resources.each{r1->
                if(r1.isdeleted == false){
                    ResourcecountT1++;
                }
            }
            Long ResourcecountT2 = 0;
            t2.resources.each{r2->
                if(r2.isdeleted == false){
                    ResourcecountT2++;
                }
            }
            (ResourcecountT2 <=> ResourcecountT1)
        })
        int endIndex = Math.min(offset + maxPerPage, topics.size());
        List<Topic> paginatedTopics = topics.subList(offset, endIndex);
        Map mp = [
                topics      : paginatedTopics,
                currentPage : currentPage,
                totalRecords: totalRecords,
                maxPerPage  : maxPerPage,
                curr_user   : curr_user
        ]
        return mp;
    }

    def nextPageP(def params, Users user) {

        Long maxPerPage = 3
        Long currentPage = 1;
        if (params?.page) {
            currentPage = params.page.toLong();
        }
        println "value of current page is :" + currentPage;
        Long offset = (currentPage - 1) * maxPerPage
        List<Topic> topics = Topic.list();
        def all = allPosts(topics, user);
        List<Resources> l = all[0];
        Long totalRecordsP = all[1];
        List<Resources> paginatedSubscriptions = PaginatePosts(l, offset, maxPerPage);
          Map mp = [
                  paginatedSubscriptions:paginatedSubscriptions,totalRecordsP:totalRecordsP,maxPerPage:maxPerPage,currentPage:currentPage
          ]
        return mp;
    }

}
