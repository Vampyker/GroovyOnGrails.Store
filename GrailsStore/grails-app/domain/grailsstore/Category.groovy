package grailsstore

class Category {
  String name
  
  static hasMany = [ products: Product ]
  
  static constraints = {
    name ( size:3..50 )
  }
  
  static mapping = {
    table('gcategory')
  }
  
  @Override
  String toString() { return "$id:$name" }
}
