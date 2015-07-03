package grailsstore

class Product {
  String title
  Double price
  String description
  
  static belongsTo = [ category: Category ]
  
  static hasMany = [ links: OrderProduct ]

  static constraints = {
    title ( size:5..100, unique: true, nullable: false )
    price ( min:2.99D, scale: 2 )
    description ( nullable: true, maxSize:9999 )
  }
  
  static mapping = {
    table ('gproduct')
  }
  
  @Override
  String toString() { return "$id:$title:$price" }
}
