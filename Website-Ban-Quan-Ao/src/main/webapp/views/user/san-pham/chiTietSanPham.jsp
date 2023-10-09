
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Product Detail</title>
    <link rel="stylesheet" href="/Assignment_Sof3011_war_exploded/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-8 offset-2">
            <c:forEach var="ctsp" items="${list}" varStatus="status">
                <div class="card mb-3">
                    <img src="${ctsp.sanPham.srcImage}" alt="ảnh sản phẩm" class="card-img-top img-fluid w-50">
                    <div class="card-body">
                        <h3 class="card-title">${ctsp.sanPham.ten}</h3>
                        <h3 class="card-text">$${ctsp.giaBan}</h3>
                        <p class="card-text mau-sac">Màu sắc :${ctsp.mauSac.ten}</p>
                        <p class="card-text mo-ta">Mô tả: ${ctsp.moTa}</p>
                        <sf:form action="/user/gio-hang/${ctsp.id}"
                              method="post">
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">Số lượng</span>
                                </div>
                                <input type="number" class="ms-3 w-25" id="quantity-input" name="soLuong" value="1"
                                       min="1" max="${ctsp.soLuongTon}">
                                <p class="text-danger ms-3">còn ${ctsp.soLuongTon} sản phẩm</p>
                            </div>
                            <c:if test="${user != null}">
                                <button type="submit" class="btn btn-primary">Thêm vào giỏ hàng</button>
                            </c:if>
                        </sf:form>
                        <c:if test="${user == null}">
                            <a class="nav-link text-primary"
                               href="/user/login">
                                Bạn hãy đăng nhập để thực hiện chức năng này
                            </a>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<!-- Related Products -->
<h3 class="fw-bold mt-5 text-center">Các sản phẩm tương tự</h3>
<div class="row col-8 offset-2 justify-content-center">
    <c:forEach var="ctsp" items="${listByCategory}" varStatus="status" begin="0" end="2">
        <div class="col-md-3 col-12">
            <div class="card">
                <img src="${ ctsp.sanPham.srcImage }" class="card-img-top img-fluid" alt="...">
                <div class="card-body">
                    <a href="/user/chi-tiet-san-pham/${ ctsp.id }"
                       class="text-decoration-none fw-bold text-dark">
                        <p class="card-text text-center">${ ctsp.sanPham.ten }</p>
                    </a>
                    <span class="card text text-center fw-bold">${ ctsp.giaBan }</span>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
<script src="/js/app.js"></script>
<script src="/js/controllers/productDetailController.js"></script>

</body>
</html>