package first_grails

class UserProfileController {
UserProfileService userProfileService;
    def index() { }

    def show(){
      if(session.user_id == null){
          render(template: "/templates/errorHandling");
      }else{
        Users user = Users.findById(session.user_id);
       Long userId = user.id;
         def result= userProfileService.show(user);
          session.user = user;
    render(view:"../Frontend/userProfile" , model:[subscriptionCount: result.subscriptionCount, topicCount: result.topicCount,all_Topics: result.topics, resource: result.l, subscription_Topic: result.sub_topic,curr_user:result.user, currentPage: result.currentPage, totalRecords: result.totalRecords,maxPerPage: result.maxPerPage])
          }
    }
}
