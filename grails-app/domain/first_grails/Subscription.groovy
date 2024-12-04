package first_grails
import first_grails.Topic

class Subscription {
   Topic topic;
   Users user;
   Seriousness seriousness;
    Date lastUpdated;
    Date dateCreated;
   enum Seriousness{
    Serious,
    Very_serious,
    Casual
   }
    static constraints = {
        // topic(unique:['user'])
        // seriousness(nullable:false)
        // user(nullable:false)
    }
    static belongsTo = [topic: Topic, user: Users];
}
