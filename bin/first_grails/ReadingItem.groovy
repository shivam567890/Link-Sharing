package first_grails

class ReadingItem {
Resources resource;
Users user;
Boolean isRead;

    static constraints = {
        
    }
    static belongsTo = [user: Users, resource: Resources];
}
