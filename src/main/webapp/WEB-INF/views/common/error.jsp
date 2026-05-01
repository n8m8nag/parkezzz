<%@ page language="java" contentType="text/html; charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error - ICK Smart Park</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            background: #0d1117;
            color: #fff;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
            gap: 16px;
        }
        h1 { font-size: 48px; color: #e74c3c; }
        p  { color: #888; font-size: 16px; }
        a  {
            margin-top: 10px;
            padding: 10px 24px;
            background: #2563eb;
            color: #fff;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
        }
        a:hover { background: #1d4ed8; }
    </style>
</head>
<body>
    <h1>500</h1>
    <p>Something went wrong on our end.</p>
    <a href="${pageContext.request.contextPath}/index.jsp">Go Home</a>
</body>
</html>