<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Page</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <style>
        .user-icons {
            text-align: right;
            background: black;
        }
    </style>
</head>
<body>

    <jsp:include page="/pages/header.jsp" />

    <div class="human">
        <div class="slider">
            <div class="slides">
                <input type="radio" name="radio-btn" id="radio1">
                <input type="radio" name="radio-btn" id="radio2">
                <input type="radio" name="radio-btn" id="radio3">
                <input type="radio" name="radio-btn" id="radio4">

                <div class="slide first">
                    <img src="<%= request.getContextPath() %>/images/lap3.jpg">
                </div>
                <div class="slide">
                    <img src="<%= request.getContextPath() %>/images/advert3.jpg">
                </div>
                <div class="slide">
                    <img src="<%= request.getContextPath() %>/images/lap1.png">
                </div>
                <div class="slide">
                    <img src="<%= request.getContextPath() %>/images/advert10.jpg">
                </div>

                <div class="navigation-auto">
                    <div class="auto-btn1"></div>
                    <div class="auto-btn2"></div>
                    <div class="auto-btn3"></div>
                    <div class="auto-btn4"></div>
                </div>
            </div>
            <div class="navigation-manual">
                <label for="radio1" class="manual-btn"></label>
                <label for="radio2" class="manual-btn"></label>
                <label for="radio3" class="manual-btn"></label>
                <label for="radio4" class="manual-btn"></label>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        var counter = 1;
        setInterval(function () {
            document.getElementById('radio' + counter).checked = true;
            counter++;
            if (counter > 4) {
                counter = 1;
            }
        }, 5000);
    </script>

    <section class="products">
        <h2><u>Browse the Product</u></h2>
        <div class="product-grid">
            <div class="product-item"><img src="<%= request.getContextPath() %>/images/p2.png" width="500px" height="700px" alt="Product 1"><p>MSI Modern 14 (2021)</p><a href="pages/p1.jsp">Learn more</a></div>
            <div class="product-item"><img src="<%= request.getContextPath() %>/images/p1.png" alt="Product 2"><p>Nitro 16 Gaming Laptop</p><a href="pages/p2.jsp">Learn more</a></div>
            <div class="product-item"><img src="<%= request.getContextPath() %>/images/p3.png" alt="Product 3"><p>ASUS VivoBook 15</p><a href="pages/p4.jsp">Learn more</a></div>
            <div class="product-item"><img src="<%= request.getContextPath() %>/images/p4.png" alt="Product 4"><p>Acer Aspire 5</p><a href="pages/p3.jsp">Learn more</a></div>
        </div>

        <h2><u>Insight And Innovation</u></h2>
        <div class="product-grid">
            <div class="product-item"><img src="<%= request.getContextPath() %>/images/p7.png" alt="Insight 1"><p>HP OMEN 16</p><a href="pages/p7.jsp">Learn more</a></div>
            <div class="product-item"><img src="<%= request.getContextPath() %>/images/p6.png" alt="Insight 2"><p>Acer Predator Helios Neo 16</p><a href="pages/p6.jsp">Learn more</a></div>
            <div class="product-item"><img src="<%= request.getContextPath() %>/images/p8.png" alt="Insight 3"><p>DELL XPS 13 9315</p><a href="pages/p8.jsp">Learn more</a></div>
            <div class="product-item"><img src="<%= request.getContextPath() %>/images/p9.png" alt="Insight 4"><p>ASUS ROG Zephyrus G14</p><a href="pages/p9.jsp">Learn more</a></div>
        </div>

        <h2>Featured Products</h2>
        <div class="product-grid">
            <div class="product-item"><img src="<%= request.getContextPath() %>/images/p6.png" alt="Insight 1"><p>Acer Predator Helios Neo 16</p><a href="pages/p6.jsp">Learn more</a></div>
            <div class="product-item"><img src="<%= request.getContextPath() %>/images/p7.png" alt="Insight 2"><p>HP OMEN 16</p><a href="pages/p7.jsp">Learn more</a></div>
            <div class="product-item"><img src="<%= request.getContextPath() %>/images/p9.png" alt="Insight 3"><p>ASUS ROG Zephyrus G14</p><a href="pages/p9.jsp">Learn more</a></div>
            <div class="product-item"><img src="<%= request.getContextPath() %>/images/p11.png" alt="Insight 4"><p>ASUS ROG Strix G16</p><a href="pages/p11.jsp">Learn more</a></div>
        </div>

        <h2>Top Selling</h2>
        <div class="product-grid">
            <div class="product-item"><img src="<%= request.getContextPath() %>/images/p1.png" alt="Insight 1"><p>Nitro 16 Gaming Laptop</p><a href="pages/p2.jsp">Learn more</a></div>
            <div class="product-item"><img src="<%= request.getContextPath() %>/images/p10.png" alt="Insight 2"><p>HP Victus 15</p><a href="pages/p10.jsp">Learn more</a></div>
            <div class="product-item"><img src="<%= request.getContextPath() %>/images/p6.png" alt="Insight 3"><p>Acer Predator Helios Neo 16</p><a href="pages/p6.jsp">Learn more</a></div>
            <div class="product-item"><img src="<%= request.getContextPath() %>/images/p3.png" alt="Insight 4"><p>Asus Vivobook 15</p><a href="pages/p4.jsp">Learn more</a></div>
        </div>
    </section>

    <footer>
        <div class="footer-section">
            <h3>Products</h3>
            <ul>
                <li>Gaming laptops</li>
                <li>Ultrabook</li>
                <li>2-in-1 convertible laptop</li>
                <li>MacBook</li>
                <li>Chromebook</li>
                <li>Netbook</li>
            </ul>
        </div>
        <div class="footer-section">
            <h3>Support</h3>
            <ul>
                <li>User queries</li>
                <li>User manual</li>
                <li>Contact us</li>
            </ul>
        </div>
        <div class="footer-section">
            <h3>About us</h3>
            <ul>
                <li>Contact us</li>
                <li>Feedback</li>
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
