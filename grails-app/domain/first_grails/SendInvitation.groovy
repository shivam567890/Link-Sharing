package first_grails

class SendInvitation {
    String receiverEmail;
    String authToken;
    String topicId;
    Boolean isValid = true;
    static constraints = {
    }
}
