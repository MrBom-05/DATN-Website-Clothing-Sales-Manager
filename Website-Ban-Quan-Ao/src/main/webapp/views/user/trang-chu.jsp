<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="content">
    <div class="container ">
        <h3 class="fw-bold text-lg-start mt-4">NEWEST ARRIVALS</h3>
        <div class="row row-cols-2 row-cols-md-4 g-4 ">
            <c:forEach items="${listTrangChu}" var="sanPham">
                <div class="col">
                    <a href="/san-pham/${sanPham.id}" class="text-decoration-none text-dark">
                        <div class="card border-0">
                            <img src="${sanPham.anh}" class="card-img-top" alt="${sanPham.ten}">
                            <div class="card-body text-center">
                                <p>${sanPham.ten}</p>
                                <c:choose>
                                    <c:when test="${sanPham.giaNhoNhat eq sanPham.giaLonNhat}">
                                        <p class="fw-bold">${sanPham.giaNhoNhat}đ</p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="fw-bold">${sanPham.giaNhoNhat} -- ${sanPham.giaLonNhat}đ</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>

        </div>
    </div>
</section>
<section>
    <div class="row justify-content-center col-2 offset-5 px-1 ">
        <a href="#"
           class="text-decoration-none text-dark fw-bold text-center py-3 px-5 border border-none rounded-pill">Xem
            Thêm</a>
    </div>
</section>