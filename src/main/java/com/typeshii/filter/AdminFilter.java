package com.typeshii.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

// blocks non admins from /admin/* routes
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);

        String path = request.getServletPath() + 
            (request.getPathInfo() != null ? request.getPathInfo() : "");

        // allow login request through without session check
        if (path.equals("/admin/login")) {
            chain.doFilter(req, res);
            return;
        }

        boolean isAdmin = session != null && 
                          session.getAttribute("loggedInAdmin") != null;

        if (isAdmin) {
            chain.doFilter(req, res);
        } else {
            response.sendRedirect(request.getContextPath() + "/adminLogin.jsp");
        }
    }
}