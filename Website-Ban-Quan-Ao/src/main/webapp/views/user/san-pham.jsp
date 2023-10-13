<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="container pt-5">
    <div class="row">
        <div class="col-3">
            <div class="row col-12">
                <!-- card 1 -->
                <div class="card border-0">
                    <div class="card-header border-0 bg-transparent">
                        <span class="text-dark fw-bold">Loại Sản Phẩm:</span>
                    </div>
                    <div class="card-body align-items-center">
                        <select class="form-select" path="idLoai">
                            <c:forEach items="${listLoai}" var="loai">
                                <option value="${loai.id}">${loai.ten}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <!-- end card 1 -->
                <hr>
                <!-- card 2 -->
                <div class="card border-0">
                    <div class="card-header border-0 bg-transparent">
                        <span class="text-dark fw-bold">Màu Sắc:</span>
                    </div>
                    <div class="card-body align-items-center">
                        <select path="idMauSac" id="idMauSac" class="form-select">
                            <c:forEach items="${listMauSac}" var="mauSac">
                                <option value="${mauSac.id}" label="${mauSac.ten}"/>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-9 mt-2">
            <div class="input-group">
                <label class="form-label">
                    <h3>Trang Chủ/Sản Phẩm</h3>
                </label>
                <div class="col-3 offset-4 ms-3 mb-3">
                    <select class="form-select" aria-label="Default select example">
                        <option selected>Sắp xếp theo</option>
                        <option value="1">Giá: thấp đến cao</option>
                        <option value="2">Giá: cao đến thấp</option>
                        <option value="3">Tên: A đến Z</option>
                        <option value="4">Tên: Z đến A</option>
                    </select>
                </div>
            </div>
            <div class="product px-5">
                <!-- repeat -->
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
                <!-- end repeat -->
            </div>

        </div>

    </div>
</section>