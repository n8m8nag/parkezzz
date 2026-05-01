package com.typeshii.parkez;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/hello")
public class HelloServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String name = req.getParameter("name");
        if (name == null || name.trim().isEmpty()) {
            name = "World";
        }

        res.setContentType("text/html;charset=UTF-8");
        PrintWriter out = res.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("  <title>Hello!</title>");
        out.println("  <style>");
        out.println("    body { font-family: sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; background: #f0f4f8; }");
        out.println("    .card { background: white; padding: 3rem 4rem; border-radius: 12px; box-shadow: 0 4px 24px rgba(0,0,0,0.1); text-align: center; }");
        out.println("    h1 { color: #2d6a4f; font-size: 2.5rem; margin: 0 0 1rem; }");
        out.println("    p { color: #666; margin: 0 0 1.5rem; }");
        out.println("    a { color: #2d6a4f; text-decoration: none; font-weight: bold; }");
        out.println("  </style>");
        out.println("</head>");
        out.println("<body>");
        out.println("  <div class='card'>");
        out.println("    <h1>Hello, " + name + "!</h1>");
        out.println("    <p>Servlet is working.</p>");
        out.println("    <a href='/basic-webapp/'>Back to Home</a>");
        out.println("  </div>");
        out.println("</body>");
        out.println("</html>");
    }
}
