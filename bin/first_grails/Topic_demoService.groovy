package first_grails

import grails.gorm.transactions.Transactional

@Transactional
class Topic_demoService {

    def serviceMethod(params) {

        println "service is called!";
        return params;

    }
}
