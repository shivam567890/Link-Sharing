package first_grails

import grails.gorm.transactions.Transactional

@Transactional
class ErrorHandlingService {

    def serviceMethod() {

    }

    String handleException(Exception e) {
        String exceptionMessage = e.toString()
        List<String> words = exceptionMessage.split(/\s+/)
        List<String> slicedWords = words.take(50)
        String slicedMessage = slicedWords.join(' ')
       return slicedMessage;
    }
}
