<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>

<html lang="en">
<style>
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
<div class="card border rounded">
    <div class="card-header  text-black">
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
                <c:forEach items="${listSanPhamTrongGioHang}" var="sp" varStatus="status">

                    <tr>
                        <td>${status.index + 1}</td>
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

                        <td>${sp.gia}</td>
                        <td>${sp.soLuong}</td>
                        <input type="hidden" id="quantity" value=""/>
                        <td>${sp.soLuong * sp.gia}</td>
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
                                                <i class="fas fa-trash" style="color: #e70d0d;"></i>
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
                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <script>
                        // Gọi API để lấy dữ liệu sản phẩm
                        var totalQuantity = 0;
                        <c:forEach items="${listSanPhamTrongGioHang}" var="sp" varStatus="status">
                        totalQuantity += ${sp.soLuong};
                        </c:forEach>
                        document.getElementById('quantity').value = totalQuantity;
                        console.log(totalQuantity);

                    </script>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Khách hàng -->
        <div class="container border mt-5">
            <div class="row">
                <div class="col-12 col-md-3">
                    <div class="mb-3">
                        <label for="khachHangSelect" class="form-label fw-bold">Khách hàng</label>
                        <select class="form-select" id="khachHangSelect" aria-label="Default select example">
                            <option selected>Chọn khách hàng</option>
                        </select>
                    </div>
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
        </div>

        <!-- Thanh toán -->
        <form method="post" action="/admin/ban-hang/thanh-toan/${idHoaDon}" id="thong-tin-thanh-toanForm">
            <div class="row border mt-3">
                <p class="fw-bold">Thông tin thanh toán</p>
                <hr>
                <div class="row">
                    <div class="col-6" id="form-khach-hang" style="display: none;">
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
                            <div class="col-4">
                                <select id="provinceSelect" class="form-select">
                                    <option value="" disabled selected>Chọn tỉnh/thành phố</option>
                                </select>
                                <input type="hidden" id="provinceName" name="tinhThanh">
                            </div>
                            <div class="col-4">
                                <select id="districtSelect" class="form-select">
                                    <option value="" disabled selected>Chọn quận/huyện</option>
                                </select>
                                <input type="hidden" id="districtName" name="quanHuyen">
                            </div>
                            <div class="col-4">
                                <select id="wardSelect" class="form-select">
                                    <option value="" disabled selected>Chọn phường/xã</option>
                                </select>
                                <input type="hidden" id="wardName" name="xaPhuong">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-6">
                                <select id="service_id" class="form-select">
                                    <option value="" disabled selected>Chọn dịch vụ</option>
                                </select>
                            </div>
                            <div class="col-6">
                                <div class="form-group">
                                    <input type="text" id="diaChi" class="form-control"
                                           placeholder="Địa chỉ giao hàng" name="diaChi">
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label class="form-label">Thời gian giao hàng dự kiến:</label>
                                    <span id="leadtime"></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="thong-tin-thanh-toan">
                        <div class="mb-3 mt-2">
                            <label class="oval-switch">
                                <input type="checkbox" id="toggleSwitch">
                                <span class="slider"></span>
                            </label>
                            <label class="form-label float-end">Giao Hàng</label>
                        </div>

                        <div class="mb-3" id="phi-van-chuyen-div" style="display: none">
                            <label class="form-label">Phí Vận Chuyển</label>
                            <input class="float-end" type="number" id="feeInput" name="phiVanChuyen" value="0" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Tổng tiền</label>
                            <input type="number" class="float-end" id="tong-tien" name="tong-tien" value="${tongTien}"
                                   readonly>
                        </div>
                        <div class="mb-3">
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
                            <input type="number" class="form-control" id="tien-khach-dua" name="tienKhachDua"
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
                        <input type="hidden" name="idKhachHang" id="id-khach-hang">
                        <button type="submit" class="btn btn-primary float-end" id="thanh_toan">Thanh toán</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<!--  Modal QR -->
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
                <div class="row">
                    <div class="col-4">
                        <select class="form-select" aria-label="Default select example">
                            <option selected>Chọn loại sản phẩm</option>
                            <option value="1">Điện thoại</option>
                            <option value="2">Laptop</option>
                            <option value="3">Máy tính bảng</option>
                        </select>
                    </div>
                    <div class="col-4">
                        <select class="form-select" aria-label="Default select example">
                            <option selected>Chọn loại sản phẩm</option>
                            <option value="1">Điện thoại</option>
                            <option value="2">Laptop</option>
                            <option value="3">Máy tính bảng</option>
                        </select>
                    </div>
                    <div class="col-4">
                        <select class="form-select" aria-label="Default select example">
                            <option selected>Chọn loại sản phẩm</option>
                            <option value="1">Điện thoại</option>
                            <option value="2">Laptop</option>
                            <option value="3">Máy tính bảng</option>
                        </select>
                    </div>
                </div>
                <div class="row mt-2">
                    <!-- tìm kiếm theo tên sp -->
                    <div class="col-5 offset-3">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Tìm kiếm sản phẩm">
                            <button class="btn btn-primary ">Tìm kiếm</button>
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
                            <tbody>
                            <c:forEach items="${listProduct}" var="sp" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                                    <script>
                                        $(document).ready(function () {
                                            var idSanPham = '${sp.id}';
                                            $.ajax({
                                                url: '/get-anh-san-pham/' + idSanPham,
                                                type: 'GET',
                                                dataType: 'json',
                                                success: function (data) {
                                                    // Xử lý phản hồi từ máy chủ và cập nhật danh sách ảnh
                                                    var listAnhSanPham = data;
                                                    var carouselInner = $('#carouselExampleSlidesOnly_${sp.id} .carousel-inner');
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
                                        <div id="carouselExampleSlidesOnly_${sp.id}"
                                             class="carousel slide"
                                             data-bs-ride="carousel"
                                             data-bs-interval="1000">
                                            <div class="carousel-inner" style="width: 150px; height: 150px">
                                                <c:forEach items="${listAnhSanPham}" var="anhSanPham"
                                                           varStatus="status">
                                                    <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                                        <img src="${anhSanPham.duongDan}" class="d-block"
                                                             id="custom-anh"
                                                             style="width: 150px; height: 150px">
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <p>${sp.sanPham.ten}</p>
                                        <p>${sp.mauSac.ten}</p>
                                    </td>
                                    <td>
                                        <p class="fw-bold gia-san-pham" id="gia-san-pham_${sp.id}">${sp.gia} vnđ</p>
                                        <p class="fw-bold gia-moi" id="gia-moi_${sp.id}"></p>
                                    </td>
                                    <td>
                                        <p>${sp.soLuong}</p>
                                    </td>
                                    <td>
                                        <form method="post" action="/admin/ban-hang/add-gio-hang/${idHoaDon}">
                                            <input type="hidden" name="idSanPhamChiTiet" value="${sp.id}"/>
                                            <input type="hidden" name="gia" value="${sp.gia} " id="gia_${sp.id}"/>
                                            <input type="hidden" name="soLuong" value="${sp.soLuong}"/>
                                            <c:if test="${sp.soLuong > 0}">
                                                <input type="number" name="soLuongMoi" id="soLuongMoi"
                                                       class="form-control" min="1" max="${sp.soLuong}"
                                                       value="1" style="width: 100px; display: inline-block;"
                                                       required="true"
                                                       oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                                                <button type="submit" class="btn btn-primary mt-1 w-25 ">Thêm</button>
                                            </c:if>
                                            <c:if test="${sp.soLuong == 0}">
                                                <span class="text-danger">Hết hàng</span>
                                            </c:if>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                                <script>
                                    $(document).ready(function () {
                                        var idSanPhamChiTiet = '${sp.id}';
                                        var giaInput = $("#gia_${sp.id}"); // Lấy ô input dựa trên id
                                        $.ajax({
                                            url: "/so-phan-tram-giam/" + idSanPhamChiTiet,
                                            method: "GET",
                                            success: function (data) {
                                                var span = $("#so-phan-tram-giam_" + idSanPhamChiTiet);
                                                var giaSpan = $("#gia-san-pham_" + idSanPhamChiTiet);
                                                var giaCu = giaSpan.html();
                                                if (data != null) {
                                                    // Kiểm tra xem có khuyến mãi không
                                                    if (data > 0) {
                                                        span.show();
                                                        span.html(data + "% off");

                                                        // Tính giá sản phẩm sau khi giảm
                                                        var giaSanPham = ${sp.gia};
                                                        var soPhanTramGiam = data;
                                                        var giaSauGiam = giaSanPham - (giaSanPham * soPhanTramGiam / 100);
                                                        giaSauGiam = Math.floor(giaSauGiam);
                                                        giaSpan.hide();

                                                        if (data > 0) {
                                                            giaSpan.after('<p class="fw-bold gia-moi">' + giaSauGiam + ' vnđ</p>');
                                                            giaSpan.after('<p class="fw-bold gia-cu " style="text-decoration: line-through;">' + giaCu + '</p');

                                                            // Cập nhật giá mới trong ô input dựa trên id
                                                            giaInput.val(giaSauGiam);
                                                        } else {
                                                            giaSpan.show();
                                                            $(".gia-moi").remove();
                                                            $(".gia-cu").remove();
                                                            giaInput.val(giaSanPham);
                                                        }
                                                    }
                                                }
                                            },
                                            error: function () {
                                                // Xử lý lỗi nếu có
                                            }
                                        });
                                    });

                                </script>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
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
    toggleSwitch.addEventListener('change', function () {
        if (this.checked) {
            // Switch is ON (bật)
            formKhachHang.style.display = 'block'; // Hiển thị biểu mẫu khi công tắc bật
            thongTinThanhToan.className = 'col-6';
            thanhToan.innerHTML = 'Tạo đơn hàng';
            tienKhachDua.style.display = 'none';
            tienThua.style.display = 'none';
            phiVanChuyen.style.display = 'block';
            //     đổi action
            thongTinThanhToanForm.action = '/admin/ban-hang/tao-don-hang/${idHoaDon}';

        } else {
            // Switch is OFF (tắt)
            formKhachHang.style.display = 'none'; // Ẩn biểu mẫu khi công tắc tắt
            thongTinThanhToan.className = 'col-12';
            thanhToan.innerHTML = 'Thanh toán';
            tienKhachDua.style.display = 'block';
            tienThua.style.display = 'block';
            phiVanChuyen.style.display = 'none';
            //     đổi action
            thongTinThanhToanForm.action = '/admin/ban-hang/thanh-toan/${idHoaDon}';

        }
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
            // get api dịch vụ
            $.ajax({
                url: 'https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/available-services',
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'Token': 'a76df0d2-77a1-11ee-b1d4-92b443b7a897'
                },
                data: {
                    from_district: 1482,
                    to_district: districtID,
                    shop_id: 190221,
                },
                success: function (data) {
                    if (data.code === 200) {
                        const select = document.getElementById('service_id');
                        select.innerHTML = '';
                        data.data.forEach(service => {
                            const option = document.createElement('option');
                            option.value = service.service_id;
                            option.text = service.short_name;
                            select.appendChild(option);

                        });
                    }
                },
                error: function (error) {
                    console.error(error);
                }
            });
        });

        // Gọi API để lấy dữ liệu dịch vụ khi thay đổi dịch vụ
        var feeCalculated = false; // Biến cờ để kiểm tra xem đã tính phí hay chưa

        $('#service_id').change(function () {
            callAPItoCalculateLeadTime();
            if (!feeCalculated) {
                callAPItoFee();
                feeCalculated = true; // Đánh dấu rằng đã tính phí
            }
        });

        function callAPItoCalculateLeadTime() {
            const districtID = $('#districtSelect').val();
            const wardCode = $('#wardSelect').val();
            const wardCodeString = wardCode.toString();
            $.ajax({
                url: 'https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/leadtime',
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'Token': 'a76df0d2-77a1-11ee-b1d4-92b443b7a897'
                },
                data: {
                    ShopID: 190221,
                    from_district_id: 1482,
                    from_ward_code: "11008",
                    to_district_id: districtID,
                    to_ward_code: wardCodeString,
                    service_id: 53320,
                },
                success: function (data) {
                    if (data.code === 200) {
                        const leadtime = data.data.leadtime;
                        const orderDate = data.data.order_date;
                        // Chuyển đổi timestamp thành định dạng ngày giờ của Việt Nam
                        const leadtimeDate = moment.unix(leadtime).format("DD-MM-YYYY");
                        $('#leadtime').text(leadtimeDate);
                    }
                },
                error: function (error) {
                    console.error(error);
                }
            });
        }

        // function tính phí
        function callAPItoFee() {
            const districtID = $('#districtSelect').val();
            const wardCode = $('#wardSelect').val();
            const wardCodeString = wardCode.toString();
            const feeInput = $('#feeInput');
            const sl = $('#quantity').val();
            console.log(sl + "số lượng");
            // Gọi API GHN với danh sách sản phẩm đã tạo
            $.ajax({
                url: 'https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee',
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'Token': 'a76df0d2-77a1-11ee-b1d4-92b443b7a897'
                },
                data: {
                    ShopID: 190221,
                    service_type_id: 2,
                    to_district_id: districtID,
                    weight: 150 * sl,
                    to_ward_code: wardCodeString,
                    // item: items // Sử dụng danh sách sản phẩm ở đây
                },
                success: function (data) {
                    if (data.code === 200) {
                        const fee = data.data.total;
                        const currentTotal = parseFloat($('#tong-tien').val());
                        const newTotal = currentTotal + fee;
                        $('#feeInput').val(fee); // Đặt giá trị phí vận chuyển vào trường feeInput
                        $('#tong-tien').val(newTotal); // Đặt giá trị mới của tổng tiền
                    }
                },
                error: function (error) {
                    console.error(error);
                }
            });
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
                    soLuongMoi: 1
                },
                success: function (response) {
                    // Xử lý khi thêm thành công
                    alert("Đã thêm sản phẩm vào giỏ hàng!");
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

    $(document).ready(function () {
        var selectElement = $("#hinh-thuc-thanh-toan");
        var tienKhachDuaInput = $("#tien-khach-dua");
        var tongTienInput = $("#tong-tien"); // Lấy ô input của tổng tiền
        var tienThuaLabel = $("#tien-thua");

        selectElement.on("change", function () {
            var hinhThucThanhToan = selectElement.val();
            var tongTien = parseFloat(tongTienInput.val());

            if (hinhThucThanhToan === "2" || hinhThucThanhToan === "3") {
                tienKhachDuaInput.val(tongTien);
            } else {
                tienKhachDuaInput.val("");
            }
        });

        tienKhachDuaInput.on("blur", function () {
            var tienKhachDua = parseFloat(tienKhachDuaInput.val());
            var tongTien = parseFloat(tongTienInput.val());

            if (tienKhachDua >= tongTien) {
                var tienThua = tienKhachDua - tongTien;
                tienThuaLabel.text(tienThua);
            } else {
                tienThuaLabel.text("0");
                alert("Tiền khách đưa phải lớn hơn hoặc bằng tổng tiền!");
            }
        });
    });

    //
    function fillCustomerData(customer) {
        $('#tenKhachHang').text('Tên khách hàng: ' + customer.hoVaTen);
        $('#emailKhachHang').text('Email: ' + customer.email);
        $('#soDienThoaiKhachHang').text('Số điện thoại: ' + (customer.soDienThoai ? customer.soDienThoai : 'N/A'));
        $('#diaChiKhachHang').text('Địa chỉ: ' + (customer.diaChi ? customer.diaChi : 'N/A'));
    }

    // Fetch customer data from API and populate the select dropdown
    $(document).ready(function () {
        $.get('http://localhost:8080/view/thong-tin-khach-hang', function (data) {
            data.forEach(function (customer) {
                $('#khachHangSelect').append('<option value="' + customer.id + '">' + customer.hoVaTen + '</option>');
            });
            $
            // Handle select change event
            $('#khachHangSelect').change(function () {
                var selectedCustomerId = $(this).val();
                var selectedCustomer = data.find(function (customer) {
                    return customer.id === selectedCustomerId;
                });
                // Điền thông tin vào các trường tương ứng
                $('#hoVaTen').val(selectedCustomer.hoVaTen);
                $('#sdt').val(selectedCustomer.soDienThoai ? selectedCustomer.soDienThoai : '');
                // Điền ID vào trường input ẩn
                $('#id-khach-hang').val(selectedCustomerId);
                fillCustomerData(selectedCustomer);
            });
        });
    });

</script>

</body>

</html>
