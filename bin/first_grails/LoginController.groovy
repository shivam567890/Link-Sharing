package first_grails
import org.hibernate.criterion.Order
class LoginController {
    InvitationService invitationService;
    def index() {
            Long maxPerPage = 2
            Long currentPage = 1;
            Long currentPageP = 1;
            Long offset = (currentPage - 1) * maxPerPage
            List<Resources> resource = Resources.createCriteria().list(max: maxPerPage, offset: offset) {
                eq("isdeleted", false)
                order("lastUpdated", "desc")
            }
            Long totalRecords = Resources.countByIsdeleted(false)
            List<Resources> res_shares = resource;
            render(view: "../Frontend/login", model: [resource: resource, currentPage: currentPage, totalRecords: totalRecords, res_shares: res_shares, maxPerPage: maxPerPage, currentPageP: currentPageP]);

    }

    def loginUser(){
        String email = params.email
        String password = params.password
        Users dummyUser = Users.findByEmail(email);
        Users user = Users.findByEmailAndPassword(email, password);
        String msg = ""

        if (user && user.active == true) {
                  Long userId = user.id;
                  Long subscriptionCount = Subscription.where {
                      user.id == userId;
                  }.count()
                  Long topicCount = Topic.where {
                      user.id == userId
                  }.count()
                //   def topics= Topic.list();
                // def sub_topic = Subscription.findAllByUser(user);
                  session.user= user;
                  session.user_id = userId;
            render(template: '/register/setLocalStorage', model: [userId: userId])
            // render (view: "../Frontend/dashboard",model: [subscriptionCount: subscriptionCount, topicCount: topicCount])
        } else if(dummyUser){
               msg = "Please write correct Credentials!!"
          }
          else {
               msg = "Please contact Admin!!"
        }
        render(template:"/templates/errorHandling", model: [msg: msg]);
    }


    def nextPage() {
        Long maxPerPage = 2
        Long currentPage = 1;
        Long currentPageP = 1;
        if(params?.page){
            currentPage= params.page.toLong();
        }
        println "value of current page is :" + currentPage;
        Long offset = (currentPage - 1) * maxPerPage
        List<Resources> resource = Resources.createCriteria().list(max: maxPerPage, offset: offset){
            eq("isdeleted", false)
            order("lastUpdated","desc")
        }
        Long totalRecords = Resources.countByIsdeleted(false)

        render(template: '/templates/recentShares', model: [resource: resource, currentPage: currentPage, totalRecords: totalRecords,maxPerPage: maxPerPage,currentPageP: currentPageP]);
    }


    def topPosts(){
        Long maxPerPage = 2
        Long currentPage = 1;
        if(params?.page){
            currentPage= params.page.toLong();
        }
        println "value of current page is :" + currentPage;
        Long offset = (currentPage - 1) * maxPerPage
        List<Resources> resource = Resources.createCriteria().list(max: maxPerPage, offset: offset){
            eq("isdeleted", false)
            order("lastUpdated","desc")
        }
        println "value of currentPGE IS :" + currentPage + "resources are:" + resource;
        Long totalRecords = Resources.countByIsdeleted(false)
        render(template: '/templates/topPosts', model: [resourceP: resource, currentPageP: currentPage, totalRecordsP: totalRecords,maxPerPageP: maxPerPage]);

    }



    def forgetPass(){
        render(view: "../Frontend/forgetPassword" );
    }

    def sendingEmail(){
        println params;
       Users user =  Users.findByEmail(params.email);
        if(user == null ){
            flash.error = "Create an account first!!"
            redirect(controller:"Login");
        }
        String authToken = UUID.randomUUID().toString();
        try {
            SendInvitation obj = new SendInvitation( receiverEmail: params.email, authToken: authToken , topicId: "noId");
            obj.save(flush: true, failOnError : true);
        }
        catch (Exception e){
            println(e);
        }
        String link = "http://localhost:8181/login/resetPassword/?receiverEmail=${params.email}&authToken=${authToken}";
        String body = "Reset Password link :  ${link}";
        String subject = "Reset Password link!!"
        Boolean result =  invitationService.sendEmail(params.email, body, subject);

        if(result){
            flash.message = "Write New Password and Confirm Password!!"
        }else{
            flash.error = "You are not authenticated user, please contact admin or try again"

        }
        redirect(action:"index");
    }

    def ResetPassword(){
        println params;
        String authToken = params.authToken;
        SendInvitation invitation  = SendInvitation.findByAuthToken(authToken);
       if(invitation && invitation.isValid == true){
           invitation.isValid = false;
           invitation.save(flush:true);
           flash.message  = "Authentication successfull!!"
           render(view: "../Frontend/resetPassword");
       }else{
           flash.error = "Authentication failed"
           redirect(action: "index");
       }
    }

    def ResetPass(){
        println params;
        Users user = Users.findByEmail(params.email);
        user.password = params.password;
        user.save(flush : true, failOnError: true);
        flash.message  =  " Password successfully reset!!"
        redirect(action: "index");
    }
}
