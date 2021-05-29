
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration</title>
        <style>
            body{
                background-image: url("images/reg_bg.jpg");
            }
            
        </style>
        <%@include file="components/common_css_js.jsp"  %>
        
    </head>
    <body >
        
        <%@include file="components/navbar.jsp" %>
        <div class="container-fluid">
            
            
        <div class="row mt-5">
            <div class="col-md-4 offset-md-4">
                <div class="card">
                    <div class="card-body px-5">
                        
                            
                <h3 class="text-center my-3">Register Yourself Here </h3>
                
                <form action="RegisterServlet" method="POST">
                
                    <div class="form-group">
                        <label for="name">Full Name</label>
                        <input name="user_name" type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter your full name here." required/>
                    </div> 
                    
                    <div class="form-group">
                        <label for="email">Email ID</label>
                        <input name="user_email" type="email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="Enter email address." required/>
                   </div> 
                
                   <div class="form-group">
                        <label for="password">Password</label>
                        <input name="user_password" type="password" class="form-control" id="password" aria-describedby="emailHelp" placeholder="Type a strong password." required/>
                   </div> 
                
                    <div class="form-group">
                        <label for="phone">Contact Number</label>
                        <input name="user_phone" type="number" class="form-control" id="phone" aria-describedby="emailHelp" placeholder="Contact number with country code." required="/">
                    </div>
                
                    <div class="form-group">
                        <label for="phone">Address</label>
                        <textarea name="user_address" style="height: 100px;" class="form-control" placeholder="Enter your Address." required></textarea>
                    </div>
                    
                    <div class="container text-center">
                        <button type="submit" class="btn btn-outline-success">Register</button>
                        <button type="reset" class="btn btn-outline-warning">Reset</button>
                    </div>
                 </form>
            
                        
                    </div>
                </div>
            </div>
        </div> 
            
        </div>   
    </body>
</html>
