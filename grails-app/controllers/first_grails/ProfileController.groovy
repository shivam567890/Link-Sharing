package first_grails

class ProfileController {

    def index() {
         if(session.user_id ==null){
             render(template: "/templates/errorHandling");
         }else {
//            List<Subscription>  sub = Subscription.list();
             Users user = Users.findById(session.user.id);
             List<Subscription> sub_topic = Subscription.findAllByUser(user);
             Boolean dont_show = 0 ;
             render(view: "../Frontend/edit_profile", model: [subscriptions: sub_topic, user: user,dont_show: dont_show]);
         }
     }

     def change_pass(){
            
            Users user = Users.findById(session.user_id);
           user.password = params.password;     
            
    if (user.save(flush: true)) {
        // Invalidate the session
        session.invalidate()
        flash.message = "Save successful!"
    } else {
        // Handle errors if any
        flash.message = "Error updating password"
    }
         redirect(controller:"Login");
     }

     def change_profile(){
        Users user = Users.findById(session.user_id);
         user.username= params.username;
         user.firstName= params.firstName;
         user.lastName = params.lastName;
         def Uphoto = (params.photo).getBytes();
         user.photo = Uphoto;
    if (user.save(flush: true)) {
        // Invalidate the session
        session.invalidate()
        flash.message = "Save successful!"
    } else {
        // Handle errors if any
        flash.message = "Error updating password"
    }
         redirect(controller:"Login");
     }
}
