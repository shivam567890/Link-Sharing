package first_grails

class AdminController {

    def index() {
       def user = Users.list();
        render(view:"../Frontend/admin", model: [users:user]);
    }

    def Deactivate(){
        Users user = Users.findById(params.userId);
        user.active = false;
        user.save(flush:true);
        redirect(action:"index");

    }
    def Activate(){
        Users user = Users.findById(params.userId);
        user.active = true;
        user.save(flush:true);
        redirect(action:"index");

    }

}
