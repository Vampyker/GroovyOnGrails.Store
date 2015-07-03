<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><g:layoutTitle default="Grails Store"/></title>
    <link rel="stylesheet" href="${resource(dir:'css',file:'superfish.css')}" />  
    <link rel="stylesheet" href="${resource(dir:'css',file:'layout.css')}" />  
    <g:layoutHead/>
  </head>
  <body>
  <div id="container">
    <header>
      <g:img dir="images" file="header.png"/>
      <span class="caption">${session.valid?.username}</span>
    </header>
    <nav>
      <ul class="sf-menu nav_h">
        <g:render template="/links"  />
      </ul>
      <ul class="sf-menu nav_v">
        <li>
          <a href="#" id="vMenuHeader" class="no-action">
            <g:img dir="images" file="menu.png" />
          </a>
          <ul>
            <g:render template="/links"  />
          </ul>
        </li>
      </ul>
    </nav>
    <main>
      <g:layoutBody/>
    </main>
  </div><!-- #container -->
  <script type="text/javascript">window.onunload = function(){}</script>
  </body>
</html>
