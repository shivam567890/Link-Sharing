package first_grails

import grails.gorm.transactions.Transactional

@Transactional
class Common_operationsService {
    ResourceRatingService resourceRatingService;

    def serviceMethod() {
        
    }

    def SortedResourceBasedOnRating(List<Resources> new_list , int maxPerPage,int currentPage,int offset ){
        Map<Resources, Float> ratingMap = new HashMap<>();
        new_list.each{it->
            Float rating = resourceRatingService.calculateAverageRatingForResource(it);
            ratingMap[it] = rating;
        }
        new_list.each{
            println ratingMap[it] ;
        }
        println "sfe"
        new_list= new_list.sort({ r1,r2 ->
            Float rating1 = ratingMap.get(r1)
            Float rating2 =ratingMap.get(r2)

            return rating2 <=> rating1
        })
        new_list.each{
            println ratingMap[it] ;
        }
        Boolean loginP = 1;
        println ratingMap;
        int endIndex = Math.min(offset + maxPerPage, new_list.size());
        List<Resources> paginatedTopics = new_list.subList(offset, endIndex);
        return [paginatedTopics,ratingMap];
    }

}
