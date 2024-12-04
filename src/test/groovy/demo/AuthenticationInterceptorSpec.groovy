package demo

import grails.testing.web.interceptor.InterceptorUnitTest
import spock.lang.Specification

class AuthenticationInterceptorSpec extends Specification implements InterceptorUnitTest<AuthenticationInterceptor> {

    def setup() {
    }

    def cleanup() {

    }

    void "Test authentication interceptor matching"() {
        when:"A request matches the interceptor"
            withRequest(controller:"authentication")

        then:"The interceptor does match"
            interceptor.doesMatch()
    }
}
