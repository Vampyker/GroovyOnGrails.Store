<li><g:link controller="home">Home</g:link></li>
<li><g:link controller="home" action="cart">Cart</g:link></li>

<g:if test="${session.valid}">
    <li><g:link controller="home" action="orders">My Orders</g:link></li>
    <g:if test="${session.valid.is_admin}">
        <li>
            <a href="#" class="no-action">Admin</a>
            <ul>
                <li><g:link controller="admin" action="orders">View All Orders</g:link></li>
                <li><g:link controller="admin" action="addProduct">Add Product</g:link></li>
            </ul>
        </li>

    </g:if>        
    <li><g:link controller="authenticate" action="logout">Logout</g:link></li>
</g:if>
<g:else>
    <li><g:link controller="authenticate" action="login">Login</g:link></li>
</g:else>
<g:if test="${session.valid}">
    <g:if test="${session.valid.is_admin}">
        <li
        style='position:absolute;right:0'
        ><a href="#" class="no-action">Scaffold</a>
        <ul>
          <li><g:link controller="userScaffold">User</g:link></li>
          <li><g:link controller="categoryScaffold">Category</g:link></li>
          <li><g:link controller="productScaffold">Product</g:link></li>
          <li><g:link controller="orderScaffold">Order</g:link></li>
          <li><g:link controller="orderProductScaffold">OrderProduct</g:link></li>
        </ul>
    </g:if>        
</g:if>        
</li>
