package grailsstore

import java.util.Date as DateTime

class Order {
  DateTime createdAt = new DateTime()
  
  static belongsTo = [ user: User ]
  
  static hasMany = [ links: OrderProduct ]

  static constraints = {
  }
  
  static mapping = {
    // You have to change the table name to something other than
    // the default name "order" because GORM doesn't quote the
    // table name in its operations. This is a mistake in GORM!
    table('gorder')
  }
  
  @Override
  String toString() { return "$id:$createdAt:$user" }
}
