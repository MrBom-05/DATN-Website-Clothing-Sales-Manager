<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <link rel="stylesheet" href="/../views/user/css/global.css"/>
    <link rel="stylesheet" href="/../views/user/css/index.css"/>
    <link rel="stylesheet" href="/../views/user/css/styleguide.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"
          integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm" crossorigin="anonymous"/>
</head>

<body>
<header>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="#">Logo</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse ps-5" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="#">New</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Tops</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Bottoms</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Kids</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Accessories</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Collections</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Sale</a>
                    </li>
                </ul>
            </div>
            <div class="menu-div-2">
                <div class="menu-img">
                    <a href="#" class="text-dark">
                        <i class="fas fa-search"></i>
                    </a>
                </div>
                <div class="menu-img">
                    <div class="menu-overlap-group">
                        <img class="menu-vector" src="../../img/vector.svg"/>
                        <div class="menu-div-wrapper">
                            <div class="menu-text-wrapper-3">4</div>
                        </div>
                    </div>
                </div>
                <div class="menu-img">
                    <i class="fas fa-user"></i>
                </div>
            </div>
        </div>
    </nav>
    <!-- Carousel -->
    <jsp:include page="${ viewBanner }"/>
</header>
<!-- Content -->
<main>
    <!-- content -->
    <jsp:include page="${ viewContent }"/>
</main>
<footer>
    <div class="container mt-5">
        <div class="row pt-4">
            <div class="col-md-3 col-12 ">
                <div class="d-flex mb-2">
                    <i class="fas fa-caret-down fa-rotate-270"></i>
                    <div class="text-sm ">
                        <a href="/chinh-sach-bao-mat" class="text-decoration-none text-dark">Chính sách bảo mật</a>
                    </div>
                </div>
                <div class="d-flex mb-2">
                    <i class="fas fa-caret-down fa-rotate-270"></i>
                    <div class="text-sm">
                        <a href="/chinh-sach-doi-tra" class="text-decoration-none text-dark">Chính sách đổi trả</a>
                    </div>
                </div>
            </div>
            <div class="col-md-5 col-12">
                <div class="d-flex mb-2">
                    <div class="text-sm font-weight-bold mr-1">Địa chỉ 1:</div>
                    <div class="text-sm flex-fill">110 Nguyễn Hy Quang, Đống Đa, Hà Nội</div>
                </div>
                <div class="d-flex mb-2">
                    <div class="text-sm font-weight-bold mr-1">Địa chỉ 2:</div>
                    <div class="text-sm flex-fill">40A Ấu Triệu, Hoàn Kiếm, Hà Nội</div>
                </div>
                <div class="d-flex mb-2">
                    <div class="text-sm font-weight-bold mr-1">Hotline:</div>
                    <div class="text-sm">090 222 6803</div>
                </div>
            </div>
            <div class="col-md-4 col-12">
                <div class="d-flex">
                    <div class="text-sm">Theo dõi chúng tôi trên mạng xã hội</div>
                </div>
                <div class="d-flex mt-3">
                    <a href="https://www.facebook.com/leninnskateshop/" class="text-decoration-none text-dark">
                        <i class="fab fa-facebook-f fa-lg"></i>
                    </a>
                    <a href="https://www.facebook.com/leninnskateshop/" class="ms-4 text-dark">
                        <i class="fab fa-instagram fa-lg"></i>
                    </a>
                </div>
            </div>
        </div>

    </div>
    <hr>
    <div class="row col-4 offset-5 pb-3">
        <p> © 2021 Lennin. Đã đăng ký Bản quyền</p>
    </div>
</footer>
<!-- Include Bootstrap JS and jQuery (if needed) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>

</html>