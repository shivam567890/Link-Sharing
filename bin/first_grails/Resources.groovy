package first_grails

import org.grails.datastore.gorm.finders.ListOrderByFinder

import javax.persistence.Lob

class Resources {
  String description;
  Users user;
  Topic topic;
  String url;
    @Lob
  byte[]  documentResource;
    Boolean isdeleted=0;
    Date dateCreated;
    Date lastUpdated;
    static constraints = {
        url(nullable:true)
        documentResource(nullable:true, maxSize: 1024 * 1024 * 10);
        isdeleted(nullable: true, defaultValue: false);
    }
    static belongsTo = [topic:Topic, user:Users];
    static hasMany = [readingItems: ReadingItem, resourceRating: ResourceRating];

}
