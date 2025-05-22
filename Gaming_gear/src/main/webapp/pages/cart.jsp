<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shopping Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../pages/header.jsp" />

    <div class="container mt-5">
        <h2>Your Shopping Cart</h2>
        
        <c:choose>
            <c:when test="${empty cart}">
                <div class="alert alert-info">Your cart is empty</div>
            </c:when>
            <c:otherwise>
                <table class="table">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cart.values()}">
                            <tr>
                                <td>${item.product.productName}</td>
                                <td>$${item.product.price}</td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/cart" method="post">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="productId" value="${item.product.productId}">
                                        <input type="number" name="quantity" value="${item.quantity}" 
                                               min="1" max="${item.product.stock}" class="form-control">
                                        <button type="submit" class="btn btn-sm btn-primary mt-1">Update</button>
                                    </form>
                                </td>
                                <td>$${item.total}</td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/cart" method="post">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="productId" value="${item.product.productId}">
                                        <button type="submit" class="btn btn-danger">Remove</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <div class="text-end">
                    <h4>Total: $${totalAmount}</h4>
                    <a href="${pageContext.request.contextPath}/checkout" class="btn btn-success btn-lg">Proceed to Checkout</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <jsp:include page="../pages/footer.jsp" />
</body>
</html>