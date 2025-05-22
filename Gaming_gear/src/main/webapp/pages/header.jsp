<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/style.css">
<style>

.navbar {
    position: relative;
}

.dropdown {
    position: relative;
}

.dropdown-menu {
    display: none;
    position: absolute;
    top: 100%;
    left: 0;
    background: #fff;
    min-width: 200px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
    z-index: 1000;
    padding: 0;
    margin: 0;
    list-style: none;
    border-radius: 4px;
}

.dropdown:hover .dropdown-menu {
    display: block;
}

.dropdown-menu li {
    padding: 0;
    margin: 0;
}

.dropdown-menu a {
    padding: 10px 20px;
    display: block;
    color: #333;
    text-decoration: none;
    transition: background-color 0.3s;
}

.dropdown-menu a:hover {
    background-color: #f5f5f5;
}

/* Adjust existing styles to accommodate dropdown */
.nav-links li {
    position: relative;
    padding: 15px 0;
}

.profile-link::after {
    content: "▼";
    font-size: 0.6em;
    margin-left: 5px;
    vertical-align: middle;
}
</style>
<style>
/* Add this CSS to your stylesheet */
.navbar {
    position: relative;
}

.dropdown {
    position: relative;
}

.dropdown-menu {
    display: none;
    position: absolute;
    top: 100%;
    left: 0;
    background: #fff;
    min-width: 200px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
    z-index: 1000;
    padding: 0;
    margin: 0;
    list-style: none;
    border-radius: 4px;
}

.dropdown:hover .dropdown-menu {
    display: block;
}

.dropdown-menu li {
    padding: 0;
    margin: 0;
}

.dropdown-menu a {
    padding: 10px 20px;
    display: block;
    color: #333;
    text-decoration: none;
    transition: background-color 0.3s;
}

.dropdown-menu a:hover {
    background-color: #f5f5f5;
}

/* Adjust existing styles to accommodate dropdown */
.nav-links li {
    position: relative;
    padding: 15px 0;
}

.profile-link::after {
    content: "▼";
    font-size: 0.6em;
    margin-left: 5px;
    vertical-align: middle;
}
</style>
<title>Insert title here</title>
</head>
<body>


<nav class="navbar">
    <div class="logo"><img src="<%= request.getContextPath() %>/images/logo.png" width="80px" height="80px"></div>
    <ul class="nav-links">
        <li><a class="active" href="<%= request.getContextPath() %>/index.jsp">Home</a></li>
        <li><a href="<%= request.getContextPath() %>/list-products">Product</a></li>
        
        
        <li><a class="active" href="<%= request.getContextPath() %>/pages/support.jsp">Support</a></li>
        <li><a class="active" href="<%= request.getContextPath() %>/pages/about.jsp">About</a></li>
        <li class="dropdown">
         <a class="active" href="<%= request.getContextPath() %>/pages/login.jsp" class="user-icon">
         </a>
         <!-- Dropdown Menu -->
            <ul class="dropdown-menu">
                <li><a href="<%= request.getContextPath() %>/pages/profile.jsp">Profile</a></li>
            </ul>
            <img src="<%= request.getContextPath() %>/images/user.png" alt="User" width="20px" height="20px">
        </li>
        <li><a class="active" href="<%= request.getContextPath() %>/pages/cart.jsp" class="icon">
            <img src="<%= request.getContextPath() %>/images/cart.png" alt="Cart" width="20px" height="20px">
        </a></li>
    </ul>
</nav>

<style>
/* Add this CSS to your stylesheet */
.navbar {
    position: relative;
}

.dropdown {
    position: relative;
}

.dropdown-menu {
    display: none;
    position: absolute;
    top: 100%;
    left: 0;
    background: #fff;
    min-width: 200px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
    z-index: 1000;
    padding: 0;
    margin: 0;
    list-style: none;
    border-radius: 4px;
}

.dropdown:hover .dropdown-menu {
    display: block;
}

.dropdown-menu li {
    padding: 0;
    margin: 0;
}

.dropdown-menu a {
    padding: 10px 20px;
    display: block;
    color: #333;
    text-decoration: none;
    transition: background-color 0.3s;
}

.dropdown-menu a:hover {
    background-color: #f5f5f5;
}

/* Adjust existing styles to accommodate dropdown */
.nav-links li {
    position: relative;
    padding: 15px 0;
}

.profile-link::after {
    content: "▼";
    font-size: 0.6em;
    margin-left: 5px;
    vertical-align: middle;
}
</style>
</body>
</html>