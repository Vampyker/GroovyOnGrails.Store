import grailsstore.*
import java.util.Date as DateTime

class BootStrap {

  def init = { servletContext ->
    println "\n-----> members:"
    [  
      [username: "john", email: "arachnid@oracle.com"],
      [username: "kirsten", email: "buffalo@go.com"],
      [username: "bill", email: "digger@gmail.com"],
      [username: "mary", email: "elephant@wcupa.edu"],
      [username: "joan", email: "kangaroo@upenn.edu"],
      [username: "alice", email: "feline@yahoo.com"],
      [username: "carla", email: "badger@esu.edu"],
      [username: "dave", email: "warthog@temple.edu"],
    ].each {
      def user = new User( username: it.username, email: it.email, 
        password: it.username.encodeAsSHA1()
      )
      user.save(failOnError: true)
      println user
    }
    
    println "\n-----> admins:"
    [ 'carla', 'dave' ].each { username ->
      def user = User.findByUsername(username)
      user.is_admin = true
      user.save(failOnError: true)    
      println user
    }
    
    println "\n-----> categories:"
    [
      'video-audio',
      'copy-scan',
      'storage',
      'voice',
      'computer',
      'network',
      'calculator',
      'camera',
      'accessory',
      'printer',
    ].each {
      def category = new Category(name: it)
      category.save(failOnError: true)
      println category
    }
    
    String descripDirectory = "descriptions"
    String productInfoFile = "ProductInfo.txt"
    String productInfo
    
    try {
      productInfo = new File(productInfoFile).text
    } 
    catch(Exception ex) {
      println "Cannot read product info from $productInfoFile"
      return
    }
    
    println "\n-----> products:"
    productInfo.eachLine {
      String line = it.trim()
      if (line == "" || line.startsWith("#")) {
        return
      }
      def (categoryName, title, price, descripFilePrefix) = 
                                       line.split("\\|").collect { it.trim() }
      File descripFile = new File(
        descripDirectory 
        + System.getProperty("file.separator")
        + descripFilePrefix + ".html" 
      )
      String description = ""
      if (descripFile.exists()) {
        description = descripFile.text
      }
      else {
        println "**** missing description file: $descripFile"
      }
      def category = Category.findByName(categoryName)
      Product product = new Product(
        title: title, price: price, description: description, category: category
      )
      product.save(failOnError: true)
      println product
    }
    
    println "\n-----> orders:"
    
    Random rand = new Random()
    
    def rndDate = { m,n ->
      
      long msPerDay = 3600L * 24 * 1000
      
      new Date(new DateTime().time  // now
        // back between m and n days ago + forward up to 1 day
        - (m + rand.nextInt(n-m)) * msPerDay + rand.nextInt((int)msPerDay)) 
    }
    
    def orders = [
      [ username: 'alice', choices: [ [1,2], [5,3], ] ],
      [ username: 'bill',  choices: [ [22,1], [26,2], ] ],
      [ username: 'alice', choices: [ [3,4], [31,1], ] ],
      [ username: 'bill',  choices: [ [1,1], [3,3], [5,1], [6,2], ] ],
      [ username: 'dave',  choices: [ [22,3], [31,1], ] ],
    ]
    
    final int INTERVAL = 5
    def n = orders.size() * INTERVAL
    
    orders.each { userChoices ->
      def user = User.findByUsername(userChoices.username)
      def order = new Order(user: user, createdAt: rndDate(n, n+INTERVAL))
      n -= INTERVAL
      order.save(failOnError: true)
      println "===> order by $order.user at $order.createdAt"
      
      userChoices.choices.each { it ->
        def (prodNum, quantity) = it
        def product = Product.get( prodNum )
        println OrderProduct.setLink(
          order:order, product:product, quantity:quantity, price:product.price
        )
      }
    }
  }
  
  def destroy = {
  }
}
