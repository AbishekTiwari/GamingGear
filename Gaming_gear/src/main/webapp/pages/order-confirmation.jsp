<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../pages/header.jsp" />

    <div class="container mt-5">
        <div class="card text-center">
            <div class="card-body">
                <h2 class="card-title">Thank you for your order!</h2>
                <p class="card-text">Your order ID is: ${param.id}</p>
                <p>We've sent a confirmation email to your registered address.</p>
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Continue Shopping</a>
            </div>
        </div>
    </div>
</body>
<jsp:include page="../pages/footer.jsp" />
</html>