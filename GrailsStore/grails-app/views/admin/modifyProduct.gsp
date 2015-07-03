<html>
  <head>
    <meta name="layout" content="my-main"/>
    <link rel="stylesheet" href="${resource(dir:'css',file:'error-display.css')}" />  
    <style type='text/css'>
      table {
      border-collapse: collapse;
      }
      th {
      text-align: left;
      padding: 6px;
      }
      td {
      padding: 6px;
      }
      td:nth-child(2), th:nth-child(2) { 
      text-align: right; 
      }
      td:nth-child(3), th:nth-child(3) { 
      text-align: center; 
      }
      .label {
      float: left; 
      width: 100px;
      text-align: left;
      vertical-align: top;
      }
      .value {
      float: left; 
      width: 500px;
      text-align: left;
      }
    </style>
  </head>
  <body>
    <h2>Modify Product</h2>
    <g:form class="value" action="${params.action}" id="${product.id}">
    <table>
      <tr>
        <td>
            <div class="label"> 
                Id:
            </div>
        </td>
        <td>
            <div class="value">
                ${product.id}
            </div>
        </td>
      </tr>
      <tr>
        <td>
            <div class="label"> 
                title:
            </div>
        </td>
        <td>
            <div class="value">
                ${params.title}
            </div>
        </td>
      </tr>
      <tr>
        <td>
            <div class="label"> 
                category:
            </div>
        </td>
        <td>
            <div class="value">
                <g:select name="category_id" from="${categories}" 
                    optionKey="id" optionValue="name" value="${params.category}" disabled="true" />
            </div>
        </td>
      </tr>
      <tr>
        <td>
            <div class="label"> 
                price:
            </div>
        </td>
        <td>
            <div style="display: inline-block; float: left; width: 500px; text-align: left; white-space: nowrap;">
                <div style="display: inline-block; width: 10px; white-space: nowrap;">$</div>
                <div style="display: inline-block; white-space: nowrap;"><input style="display: inline-block; white-space: nowrap; width: 200px; text-align: left;" type=number step=0.01 name="price" value="${params.price}" /></div>
                <div class='errors'>
                    <g:renderErrors bean="${product}" as="list" field="price"/>
                </div>
            </div>
        </td>
      </tr>
      <tr>
        <td style="vertical-align: top;">
            <div class="label" > 
                description:
            </div>
        </td>
        <td>
            <div style="display: inline-block; float: left; width: 500px; text-align: left; white-space: nowrap;">
                <textarea style="float: left; width: 500px; text-align: left;" rows="20" cols="60" name="description" >${params.description}</textarea>
                <div class='errors'>
                    <g:renderErrors bean="${product}" as="list" field="description"/>
                </div>
            </div>
        </td>
      </tr>
      <tr>
        <td></td>
        <td>
            <div class="value">
                <button type="submit" name="doit">Update</button>
            </div>
        </td>
      </tr>
    </table>
    </g:form>
  </body>
</html>
