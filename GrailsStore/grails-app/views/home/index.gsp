<html>
  <head>
    <meta name="layout" content="my-main"/>
    <style type='text/css'>
      table {
      border-collapse: collapse;
      }
      th, td {
      text-align: left;
      padding: 3px 7px 3px 3px;
      }
      td:nth-child(3), th:nth-child(3) { 
      text-align: right; 
      }
      tr:nth-child(even) { background: #ddd; }
      tr:nth-child(odd) { background: #fff; }
      td a { 
      text-decoration: none;
      color: #a00;
      }
      td a:hover { 
      text-decoration: underline;
      color: #00c;
      }
      .categories {
      margin: 15px 0;
      }
    </style>
  </head>
  <body>
    <h2>Home</h2>

    <div class='categories'>
      <g:form action="${params.action}">
      <g:select name="category_id" from="${categories}" 
         noSelection="${['':'ALL']}"
         optionKey="id" optionValue="name" value="${session.category_id ? session.category_id : params.category_id}" />
      <button name="doit">Set Category</button>
      </g:form>
    </div>

    <table>
      <tr>
        <th><g:link action='setOrder' id="title">title</g:link></th>
        <th><g:link action='setOrder' id="category">category</g:link></th>
        <th><g:link action='setOrder' id="price">price</g:link></th>
        </tr>
      <g:each in="${products}" var="product">
        <tr>
          <td>
            <g:link action="details" id="${product.id}">${product.title}</g:link>
            </td>
            <td>${product.category.name}</td>
          <td>$${String.format("%.2f", product.price)}</td>
        </tr>
      </g:each>
    </table>
  </body>
</html>
