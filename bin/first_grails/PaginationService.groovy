package first_grails

import grails.gorm.transactions.Transactional

@Transactional
class PaginationService {

    def serviceMethod() {
        Long maxPerPage = 2
        Long currentPage = 1;
        Long offset = (currentPage - 1) * maxPerPage
     return [maxPerPage:maxPerPage,currentPage:currentPage,offset: offset];
    }
}
