<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/style.css">
    <style>
        .outside {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .input-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #444;
        }
        input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }
        .reg-container {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            box-sizing: border-box;
            padding: 0px;
            margin-bottom: 70px;
            margin-top: 70px;
        }
        .container-reg {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 50px;
        }
        .form-card {
            background-color: #ffffff;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        .register-button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 15px;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 18px;
            transition: background 0.3s;
            margin-bottom: 10px;
        }
        .register-button:hover {
            background-color: #0056b3;
        }
        .account {
            color: black;
            text-decoration: none;
            font-family: Arial, Helvetica, sans-serif;
        }
        input, select {
            margin-bottom: 15px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .input-group.success input {
            border-color: #09c372;
        }
        .input-group.error input {
            border-color: #ff3860;
        }
        .input-group .error {
            color: #ff3860;
            font-size: 9px;
            height: 13px;
        }
        .error-popup {
            display: none;
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px;
            background-color: #ffebee;
            border: 1px solid #ef9a9a;
            border-radius: 4px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            z-index: 1000;
        }

        .error-popup.show {
            display: block;
            animation: fadeIn 0.3s, fadeOut 0.3s 2.7s;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeOut {
            from { opacity: 1; transform: translateY(0); }
            to { opacity: 0; transform: translateY(-20px); }
        }
    </style>
    <title>Registration Form</title>
</head>
<body>
     <nav class="navbar">
        <div class="logo"><img src="../images/logo.png" width="80px" height="80px"></div>
        <ul class="nav-links">
            <li><a href="../index.html">Home</a></li>
            <li><a href="product.html">Product</a></li>
            <li><a href="#">Community</a></li>
            <li><a href="#">Support</a></li>
            <li><a href="about.html">About</a></li>
            <li><a href="login.html" class="user-icon"><img src="../images/user.png" alt="User" width="20px" height="20px"></a></li>
            <li> <a href="cart.html" class="icon"><img src="../images/cart.png" alt="Cart" width="20px" height="20px"></a></li> 
        </ul>
    </nav>
    <div class="reg-container">
        <div class="container-reg">
            <div class="form-card">
        <h1>Welcome to GAMING GEAR</h1>
      

        <!-- Registration Form -->
        <form action="${pageContext.request.contextPath}/register" method="post">

            <div class="input-group">
                        <label for="firstname">First Name</label>
                        <input type="text" id="firstname" name="firstname" placeholder="First Name" required>
                    </div>
                    <div class="input-group">
                        <label for="lastname">Last Name</label>
                        <input type="text" id="lastname" name="lastname" placeholder="Last Name" required>
                    </div>
                    <div class="input-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" placeholder="Username" required>
                    </div>
                    <div class="input-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" placeholder="Email" required>
                    </div>
                    <div class="input-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" placeholder="Password" required>
                    </div>
                    <div class="input-group">
                        <label for="password2">Retype Password</label>
                        <input type="password" id="password2" name="confirm-password" placeholder="Confirm Password" required>
                    </div>
                    <div class="input-group">
                        <label for="role">Role</label>
                        <select name="role" id="role">
                            <option value="user">User</option>
                            <option value="admin">Admin</option>
                        </select>
                    </div>
                    <button type="submit" class="register-button">REGISTER</button>
                </form>
                <a href="login.jsp" class="account"><u>Already have an account?</u></a>
            
</div>
<!-- Error Popup -->
            <div id="errorPopup" class="error-popup">
                <%= request.getParameter("error") != null ? request.getParameter("error") : "" %>
            </div>

            <script>
                // Auto show error if message exists
                window.onload = function () {
                    const popup = document.getElementById('errorPopup');
                    if (popup.textContent.trim() !== "") {
                        popup.classList.add('show');
                        setTimeout(() => popup.classList.remove('show'), 3000);
                    }
                };
            </script>
</div>
</div>
        
 
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
