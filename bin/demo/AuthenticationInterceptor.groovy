package demo


class AuthenticationInterceptor {

   public AuthenticationInterceptor(){
       match(controller: ['Topic', 'Profile', 'UserProfile', 'LinkResource','Mail'])
//       matchAll().excludes(controller: ['login', 'register'])

   }

    boolean before() {
        def user = session.getAttribute('user_id')
        println "interceptor is working fine!!!"
        if (!user || (session && session.getAttributeNames().hasNext())) {
            redirect(template:"templates/errorHandling");
            return false;
        }
        return true;
    }

    boolean after() {
        println "after interceptor"
        true }

    void afterView() {
        // no-op
    }
}
