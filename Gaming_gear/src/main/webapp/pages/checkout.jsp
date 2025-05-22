<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .summary-card {
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            border-radius: 8px;
        }
        .form-section {
            padding: 2rem;
            background: #f8f9fa;
            border-radius: 8px;
        }
    </style>
</head>
<body>
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

    <div class="container mt-5 mb-5">
        <h2 class="mb-4">Checkout</h2>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>

        <div class="row g-4">
            <div class="col-lg-8">
                <div class="form-section">
                    <form action="${pageContext.request.contextPath}/checkout" method="post">
                        <h4 class="mb-4">Payment Details</h4>
                        <div class="mb-3">
                            <label class="form-label">Card Number</label>
                            <input type="text" name="cardNumber" class="form-control" 
                                   placeholder="4242 4242 4242 4242" required>
                        </div>
                        
                        <div class="row g-3">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Expiration Date</label>
                                <input type="text" name="expDate" class="form-control" 
                                       placeholder="MM/YY" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">CVV</label>
                                <input type="text" name="cvv" class="form-control" 
                                       placeholder="123" required>
                            </div>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                            <button type="submit" class="btn btn-primary btn-lg w-100">Complete Purchase</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="summary-card h-100">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title mb-4">Order Summary</h5>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <span>Subtotal:</span>
                                    <span>$${subtotal}</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <span>Tax (10%):</span>
                                    <span>$${tax}</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center fw-bold fs-5">
                                    <span>Total:</span>
                                    <span>$${total}</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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