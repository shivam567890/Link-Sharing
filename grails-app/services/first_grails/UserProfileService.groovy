package first_grails

import grails.gorm.transactions.Transactional
import org.hibernate.criterion.Projections

@Transactional
class UserProfileService {

    def serviceMethod() {

    }

    def show(Users user){

            Long userId = user.id;
        Long subscriptionCount = Subscription.createCriteria().get {
            projections {
                count()
            }
            createAlias('topic', 't')
            eq('user.id', userId)
            eq('t.isdeleted', false)
        }
        Long topicCount = Topic.createCriteria().get{
            projections{
                count()
            }
            eq('user.id', userId)
            eq('isdeleted', false)
        }


          List<Topic>  topics =  Topic.list();
            println  "topic size is : " +topics.size();

        List<Topic> abc  = topics.findAll{ it-> it.user == user};
            topics =abc;
            println  "topic size  (abc) is : " +abc.size();

        List<Resources> l = []
        List<Resources> all_resource = Resources.list();
            all_resource.each { resource ->
                List<ReadingItem> readingItemlist = ReadingItem.findAllByResource(resource);
                Boolean flag=0;
                int not_found=0;
                readingItemlist.each{it->
                    if(it.user==user && !it.isRead){
                        flag=1;
                    }
                    not_found++;
                }
                if(flag || not_found==0){
                    l.add(resource);
                }
            }

            List<Subscription> sub_topic = Subscription.findAllByUser(user)

            sub_topic = sub_topic.sort { s1, s2 ->
                def s1_resources = Resources.createCriteria().get {
                    'in'('topic', s1.topic)
                    ne('isdeleted', true)
                    projections {
                        countDistinct('id')
                    }
                }

                def s2_resources = Resources.createCriteria().get {
                    'in'('topic', s2.topic)
                    ne('isdeleted', true)
                    projections {
                        countDistinct('id')
                    }
                }
                def resourceComparison = s1_resources.compareTo(s2_resources)

                if (resourceComparison == 0 && s1_resources == 0) {
                    return s1.lastUpdated <=> s2.lastUpdated
                }
                if (s1_resources == 0 || s2_resources == 0) {
                    return s1_resources <=> s2_resources
                }
                def most_recent_resource_of_s1 = s1.topic.resources.findAll { !it.isdeleted }.max { it.lastUpdated }?.lastUpdated
                def most_recent_resource_of_s2 = s2.topic.resources.findAll { !it.isdeleted }.max { it.lastUpdated }?.lastUpdated
                return most_recent_resource_of_s1 <=> most_recent_resource_of_s2
            }.reverse()
            Long maxPerPage = 3;
            Long currentPage = 1;
            int offset = (currentPage - 1) * maxPerPage;
        int endIndex = Math.min(offset + maxPerPage, topics.size());
        List<Topic> paginatedTopics = topics.subList(offset, endIndex);
            Long totalRecords=topics.size();
        Map mp = [
                subscriptionCount: subscriptionCount, topicCount: topicCount,topics: paginatedTopics, l: l, sub_topic: sub_topic,user:user, currentPage: currentPage, totalRecords: totalRecords,maxPerPage: maxPerPage
        ]
          return mp;
    }
}
