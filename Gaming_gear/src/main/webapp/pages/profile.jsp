<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gaming Gear Profile</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .profile-container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .profile-picture {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            margin: 0 auto 1rem;
            display: block;
            object-fit: cover;
        }
        .form-control[readonly] {
            background-color: #f8f9fa;
            border-color: #dee2e6;
        }
        .alert-message {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1000;
            animation: fadeOut 3s forwards;
            animation-delay: 2s;
        }
        @keyframes fadeOut {
            from {opacity: 1;}
            to {opacity: 0;}
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="logo">
            <img src="<%= request.getContextPath() %>/images/logo.png" width="80px" height="80px">
        </div>
        <ul class="nav-links">
            <li><a href="<%= request.getContextPath() %>/index.jsp">Home</a></li>
            <li><a href="<%= request.getContextPath() %>/products">Products</a></li>
            <li><a href="#">Community</a></li>
            <li><a href="#">Support</a></li>
            <li><a href="<%= request.getContextPath() %>/pages/about.html">About</a></li>
            <li><a href="<%= request.getContextPath() %>/profile"><img src="<%= request.getContextPath() %>/images/user.png" alt="Profile" width="20px" height="20px"></a></li>
            <li><a href="<%= request.getContextPath() %>/cart"><img src="<%= request.getContextPath() %>/images/cart.png" alt="Cart" width="20px" height="20px"></a></li>
            <li><a href="<%= request.getContextPath() %>/logout" class="btn btn-danger">Logout</a></li>
        </ul>
    </nav>

    <c:if test="${not empty message}">
        <div class="alert alert-${messageType} alert-message">
            ${message}
        </div>
    </c:if>

    <div class="profile-container">
    <form action="${pageContext.request.contextPath}/profile" method="post">
        <div class="text-center mb-4">
            <img src="${pageContext.request.contextPath}/images/user.png" 
                 class="profile-picture" 
                 alt="Profile">
            <h2>${user.fullName}</h2>
        </div>

        <!-- User ID -->
        <div class="mb-3">
            <label class="form-label">User ID</label>
            <input type="text" class="form-control" 
                   value="${user.userId}" readonly>
        </div>

        <!-- Email Field -->
        <div class="mb-3">
            <label class="form-label">Email address</label>
            <input type="email" class="form-control" name="email"
                   value="${user.email}" ${empty editMode ? 'readonly' : ''}>
        </div>

        <!-- Shipping Address (empty for now) -->
        <div class="mb-3">
            <label class="form-label">Shipping Address</label>
            <input type="text" class="form-control" 
                   value="${user.address}" readonly>
        </div>

        <!-- Password Fields (only shown when changing password) -->
        <c:if test="${not empty showPasswordFields}">
            <div class="mb-3">
                <label class="form-label">Current Password</label>
                <input type="password" class="form-control" 
                       name="currentPassword" required>
            </div>
            <div class="mb-3">
                <label class="form-label">New Password</label>
                <input type="password" class="form-control" 
                       name="newPassword" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Confirm Password</label>
                <input type="password" class="form-control" 
                       name="confirmPassword" required>
            </div>
        </c:if>

        <!-- Action Buttons -->
        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
            <c:choose>
                <c:when test="${not empty editMode}">
                    <button type="submit" name="action" value="save" 
                            class="btn btn-primary">Save Changes</button>
                    <button type="submit" name="action" value="cancel" 
                            class="btn btn-secondary">Cancel</button>
                </c:when>
                <c:otherwise>
                    <button type="submit" name="action" value="edit" 
                            class="btn btn-primary">Edit Profile</button>
                    <button type="submit" name="action" value="changePassword" 
                            class="btn btn-warning">Change Password</button>
                </c:otherwise>
            </c:choose>
        </div>
    </form>
</div>