<html>
  <head>
    <meta name="layout" content="my-main"/>
    <link rel="stylesheet" href="${resource(dir:'css',file:'form-table.css')}" />  
    <style type='text/css'>
    </style>
  </head>
  <body>
    <h2>Login</h2>
    <g:form action="validate">
      <table>
        <tr><td>username:</td>
          <td>
            <input type='text' name="username" autofocus
                   value="${flash.username}"/>
          </td>
        </tr>
        <tr><td>password:</td>
          <td>
            <input type='password' name="password" />
          </td>
        </tr>
        <tr><td></td>
          <td><button type='submit' name='doit'>Login</button></td>
        </tr>
      </table>
      <h3>${flash.message}</h3>
    </g:form>
  </body>
</html>
