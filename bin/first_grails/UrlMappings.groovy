package first_grails

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: "Register", action: "dashboard")
        "500"(view:'/error')
        "404"(view:'/notFound')
        "/helloWorld/new_method"(controller:"helloWorld", action:"f1");
        "/1234"(view:"/user/frontend");
        "/1"(view:"/Frontend/login");
        "/2"(view:"/Frontend/register");
        "/dashboard"(view:"/Frontend/dashboard");
//        "/register/$dashboard?"(controller: "register") {
//            // Apply the interceptor to all actions of UserController
//            interceptor(first_grails.AuthenticationInterceptor.GroovyInterceptor)
//        }
//        "/topic/$create_Topic?"(controller: "topic"){
//            interceptor(first_grails.AuthenticationInterceptor.GroovyInterceptor)
//        }
    }
}
