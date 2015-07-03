<html>
  <head>
    <meta name="layout" content="my-main"/>
    <style type='text/css'>
      table {
      border-collapse: collapse;
      }
      th {
      text-align: left;
      padding: 6px;
      }
      td {
      border: solid 1px black;
      padding: 6px;
      }
      td:nth-child(2), th:nth-child(2) { 
      text-align: right; 
      }
      td:nth-child(3), th:nth-child(3) { 
      text-align: center; 
      }
    </style>
  </head>
  <body>
    <g:if test="${orderProducts.size()}" >
      <h2>Admin Order #${order.id} Details</h2>
      <g:set var="totalCost" value="${0}" />
      <table>
        <tr>
          <th>product</th>
          <th>unit price</th>
          <th>quantity</th>
        </tr>
        <g:each in="${orderProducts}">
          <tr>
            <td>
            ${it.value.product.title}
            
            </td>
            <td>$${String.format("%.2f", it.value.orderProduct.price)}</td>
            <td>${it.value.orderProduct.quantity}</td>
            <g:set var="totalCost" value="${totalCost + 
                ((Number)(it.value.orderProduct.price ? it.value.orderProduct.price : 0 )* 
                 (it.value.orderProduct.quantity ? it.value.orderProduct.quantity : 0).toInteger())}" />
          </tr>
        </g:each>
      </table>
      Total: $ ${String.format("%.2f",totalCost)}
      <br>
      <br>
      <g:form action="orderDelete" id="${order.id}">
        <button>Delete Order(process)</button>
        <h3>${flash.message}</h3>
      </g:form>
    </g:if>
    <g:else>
      <h4>No Order</h4>
    </g:else>
  </body>
</html>
