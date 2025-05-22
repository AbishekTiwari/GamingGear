<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gaming Gear Profile</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <style>
        .profile-container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            font-family: 'Arial', sans-serif;
        }

        .profile-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .profile-picture {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            margin: 0 auto 1rem;
            object-fit: cover;
            border: 3px solid #2c3e50;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            color: #2c3e50;
            font-weight: 600;
        }

        .form-input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #bdc3c7;
            border-radius: 4px;
            font-size: 1rem;
            background-color: #f8f9fa;
            color: #2c3e50;
        }

        .button-group {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 2rem;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-secondary {
            background-color: #95a5a6;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #7f8c8d;
        }

        .btn-primary {
            background-color: #3498db;
            color: white;
        }

        .btn-primary:hover {
            background-color: #2980b9;
        }

        h2 {
            color: #2c3e50;
            margin: 0.5rem 0;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="logo">
            <img src="<%= request.getContextPath() %>/images/logo.png" width="80px" height="80px">
        </div>
        <ul class="nav-links">
            <li><a href="../index.jsp">Home</a></li>
            <li><a href="<%= request.getContextPath() %>/list-products">Product</a></li>
            
            <li><a href="support.jsp">Support</a></li>
            <li><a href="about.jsp">About</a></li>
            <li><a href="login.jsp" class="user-icon"><img src="../images/user.png" alt="User" width="20px" height="20px"></a></li>
            <li><a href="cart.jsp" class="icon"><img src="../images/cart.png" alt="Cart" width="20px" height="20px"></a></li> 
            <li><a href="<%= request.getContextPath() %>/logout">Logout</a></li>
        </ul>
    </nav>

    <div class="profile-container">
        <div class="profile-header">
            <img src="<%= request.getContextPath() %>/<%= session.getAttribute("profilePicture") != null 
    ? session.getAttribute("profilePicture") 
    : "images/user.png" %>" 
    class="profile-picture" alt="Profile">

            <h2><%= session.getAttribute("username") %></h2>
        </div>

        <div class="form-group">
            <label class="form-label">User ID</label>
            <input type="text" class="form-input" 
                   value="<%= session.getAttribute("userid") %>" readonly>
        </div>

        <div class="form-group">
            <label class="form-label">First Name</label>
            <input type="text" class="form-input" 
                   value="<%= session.getAttribute("firstname") %>" readonly>
        </div>

        <div class="form-group">
            <label class="form-label">Last Name</label>
            <input type="text" class="form-input" 
                   value="<%= session.getAttribute("lastname") %>" readonly>
        </div>

        <div class="form-group">
            <label class="form-label">Email address</label>
            <input type="email" class="form-input" 
                   value="<%= session.getAttribute("email") %>" readonly>
        </div>

        <div class="form-group">
            <label class="form-label">Role</label>
            <input type="text" class="form-input" 
                   value="<%= session.getAttribute("role") %>" readonly>
        </div>

        <div class="button-group">
            <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-secondary">Back</a>
            <a href="<%= request.getContextPath() %>/edit-profile" class="btn btn-primary">Edit Profile</a>

        </div>
    </div>
    <jsp:include page="../pages/footer.jsp" />
</body>
</html>