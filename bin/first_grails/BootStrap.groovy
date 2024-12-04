//package first_grails
//
//class BootStrap {
//
//    def init = { servletContext ->
//    }
//    def destroy = {
//    }
//}


package first_grails
import org.springframework.core.io.ClassPathResource

class BootStrap {

    def init = { servletContext ->
        // Check if an admin user already exists
        def adminUser = Users.findByAdmin(true)

        if (!adminUser) {
            // Create admin user if it doesn't exist
            def admin = new Users(
                    email: "shivam.kh007@gmail.com",
                    username: "admin",
                    password: "password",
                    firstName: "Shivam",
                    lastName: "Khandelwal",
                    admin: true
            )
            // Read the image file from assets
            byte[] imageBytes = readImageBytes("/home/shivamkhandelwal/Desktop/Java/First_grails/grails-app/assets/images/admin.jpg")

            // Set the image bytes to the admin user's photo field
            admin.photo = imageBytes;
            admin.save(failOnError: true)
        }
    }

    def destroy = {
    }

    private byte[] readImageBytes(String imagePath) {
        try {
            // Read image file using absolute path
            InputStream inputStream = new FileInputStream(new File(imagePath))
            return inputStream ? inputStream.bytes : null
        } catch (IOException e) {
            println "Error reading image file: $e.message"
            return null
        }
    }

}
