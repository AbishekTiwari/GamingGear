<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.gaminggear.model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eef0f4;
            margin: 0;
            padding: 20px;
        }
        details {
            background: white;
            border-radius: 6px;
            margin-bottom: 15px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            padding: 15px;
        }
        summary {
            font-weight: bold;
            font-size: 1.2em;
            cursor: pointer;
            padding: 10px;
            outline: none;
        }
        form {
            margin-top: 10px;
        }
        input, textarea, select {
            width: 100%;
            max-width: 400px;
            padding: 8px;
            margin-bottom: 10px;
        }
        input[type="submit"] {
            background-color: #3498db;
            color: white;
            border: none;
            cursor: pointer;
            padding: 10px 20px;
        }
        input[type="submit"]:hover {
            background-color: #2980b9;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
        }
        th {
            background-color: #f4f4f4;
        }
        .messages {
            margin: 20px 0;
        }
        .success {
            color: green;
            padding: 10px;
            background: #e8f5e9;
        }
        .error {
            color: red;
            padding: 10px;
            background: #ffebee;
        }
        
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
</head>
<body>
<nav class="navbar">
    <div class="logo">
        <img src="${pageContext.request.contextPath}/images/logo.png" width="80px" height="80px">
    </div>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/list-products">View Product Page</a></li>
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
            
        </a></li>
    </ul>
</nav>

<h1>Admin Dashboard</h1>

<div class="messages">
    <c:if test="${not empty sessionScope.message}">
        <div class="success">${sessionScope.message}</div>
        <c:remove var="message" scope="session"/>
    </c:if>
    <c:if test="${not empty sessionScope.error}">
        <div class="error">${sessionScope.error}</div>
        <c:remove var="error" scope="session"/>
    </c:if>
</div>

<!-- Add Product -->
<details>
    <summary>Add Product</summary>
    <form action="${pageContext.request.contextPath}/addProduct" method="post" enctype="multipart/form-data">
        <input type="text" name="productname" placeholder="Product Name" required>
        <input type="text" name="brandname" placeholder="Brand Name" required>
        <input type="number" step="0.01" name="price" placeholder="Price" required>
        <textarea name="productspecification" placeholder="Specification" required></textarea>
        <input type="date" name="releasedate" required>
        <input type="number" name="stock" placeholder="Stock quantity" required>
        <input type="file" name="image" accept="image/*" required>
        <input type="submit" value="Add Product">
    </form>
</details>

<!-- Update Product -->
<details>
    <summary>Update Product</summary>
    <form action="${pageContext.request.contextPath}/updateProduct" method="post">
        <select name="productid" required>
            <option value="">Select Product</option>
            <c:forEach var="product" items="${products}">
                <option value="${product.productId}">${product.productName}</option>
            </c:forEach>
        </select>
        <input type="text" name="productname" placeholder="New Name" required>
        <input type="text" name="brandname" placeholder="New Brand" required>
        <input type="number" step="0.01" name="price" placeholder="New Price" required>
        <textarea name="productspecification" placeholder="New Specification" required></textarea>
        <input type="date" name="releasedate" required>
        <input type="submit" value="Update Product">
    </form>
</details>

<!-- Delete Product -->
<details>
    <summary>Delete Product</summary>
    <form action="${pageContext.request.contextPath}/deleteProduct" method="post">
        <select name="productid" required>
            <option value="">Select Product</option>
            <c:forEach var="product" items="${products}">
                <option value="${product.productId}">${product.productName}</option>
            </c:forEach>
        </select>
        <input type="submit" value="Delete Product">
    </form>
</details>

<!-- Update Stock -->
<details>
    <summary>Update Stock</summary>
    <form action="${pageContext.request.contextPath}/updateStock" method="post">
        <select name="productid" required>
            <option value="">Select Product</option>
            <c:forEach var="product" items="${products}">
                <option value="${product.productId}">${product.productName}</option>
            </c:forEach>
        </select>
        <input type="number" name="newstock" placeholder="New Stock Quantity" required>
        <input type="submit" value="Update Stock">
    </form>
</details>

<!-- Example Sales Report -->
<details>
    <summary>Total Sales Report</summary>
    <table>
        <tr><th>Product</th><th>Total Sold</th><th>Total Revenue</th></tr>
        <tr><td>Example Product</td><td>25</td><td>$1,250.00</td></tr>
    </table>
</details>

<footer>
    <div class="footer-section">
        <h3>Products</h3>
        <ul>
            <li>gaming laptops</li>
            <li>ultra book</li>
            <li>2-1 convertible laptop</li>
            <li>mac book</li>
            <li>chrome book</li>
            <li>net book</li>
        </ul>
    </div>
    <div class="footer-section">
        <h3>Support</h3>
        <ul>
            <li>user queries</li>
            <li>user manual</li>
            <li>contact us</li>
        </ul>
    </div>
    <div class="footer-section">
        <h3>About us</h3>
        <ul>
            <li>contact us</li>
            <li>feedback</li>
        </ul>
    </div>
    <div class="social-media">
        <h3>Find us on</h3>
        <div class="social-icons">
            <a href="https://www.facebook.com">Facebook</a>
            <a href="https://www.instagram.com">Instagram</a>
            <a href="https://x.com/home?lang=en">Twitter</a>
        </div>
    </div>
</footer>
</body>
</html>
