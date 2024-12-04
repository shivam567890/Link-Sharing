package first_grails

import grails.testing.services.ServiceUnitTest
import spock.lang.Specification

class DemoServiceSpec extends Specification implements ServiceUnitTest<DemoService>{

    def setup() {

    }

    def cleanup() {
    }

    void "test something"() {
        DemoService demoService = Spy(DemoService)


        given:
        int a = 5
        int b = 3

        when:
        def result = demoService.serviceMethod(a, b)

        then:
        result == 8


    }
}
