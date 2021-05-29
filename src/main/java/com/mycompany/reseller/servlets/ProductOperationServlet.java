package com.mycompany.reseller.servlets;

import com.mycompany.reseller.dao.CategoryDao;
import com.mycompany.reseller.dao.ProductDao;
import com.mycompany.reseller.entities.Category;
import com.mycompany.reseller.entities.Product;
import com.mycompany.reseller.helper.FactoryProvider;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig 
public class ProductOperationServlet extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String op = request.getParameter("operation");
            if(op.trim().equals("addcategory"))
            {
//   Fetching Category Details
              String title = request.getParameter("categoryTitle");
              String description = request.getParameter("categoryDescription");
              
              Category category = new Category();
              category.setCategoryTitle(title);
              category.setCategoryDescription(description);
              
                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                
                int categoryId = categoryDao.saveCategory(category);
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "Category successfully added.");
                response.sendRedirect("admin.jsp");
                return;
            }
            else if(op.trim().equals("addproduct"))
            {
                //add product\
                String pName = request.getParameter("prodName");
                int pPrice = Integer.parseInt(request.getParameter("prodPrice"));
                int pDiscount = Integer.parseInt(request.getParameter("prodDiscount"));
                int pQuantity = Integer.parseInt(request.getParameter("prodQuantity"));
                String pDescription = request.getParameter("prodDescription");
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                Part part = request.getPart("prodPic");
                
                Product p = new Product();
                p.setProductName(pName);
                p.setProductPrice(pPrice);
                p.setProductDiscount(pDiscount);
                p.setProductQuantity(pQuantity);
                p.setProductDescription(pDescription);
                p.setProductPhoto(part.getSubmittedFileName());
                
                
                CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                Category category = cdao.getCatId(categoryId);
                
                p.setCategory(category);
                
                ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
                pdao.saveProduct(p);
                
                
                String path = request.getRealPath("images")+File.separator+"products"+File.separator+part.getSubmittedFileName();
                System.out.println(path);
       
                try {
                 
                FileOutputStream fos = new FileOutputStream(path);
                InputStream is = part.getInputStream();
                
                byte[] data = new byte[is.available()];
                is.read(data);
                fos.write(data);
                
                fos.close();
                
                } catch (Exception e) {
                    e.printStackTrace();
                }
                
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "Product Added Successfully");
                response.sendRedirect("admin.jsp");
                return;
                        
            }
            
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
