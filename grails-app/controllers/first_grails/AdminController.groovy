package first_grails

class AdminController {

    def index() {
       List<Users> user = Users.list();
        Users curr_user = session.user;

        List<Subscription> sub_topic = Subscription.createCriteria().list{
            eq("user" , curr_user)
        }
        render(view:"../Frontend/admin", model: [users:user,curr_user:curr_user,subscription_Topic:sub_topic]);
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
