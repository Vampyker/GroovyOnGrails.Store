package grailsstore

class AdminController {
    
    
    def beforeInterceptor = {
    }
    
    def index() { 
    }

    def orders() {
        if(checkAdmin()){
            Map info = [:]
            def orders = Order.findAll("from Order order by createdAt asc")
          
            orders.each { order ->
                info[order.id] = [date: order.createdAt, username: order.user.username, email: order.user.email]
            }
            return [ info: info ]
        }
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
    
    def orderDelete(String id) {
        if(checkAdmin()){
            if(!session.isDeleteOrder || session.deleteOrderId != id){
                session.isDeleteOrder = true
                session.deleteOrderId = id
                flash.message = "Click delete again to confirm!"
                redirect(controller: "admin", action:"orderDetails", id: id)
                return 
            }
            
            Order order = Order.get(id)
            OrderProduct.getAll().each({op ->
                if(op.order == order){
                    println OrderProduct.removeLink(order:order, product:op.product)
                }
            })
            
            order.delete(flush: true);
            
            session.isDeleteOrder = false
            session.deleteOrderId = 0
            
            redirect(controller: "admin", action:"orders")
        }
    }
    
    def setIsDeleteOrder() {
    }
    
    def addProduct() {
        

        if(checkAdmin()){
            def product = null
            if (params.containsKey('doit')) {
                def category = Category.get(params.category_id)
                product = new Product(
                    title: params.title.trim(), 
                    price: params.price, 
                    description: params.description, 
                    category: category)
                if(product.save(flush: true)){
                    redirect(controller: "home", action:"details", id:product.id)
                }
            }    
            def categories = Category.findAll("from Category order by name")    
            return [ categories: categories , product: product]
        }
    }
    
    def modifyProduct() {
        if(checkAdmin()){
            def product = Product.get(params.id)
            if(!product){
                redirect(controller: "home", action:"lost")
            }
            
            if (params.containsKey('doit')) {
                product.description = params.description
                product.price = Double.parseDouble(params.price)
                
                if(product.save(flush: true)){
                    redirect(controller: "home", action:"details", id:product.id)
                }
            }    
            else {
                params.description = product.description
                params.title = product.title
                params.price = product.price
                params.category = product.category.id
            }
            def categories = Category.findAll("from Category order by name")    
            return [ categories: categories , product: product]
        }
    }
    
    def checkAdmin() {
        if(!session.valid || !session.valid.is_admin) {
            redirect(controller: "home", action:"lost")
            return false
        }
        return true
    }
}
