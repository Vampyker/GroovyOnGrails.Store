package grailsstore

class OrderProduct {
  Double price
  Integer quantity
  
  static belongsTo = [ product: Product, order: Order ]

  static constraints = {
    product ( unique: ['order'] )
    quantity ( min:1 )
  }
  
  static mapping = {
    table('gorder_gproduct')
  }
 
  static OrderProduct setLink(Map params) {
    def link = OrderProduct.findWhere(
      order: params.order, product: params.product)
    if (!link) {
      link = new OrderProduct(params)
      link.save()
    }
    return link
  }
 
  static boolean removeLink(Map params) {
    def link = OrderProduct.findWhere(
      order: params.order, product: params.product)
    if (link) {
      link.delete()
      return true
    }
    return false
  }
  
  @Override
  String toString() { 
    return "$product.title <=> ($quantity,$price)" 
  }
}
