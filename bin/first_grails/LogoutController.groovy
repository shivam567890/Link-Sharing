package first_grails

class LogoutController {
     def index() {
        session.invalidate();
         redirect(controller:"Login");
     }


}
