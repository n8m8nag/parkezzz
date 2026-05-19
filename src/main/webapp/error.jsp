<%@ page language="java" contentType="text/html; charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>500 - ParkEZz</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            background: #0d1117;
            width: 100vw;
            height: 100vh;
            overflow: hidden;
            position: relative;
            font-family: Arial, sans-serif;
        }

        .scene {
            width: 100%;
            height: 100%;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* the 5 */
        .num-five {
            position: absolute;
            height: 58vh;
            top: 40%;
            left: 25%;
            transform: translateY(-50%);
            mix-blend-mode: screen;
            opacity: 0.82;
            pointer-events: none;
        }

        /* first 0 — left portrait, normal */
        .zero-left {
            position: absolute;
            height: 50vh;
            top: 40%;
            left: 40%;
            transform: translateY(-50%) ;
            mix-blend-mode: screen;
            opacity: 0.88;
            pointer-events: none;
        }

        /* second 0 — right portrait, flipped to face left one */
        .zero-right {
            position: absolute;
            height: 50vh;
            top: 40%;
            right: 30%;
            transform: translateY(-50%);
            mix-blend-mode: screen;
            opacity: 0.88;
            pointer-events: none;
        }

        /* bottom ui */
        .ui {
            position: absolute;
            bottom: 99px;
            left: 50%;
            transform: translateX(-50%);
            text-align: center;
            z-index: 10;
            white-space: nowrap;
        }
        .ui p {
            color: #3d4556;
            font-size: 21px;
            letter-spacing: 4px;
            text-transform: uppercase;
            margin-bottom: 55px;
        }
        .ui a {
            display: inline-block;
            color: #4d8ef0;
            text-decoration: none;
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 3px;
            text-transform: uppercase;
            padding: 12px 32px;
            border: 1px solid rgba(77,142,240,0.4);
            border-radius: 4px;
            background: rgba(77,142,240,0.06);
            backdrop-filter: blur(4px);
            transition: background 0.25s, border-color 0.25s, color 0.25s, box-shadow 0.25s;
        }
        .ui a:hover {
            color: #fff;
            background: rgba(77,142,240,0.18);
            border-color: #4d8ef0;
            box-shadow: 0 0 18px rgba(77,142,240,0.3);
        }
    </style>
</head>
<body>

    <div class="scene">
        <img src="${pageContext.request.contextPath}/images/5.png"       class="num-five"   alt="5">
        <img src="${pageContext.request.contextPath}/images/0.png" class="zero-left"  alt="0">
        <img src="${pageContext.request.contextPath}/images/0.png" class="zero-right" alt="0">
    </div>

    <div class="ui">
        <p>This Rarely Happens, Go Back -_-</p>
        <a href="${pageContext.request.contextPath}/index.jsp">Go Home</a>
    </div>

</body>
</html>
