package first_grails

import grails.testing.services.ServiceUnitTest
import spock.lang.Specification

class ErrorHandlingServiceSpec extends Specification implements ServiceUnitTest<ErrorHandlingService>{

    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
        expect:"fix me"
            true == false
    }
}
