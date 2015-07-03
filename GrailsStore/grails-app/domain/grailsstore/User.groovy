package grailsstore

class User {
  String username
  String email
  String password
  Boolean is_admin = false
  
  static hasMany = [ orders: Order ]
  
  static constraints = {
    username ( size:3..50, matches: "[a-zA-Z]+\\d*" )
    password ( size:40..40 )
    email ( blank: false, email:true )
  }
  
  static mapping = {
    table('guser')
  }
  
  @Override
  String toString() { return "$id:$username" }
}
