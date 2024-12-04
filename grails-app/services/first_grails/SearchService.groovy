package first_grails

import grails.gorm.transactions.Transactional

@Transactional
class SearchService {
RegisterService registerService;
    def PaginatedSearch(List<Resources> l,String searchTerm,  Users user) {
        List<Resources> demo = l;
        List<Resources>search_posts = []
        if(searchTerm.length() > 0) {
            String lowercasesearchTerm = searchTerm.toLowerCase();
            demo.each { it ->
                if (it.description.contains(searchTerm) || (it.topic.name.toLowerCase() == lowercasesearchTerm)) {
                    search_posts.add(it);
                }
            }
        }else if(user.admin ==false && searchTerm.length() == 0){
            search_posts= demo;
        }
        Long totalRecordsP = search_posts.size();
        println "total Records : " + totalRecordsP;
        Long offset = 0;
        Long maxPerPage = 3;
        List<Resources> PaginatedSearchResult = registerService.PaginatePosts(search_posts,offset,maxPerPage);
        return [PaginatedSearchResult,offset,maxPerPage,totalRecordsP];
    }
}
