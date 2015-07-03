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
    <h2>Order Listing</h2>

    <g:if test="${info.size()}">
      <table>
        <tr>
          <th></th>
          <th></th>
        </tr>
        <g:each in="${info}">
          <tr>
            <td>
              <g:link action="orderDetails" id="${it.key}">Order # ${it.key} : ${it.value.date}</g:link>
            </td>
          </tr>
        </g:each>
      </table>
    </g:if>
    <g:else>
      <h4>No Order</h4>
    </g:else>
  </body>
</html>
