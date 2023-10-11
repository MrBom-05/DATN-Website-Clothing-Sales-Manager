<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="container pt-5">
    <div class="row">
        <div class="col-3">
            <div class="row col-12">
                <!-- card 1 -->
                <div class="card border-0">
                    <div class="card-header border-0 bg-transparent">
                        <span class="text-dark fw-bold">Department</span>
                    </div>
                    <div class="card-body d-flex align-items-center flex-wrap">
                        <!-- Thêm class d-flex, align-items-center, và flex-wrap -->
                        <!-- repeat -->
                        <div class="col-12 mb-2"> <!-- Sử dụng col-6 để chia đều cột con -->
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="checkbox">
                                <label class="form-check-label" for="checkbox">
                                    Men
                                </label>
                                <p class="float-end">123444444</p>
                            </div>
                        </div>
                        <div class="col-12 mb-2"> <!-- Sử dụng col-6 để chia đều cột con -->
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="checkbox">
                                <label class="form-check-label" for="checkbox">
                                    Men
                                </label>
                                <p class="float-end">123444444</p>
                            </div>
                        </div>
                        <div class="col-12 mb-2"> <!-- Sử dụng col-6 để chia đều cột con -->
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="checkbox">
                                <label class="form-check-label" for="checkbox">
                                    Men
                                </label>
                                <p class="float-end">123444444</p>
                            </div>
                        </div>
                        <div class="col-12 mb-2"> <!-- Sử dụng col-6 để chia đều cột con -->
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="checkbox">
                                <label class="form-check-label" for="checkbox">
                                    Men
                                </label>
                                <p class="float-end">123444444</p>
                            </div>
                        </div>
                        <!--end repeat -->
                    </div>
                </div>
                <!-- end card 1 -->
                <hr>
                <!-- card 2 -->
                <div class="card border-0">
                    <div class="card-header border-0 bg-transparent">
                        <span class="text-dark fw-bold">Category</span>
                    </div>
                    <div class="card-body d-flex align-items-center flex-wrap">
                        <!-- Thêm class d-flex, align-items-center, và flex-wrap -->
                        <!-- repeat -->
                        <div class="col-12 mb-2"> <!-- Sử dụng col-6 để chia đều cột con -->
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="checkbox">
                                <label class="form-check-label" for="checkbox">
                                    Men
                                </label>
                                <p class="float-end">123444444</p>
                            </div>
                        </div>
                        <div class="col-12 mb-2"> <!-- Sử dụng col-6 để chia đều cột con -->
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="checkbox">
                                <label class="form-check-label" for="checkbox">
                                    Men
                                </label>
                                <p class="float-end">123444444</p>
                            </div>
                        </div>
                        <div class="col-12 mb-2"> <!-- Sử dụng col-6 để chia đều cột con -->
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="checkbox">
                                <label class="form-check-label" for="checkbox">
                                    Men
                                </label>
                                <p class="float-end">123444444</p>
                            </div>
                        </div>
                        <div class="col-12 mb-2"> <!-- Sử dụng col-6 để chia đều cột con -->
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="checkbox">
                                <label class="form-check-label" for="checkbox">
                                    Men
                                </label>
                                <p class="float-end">123444444</p>
                            </div>
                        </div>
                        <!--end repeat -->
                    </div>
                </div>
                <!-- end card 2 -->
                <hr>
                <!-- card 3 -->
                <div class="card border-0">
                    <div class="card-header border-0 bg-transparent">
                        <span class="text-dark fw-bold">Size</span>
                    </div>
                    <div class="card-body d-flex align-items-center flex-wrap">
                        <!-- Thêm class d-flex, align-items-center, và flex-wrap -->
                        <!-- repeat -->
                        <div class="col-12 mb-2"> <!-- Sử dụng col-6 để chia đều cột con -->
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="checkbox">
                                <label class="form-check-label" for="checkbox">
                                    Size S
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="checkbox">
                                <label class="form-check-label" for="checkbox">
                                    Size S
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="checkbox">
                                <label class="form-check-label" for="checkbox">
                                    Size S
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="checkbox">
                                <label class="form-check-label" for="checkbox">
                                    Size S
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="checkbox">
                                <label class="form-check-label" for="checkbox">
                                    Size S
                                </label>
                            </div>
                        </div>
                        <!--end repeat -->
                    </div>
                </div>
                <!-- end card 3 -->
            </div>
        </div>
        <div class="col-9 mt-2">
            <div class="input-group">
                <label class="form-check-label" for="checkbox">
                    <h2>Home/New Arrivals</h2>
                </label>
                <div class="col-3 offset-4 ms-3 mb-3">
                    <select class="form-select" aria-label="Default select example">
                        <option selected>Sort by</option>
                        <option value="1">Price: Low to High</option>
                        <option value="2">Price: High to Low</option>
                        <option value="3">Product Name: A to Z</option>
                        <option value="4">Product Name: Z to A</option>
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