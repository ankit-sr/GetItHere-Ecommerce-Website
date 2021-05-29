<%

    User user = (User) session.getAttribute("current-user");
    if (user == null) {

        session.setAttribute("message", "You are not logged in !! Login first.");
        response.sendRedirect("login.jsp");
        return;
    }
%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout</title>
        <%@include file="components/common_css_js.jsp"  %>
        <style>
            body{
                background-image: url("images/Checkout.jpg");
            }
        </style>

    </head>
    <body>
        <%@include file="components/navbar.jsp" %>

        <div class="container">
            <div class="row mt-5">
                <div class="col-md-6">
                    <!--cart-->
                    <div class="card"> 
                        <div class="card-body">
                            <h3 class="text-center">Your Cart</h3>
                            <div class="cart-body mt-3"></div>
                        </div>  
                    </div>    
                </div>
                <div class="col-md-6">
                    <!--form details-->
                    <div class="card"> 
                        <div class="card-body">
                            <h3 class="text-center">Choose appropriate delivery details.</h3>
                            <form action="#" class="mt-5">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input value="<%= user.getUserEmail() %>" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Your Name</label>
                                    <input value="<%= user.getUserName()%>" type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter name">
                                </div>
                                <div class="form-group">
                                    <label for="phone">Contact Number</label>
                                    <input value="<%= user.getUserPhone()%>" name="user_phone" type="number" class="form-control" id="phone" aria-describedby="emailHelp" placeholder="Enter contact number" />
                                </div>
                                <div class="form-group">
                                    <label for="exampleFormControlTextarea1">Delivery Address</label>
                                    <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" placeholder="Enter your address"><%= user.getUserAddress()%></textarea>
                                </div>
                                <div class="container text-center">
                                    <a href="index.jsp" class="btn btn-outline-warning">Continue Shopping</a>
                                    <button class="btn btn-outline-success">Order now</button>
                                </div>
                            </form>
                        </div>  
                    </div> 
                </div>

            </div>

        </div>

        <%@include file="components/cart_modal.jsp" %>
    </body>
</html>
