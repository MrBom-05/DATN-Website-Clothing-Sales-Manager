<%--
  Created by IntelliJ IDEA.
  User: anhkon
  Date: 3/21/2023
  Time: 7:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/../css/bootstrap.min.css">
</head>
<body>
<c:if test="${ f:length(list) == 0 }">
    <h4 class="text-center">Không có dữ liệu</h4>
</c:if>

<c:if test="${ f:length(list) != 0 }">
<div class="container">
    <div class="row text-center mt-4 mb-4">
        <h2>Sản phẩm bán chạy nhất</h2>
    </div>
    <!-- Sản phẩm -->
    <div class="row">
        <c:forEach var="ctsp" items="${list}" varStatus="status" begin="0" end="3">
            <div class="col-md-3 col-12">
                <div class="card">
                    <img src="${ ctsp.sanPham.srcImage }" class="card-img-top img-fluid w50" alt="...">
                    <div class="card-body">
                        <a href="/user/chi-tiet-san-pham/${ ctsp.id } "
                           class="text-decoration-none fw-bold text-dark">
                            <p class="card-text text-center">${ ctsp.sanPham.ten }</p>
                        </a>
                        <span class="card text text-center fw-bold">${ ctsp.giaBan }</span>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="row text-center mt-4 mb-4">
        <h2>Sản phẩm mới nhất</h2></div>
    <!-- Sản phẩm mới nhất -->
    <div class="row">
        <article class="col-12 ">
            <div class="row">
                <c:forEach var="ctsp" items="${list}" varStatus="status" begin="0" end="7">
                    <div class="col-md-3 col-12">
                        <div class="card">
                            <img src="${ ctsp.sanPham.srcImage }" class="card-img-top img-fluid w50" alt="...">
                            <div class="card-body">
                                <a href="/user/chi-tiet-san-pham/${ ctsp.id } "
                                   class="text-decoration-none fw-bold text-dark">
                                    <p class="card-text text-center">${ ctsp.sanPham.ten }</p>
                                </a>
                                <span class="card text text-center fw-bold">${ ctsp.giaBan }</span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </article>
    </div>
    </c:if>
</div>

</body>
</html>
