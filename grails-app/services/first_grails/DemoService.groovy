package first_grails

import grails.gorm.transactions.Transactional

@Transactional
class DemoService {

    static def serviceMethod(int a, int b) {
        return  a+b;
    }



}
