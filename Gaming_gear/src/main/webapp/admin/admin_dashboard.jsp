<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.gaminggear.model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    
<style>
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
    </style>
</head>
<body>
<nav class="navbar">
        <div class="logo"><img src="${pageContext.request.contextPath}/images/logo.png" width="80px" height="80px"></div>
        <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/index.html">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/products" class="btn">View Product Page</a></li>
            <li><a href="#">Community</a></li>
            <li><a href="#">Support</a></li>
            <li><a href="about.html">About</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/login.jsp" class="user-icon"><img src="${pageContext.request.contextPath}/images/user.png" alt="User" width="20px" height="20px"></a></li>
            <li> <a href="${pageContext.request.contextPath}/pages/cart.html" class="icon"><img src="${pageContext.request.contextPath}/images/cart.png" alt="Cart" width="20px" height="20px"></a></li> 
        </ul>
    </nav>
<h1>Admin Dashboard</h1>
<div class="messages">
    <% if (request.getSession().getAttribute("message") != null) { %>
        <div class="success"><%= request.getSession().getAttribute("message") %></div>
        <% request.getSession().removeAttribute("message"); %>
    <% } %>
    <% if (request.getSession().getAttribute("error") != null) { %>
        <div class="error"><%= request.getSession().getAttribute("error") %></div>
        <% request.getSession().removeAttribute("error"); %>
    <% } %>
</div>
<!-- Add Product -->
<details>
    <summary>Add Product</summary>
    <form action="addProduct" method="post" enctype="multipart/form-data">
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
    <form action="updateProduct" method="post">
        <select name="productid" required>
            <option value="">Select Product</option>
            <%
                List<Product> list = (List<Product>) request.getAttribute("productList");
                if (list != null) {
                    for (Product p : list) {
            %>
                <option value="<%= p.getProductId() %>"><%= p.getProductName() %></option>
            <%
                    }
                }
            %>
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
    <form action="deleteProduct" method="post">
        <select name="productid" required>
            <option value="">Select Product</option>
            <%
                if (list != null) {
                    for (Product p : list) {
            %>
                <option value="<%= p.getProductId() %>"><%= p.getProductName() %></option>
            <%
                    }
                }
            %>
        </select>
        <input type="submit" value="Delete Product">
    </form>
</details>

<!-- Update Stock -->
<details>
    <summary>Update Stock</summary>
    <form action="updateStock" method="post">
        <select name="productid" required>
            <option value="">Select Product</option>
            <%
                if (list != null) {
                    for (Product p : list) {
            %>
                <option value="<%= p.getProductId() %>"><%= p.getProductName() %></option>
            <%
                    }
                }
            %>
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
