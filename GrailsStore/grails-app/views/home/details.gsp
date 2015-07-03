<html>
  <head>
    <meta name="layout" content="my-main"/>
    <style type='text/css'>
      td, th {
      vertical-align: top;
      text-align: left;
      padding: 0 5px 5px 0;
      }
      .cell {
      display: inline-block;
      vertical-align: top;
      margin-bottom: 15px;
      }
      .cell  h4 { 
      margin: 0 0 5px 0;
      }
      .cell.left { 
      margin-right: 10px;
      padding-right: 5px;
      }
      .cell.right {
      border: solid 1px black;
      padding: 8px 15px;
      border-radius: 5px;
      }
      h3 { color: red; }
      h4.noDescrip { color: #00c }
      
      .control form,
      .control a { 
      display: inline-block;
      vertical-align: top;
      margin: 0 10px 5px 0;
      }
    </style>
  </head>
  <body>
    <h2>Product Details</h2>

    <div class='cell left'>
      <table>
        <tr><th>id:</th><td>${product.id}</td></tr>
        <tr><th>title:</th><td>${product.title}</td></tr>
        <tr><th>category:</th><td>${product.category.name}</td></tr>
        <tr><th>price:</th><td>$${product.price}</td></tr>
      </table>
    </div>

    <div class='cell right'>
      <g:form action="${params.action}" id="${product.id}">
        <b>Amount in Cart</b>
        <br />
        <input type="number" id="product_quantity" name="quantity" min="1" value="${session.cart.get(product.id) ? session.cart.get(product.id) : ""}" />
        <br />
        <button type='submit' name='setIt' >Change Amount</button>
        <br />
        <button type='submit' name='removeIt'>Remove Product from Cart</button>
        <g:if test="${session.valid}">
            <g:if test="${session.valid.is_admin}">
                <br>
                <g:link controller="admin" action="modifyProduct" id="${product.id}" >Modify Product(Admin Only)</g:link>
            </g:if>        
        </g:if>
      </g:form>
    </div>
    
    <div>
      <g:if test="${product.description}">
        ${raw(product.description)}
      </g:if>
      <g:else>
        <h4 class="noDescrip">NO DESCRIPTION AVAILABLE</h4>
      </g:else>
    </div>
    
   <h3>${flash.message}</h3>

  </body>
</html>
