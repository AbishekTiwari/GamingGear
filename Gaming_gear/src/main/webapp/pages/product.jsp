<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gaming Gear Products</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Fixed navbar CSS */
        .navbar {
            display: flex;
            padding-left: 100px;
            align-items: center;
            justify-content: space-between;
            background-color: black;
            padding: 10px 20px;
            position: sticky;
            top: 0;
            z-index: 1000; /* Add this */
            width: 100%;
        }

        .logo {
            color: white;
            font-size: 24px;
        }

        .nav-links {
            display: flex;
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .nav-links li {
            margin: 0 15px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: bold;
            position: relative;
        }

        .nav-links a:hover,
        .nav-links a:active {
            color: red;
            transition: 1s;
        }

        .nav-links a:active::after,
        .nav-links a:hover::after {
            content: "";
            width: 50%;
            height: 2px;
            background-color: red;
            position: absolute;
            bottom: -4px;
            left: 20px;
        }
        
        
        .product-card {
            transition: transform 0.3s, box-shadow 0.3s;
            border: none;
            border-radius: 15px;
            overflow: hidden;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .product-image {
            height: 250px;
            object-fit: contain;
            padding: 15px;
            background: #f8f9fa;
        }
        .price-tag {
            font-size: 1.5rem;
            color: #dc3545;
            font-weight: 700;
        }
        .specs-list {
            list-style: none;
            padding-left: 0;
            color: #6c757d;
        }
        .stock-status {
            font-size: 0.9rem;
        }
        .in-stock {
            color: #28a745;
        }
        .low-stock {
            color: #ffc107;
        }
        .brand-badge {
            background: rgba(0,0,0,0.1);
            color: #6c757d;
        }
        .quantity-controls {
            margin: 15px 0;
        }
        .quantity-controls input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .btn-custom {
            transition: all 0.3s ease;
        }
        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>

   
    <nav class="navbar">
        <div class="logo">
            <img src="<%= request.getContextPath() %>/images/logo.png" width="80px" height="80px">
        </div>
        <ul class="nav-links">
            <li><a class="active" href="<%= request.getContextPath() %>/index.jsp">Home</a></li>
            <li><a href="<%= request.getContextPath() %>/products" class="btn">Product</a></li>
            <li><a class="active" href="#">Community</a></li>
            <li><a class="active" href="#">Support</a></li>
            <li><a class="active" href="<%= request.getContextPath() %>/pages/about.html">About</a></li>
            <li>
                <a class="active" href="<%= request.getContextPath() %>/pages/login.jsp" class="user-icon">
                    <img src="<%= request.getContextPath() %>/images/user.png" alt="User" width="20px" height="20px">
                </a>
            </li>
            <li>
                <a class="active" href="<%= request.getContextPath() %>/pages/cart.jsp" class="icon">
                    <img src="<%= request.getContextPath() %>/images/cart.png" alt="Cart" width="20px" height="20px">
                </a>
            </li>
        </ul>
    </nav>

    
    <div class="container py-5">
        <h1 class="text-center mb-5">Explore Our Gaming Collection</h1>
        
        <c:choose>
            <c:when test="${not empty products}">
                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                    <c:forEach var="product" items="${products}">
                        <div class="col">
                            <div class="card product-card h-100">
                                <img src="${pageContext.request.contextPath}/images/${product.imagePath}" 
                                     class="card-img-top product-image" 
                                     alt="${product.productName}">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <span class="badge brand-badge">${product.brandName}</span>
                                        <span class="stock-status ${product.stock > 10 ? 'in-stock' : 'low-stock'}">
                                            ${product.stock > 10 ? 'In Stock' : 'Low Stock'}
                                        </span>
                                    </div>
                                    <h5 class="card-title">${product.productName}</h5>
                                    <p class="price-tag">$${product.price}</p>
                                    
                                    <div class="mb-3">
                                        <h6 class="text-muted">Specifications:</h6>
                                        <ul class="specs-list">
                                            <c:forTokens items="${product.productSpecification}" delims="," var="spec">
                                                <li>• ${spec}</li>
                                            </c:forTokens>
                                        </ul>
                                    </div>
                                    <!-- Quantity Controls -->
                                    <div class="quantity-controls">
                                        <label for="quantity-${product.productId}">Quantity:</label>
                                        <input type="number" 
                                               class="form-control" 
                                               id="quantity-${product.productId}" 
                                               name="quantity" 
                                               min="1" 
                                               max="${product.stock}" 
                                               value="1">
                                    </div>

                                    <!-- Action Buttons -->
                                    <div class="d-flex gap-2 mt-3">
                                        <button class="btn btn-outline-primary btn-custom w-50"
                                                onclick="addToCart('${product.productId}', document.getElementById('quantity-${product.productId}').value)">
                                            Add to Cart
                                        </button>
                                        <button class="btn btn-primary btn-custom w-50"
                                                onclick="buyNow('${product.productId}', document.getElementById('quantity-${product.productId}').value)">
                                            Buy Now
                                        </button>
                                    </div>

                                    <div class="mt-auto">
                                        <small class="text-muted">Released: ${product.releaseDate}</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-info text-center">
                    No products found in our inventory. Please check back later!
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>