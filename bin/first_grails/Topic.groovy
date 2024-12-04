package first_grails

class Topic {
    String name
    Users user
    Visibility visibility // Using enum name as property type
    Boolean isdeleted=0
    Date lastUpdated;
    static constraints = {
        // name(blank:false, unique:['user']);
        isdeleted(nullable: true, defaultValue:false);
    }

    static belongsTo = [user: Users]
    static hasMany = [resources: Resources, subscriptions: Subscription]

    enum Visibility {
        Public,
        Private
    }
}

