package first_grails

import grails.gorm.transactions.Transactional

@Transactional
class ResourceRatingService {

    def serviceMethod() {
       println "hello world!"
        return 1;
    }

     Float calculateAverageRatingForResource(Resources resource) {
        def ratings = ResourceRating.findAllByResource(resource)
        def totalScore = 0
        ratings.each {
            totalScore += it.score
        }
        if (ratings.size() > 0) {
            return totalScore / ratings.size()
        } else {
            return 0.0
        }
    }
}
