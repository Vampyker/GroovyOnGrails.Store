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
    <h2>Cart</h2>

    <g:if test="${info.size()}">
      <g:set var="totalCost" value="${0}" />
      <table>
        <tr>
          <th>product</th>
          <th>unit price</th>
          <th>quantity</th>
        </tr>
        <g:each in="${info}">
          <tr>
            <td>
              <g:link action="details" id="${it.key}">${it.value.title}</g:link>
            </td>
            <td>$${String.format("%.2f", it.value.price)}</td>
            <td>${it.value.quantity}</td>
            <g:set var="totalCost" value="${totalCost + 
                ((Number)(it.value.price ? it.value.price : 0 )* 
                 (it.value.quantity ? it.value.quantity : 0).toInteger())}" />
          </tr>
        </g:each>
      </table>
      Total: $ ${String.format("%.2f",totalCost)}
      <p>
        <g:if test="${session.valid}">
            <g:link action="placeOrder"><button>Place Order</button></g:link>
        </g:if>
        <g:link action="clearCart"><button>Clear Cart</button></g:link>
      </p>
    </g:if>
    <g:else>
      <h4>Empty Cart</h4>
    </g:else>
  </body>
</html>
