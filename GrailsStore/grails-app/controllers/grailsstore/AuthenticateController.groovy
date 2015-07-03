package grailsstore

class AuthenticateController {

  def beforeInterceptor = {
    response.setHeader('Cache-Control', 'no-cache, no-store, max-age=0, must-revalidate')
  }

  def login() { 
    if (session.valid) {
      redirect(controller: "home")
    }
  }
  
  def validate() {
    def username = params.username.trim()
    def password = params.password.encodeAsSHA1()
    def user = User.findByUsernameAndPassword(username,password)
    if (user) {
      session.valid = [id: user.id, username: user.username, is_admin: user.is_admin]
      redirect(controller: "home")
    }
    else {
      flash.message = "Authentication Failure"
      flash.username = params.username
      redirect(action: "login")
    }
  }
    
  def logout() {
    session.valid = null
    session.cart = null;
    redirect(controller: "home")
  }
}
