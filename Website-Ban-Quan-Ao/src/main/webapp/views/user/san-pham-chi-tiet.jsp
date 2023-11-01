<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="container pt-3">
    <div class="row">
        <section class="col-lg-6">
            <div class="row mb-3">
                <div>
                    <div id="carouselExampleIndicators" class="carousel slide">
                        <div class="carousel-indicators">
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0"
                                    class="active" aria-current="true" aria-label="Slide 1"></button>
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"
                                    aria-label="Slide 2"></button>
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"
                                    aria-label="Slide 3"></button>
                        </div>
                        <div class="carousel-inner">
                            <c:forEach items="${listAnh}" var="hinhAnh" varStatus="loop">
                                <c:if test="${loop.index == 0}">
                                    <div class="carousel-item active">
                                        <img src="${hinhAnh.duongDan}" class="d-block w-100" alt="...">
                                    </div>
                                </c:if>
                                <c:if test="${loop.index != 0}">
                                    <div class="carousel-item">
                                        <img src="${hinhAnh.duongDan}" class="d-block w-100" alt="...">
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators"
                                data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators"
                                data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>
                </div>
            </div>
        </section>
        <section class="col-lg-6">
            <div class="col-lg-12">
                <h3 class="fw-bold text-uppercase">${sanPham.ten}</h3>
            </div>
            <div class="justify-content-between mt-4">
                <div>
                    <c:choose>
                        <c:when test="${sanPham.giaNhoNhat == sanPham.giaLonNhat}">
                            <h5>${sanPham.giaNhoNhat} vnđ</h5>
                        </c:when>
                        <c:otherwise>
                            <h5>${sanPham.giaNhoNhat} -- </h5>
                            <h5>${sanPham.giaLonNhat} vnđ</h5>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <hr/>
            <div class="input-group pt-2">
                <h6 class="me-2" id="product-name">Mô tả</h6>
            </div>
            <div class="content" id="content-mota">
                <div class="mota-desc">
                    <p>${sanPham.moTa}</p>
                </div>
            </div>
            <hr/>
            <form:form modelAttribute="gioHang" action="/gio-hang/${sanPham.id}" method="post">
                <div class="mt-3 row">
                    <div class="col-3">
                        <div class="title">
                            <p>Màu sắc:</p>
                        </div>
                        <form:select path="idMauSac" class="form-select w-75" aria-label="Color Select"
                                     id="mauSacSelect">
                            <option selected>Chọn</option>
                            <c:forEach items="${listMauSac}" var="mauSac">
                                <option value="${mauSac.id}" ${mauSac.id == idMauSac ? "selected" : ""}>${mauSac.ten}</option>
                            </c:forEach>
                        </form:select>

                        <script>
                            // Lấy thẻ select
                            var selectElement = document.getElementById("mauSacSelect");

                            // Thêm sự kiện onchange để theo dõi khi người dùng thay đổi giá trị
                            selectElement.addEventListener("change", function () {
                                // Lấy giá trị value của select
                                var selectedValue = selectElement.value;

                                // Cập nhật đường link với giá trị mới
                                var newURL = "http://localhost:8080/san-pham/${sanPham.id}/" + selectedValue;

                                // Tải lại trang với đường link mới
                                window.location.href = newURL;
                            });
                        </script>
                    </div>

                    <div class="col-3">
                        <div class="title">
                            <p>Kích cỡ:</p>
                        </div>
                        <form:select path="idKichCo" class="form-select w-75" aria-label="Size Select">
                            <option selected>Chọn</option>
                            <c:forEach items="${listKichCo}" var="kichCo">
                                <option value="${kichCo.id}">${kichCo.ten}</option>
                            </c:forEach>
                        </form:select>
                    </div>
                    <div class="col-3">
                        <div class="quantity">
                            <div class="title">
                                <p>Số lượng:</p>
                            </div>
                            <div class="input-group">
                                <button class="btn btn-outline-dark" type="button"
                                        onclick="decrement()">-
                                </button>
                                <form:input path="soLuong" type="number" class="form-control text-center w-50"
                                            id="quantity" name="quantity"
                                            value="1" min="1"/>
                                <button class="btn btn-outline-dark" type="button"
                                        onclick="increment()">+
                                </button>
                            </div>
                            <script>
                                function decrement() {
                                    var quantityInput = document.getElementById("quantity");
                                    var currentValue = parseInt(quantityInput.value);
                                    if (currentValue > 1) {
                                        quantityInput.value = currentValue - 1;
                                    }
                                }

                                function increment() {
                                    var quantityInput = document.getElementById("quantity");
                                    var currentValue = parseInt(quantityInput.value);
                                    quantityInput.value = currentValue + 1;
                                }
                            </script>
                        </div>
                    </div>
                </div>

                <div class="mt-5">
                    <div class="justify-content-between">
                        <button type="submit" class="btn btn-dark">Thêm vào giỏ hàng</button>
                    </div>
                </div>
            </form:form>
        </section>

    </div>
    <hr>
    <div class="row">
        <h3 class="text-center">Sản phẩm liên quan</h3>
        <div class="d-flex justify-content-between">
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
                <!-- Sử dụng col-lg-3 để hiển thị 4 sản phẩm trong mỗi hàng và làm cho sản phẩm lớn hơn -->
                <div class="col-lg-3">
                    <a href="/product/light-blue-denim-baggy-short" class="text-decoration-none text-dark">
                        <div class="card border-0">
                            <img src="../../img/quan.png" class="card-img-top" alt="LIGHT BLUE DENIM BAGGY SHORT">
                            <div class="card-body text-center">
                                <p>Light Blue Denim Baggy Short</p>
                                <p class="fw-bold">1.200.000đ</p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-3">
                    <a href="/product/light-blue-denim-baggy-short" class="text-decoration-none text-dark">
                        <div class="card border-0">
                            <img src="../../img/quan.png" class="card-img-top" alt="LIGHT BLUE DENIM BAGGY SHORT">
                            <div class="card-body text-center">
                                <p>Light Blue Denim Baggy Short</p>
                                <p class="fw-bold">1.200.000đ</p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-3">
                    <a href="/product/light-blue-denim-baggy-short" class="text-decoration-none text-dark">
                        <div class="card border-0">
                            <img src="../../img/quan.png" class="card-img-top" alt="LIGHT BLUE DENIM BAGGY SHORT">
                            <div class="card-body text-center">
                                <p>Light Blue Denim Baggy Short</p>
                                <p class="fw-bold">1.200.000đ</p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-3">
                    <a href="/product/light-blue-denim-baggy-short" class="text-decoration-none text-dark">
                        <div class="card border-0">
                            <img src="../../img/quan.png" class="card-img-top" alt="LIGHT BLUE DENIM BAGGY SHORT">
                            <div class="card-body text-center">
                                <p>Light Blue Denim Baggy Short</p>
                                <p class="fw-bold">1.200.000đ</p>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<%--cdn jquery--%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
