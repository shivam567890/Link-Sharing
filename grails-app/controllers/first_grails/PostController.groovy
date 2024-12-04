package first_grails
import org.springframework.beans.factory.annotation.Autowired
import javax.servlet.http.HttpServletRequest

class PostController {
    ResourceRatingService resourceRatingService;
    PostService postService;
    TopicShowService topicShowService;
   RegisterService registerService
    def index() { }

    def show(Long resId , Float avgRating){
             if(session.user  == null){
                 render(template: "/templates/errorHandling")
             }else {
                 Users user = session.user;
                def result=  postService.show(user,resId)
                 List<Subscription> sub_topic = Subscription.createCriteria().list{
                     eq("user" , user)
                 }
                 List<Topic> dummyTopic   = Topic.list();
                 List<Topic>modalTopic  = registerService.SortedTopic(dummyTopic);
                int maxPerPage = 3;
                 int offset  = 0;
                 int endIndex = Math.min(offset + maxPerPage, modalTopic.size());
                 List<Topic> paginatedTopics = modalTopic.subList(offset, endIndex);
                 render(view: "../Frontend/post", model: [resId: result.resId, post_rating: result.rating, avgRating: result.av_rating, all_Topics: paginatedTopics, curr_user: result.curr_user, curr_resource: result.resource,maxPerPage:result.maxPerPage,currentPage:result.currentPage,offset:result.offset,totalRecords:result.totalRecords,subscription_Topic : sub_topic]);
             }
    }

    def save(){
      println "hello check"
         Long rating = params.rating.toLong();
         Long resId = params.resId.toLong();
         Users user = session.user;
         Resources resource= Resources.findById(resId);
         ResourceRating r= ResourceRating.findByUserAndResource(user, resource);
        println "value of avgRating is : " + 12;
         def curr_res_rating= new ResourceRating();

         if(r!=null){
            r.score = rating;
            r.save(flush:true, failOnError:true);
         }
         else{
         curr_res_rating.resource= resource;
         curr_res_rating.user= user;
         curr_res_rating.score= rating;
         curr_res_rating.save(flush:true, failOnError:true);
         }
         if(r!=null){curr_res_rating=r;}
        Float avgRating  = resourceRatingService.calculateAverageRatingForResource(resource);
        println "value of avgRating is : " + avgRating;
        render(avgRating);
    }

      def delete_post(){
          Resources res = Resources.findById(params.id);
          res.isdeleted=1;
          res.save(flush:true);
          Long userId = session.user.id;
          redirect(controller:"Register", action:"dashboard", params: [userId: userId]);
      }
    }