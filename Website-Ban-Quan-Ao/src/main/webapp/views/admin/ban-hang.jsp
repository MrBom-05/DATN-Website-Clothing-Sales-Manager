<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>

<html lang="en">
<style>
    #searchResults {
        list-style-type: none;
        padding: 0;
        margin: 0;
    }

    .result-item {
        padding: 8px;
        background-color: white;
        border: 1px solid #ddd;
        cursor: pointer;
    }

    .result-item:hover {
        background-color: #f5f5f5;
    }

    .not-found {
        padding: 8px;
        background-color: white;
        color: red;
        font-style: italic;
    }

    .oval-switch {
        display: inline-block;
        width: 50px;
        height: 26px;
        background-color: #ccc;
        border-radius: 13px;
        position: relative;
    }

    .oval-switch input {
        display: none;
    }

    .oval-switch .slider {
        position: absolute;
        cursor: pointer;
        background-color: #00FF00; /* Màu xanh khi bật */
        width: 24px;
        height: 24px;
        border-radius: 50%;
        left: 1px;
        transition: 0.4s;
    }

    .oval-switch input:checked + .slider {
        background-color: #00FF00; /* Màu xanh khi bật */
        left: 25px;
    }

    .oval-switch input:not(:checked) + .slider {
        background-color: #fff; /* Màu trắng khi tắt */
        left: 1px;
    }

    .card {
        border: 1px solid #e0e0e0;
        border-radius: 10px;
        margin: 20px;
    }

    .card-header {
        background-color: #007bff;
        color: #fff;
        border-radius: 10px 10px 0 0;
    }

    .card-body {
        padding: 20px;
    }

    .btn-primary {
        background-color: #007bff;
        border: none;
    }

    .btn-primary:hover {
        background-color: #0056b3;
    }

    .row {
        margin-bottom: 20px;
    }

    .row.border {
        border: 1px solid #e0e0e0;
        border-radius: 10px;
        padding: 20px;
    }

    table {
        width: 100%;
    }

    table th {
        background-color: #007bff;
        color: #fff;
    }

    table tbody tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    table tbody tr:nth-child(odd) {
        background-color: #fff;
    }

    table td {
        text-align: center;
    }

    input[type="text"],
    input[type="number"],
    .form-control,
    select.form-select,
    textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    .float-start {
        float: left;
    }

    .float-end {
        float: right;
    }

    .fw-bold {
        font-weight: bold;
    }
    .image-input {
        display: none;
    }

    .image-preview-container {
        position: relative;
        width: 300px;
        height: 300px;
        margin: 10px;
        border: 1px dashed #ccc;
        text-align: center;
        cursor: pointer; /* Sử dụng con trỏ kiểu tay khi di chuột vào */
    }

    .image-preview {
        max-width: 100%;
        max-height: 100%;
        display: none;
    }

    .image-placeholder {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        font-size: 36px;
        color: #333;
    }

    /* Ẩn label khi đã chọn ảnh */
    .image-input-label.selected {
        display: none;
    }
</style>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý hóa đơn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
</head>


<body>

<c:if test="${not empty sessionScope.successMessage}">
    <div class="alert alert-success" role="alert">
            ${sessionScope.successMessage}
    </div>
    <script>
        setTimeout(function () {
            $('.alert').alert('close');
        }, 3000);
    </script>
    <% session.removeAttribute("successMessage"); %>
</c:if>
<c:if test="${not empty sessionScope.errorMessage}">
    <div class="alert alert-danger" role="alert">
            ${sessionScope.errorMessage}
    </div>
    <% session.removeAttribute("errorMessage"); %>
    <script>
        setTimeout(function () {
            $('.alert').alert('close');
        }, 3000);
    </script>
</c:if>
<div class="card border rounded">
    <div class="card-header text-black">
        <h3 class="mb-0">Bán hàng tại quầy</h3>
    </div>
    <div class="card-body">
        <form method="post" action="/admin/ban-hang/add-hoa-don">
            <input type="hidden" name="id" value="${admin.id}">
            <button type="submit" class="btn btn-primary">Tạo mới</button>
        </form>
        <hr>

        <!-- QR -->
        <div class="row">
            <div class="col">
                <p class="float-start fw-bold">Đơn Hàng ${hoaDon.ma}</p>
            </div>
        </div>

        <!-- List hóa đơn -->
        <div class="row">
            <c:forEach items="${listHoaDon}" var="hoaDon" varStatus="index">
                <div class="d-grid gap-2 col-2">
                    <a href="/admin/ban-hang/view-hoa-don/${hoaDon.id}" class="btn btn-primary">
                            ${hoaDon.ma}
                    </a>
                </div>
            </c:forEach>
        </div>

        <!-- Giỏ hàng -->
        <div class="row border mt-5">
            <p class="fw-bold mb-2">Giỏ Hàng</p>
            <div class="col text-end">
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#SPModal">Thêm sản phẩm</button>
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#QRModal">
                    Quét QR
                </button>
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#MASPModal">
                    Thêm với mã SP
                </button>
            </div>
            <table class="table text-center">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col" style="width: 150px;"><i class="fas fa-image"></i></th>
                    <th scope="col">Sản phẩm</th>
                    <th scope="col">Giá</th>
                    <th scope="col">Số lượng</th>
                    <th scope="col">Tổng tiền</th>
                    <th scope="col">Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <form id="paymentForm" action="/create-payment-link" method="post">
                    <button type="submit" style="display: none">Tạo Link thanh toán</button>
                    <input type="hidden" name="tongTien" value="" id="total">
                    <input type="hidden" name="ma" value="${hoaDon.ma}">
                    <input type="hidden" name="idHoaDon" value="${idHoaDon}">
                </form>
                <c:forEach items="${listSanPhamTrongGioHang}" var="sp" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                        <script>
                            $(document).ready(function () {
                                var idSanPham = '${sp.idSanPhamChiTiet}';
                                console.log(idSanPham);
                                $.ajax({
                                    url: '/get-anh-san-pham/' + idSanPham,
                                    type: 'GET',
                                    dataType: 'json',
                                    success: function (data) {
                                        // Xử lý phản hồi từ máy chủ và cập nhật danh sách ảnh
                                        var listAnhSanPham = data;
                                        var carouselInner = $('#carouselExampleSlidesOnly_${sp.idSanPhamChiTiet} .carousel-inner');
                                        carouselInner.empty();

                                        $.each(listAnhSanPham, function (index, anhSanPham) {
                                            var isActive = index === 0 ? 'active' : '';
                                            var carouselItem = '<div class="carousel-item ' + isActive + '">'
                                                + '<img src="' + anhSanPham.duongDan + '" class="d-block" id="custom-anh" style="width: 150px; height: 150px">'
                                                + '</div>';
                                            carouselInner.append(carouselItem);
                                        });
                                    },
                                    error: function () {
                                        console.log('Lỗi khi lấy danh sách ảnh sản phẩm');
                                    }
                                });
                            });
                        </script>
                        <td>
                            <!-- Ảnh -->
                            <div id="carouselExampleSlidesOnly_${sp.idSanPhamChiTiet}"
                                 class="carousel slide" data-bs-ride="carousel" data-bs-interval="3000">
                                <div class="carousel-inner" style="width: 150px; height: 150px">
                                    <c:forEach items="${listAnhSanPham}" var="anhSanPham" varStatus="status">
                                        <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                            <img src="${anhSanPham.duongDan}" class="d-block"
                                                 style="width: 150px; height: 150px">
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </td>
                        <td>
                            <p>${sp.tenSanPham}</p>
                            <p>${sp.tenMau}/${sp.tenSize}</p>
                        </td>

                        <td id="formattedGia">
                                ${sp.gia}
                        </td>
                        <td>${sp.soLuong}</td>
                        <td id="formattedTotal">${sp.soLuong * sp.gia}</td>

                        <!-- Thêm script để định dạng giá trị hiển thị -->

                        <input type="hidden" id="quantity" value=""/>
                        <c:set var="tongTien" value="${tongTien + (sp.soLuong * sp.gia)}"/>
                        <td>
                            <c:if test="${hoaDon.trangThai == 0}">
                                <form method="post"
                                      action="/admin/ban-hang/delete-gio-hang/${sp.idHoaDonChiTiet}">
                                    <div class="input-group">
                                        <input type="number" name="soLuong" min="1"
                                               max="${sp.soLuong}" value="1" class="w-50"
                                               oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                                        <div class="input-group-append mt-2">
                                            <button type="submit" style="border: none" class="ms-2">
                                                <i class="fas fa-trash" style="color: #fb0404;"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </c:if>
                            <c:if test="${hoaDon.trangThai == 1}">
                                <span class="text-danger">Không thể thao tác</span>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Khách hàng -->
        <div class="container border mt-5">
            <div class="row">
                <div class="col-12 col-md-3">
                    <div class="mb-3">
                        <label for="searchInputKh" class="form-label fw-bold">Tìm kiếm khách hàng</label>
                        <input type="text" class="form-control" id="searchInputKh" placeholder="Nhập tên khách hàng">
                    </div>
                    <!-- Dropdown sẽ hiển thị kết quả tìm kiếm -->
                    <ul id="searchResults" class="list-group" style="display: none;"></ul>
                </div>
                <div class="col-12 col-md-9">
                    <div class="mb-3">
                        <p class="fw-bold">Thông tin khách hàng</p>
                        <p class="text-center" id="tenKhachHang">Tên khách hàng: Khách Lẻ</p>
                        <p class="text-center" id="emailKhachHang">Email: </p>
                        <p class="text-center" id="soDienThoaiKhachHang">Số điện thoại: </p>
                        <p class="text-center" id="diaChiKhachHang">Địa chỉ: </p>
                    </div>
                </div>
            </div>
            <input type="hidden" id="idKhachHangInput" value="">
        </div>

        <!-- Thanh toán -->
        <form method="post" action="/admin/ban-hang/thanh-toan/${idHoaDon}" id="thong-tin-thanh-toanForm"  enctype="multipart/form-data">
            <input type="hidden" name="idKhachHang" id="id-khach-hang">
            <div class="row border mt-3">
                <p class="fw-bold">Thông tin thanh toán</p>
                <hr>
                <div class="row">
                    <div class="col-6" id="form-khach-hang">
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="hoVaTen" class="form-label">Họ và tên</label>
                                    <input type="text" id="hoVaTen" class="form-control" name="nguoiNhan"
                                    />
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label class="form-label">SĐT</label>
                                    <input type="text" class="form-control" name="sdt"
                                           id="sdt"/>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-6">
                                <select id="provinceSelect" class="form-select">
                                    <option value="" disabled selected>Chọn tỉnh/thành phố</option>
                                </select>
                                <input type="hidden" id="provinceName" name="tinhThanh">
                            </div>
                            <div class="col-6">
                                <select id="districtSelect" class="form-select">
                                    <option value="" disabled selected>Chọn quận/huyện</option>
                                </select>
                                <input type="hidden" id="districtName" name="quanHuyen">
                            </div>
                            <div class="col-6 mt-3">
                                <select id="wardSelect" class="form-select">
                                    <option value="" disabled selected>Chọn phường/xã</option>
                                </select>
                                <input type="hidden" id="wardName" name="xaPhuong">
                            </div>
                            <div class="col-6 mt-3">
                                <input type="text" class="form-control" id="ma-van-chuyen" name="maVanChuyen"
                                       placeholder="Mã vận chuyển">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-6">
                                <input type="text" id="ten-don-vi" name="tenDonViVanChuyen"
                                       placeholder="Tên đơn vị vận chuyển">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-12">
                        <textarea class="form-control" id="dia-chi" name="diaChi" rows="3"
              placeholder="Địa chỉ chi tiết"></textarea>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-12">
                                <label for="imageInput" class="image-preview-container">
                                    <label class="form-label">Ảnh chuyển khoản</label>
                                    <img id="imageDisplay" class="image-preview" src="" alt="Image">
                                    <span class="image-placeholder" id="placeholder1">+</span>
                                </label>
                                <input name="anh" type="file" id="imageInput" class="image-input" accept="image/*"
                                       onchange="displayImage();">
                            </div>
                        </div>
                        <script>
                            function displayImage() {
                                var input = document.getElementById('imageInput');
                                var imageDisplay = document.getElementById('imageDisplay');
                                var placeholder = document.getElementById('placeholder1'); // Đã thêm id vào placeholder

                                if (input.files && input.files[0]) {
                                    var reader = new FileReader();

                                    reader.onload = function (e) {
                                        imageDisplay.src = e.target.result;
                                        imageDisplay.style.display = 'block';
                                        placeholder.style.display = 'none';
                                        // Chuyển đổi ảnh thành base64 và hiển thị nó
                                        convertToBase64(input.files[0], function (base64Image) {
                                            // Lưu base64Image vào một biến hoặc gửi nó điều kiện cần thiết
                                        });
                                    };
                                    console.log(input.files[0]);

                                    reader.readAsDataURL(input.files[0]);
                                } else {
                                    imageDisplay.src = ''; // Xóa ảnh nếu không có tệp được chọn
                                    imageDisplay.style.display = 'none';
                                    placeholder.style.display = 'block';
                                }
                            }
                            function convertToBase64(file, callback) {
                                var reader = new FileReader();
                                reader.readAsDataURL(file);
                                reader.onload = function () {
                                    var base64Image = reader.result.split(',')[1];
                                    callback(base64Image);
                                };
                                reader.onerror = function (error) {
                                    console.error('Error reading file: ', error);
                                };
                            }
                        </script>
                    </div>

                    <div class="col-6" id="thong-tin-thanh-toan">
                        <div class="mb-3 mt-2">
                            <label class="oval-switch">
                                <input type="checkbox" id="toggleSwitch">
                                <span class="slider"></span>
                            </label>
                            <label class="form-label float-end">Giao Hàng</label>
                        </div>

                        <div class="mb-3" id="phi-van-chuyen-div" style="display: none">
                            <label class="form-label">Phí Vận Chuyển</label>
                            <input class="float-end" type="text" id="feeInput" name="phiVanChuyen"
                                   oninput="formatCurrency(this); updateTotal()" value="0">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Tổng tiền</label>
                            <input type="text" class="float-end" id="tong-tien" name="tong-tien" value="${tongTien}"
                                   readonly>
                        </div>
                        <div class="mb-3" id="hinh-thuc-thanh-toan-div">
                            <label class="form-label">Hình thức thanh toán</label>
                            <select class="form-select" id="hinh-thuc-thanh-toan" name="httt"
                                    aria-label="Default select example">
                                <option selected value="0">Chọn hình thức thanh toán</option>
                                <option value="1">Tiền mặt</option>
                                <option value="2">Chuyển khoản</option>
                            </select>
                        </div>
                        <div class="mb-3" id="tien-khach-dua-div">
                            <label class="form-label">Tiền khách đưa</label>
                            <input oninput="formatCurrency(this);" type="text" class="form-control" id="tien-khach-dua"
                                   name="tienKhachDua"
                                   min="${tongTien}" step="0.01">
                        </div>
                        <div class="mb-3" id="tien-thua-div">
                            <label class="form-label">Tiền Thừa</label>
                            <label class="form-label float-end" id="tien-thua">0</label>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Ghi chú</label>
                            <textarea class="form-control" id="ghi-chu" name="ghiChu" rows="3"
                                      placeholder="Ghi chú"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary float-end" id="thanh_toan" onclick="exportPDFBill()">Thanh toán</button>
                            Thanh toán</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- Modal QR -->
<div class="modal fade" id="QRModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            <div class="modal-body">
                <div class="form-group">
                    <label>Quét mã QR code</label>
                    <div class="video-container">
                        <video id="qr-video" width="300px" height="300px"></video>
                        <canvas id="qr-canvas" style="display: none;"></canvas>
                        <div id="qr-result">Chưa có mã QR code được quét.</div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<!-- End Modal QR -->
<!-- Modal mã Sản Phẩm -->
<div class="modal fade" id="MASPModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Thêm sản phẩm vào giỏ hàng</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Thêm các trường để nhập mã sản phẩm và số lượng -->
                <div class="mb-3">
                    <label for="maSanPhamChiTiet" class="form-label">Mã Sản Phẩm Chi Tiết:</label>
                    <input type="text" class="form-control" id="maSanPhamChiTiet">
                </div>
                <div class="mb-3">
                    <label for="soLuongMoi" class="form-label">Số Lượng:</label>
                    <input type="number" class="form-control" id="soLuongMoi" value="1" min="1">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                <button type="button" class="btn btn-primary" onclick="themSanPhamVaoGioHang()">Thêm vào giỏ hàng
                </button>
            </div>
        </div>
    </div>
</div>

<!-- End Modal mã Sản Phẩm -->
<!-- Modal Sản Phẩm -->
<div class="modal fade" id="SPModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">Danh sách sản phẩm</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- thêm các filter với combox box -->
                <div class="row mt-2">
                    <!-- Tìm kiếm theo tên sản phẩm -->
                    <div class="col-6">
                        <div class="input-group">
                            <input id="searchInput" type="text" class="form-control" placeholder="Tìm kiếm sản phẩm">
                            <button id="searchButton" class="btn btn-primary">Tìm kiếm</button>
                        </div>
                    </div>
                    <div class="col-6 ">
                        <button class="btn btn-primary w100 " id="allProduct">Tất cả sản phẩm</button>
                    </div>
                </div>
                <div class="row">
                    <table class="table text-center">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col" style="width: 150px;"><i class="fas fa-image"></i></th>
                            <th scope="col">Sản phẩm</th>
                            <th scope="col">Giá</th>
                            <th scope="col">Số lượng</th>
                            <th scope="col">Thao tác</th>
                        </tr>
                        </thead>
                        <tbody id="productTableBody">
                        <!-- Các dòng sản phẩm sẽ được thêm vào đây -->
                        </tbody>
                    </table>

                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <script>
                        var allProducts; // Variable to store all products for filtering
                        $(document).ready(function () {
                            // Tải sản phẩm từ API
                            $.ajax({
                                url: '/view/san-pham-chi-tiet',
                                type: 'GET',
                                dataType: 'json',
                                success: function (data) {
                                    // Hiển thị sản phẩm trong bảng
                                    allProducts = data;
                                    renderProducts(allProducts);
                                },
                                error: function () {
                                    console.log('Lỗi khi tải sản phẩm từ API');
                                }
                            });
                            $('#searchButton').on('click', function () {
                                var searchTerm = $('#searchInput').val().toLowerCase();
                                searchProducts(searchTerm);
                            });
                            // Xử lý sự kiện khi nhấn nút "Tất cả sản phẩm"
                            $('#allProduct').on('click', function () {
                                renderProducts(allProducts);
                            });
                        });

                        function renderProducts(products) {
                            // Xóa nội dung bảng hiện tại
                            $('#productTableBody').empty();

                            // Duyệt qua các sản phẩm và thêm dòng vào bảng
                            $.each(products, function (index, product) {
                                var productRow = '<tr>' +
                                    '<td>' + (index + 1) + '</td>' +
                                    '<td>' +
                                    '<div id="carouselExampleSlidesOnly_' + product.id + '" class="carousel slide" data-bs-ride="carousel" data-bs-interval="1000">' +
                                    '<div class="carousel-inner" style="width: 150px; height: 150px"></div>' +
                                    '</div>' +
                                    '</td>' +
                                    '<td>' +
                                    '<p>' + product.tenSanPham + '</p>' +
                                    '<p>' + product.tenMauSac + '</p>' +
                                    '</td>' +
                                    '<td>' +
                                    '<p class="fw-bold gia-san-pham" id="gia-san-pham_' + product.id + '">' + product.gia + '</p>' +
                                    '<p class="fw-bold gia-moi" id="gia-moi_' + product.id + '"></p>' +
                                    '</td>' +
                                    '<td>' +
                                    '<p>' + product.soLuong + '</p>' +
                                    '</td>' +
                                    '<td>';

                                if (product.soLuong > 0) {
                                    productRow += '<form method="post" action="/admin/ban-hang/add-gio-hang/${idHoaDon}">' +
                                        '<input type="hidden" name="idSanPhamChiTiet" value="' + product.id + '"/>' +
                                        '<input type="hidden" name="gia" value="' + product.gia + ' " id="gia_' + product.id + '"/>' +
                                        '<input type="hidden" name="soLuong" value="' + product.soLuong + '"/>' +
                                        '<input type="number" name="soLuongMoi" id="soLuongMoi_' + product.id + '" class="form-control" min="1" max="' + product.soLuong + '" value="1" style="width: 100px; display: inline-block;" required="true" oninput="this.value = this.value.replace(/[^0-9]/g, \'\');" onchange="updatePromotion(' + product.id + ')">' +
                                        '<button type="submit" class="btn btn-primary mt-1 w-25">Thêm</button>';
                                } else {
                                    productRow += '<span class="text-danger">Hết hàng</span>';
                                }

                                productRow += '</td></tr>';

                                $('#productTableBody').append(productRow);

                                // Load ảnh sản phẩm
                                loadProductImages(product.id);

                                // Load discount percentage
                                getDiscountPercentage(product.id);
                            });
                        }

                        function loadProductImages(productId) {
                            var idSanPham = productId;
                            $.ajax({
                                url: '/get-anh-san-pham/' + idSanPham,
                                type: 'GET',
                                dataType: 'json',
                                success: function (data) {
                                    // Xử lý phản hồi từ máy chủ và cập nhật danh sách ảnh
                                    var listAnhSanPham = data;
                                    var carouselInner = $('#carouselExampleSlidesOnly_' + productId + ' .carousel-inner');
                                    carouselInner.empty();

                                    $.each(listAnhSanPham, function (index, anhSanPham) {
                                        var isActive = index === 0 ? 'active' : '';
                                        var carouselItem = '<div class="carousel-item ' + isActive + '">' +
                                            '<img src="' + anhSanPham.duongDan + '" class="d-block" id="custom-anh" style="width: 150px; height: 150px">' +
                                            '</div>';
                                        carouselInner.append(carouselItem);
                                    });
                                },
                                error: function () {
                                    console.log('Lỗi khi lấy danh sách ảnh sản phẩm');
                                }
                            });
                        }

                        function getDiscountPercentage(productId) {
                            $.ajax({
                                url: '/phan-tram-giam/' + productId,
                                type: 'GET',
                                dataType: 'json',
                                success: function (data) {
                                    // Update the UI to display the discount percentage
                                    updateDiscountPercentage(productId, data);
                                },
                                error: function () {
                                    console.log('Lỗi khi tải phần trăm giảm từ API');
                                }
                            });
                        }

                        function updateDiscountPercentage(productId, discountPercentage) {
                            var giaSanPhamId = '#gia-san-pham_' + productId;
                            var giaMoiId = '#gia-moi_' + productId;
                            const giaInput = document.getElementById('gia_' + productId);
                            var giaSanPhamElement = $(giaSanPhamId);
                            var giaMoiElement = $(giaMoiId);

                            var giaSanPham = parseFloat(giaSanPhamElement.text());

                            if (discountPercentage > 0) {
                                var giaMoi = giaSanPham - (giaSanPham * discountPercentage) / 100;
                                console.log(giaMoi);
                                giaInput.value = giaMoi;
                                console.log(giaInput.value);
                                // Update the UI with the discount percentage and the new price
                                giaMoiElement.text('Giảm ' + discountPercentage + '%: ' + giaMoi);
                                giaSanPhamElement.addClass('text-decoration-line-through');
                            } else {
                                // If there is no discount, hide the giaMoiElement
                                giaMoiElement.hide();
                            }
                        }

                        function updatePromotion(productId) {
                            // Your existing code for updating promotion

                            // After updating promotion, fetch and display the discount percentage
                            getDiscountPercentage(productId);
                        }

                        function searchProducts(searchTerm) {
                            // Lọc sản phẩm dựa trên từ khóa tìm kiếm
                            var filteredProducts = [];

                            // Duyệt qua tất cả sản phẩm và kiểm tra tên sản phẩm
                            $.each(allProducts, function (index, product) {
                                if (product.tenSanPham.toLowerCase().includes(searchTerm)) {
                                    filteredProducts.push(product);
                                }
                            });

                            // Hiển thị sản phẩm được lọc
                            renderProducts(filteredProducts);
                        }

                        // filter
                    </script>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<!-- Modal hiển thị mã QR -->
<div class="modal fade" id="qrCodeModal" tabindex="-1" role="dialog" aria-labelledby="qrCodeModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="qrCodeModalLabel">Mã QR Code</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Nội dung mã QR sẽ được hiển thị ở đây -->
            </div>
        </div>
    </div>
</div>

<script src="https://rawgit.com/schmich/instascan-builds/master/instascan.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>

<script>
    // bật/tắt giao hàng
    var toggleSwitch = document.getElementById('toggleSwitch');
    var formKhachHang = document.getElementById('form-khach-hang');
    var thongTinThanhToan = document.getElementById('thong-tin-thanh-toan');
    var thanhToan = document.getElementById('thanh_toan');
    var thongTinThanhToanForm = document.getElementById('thong-tin-thanh-toanForm');
    var tienKhachDua = document.getElementById('tien-khach-dua-div');
    var tienThua = document.getElementById('tien-thua-div');
    var phiVanChuyen = document.getElementById('phi-van-chuyen-div');
    var hinhThucThanhToan = document.getElementById('hinh-thuc-thanh-toan-div');
    var hoVaTen = document.getElementById('hoVaTen');
    toggleSwitch.addEventListener('change', function () {
        if (this.checked) {
            // Switch is ON (bật)
            thanhToan.innerHTML = 'Tạo đơn hàng';
            phiVanChuyen.style.display = 'block';
            // đổi action
            tienKhachDua.style.display = 'none';
            hinhThucThanhToan.style.display = 'none';
            tienThua.style.display = 'none';
            thongTinThanhToanForm.action = '/admin/ban-hang/tao-don-hang/${idHoaDon}';

        } else {
            // Switch is OFF (tắt)
            // disable form input hovaten
            thanhToan.innerHTML = 'Thanh toán';
            tienKhachDua.style.display = 'block';
            tienThua.style.display = 'block';
            phiVanChuyen.style.display = 'none';
            hinhThucThanhToan.style.display = 'block';
            // đổi action
            thongTinThanhToanForm.action = '/admin/ban-hang/thanh-toan/${idHoaDon}';

        }
    });

    const scanner = new Instascan.Scanner({video: document.getElementById('qr-video')});
    // Thêm sự kiện cho khi quét QR code thành công
    scanner.addListener('scan', function (content) {
        if (content !== "") {
            // Hiển thị kết quả quét được lên giao diện
            document.getElementById('qr-result').textContent = 'Quét thành công';
            $.ajax({
                url: `/admin/ban-hang/add-gio-hang-qr-code/${idHoaDon}`,
                method: "POST",
                data: {
                    idSanPhamChiTiet: content,
                    gia: $("#gia_" + content).val(),
                    soLuongMoi: 1,
                },
                success: function (response) {
                    // Xử lý khi thêm thành công
                    alert("Đã thêm sản phẩm vào giỏ hàng!");
                    location.reload();
                },
                error: function (xhr, status, error) {
                    // Xử lý khi có lỗi từ server
                    alert("Lỗi: " + xhr.responseText);
                    // load lại trang
                    location.reload();
                }
            });
        }
    });


    // Khi trang web được tải, bắt đầu quét QR code
    Instascan.Camera.getCameras().then(function (cameras) {
        if (cameras.length > 0) {
            scanner.start(cameras[0]);
        } else {
            alert('Không tìm thấy máy ảnh.');
        }
    }).catch(function (e) {
        console.error(e);
    });

    // Hàm được gọi khi nhấn nút "Thêm vào giỏ hàng" trong modal
    function themSanPhamVaoGioHang() {
        // Lấy giá trị từ các trường nhập liệu trong modal
        var maSanPhamChiTiet = $("#maSanPhamChiTiet").val();
        var soLuongMoi = $("#soLuongMoi").val();

        // Gọi AJAX để thêm sản phẩm vào giỏ hàng
        $.ajax({
            url: `/admin/ban-hang/add-gio-hang-ma-san-pham/${idHoaDon}`,
            method: "POST",
            data: {
                maSanPhamChiTiet: maSanPhamChiTiet,
                soLuongMoi: soLuongMoi,
            },
            success: function (response) {
                // Xử lý khi thêm thành công
                alert("Đã thêm sản phẩm vào giỏ hàng!");
                $("#SPModal").modal("hide");  // Đóng modal sau khi thêm sản phẩm thành công
                location.reload();
            },
            error: function (xhr, status, error) {
                // Xử lý khi có lỗi từ server
                alert("Lỗi: " + xhr.responseText);
                console.log("Lỗi: " + xhr.responseText);
                // load lại trang
                location.reload();
            }
        });
    }


    // Hàm để mở modal khi cần nhập thông tin sản phẩm
    function moModalThemSanPham() {
        // Xử lý mở modal ở đây nếu cần
        $("#SPModal").modal("show");
    }

    //
    function fillCustomerData(customer) {
        $('#tenKhachHang').text('Tên khách hàng: ' + customer.hoVaTen);
        $('#emailKhachHang').text('Email: ' + customer.email);
        $('#soDienThoaiKhachHang').text('Số điện thoại: ' + (customer.soDienThoai ? customer.soDienThoai : 'N/A'));
        $('#diaChiKhachHang').text('Địa chỉ: ' + (customer.diaChi ? customer.diaChi : 'N/A'));
    }

    // khách hàng
    $(document).ready(function () {
        // Lấy dữ liệu khách hàng từ API
        $.get('http://localhost:8080/view/thong-tin-khach-hang', function (data) {
            // Lưu trữ dữ liệu khách hàng để sử dụng sau này
            var customerData = data;

            // Hàm cập nhật thông tin khách hàng dựa trên ID khách hàng được chọn
            function updateCustomerInfo(selectedCustomerId) {
                var selectedCustomer = customerData.find(function (customer) {
                    return customer.id === selectedCustomerId;
                });
                // Cập nhật thông tin khách hàng trên giao diện
                $('#tenKhachHang').text('Tên khách hàng: ' + selectedCustomer.hoVaTen);
                $('#emailKhachHang').text('Email: ' + (selectedCustomer.email ? selectedCustomer.email : ''));
                $('#soDienThoaiKhachHang').text('Số điện thoại: ' + (selectedCustomer.soDienThoai ? selectedCustomer.soDienThoai : ''));
                $('#diaChiKhachHang').text('Địa chỉ: ' + (selectedCustomer.diaChi ? selectedCustomer.diaChi : ''));

                // Cập nhật giá trị ID khách hàng được chọn trong input ẩn
                $('#idKhachHangInput').val(selectedCustomerId);

                fillCustomerData(selectedCustomer);
                console.log(selectedCustomer);
            }

            // Hàm lọc và cập nhật danh sách khách hàng dựa trên từ khóa tìm kiếm
            function filterCustomers(searchTerm) {
                var filteredCustomers = customerData.filter(function (customer) {
                    // Tìm kiếm không phân biệt chữ hoa, chữ thường trong tên khách hàng
                    return customer.hoVaTen.toLowerCase().includes(searchTerm.toLowerCase());
                });

                // Xóa các lựa chọn hiện tại trong danh sách kết quả
                $('#searchResults').empty();

                if (filteredCustomers.length === 0) {
                    // Hiển thị thông báo khi không tìm thấy khách hàng
                    $('#searchResults').append('<li class="result-item not-found">Không tìm thấy khách hàng</li>');
                } else {
                    // Thêm khách hàng đã lọc vào danh sách kết quả
                    filteredCustomers.forEach(function (customer) {
                        $('#searchResults').append('<li class="result-item" data-id="' + customer.id + '">' + customer.hoVaTen + '</li>');
                    });
                }
            }

            // Xử lý sự kiện input cho ô tìm kiếm khách hàng (tìm kiếm thời gian thực)
            $('#searchInputKh').on('input', function () {
                var searchTerm = $(this).val();
                filterCustomers(searchTerm);

                // Hiện dropdown khi có kết quả tìm kiếm
                if (searchTerm) {
                    $('#searchResults').show();
                } else {
                    $('#searchResults').hide();
                }
            });

            // Xử lý sự kiện click cho việc cập nhật thông tin khách hàng
            $(document).on('click', '.result-item', function () {
                var selectedCustomerId = $(this).data('id');
                updateCustomerInfo(selectedCustomerId);

                // Ẩn dropdown khi chọn một kết quả
                $('#searchResults').hide();
            });
        });

    });

    // api ghn
    $(document).ready(function () {
        // Biến kiểm tra trạng thái đã chọn
        var isDistrictSelected = false;
        var isWardSelected = false;
        var isServiceSelected = false;
        // Gọi API để lấy dữ liệu tỉnh/thành phố
        $.ajax({
            url: 'https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/province',
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'Token': 'a76df0d2-77a1-11ee-b1d4-92b443b7a897'
            },
            success: function (data) {
                if (data.code === 200) {
                    const select = document.getElementById('provinceSelect');
                    const input = document.getElementById('provinceName'); // Get the input element

                    data.data.forEach(province => {
                        const option = document.createElement('option');
                        option.value = province.ProvinceID;
                        option.text = province.ProvinceName;
                        select.appendChild(option);
                    });

                    // Set province name in the input field when a province is selected
                    $('#provinceSelect').change(function () {
                        const selectedProvinceName = $('#provinceSelect option:selected').text();
                        input.value = selectedProvinceName; // Set the value of the input field
                    });
                }
            },
            error: function (error) {
                console.error(error);
            }
        });

        // Gọi API để lấy dữ liệu quận/huyện khi thay đổi tỉnh/thành phố
        $('#provinceSelect').change(function () {
            isDistrictSelected = false; // Đặt lại trạng thái khi thay đổi tỉnh/thành phố
            isWardSelected = false; // Đặt lại trạng thái khi thay đổi tỉnh/thành phố

            const provinceID = $(this).val();
            $.ajax({
                url: 'https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/district',
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'Token': 'a76df0d2-77a1-11ee-b1d4-92b443b7a897'
                },
                data: {
                    province_id: provinceID
                },
                success: function (data) {
                    if (data.code === 200) {
                        const select = document.getElementById('districtSelect');
                        const input = document.getElementById('districtName');
                        select.innerHTML = '';
                        data.data.forEach(district => {
                            const option = document.createElement('option');
                            option.value = district.DistrictID;
                            option.text = district.DistrictName;
                            select.appendChild(option);
                        });
                        $('#districtSelect').change(function () {
                            const selectedDistrictName = $('#districtSelect option:selected').text();
                            input.value = selectedDistrictName; // Set the value of the input field
                        });
                    }
                },
                error: function (error) {
                    console.error(error);
                }
            });
        });

        // Gọi API để lấy dữ liệu phường/xã khi thay đổi quận/huyện
        $('#districtSelect').change(function () {
            isDistrictSelected = true; // Đánh dấu trạng thái khi đã chọn quận/huyện
            isWardSelected = false; // Đặt lại trạng thái khi thay đổi quận/huyện

            const districtID = $(this).val();
            $.ajax({
                url: 'https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/ward?district_id=' + districtID,
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'Token': 'a76df0d2-77a1-11ee-b1d4-92b443b7a897'
                },
                data: {
                    district_id: districtID
                },
                success: function (data) {
                    if (data.code === 200) {
                        const select = document.getElementById('wardSelect');
                        const input = document.getElementById('wardName');
                        select.innerHTML = '';
                        data.data.forEach(ward => {
                            const option = document.createElement('option');
                            option.value = ward.WardCode;
                            option.text = ward.WardName;
                            select.appendChild(option);
                        })
                        $('#wardSelect').change(function () {
                            const selectedWardName = $('#wardSelect option:selected').text();
                            input.value = selectedWardName; // Set the value of the input field
                        });
                    }
                },
                error: function (error) {
                    console.error(error);
                }
            });
        });


        // tính tiền
        $(document).ready(function () {
            var selectElement = $("#hinh-thuc-thanh-toan");
            var tienKhachDuaInput = $("#tien-khach-dua");
            var tongTienInput = $("#tong-tien"); // Lấy ô input của tổng tiền
            var tienThuaLabel = $("#tien-thua");


            // Sự kiện change cho hình thức thanh toán
            selectElement.on("change", function () {
                updateTienKhachDua(); // Cập nhật tiền khách đưa khi thay đổi hình thức thanh toán
            });

            // Sự kiện blur cho tiền khách đưa
            tienKhachDuaInput.on("blur", function () {
                updateTienThua(); // Cập nhật tiền thừa khi blur khỏi trường tiền khách đưa
            });

            // Sự kiện khi thay đổi giá trị phí vận chuyển
            $('#feeInput, #tong-tien').on('input', function () {
                formatCurrency(this);
                updateTotal(); // Cập nhật tổng tiền khi giá trị phí vận chuyển hoặc tổng tiền thay đổi
            });

            // Sự kiện input để ngăn chặn việc nhập chữ trong trường tiền khách đưa
            tienKhachDuaInput.on("input", function () {
                formatCurrency(this); // Gọi hàm formatCurrency để giữ lại chỉ số và dấu phẩy
            });

            function formatCurrency(input) {
                // Giữ lại chỉ các ký tự số và dấu phẩy
                let inputValue = input.value.replace(/[^\d,]/g, '');

                // Định dạng lại giá trị
                inputValue = inputValue.replace(/,/g, '');

                // Gán giá trị đã định dạng lại vào trường input
                input.value = inputValue.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }

            function updateTotal() {
                // Use jQuery to get the value of the feeInput
                let feeInput = $('#feeInput');

                // Giữ lại chỉ các ký tự số và dấu phẩy
                let phiVanChuyen = parseFloat(feeInput.val().replace(/,/g, '')) || 0;

                // Lấy giá trị tổng tiền từ JSP
                let tongTien = parseFloat('${tongTien}') || 0;

                // Thêm phí vận chuyển vào tổng tiền
                tongTien += phiVanChuyen;

                // Định dạng lại tổng tiền và hiển thị trên giao diện
                let formattedTongTien = tongTien.toLocaleString('en-US');
                tongTienInput.val(formattedTongTien);

                // Gán giá trị phiVanChuyen cho trường phiVanChuyen ẩn để submit lên server
                feeInput.val(phiVanChuyen);
            }

            function updateTienKhachDua() {
                var hinhThucThanhToan = selectElement.val();
                var tongTien = parseFloat(tongTienInput.val());

                if (hinhThucThanhToan === "2" || hinhThucThanhToan === "3") {
                    tienKhachDuaInput.val(tongTien.toLocaleString('en-US'));
                } else {
                    tienKhachDuaInput.val("");
                }
            }

            function updateTienThua() {
                var tienKhachDua = parseFloat(tienKhachDuaInput.val().replace(/[^\d]/g, '')) || 0;
                var tongTien = parseFloat(tongTienInput.val());

                if (tienKhachDua >= tongTien) {
                    var tienThua = tienKhachDua - tongTien;
                    tienThuaLabel.text(tienThua.toLocaleString('en-US'));
                } else {
                    tienThuaLabel.text("0");
                    alert("Tiền khách đưa phải lớn hơn hoặc bằng tổng tiền!");
                }
            }
        });
        <%--// api vietqr--%>
        <%--$(document).ready(function () {--%>
        <%--    var clientId = '01d6d8e1-f32f-49c2-b2ed-569c35d2d407';--%>
        <%--    var apiKey = 'd662918e-19bd-4947-8ddd-fb8a1474dfe0';--%>
        <%--    var apiUrl = 'https://api.vietqr.io/v2/generate';--%>

        <%--    // Sự kiện change trên phần tử select--%>
        <%--    $('#hinh-thuc-thanh-toan').on('change', function () {--%>
        <%--        var selectedValue = $(this).val();--%>

        <%--        // Kiểm tra giá trị được chọn và hiển thị modal tương ứng--%>
        <%--        if (selectedValue === '1') {--%>
        <%--            // Tiền mặt - không hiển thị modal--%>
        <%--            // Có thể ẩn modal nếu nó đang hiển thị--%>
        <%--            $('#qrCodeModal').modal('hide');--%>
        <%--        } else if (selectedValue === '2') {--%>
        <%--            // Chuyển khoản - hiển thị modal và gửi yêu cầu API--%>
        <%--            $('#qrCodeModal').modal('show');--%>
        <%--            sendApiRequest();--%>
        <%--        }--%>
        <%--    });--%>

        <%--    function sendApiRequest() {--%>
        <%--        // Dữ liệu để gửi lên API--%>
        <%--        let tongTien = parseFloat('${tongTien}') || 0;--%>
        <%--        const maHoaDon = '${hoaDon.ma}';--%>
        <%--        var requestData = {--%>
        <%--            "accountNo": "0866613082003",--%>
        <%--            "accountName": "PHAM LE QUYEN ANH",--%>
        <%--            "acqId": "970422",--%>
        <%--            "addInfo": "Thanh toan hoa don " + maHoaDon,--%>
        <%--            "amount": tongTien,--%>
        <%--            "template": "compact",--%>
        <%--        };--%>

        <%--        // Gửi yêu cầu API sử dụng jQuery AJAX--%>
        <%--        $.ajax({--%>
        <%--            url: apiUrl,--%>
        <%--            type: 'POST',--%>
        <%--            headers: {--%>
        <%--                'x-client-id': clientId,--%>
        <%--                'x-api-key': apiKey,--%>
        <%--                'Content-Type': 'application/json'--%>
        <%--            },--%>
        <%--            data: JSON.stringify(requestData),--%>
        <%--            success: function (response) {--%>
        <%--                $('#qrCodeModal .modal-body').html('<img src="' + response.data.qrDataURL + '" class="img-fluid" />');--%>
        <%--            },--%>
        <%--            error: function (error) {--%>
        <%--                // Xử lý lỗi nếu có--%>
        <%--                console.error('API Error:', error);--%>
        <%--            }--%>
        <%--        });--%>
        <%--    }--%>
        <%--});--%>
        // api vietqr
        $(document).ready(function () {
            // Sự kiện change trên phần tử select
            $('#hinh-thuc-thanh-toan').on('change', function () {
                var selectedValue = $(this).val();

                // Kiểm tra giá trị được chọn và thực hiện hành động tương ứng
                if (selectedValue === '1') {
                    // Tiền mặt - ẩn form
                    $('#paymentForm').hide();
                } else if (selectedValue === '2') {
                    // Chuyển khoản - hiển thị form và tự động submit form
                    $('#paymentForm').show().submit();
                }
            });
        });
        // Lấy giá trị từ input có id="tong-tien"
        var tongTienInput = document.getElementById('tong-tien');
        var tongTienValue = tongTienInput.value;

        // Gán giá trị vào input có id="total"
        var totalInput = document.getElementById('total');
        totalInput.value = tongTienValue;
    });


</script>
</body>

</html>
