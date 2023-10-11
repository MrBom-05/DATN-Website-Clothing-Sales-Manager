<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container pt-3">
    <div class="row">
        <section class="col-lg-8">
            <div class="row mb-3">
                <div class="col-lg-8">
                    <div class="img" id="large-image">
                        <img src="/img/lenin-00021aa-l3X1P0_800x800.jfif" alt="" class="img-fluid w-100">
                    </div>
                    <div class="slide-container mt-3">
                        <div class="slide-wrapper">
                            <div class="slide">
                                <img src="../../img/quan.png" alt=""
                                     onclick="changeLargeImage(0)" class="img-fluid w-75">
                            </div>
                            <div class="slide">
                                <img src="https://picsum.photos/600/400?random=2" alt=""
                                     onclick="changeLargeImage(1)">
                            </div>
                            <div class="slide">
                                <img src="https://picsum.photos/600/400?random=3" alt=""
                                     onclick="changeLargeImage(2)">
                            </div>
                            <div class="slide">
                                <img src="https://picsum.photos/600/400?random=4" alt=""
                                     onclick="changeLargeImage(3)">
                            </div>
                        </div>
                        <div class="slide-button slide-button-prev" onclick="prevSlide()"><i
                                class="fas fa-long-arrow-alt-left"></i></div>
                        <div class="slide-button slide-button-next" onclick="nextSlide()"><i
                                class="fas fa-long-arrow-alt-right"></i></div>
                    </div>
                </div>
                <div class="col-8">
                    <div class="input-group pt-2">
                        <h4 class="me-2" id="product-name">Mô tả</h4>
                        <p class="me-2">||</p>
                        <h4 id="toggle-button" onclick="toggleContent()">Size</h4>
                    </div>
                    <hr>
                    <div class="content" id="content-mota">
                        <div class="mota-desc">
                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Cumque, alias sapiente
                                repellendus quia,
                                eligendi provident debitis aliquid at esse, minima eveniet voluptas tempore
                                eaque nihil pariatur sed
                                inventore quisquam fugit!</p>
                        </div>
                    </div>
                    <div class="content" id="content-size" style="display: none;">
                        <div class="size-desc">
                            <button class="btn btn-outline-secondary me-2">S</button>
                            <button class="btn btn-outline-secondary me-2">M</button>
                            <button class="btn btn-outline-secondary me-2">L</button>
                            <button class="btn btn-outline-secondary">XL</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section class="col-lg-4">
            <div class="col-lg-12 mt-3 mb-3">
                <p>MEN’S TEES</p>
            </div>
            <div class="col-lg-12">
                <h3>Vote Now T-Shirt</h3>
            </div>
            <div class="d-flex justify-content-between">
                <span>Giá 1</span>
                <span>Giá 2</span>
                <span>Còn Hàng</span>
            </div>
            <div class="color mt-3">
                <div class="title">
                    <h3>Color</h3>
                </div>
                <select class="form-select w-50" aria-label="Color Select">
                    <option selected>Chọn màu</option>
                    <option value="red">Đỏ</option>
                    <option value="black">Đen</option>
                    <option value="green">Xanh</option>
                    <option value="yellow">Vàng</option>
                </select>
            </div>
            <div class="size mt-3">
                <div class="title">
                    <h3>Size</h3>
                </div>
                <select class="form-select w-50" aria-label="Size Select">
                    <option selected>Chọn size</option>
                    <option value="S">S</option>
                    <option value="M">M</option>
                    <option value="L">L</option>
                    <option value="XL">XL</option>
                </select>
            </div>
            <!-- quantity -->
            <div class="quantity mt-3">
                <div class="title">
                    <h3>Quantity</h3>
                </div>
                <div class="input-group">
                    <button class="btn btn-outline-secondary" type="button" id="button-addon1">-</button>
                    <input type="text" class="form-control text-center w-50" placeholder=""
                           aria-label="Quantity" aria-describedby="button-addon1" value="1">
                    <button class="btn btn-outline-secondary" type="button" id="button-addon1">+</button>
                </div>
            </div>
            <!-- add to cart -->
            <div class="add-to-cart mt-3">
                <div class="justify-content-between">
                    <button class="btn btn-success">Add to cart</button>
                </div>
            </div>
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
<script>
    let currentIndex = 0;
    const slides = document.querySelectorAll('.slide');
    const slideWrapper = document.querySelector('.slide-wrapper');
    const numSlides = slides.length;
    const numVisibleSlides = 3; // Số lượng ảnh hiển thị trên giao diện

    function updateButtons() {
        if (numSlides <= numVisibleSlides) {
            document.querySelector('.slide-button-prev').style.display = 'none';
            document.querySelector('.slide-button-next').style.display = 'none';
        } else {
            document.querySelector('.slide-button-prev').style.display = 'block';
            document.querySelector('.slide-button-next').style.display = 'block';
        }
    }

    function showSlide(index) {
        if (index < 0) {
            index = numSlides - 1;
        } else if (index >= numSlides) {
            index = 0;
        }

        currentIndex = index;

        const offset = -currentIndex * 33.33 + '%';
        slideWrapper.style.transform = `translateX(${offset})`;
    }

    function prevSlide() {
        showSlide(currentIndex - 1);
        updateButtons();
    }

    function nextSlide() {
        showSlide(currentIndex + 1);
        updateButtons();
    }

    function changeLargeImage(index) {
        const largeImage = document.getElementById('large-image');
        const imageToDisplay = slides[index].querySelector('img').cloneNode(true);

        // Xóa nội dung của ảnh lớn và thêm ảnh mới
        largeImage.innerHTML = '';
        largeImage.appendChild(imageToDisplay);
    }

    function toggleContent() {
        var contentMota = document.getElementById("content-mota");
        var contentSize = document.getElementById("content-size");
        var productName = document.getElementById("product-name");
        var toggleButton = document.getElementById("toggle-button");

        if (contentMota.style.display === "none") {
            contentMota.style.display = "block";
            contentSize.style.display = "none";
            productName.textContent = "Mô tả";
            toggleButton.textContent = "Size";
        } else {
            contentMota.style.display = "none";
            contentSize.style.display = "block";
            productName.textContent = "Size";
            toggleButton.textContent = "Mô tả";
        }
    }

    updateButtons();
    showSlide(currentIndex);
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
