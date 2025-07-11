<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Page</title>
    <link rel="stylesheet" href="../css/style.css">
    <Style>
        div.about{
           
           background-color:rgb(247, 245, 245);
           padding-left: 20px;
           padding-right:20px ;
           padding-bottom:20px ;
           padding-top:20px ;
           border-radius: 10px;
           border-color: rgb(10, 10, 10);
           box-shadow: 0 0 10px rgb(8, 8, 8);
           text-align: center;
           margin-left: 50px;
           margin-right: 50px;
           margin-top: 50px;
           margin-bottom: 50px;
          }
          p.about{
           font-size: large;
           font-family:'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
           color: rgb(87, 90, 93);
          }
          p.member_info{
           font-size:medium;
           font-family: Arial, Helvetica, sans-serif;
           color:rgb(87, 90, 93);
       
          }
       .member{
           margin-top: 80px;
           display: flex;
           justify-content: space-evenly;
           flex-wrap: wrap; /* Allow flex items to wrap to the next line if needed */
       }
       .b{
           display: inline-block;
           height: 460px;
           width : 330px;
           border-radius: 10px;
           border-color: rgb(10, 10, 10);
           box-shadow: 0 0 10px rgb(8, 8, 8);
           padding: 0px 20px;
           background-color:rgb(255, 255, 255);
           margin-left: 20px;
           text-align: center;
           cursor: pointer;
           transition: 0.5s;
           }
       .b:hover{
           scale: 1.1;
           }
       h2{
           text-align: center;
       }
        .member_photo{
          display: block;
          margin-left: auto;
          margin-right: auto;
          width: 50%;
          border-radius: 50%;
          padding-top: 20px;
        }
        .name{
           display: block;
           margin-left: auto;
           margin-right: auto;
           width: 50%;
           border-radius: 50%
        }
          /* Feedback form*/
        section{
           font-family: 'Arial', sans-serif;
           margin: 0;
           padding: 0;
           background-color:rgb(247, 245, 245);
           padding-left: 20px;
           padding-right:20px ;
           padding-bottom:20px ;
           padding-top:20px ;
           border-radius: 10px;
           border-color: rgb(10, 10, 10);
           box-shadow: 0 0 10px rgb(8, 8, 8);
           margin-top: 50px;
           background-color: #fff;
           padding: 20px;
           margin-bottom: 40px;
           
           
        }
        button {
               background-color: #313030;
               color: #fff;
               padding: 10px;
               border-radius: 4px;
               cursor: pointer;
           }
        label {
               margin-bottom: 8px;
           }
       form {
            display: flex;
           flex-direction: column;
        }
        input, textarea {
               margin-bottom: 16px;
               padding: 10px;
               border: 1px solid #ccc;
               border-radius: 4px;
           }
    </Style>
</head>
<body>
    <jsp:include page="../pages/header.jsp" />
        <div class="about">
            <h2>About Us </h2>
                <p class="about">Welcome to Gaming Gears, where we make printing super cool and easy! We have awesome Laptops from top brands that are perfect for everyone, whether you're a professional or a small business .
                We really care about quality, so all our printers go through superhero-level testing to make sure they're top-notch. And guess what? We give you a guarantee (like a superhero cape) with every printer, so you can feel super confident in your choice.
                    
                <br>Our team of friendly experts is always ready to help you find the perfect printer for your needs. Got questions? Need help setting up your new gadget? We're here for you!
                    
                    Oh, and we know how important your time is, so we've got a delivery service that brings your laptop straight to your door. Easy peasy!
                    
                  <br>  We believe everyone should have access to awesome gaming gears , so our prices are like super competitive and affordable for everyone.
                    
                    Thanks a bunch for choosing Gaming Gear as your laptops. Get ready for top-of-the-line laptops, super service, and a gaming like never before!
                </p>
           
            
        </div>
        <h2 > About The Member </h2>
        <div class="member">
            
            <div class="b"> 
            <img  class="member_photo" src="../images/rijan1.jpg">
           <h3 class="name"> Rijan Gubhaju </h3>
            <p class="member_info"> Meet Rijan Gubhaju, a diligent and enthusiastic undergraduate student currently pursuing a Bachelor's degree in Computing at Islington college. With a 
            passion for programming , he combine academic curiosity with a commitment to excellence. Rijan Gubhaju is eager to leverage classroom learning and hands-on experiences 
            to contribute effectively and make a positive impact in both academic 
            and extracurricular pursuits. With a focus on continuous growth and a proactive approach to challenges, he embody the spirit of a dedicated student on the path to success.</p>
         </div>
         <div class="b">
            <img  class="member_photo" src="../images/bishnu.jpg">
            <h3 class="name"> Rajiv Khadgi  </h3>
             <p class="member_info"> Introducing Rajiv Khadgi, a friendly and hardworking college student studying for a Bachelor's degree in Computing at Islington college. He really love learning about making new website and are excited to bring that passion to the projects and activities at our university. Rajiv Khadgi is always ready to learn new things and is eager to be a helpful and positive part of our academic community. We're lucky to have him on this learning journey with us!</p>
         </div >
         <div class= "b">
            <img  class="member_photo" src="../images/aakash1.jpg">
            <h3 class="name"> Aaryan Maharajan </h3>
             <p class="member_info"> Let me introduce you to Aaryan Maharajan, a dedicated student pursuing a Bachelor's degree in computing at Islington college . He are currently studying programming  and bring a strong enthusiasm for learning and exploring new ideas. Aaryan Maharajan is excited to be a part of the university community, always ready to tackle new challenges and make the most of his educational experience. With a friendly and open-minded approach, he are here to contribute positively to the vibrant atmosphere at our university.</p>
         </div>
         <div class= "b">
            <img  class="member_photo" src="../images/nikhil1.jpg">
            <h3 class="name"> Pranish Thapa </h3>
             <p class="member_info"> Allow me to present Pranish Thapa, an undergraduate student currently enrolled in Bsc(hons) computing at Islington college. With a keen interest in database, he embark on the exciting journey of higher education with enthusiasm and a hunger for knowledge. Pranish Thapa is thrilled to be part of the islington community, eager to absorb new concepts, engage in diverse experiences, and contribute to the collective learning environment. Inquisitive and approachable, helook forward to forging connections, embracing challenges, and making the most of the academic adventure ahead.</p>
         </div>

         <div class= "b">
            <img  class="member_photo" src="../images/nikhil1.jpg">
            <h3 class="name"> Abishek Tiwari </h3>
             <p class="member_info"> Allow me to present Abishek Tiwari, an undergraduate student currently enrolled in Bsc(hons) computing at Islington college. With a keen interest in database, he embark on the exciting journey of higher education with enthusiasm and a hunger for knowledge. Abishek Tiwari is thrilled to be part of the islington community, eager to absorb new concepts, engage in diverse experiences, and contribute to the collective learning environment. Inquisitive and approachable, helook forward to forging connections, embracing challenges, and making the most of the academic adventure ahead.</p>
         </div>

        </div>

        <section class="feeding-form">
            <h2>Share Your Opinions</h2>
            <p>Contribute to our feeding program by filling out the form below:</p>

            <form action="/submit_feeding_form" method="post">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>

                <label for="message">Message:</label>
                <textarea id="message" name="message" rows="4" required></textarea>

                <button type="submit">Submit</button>
            </form>
        </section>
        <jsp:include page="../pages/footer.jsp" />
    </body>
    </html>