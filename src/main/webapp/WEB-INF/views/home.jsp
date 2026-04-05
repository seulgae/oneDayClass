<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${title}</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            line-height: 1.6;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        h1 {
            color: #222;
        }
        .card {
            padding: 24px;
            border: 1px solid #ddd;
            border-radius: 12px;
            background: #fafafa;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card">
        <h1>${title}</h1>
        <p>${message}</p>
        <p>MVC 구조에서 Controller가 Model 데이터를 전달하고 JSP가 View를 렌더링합니다.</p>
    </div>
</div>
</body>
</html>
