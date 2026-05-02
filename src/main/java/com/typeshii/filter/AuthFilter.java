package com.typeshii.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

// blocks unauthenticated users from /user/* routes
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);

        String path = request.getServletPath() +
            (request.getPathInfo() != null ? request.getPathInfo() : "");

        // allow login and register through without session check
        if (path.equals("/user/login") || path.equals("/user/register")) {
            chain.doFilter(req, res);
            return;
        }

        boolean loggedIn = session != null && 
                           session.getAttribute("loggedInUser") != null;

        if (loggedIn) {
            chain.doFilter(req, res);
        } else {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}