<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Gaming Gear Login</title>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="outside">
        <div class="container">
            <div class="form-wrapper">
                <div class="header">
                    <h1>Welcome to GAMING GEAR</h1>
                </div>
                <form action="<%= request.getContextPath() %>/login" method="post">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="Email" required>

                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Password" required>

                    

                    <a href="register.jsp" class="new"><u>Create Account</u></a>
                    <a href="#" class="forgot-password">Forgot your Password?</a>

                    <div class="input-group">
                        <label>
                            <input type="checkbox" name="remember-me"> Remember Me
                        </label>
                    </div>

                    <button type="submit" class="login-button">Log in</button>

                    <div class="divider">
                        <span>OR</span>
                    </div>

                    <button type="button" class="facebook-button">Continue with Facebook</button>
                    <button type="button" class="google-button">Continue with Google</button>
                </form>
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

    <jsp:include page="../pages/footer.jsp" />
</body>
</html>
