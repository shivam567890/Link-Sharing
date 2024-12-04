package first_grails

//import grails.gorm.transactions.Transactional
import org.springframework.http.HttpHeaders
import org.springframework.http.MediaType
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.bind.annotation.*
import javax.servlet.annotation.MultipartConfig
class DocumentResourceController {

    def index() { }
//
//    @Transactional
//    @RequestMapping("/documentRes", method = RequestMethod.POST)
//    @MultipartConfig(maxFileSize = "10MB") // Adjust the maximum file size as needed
    def documentRes(){

                  try{
            // println "hello: ${params.userId}";
          Topic ctopic = Topic.findByName(params.topic);
          Users curr_user = Users.findById(session.user.id);
          Resources new_res = new Resources(description:params.description,user: curr_user,topic : ctopic, documentResource: params.documentResource);
             new_res.save(flush:true, failOnError:true);
                      flash.message = "Document uploaded successfully!"
                      List<Resources> res = Resources.list();
                      List<Topic>topics = Topic.list();
             redirect(controller:"Register", action:"dashboard");
          }
                  catch (Exception e) {
                      String exceptionMessage = e.toString()
                      List<String> words = exceptionMessage.split(/\s+/)
                      List<String> slicedWords = words.take(50)
                      String slicedMessage = slicedWords.join(' ')
                      session.invalidate();
                      render(template: '/templates/errorHandling', model: [msg: slicedMessage]);
                  }

    }

    def downloadFile(Long fileId) {
        Resources fileEntity = Resources.get(fileId)
        if (!fileEntity) {
            // Handle case where file is not found
            // Redirect or display error message
            return
        }

        response.setHeader(HttpHeaders.CONTENT_DISPOSITION, "attachment;filename=${fileEntity.description}")
        response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE)
        response.setContentLength(fileEntity.documentResource.length)

        response.getOutputStream().write(fileEntity.documentResource)
        response.getOutputStream().flush()

        // Close the response output stream
        response.getOutputStream().close()

        // Render an empty response since the file has been downloaded
        render(contentType: "text/html", text: "")
    }
}
