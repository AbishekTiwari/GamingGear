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
        /* Add to existing navbar CSS */
.search-form {
    flex-grow: 1;
    max-width: 500px;
    margin: 0 20px;
}

@media (max-width: 768px) {
    .navbar {
        flex-wrap: wrap;
        padding: 10px;
    }
    .search-form {
        order: 3;
        width: 100%;
        margin: 10px 0;
    }
    .nav-links {
        order: 2;
    }
}
    </style>
</head>
<body>

   
    <jsp:include page="../pages/header.jsp" />
<!-- Add Search Form -->
    <form class="d-flex search-form" action="<%= request.getContextPath() %>/list-products" method="GET">
        <input class="form-control me-2" 
               type="search" 
               name="query"
               placeholder="Search products..." 
               aria-label="Search"
               value="${searchQuery}">
        <button class="btn btn-outline-danger" type="submit">Search</button>
    </form>
    
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
                                    

                                    <!-- Action Buttons -->
                                    <!-- In product.jsp, modify the action buttons section -->
<div class="d-flex gap-2 mt-3">
    <form action="${pageContext.request.contextPath}/cart" method="post" style="width: 50%">
        <input type="hidden" name="action" value="add">
        <input type="hidden" name="productId" value="${product.productId}">
        <input type="number" name="quantity" 
               value="1" min="1" max="${product.stock}"
               class="form-control mb-2">
        <button type="submit" class="btn btn-outline-primary btn-custom w-100">
            Add to Cart
        </button>
    </form>
    
    <form action="${pageContext.request.contextPath}/checkout" method="post" style="width: 50%">
        <input type="hidden" name="productId" value="${product.productId}">
        <input type="hidden" name="quantity" 
               value="1" class="form-control">
        <button type="submit" class="btn btn-primary btn-custom w-100">
            Buy Now
        </button>
    </form>
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
    <script>
function validateSearch() {
    const searchInput = document.querySelector('input[name="query"]');
    if (searchInput.value.trim().length < 2) {
        alert('Please enter at least 2 characters for search');
        return false;
    }
    return true;
}

// Attach validation to form
document.querySelector('.search-form').addEventListener('submit', validateSearch);
</script>

</body>
</html>