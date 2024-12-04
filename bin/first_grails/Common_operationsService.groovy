package first_grails

import grails.gorm.transactions.Transactional

@Transactional
class Common_operationsService {

    def serviceMethod() {
        
    }

    void Subscription_list(def user, def topic, def seriousness ){

            Subscription new_subs= new Subscription();
            new_subs.topic = topic;
            new_subs.user = user;
            new_subs.seriousness = seriousness;
            new_subs.save(flush:true, failOnError:true);
    }


}
