package grailsstore

class HomeController {
  
  def beforeInterceptor = {

    if (params.containsKey('category_id')) {
        session.category_id = params.category_id
    }
    
    if (!session.field) {
      session.field = "title"
      session.order = 'asc'
    }
    // Emergency
    // session.field = null
    // session.cart = null
    
    if (!session.cart) {
      session.cart = [:]
    }
  }
  
  def setOrder(String id) {  // parameter name MUST be id
    def field = id
    if (field == session.field) {
      session.order = session.order == 'asc' ? 'desc' : 'asc'
    }
    else {
      session.field = field
      session.order = 'asc'
    }
    return redirect(action: "index")
  }

  def index() { 
    def categories = Category.findAll("from Category order by name")
    def products
    if (params.category_id || session.category_id) {
      def current_category_id = params.category_id ? params.category_id : session.category_id
      Category category = Category.get(current_category_id) 
      
      products = Product.findAllByCategory(category, [sort: session.field, order: session.order])
      session.category_id = current_category_id
    }
    else {
      products = Product.findAll("from Product order by " + session.field +
          (session.field == "category" ? ".name " : " ") + session.order)
    }
    return [ products: products, categories: categories ]
  }
  
  def cart() {
    Map info = [:]
    session.cart.each { key,value ->
      Product product = Product.get(key)
      info[key] = [title: product.title, price: product.price, quantity: value]
    }
    return [ info: info ]
  }
  
  def details(Long id) {
    if (params.removeIt != null) {
        session.cart.remove(id)
        redirect( action: "cart" )
    }
    if (params.setIt != null) {
      session.cart[id] = params.quantity
      if(!params.quantity || params.quantity.toInteger() < 1) {
        session.cart.remove(id)  
      }
      redirect( action: "cart" )
    }
    return [ product: Product.get(id) ]
  }
  
  def clearCart() {
    session.cart = null;
    redirect( action: "cart" )
  }
  
  def placeOrder() {
        if(session.valid) {
            def user = User.findByUsername(session.valid.username)
            def order = new Order(createdAt: new Date(), user: user)
            
            order.belongsTo = user
            order.save(flush: true)
            session.cart.each({cartProduct ->
                    Product product = Product.get(cartProduct.key)                    
                    println OrderProduct.setLink(order:order, product:product, quantity:cartProduct.value, price:product.price)
            })

            session.cart = null;
            redirect( action: "index" )
        }
        else {
            redirect( action: "index" )
        }
    }
    
    def orders() {
        Map info = [:]
        def user = User.findByUsername(session.valid.username)
        def orders = Order.findAll("from Order order by createdAt desc")    
        
        orders.each { order ->
            if(order.user == user) {
                info[order.id] = [date: order.createdAt]
            }
        }
        return [ info: info ]
    }
    
    def orderDetails(Long id) {
        Order order = Order.get(id)
        
        def orderProducts = [:]
        
        OrderProduct.findAll().each({ op ->
            if(order == op.order){
                orderProducts[op.id] = [ orderProduct: op, order: op.order, product: op.product ]
            }
        })
        return [orderProducts: orderProducts, order: order]
    }
    
    def lost() {
    }
}