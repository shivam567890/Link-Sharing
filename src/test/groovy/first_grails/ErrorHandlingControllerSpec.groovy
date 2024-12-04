package first_grails

import grails.testing.web.controllers.ControllerUnitTest
import spock.lang.Specification

class ErrorHandlingControllerSpec extends Specification implements ControllerUnitTest<ErrorHandlingController> {

    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
        expect:"fix me"
            true == false
    }
}
