
<%@page import="com.mycompany.reseller.helper.Desc"%>
<%@page import="com.mycompany.reseller.entities.Category"%>
<%@page import="com.mycompany.reseller.dao.CategoryDao"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.reseller.entities.Product"%>
<%@page import="com.mycompany.reseller.dao.ProductDao"%>
<%@page import="com.mycompany.reseller.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>GetItHere-Home</title>

        <%@include file="components/common_css_js.jsp"  %>


    </head>
    <body>

        <%@include file="components/navbar.jsp" %> 
        <%@include file="components/message.jsp" %>
        <div class="row mt-2 mx-4">
            
            <div class="container text-center mt-3">
                <h3 >Welcome to GetItHere !! Choose your favorites from our collection</h3>
            </div>
        </div>
        <div class="container-fluid">
            <div class="row mt-3 mx-2">
                <%  String cat = request.getParameter("category");
                    ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
                    List<Product> list = null;
                    if (cat == null || cat.trim().equals("all")) {
                        list = pdao.getAllProducts();
                    } else {
                        int cid = Integer.parseInt(cat.trim());
                        list = pdao.getProductById(cid);
                    }

                    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                    List<Category> clist = cdao.getCategories();
                %>
                <!--Show Categories-->
                <div class="col-md-2">
                    <div class="list-group mt-4">
                        <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">
                            All Products
                        </a>

                        <%  for (Category category : clist) {
                        %>
                        <a href="index.jsp?category=<%= category.getCategoryId()%>" class="list-group-item list-group-item-action"><%= category.getCategoryTitle()%></a>
                        <%
                            }
                        %>
                    </div>


                </div>
                <div class="col-md-10">  

                    <div class="row mt-4 " >
                        <div class="col-md-12">
                            <div class="card-columns">
                                <%
                                    for (Product product : list) {
                                %>


                                <div class="card product">
                                    <div class="container text-center">
                                        <img class="card-img-top" src="images\Products\<%= product.getProductPhoto() %>" style="max-height: 270px; max-width: 100%; width: auto" alt="Card image cap">
                                    </div>
                                    <div class="card-body" >
                                        <h5 class="card-title"><%= product.getProductName()%></h5>
                                        <p class="card-text"><%= Desc.descShort(product.getProductDescription())%></p>

                                    </div>
                                    <div class="card-footer">
                                        <button class="btn custom-bg text-white" onclick="addtocart(<%= product.getProductId()%>, '<%= product.getProductName()%>',<%= product.getPriceAfterDiscount()%>)" >Add to Cart</button>
                                        <button class="btn btn-light float-right">&#x20B9;<%= product.getPriceAfterDiscount()%>/- <span class="text-secondary discount-label"><%= product.getProductDiscount()%>% off</span></button>
                                    </div>
                                </div>

                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
             <%@include file="components/cart_modal.jsp" %>
             
    </body>
</html>
