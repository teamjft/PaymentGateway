<h1>Welcome to<i style="color:#003087;"> Pay</i><i style="color:#009CDE;">Pal</i> Demo</h1>
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <ul class="nav navbar-nav" >
            <li class="active" ><g:link controller="home" action="index">Home</g:link></li>
            <li><g:link controller="home" action="savedCard">Manage Card</g:link></li>
            <li style="height: 52px;padding: 14px;">
                <form name="submitForm" method="POST" action="${createLink(controller: 'logout')}">
                    <a id="" HREF="javascript:document.submitForm.submit()">Logout</a>
                </form>
            </li>
        </ul>
    </div>
</nav>