package first_grails

import grails.gorm.transactions.Transactional

@Transactional
class TopicShowService {

    def serviceMethod(Topic curr_topic, Users  topic_owner, Long currentPage,Users user) {

        Long maxPerPage = 2
        Long offset = (currentPage - 1) * maxPerPage

        def topic_posts = Resources.createCriteria().list(max:maxPerPage,offset: offset){
            topic{
                eq('id', curr_topic.id)
            }
        }
        def topic_subscribers = Subscription.createCriteria().list(max: maxPerPage, offset: offset) {
            topic {
                eq('id', curr_topic.id) // Assuming you're comparing topic IDs
            }
        }

        def  totalRecords = Subscription.createCriteria().count{
            topic{
                eq('id', curr_topic.id)
            }
        }
        def totalRecords_Posts = Resources.createCriteria().count{
            topic{
                eq('id', curr_topic.id);
            }
        }
        Map subscribers_with_photo = [:]
        topic_subscribers.each{it->
            String users_img= it.user.photoURL;
            subscribers_with_photo[it] = users_img;
        }
        List<Subscription> sub_topic = Subscription.createCriteria().list{
            eq("user" , user)
        }
        def topic_Show_Map = [
                curr_topic: curr_topic,
                topic_owner: topic_owner,
                topic_subscribers: topic_subscribers,
                topic_posts: topic_posts,
                subscribers_with_photo:subscribers_with_photo,
                sub_topic: sub_topic
        ]
        println "total sibscrubers:" + subscribers_with_photo.size();
        println "based on pagination subscribers" + topic_subscribers;
        String user_img = topic_owner.photoURL;


        Map mp1 = [:];

        mp1 = [
                topic_Show_Map: topic_Show_Map,
                totalRecords_Posts: totalRecords_Posts,
                totalRecords: totalRecords,
                user_img: user_img,
                maxPerPage:maxPerPage
        ]
        return mp1;
    }

    def RestPageResources(Topic curr_topic, Users topic_owner, Long currentPage){
        Long maxPerPage = 2
        Long offset = (currentPage - 1) * maxPerPage;
        def topic_posts = Resources.createCriteria().list(max:maxPerPage,offset: offset){
            topic{
                eq('id', curr_topic.id)
            }
        }

        def totalRecords_Posts = Resources.createCriteria().count{
            topic{
                eq('id', curr_topic.id);
            }
        }
        def topic_Show_Map =[
                curr_topic: curr_topic,
                topic_owner: topic_owner,
                topic_posts: topic_posts
        ]
           Map mp = [:]
           mp= [
               topic_Show_Map: topic_Show_Map,
               totalRecords_Posts: totalRecords_Posts,
               topic_posts: topic_posts,
               maxPerPage: maxPerPage
           ]
        println "hello guys !!!!!!!!!!"
        return mp;

    }
}
