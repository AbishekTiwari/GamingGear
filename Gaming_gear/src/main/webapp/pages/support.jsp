<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/style.css">
    <style>
.search-input {
    padding: 10px;
    width: 80%;
    max-width: 600px;
    border: none;
    border-radius: 5px;
    margin-top: 10px;
    text-align: center;
    padding: 20px;
    background: url('background.jpg') no-repeat center center/cover;
    align-items: center;
}

.self-help-links, .additional-resources {
    margin: 20px auto;
    padding: 20px;
    max-width: 800px;
}

.link-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
    gap: 10px;
    text-align: center;
}

.link-item {
    background-color: #222;
    border-radius: 5px;
    padding: 20px;
}

.resource-item {
    margin: 20px 0;
    text-align: center;
}

.resource-item img {
    width: 100%;
    height: auto;
    border-radius: 5px;
}

.learn-more {
    display: inline-block;
    margin-top: 10px;
    padding: 10px 20px;
    background-color: #007bff;
    color: #fff;
    border-radius: 5px;
    text-decoration: none;
}
    </style>
    <title>Gaming Gear Login</title>
</head>
<body>
    <jsp:include page="../pages/header.jsp" />
   <section>
    <div class="support-container">
        <div class="search">
                <h1> support</h1>
                <p>Enter your Serial Number or SNID. You can also type a question or keywords.</p>
                <input type="text" placeholder="What can we help you with?" class="search-input">
        </div>  
    </div>
   </section>
<jsp:include page="../pages/footer.jsp" />
</body>
</html>