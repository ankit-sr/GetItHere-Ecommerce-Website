<%@page import="com.mycompany.reseller.dao.UserDao"%>
<%@page import="com.mycompany.reseller.entities.Product"%>
<%@page import="com.mycompany.reseller.dao.ProductDao"%>
<%@page import="com.mycompany.reseller.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.reseller.helper.FactoryProvider"%>
<%@page import="com.mycompany.reseller.dao.CategoryDao"%>
<%@page import="com.mycompany.reseller.entities.User"%>
<%

    User user = (User) session.getAttribute("current-user");
    if (user == null) {

        session.setAttribute("message", "You are not logged in !! Login first.");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (user.getUserType().equals("customer")) {
            session.setAttribute("message", "You are not an admin !!");
            response.sendRedirect("index.jsp");
        }
    }


%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin</title>
        <%@include file="components\common_css_js.jsp" %>
        <style>
            body{
                background-image: url("images/admin-bg.jpg");
            }   
        </style>
    </head>
    <body>
        <%@include file="components\navbar.jsp" %>
        <%@include file="components\message.jsp" %>
        <%
            ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
            List<Product> plist =  pdao.getAllProducts();
        %>
        <!--product category-->
        <%
            CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
            List<Category> list = cdao.getCategories();
        %>
        <%
            UserDao udao = new UserDao(FactoryProvider.getFactory());
            List<User> uList = udao.getUsers();
        
        %>

        <div class="container ankit">
            <div class="row mt-5">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="height: 150px" class="img-fluid" src="images\group.png"/>
                            </div>
                            <h2><%= uList.size()%></h2>
                            <h2 class="text-uppercase text-muted">Users</h2>
                        </div>      
                    </div>  
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="height: 150px" class="img-fluid " src="images\list.png"/>
                            </div>
                            <h2><%= list.size()%></h2>
                            <h2 class="text-uppercase text-muted">Categories</h2>
                        </div>      
                    </div> 
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="height: 150px" class="img-fluid" src="images\detail.png"/>
                            </div>
                            <h2><%= plist.size()%></h2>
                            <h2 class="text-uppercase text-muted">Products</h2>
                        </div>      
                    </div>  
                </div>
            </div>

            <div class="row mt-5">
                <div class="col-md-6">
                    <div class="card" data-toggle="modal" data-target="#add-category">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="height: 140px" class="img-fluid" src="images\category.png">
                            </div>
                            <h2 class="text-uppercase text-muted mt-3">Add Category</h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card" data-toggle="modal" data-target="#add-product">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="height: 150px" class="img-fluid" src="images\shopping-cart.png">
                            </div> 
                            <h2 class="text-uppercase text-muted mt-2">Add Product</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--category form-->

        <!-- Modal -->
        <div class="modal fade" id="add-category" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLongTitle">Fill Category Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post">
                            <input type="hidden" name="operation" value="addcategory">
                            <div class="form-group">
                                <input type="text" class="form-control" name="categoryTitle" placeholder="Enter category title" required /> 
                            </div>
                            <div class="form-group">
                                <textarea style="height:100px" class="form-control" name="categoryDescription" placeholder="Enter category description" required></textarea>
                            </div>
                            <div class="container text-center">
                                <button class="btn btn-outline-success">Add Category</button>
                                <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!--end category form-->

        <!--Product Form-->
        
        <!-- Modal -->
        <div class="modal fade" id="add-product" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Product Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method ="post" enctype="multipart/form-data">
                            <input type="hidden" name="operation" value="addproduct"/>
                            <div class="form-group">
                                <input type ="text" class="form-control" name="prodName" placeholder="Enter product name " required/>
                            </div>
                            
                            
                            
                            <div class="form-group">
                                <select name ="categoryId" class="form-control">
                                    <%
                                        for(Category c:list){
                                    %>
                                    <option value ="<%= c.getCategoryId() %>"><%= c.getCategoryTitle() %></option>
                                        
                                    <%
                                        }
                                    %>
                                    
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <input type ="number" class="form-control" name="prodPrice" placeholder="Enter product price " required/>
                            </div>
                            <div class="form-group">
                                <input type ="number" class="form-control" name="prodDiscount" placeholder="Enter product discount " required/>
                            </div>
                            <div class="form-group">
                                <input type ="number" class="form-control" name="prodQuantity" placeholder="Enter product quantity " required/>
                            </div>
                            <div class="form-group">
                                <textarea style="height: 100px" class="form-control" name="prodDescription" placeholder="Enter product details here" required></textarea>
                            </div>
                            
                            <div class="form-group">
                                <label for="prodPic"><strong>Add picture for this product</strong></label><br>
                                <input type="file" id="prodPic" name="prodPic" required/>
                            </div>
                            
                            <div class="container text-center">
                                <button type="submit" class="btn btn-outline-success">Add Product</button>
                                <button type="reset" class="btn btn-outline-secondary" data-dismiss="modal">Close</button>
                            </div>
                            
                        </form>
                    </div>
                    
                </div>
            </div>
        </div>

        <!--End Product Form-->
          <%@include file="components/cart_modal.jsp" %>
    </body>
</html>
