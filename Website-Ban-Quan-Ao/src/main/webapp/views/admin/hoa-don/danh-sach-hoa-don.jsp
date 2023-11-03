<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>

<style>
    /*body {*/
    /*    font-family: Arial, sans-serif;*/
    /*    background-color: #f0f0f0;*/
    /*    display: flex;*/
    /*    justify-content: center;*/
    /*    align-items: center;*/
    /*    min-height: 100vh;*/
    /*    margin: 0;*/
    /*}*/

    .timeline {
        display: flex;
        align-items: stretch;
        justify-content: space-between;

    }

    .timeline-item {
        flex: 1;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .timeline-content {
        color: #fff;
        border-radius: 5px;
        padding: 10px;
        text-align: center;
        position: relative;
        margin: 10px;
        width: 100%;
        /* Đảm bảo rằng tất cả các ô có cùng kích thước */
    }

    .timeline-item:nth-child(odd) .timeline-content {
        background-color: green;
    }

    .timeline-arrow {
        display: flex;
        align-items: center;
        padding: 10px;
    }

    .timeline-arrow i {
        font-size: 24px;
    }

    .timeline-arrow i.fas.fa-arrow-right::before {
        content: "\f061";
        /* Unicode của mũi tên nơi đây */
        font-family: "Font Awesome 5 Free";
        font-weight: 900;
    }
</style>

<body>
<div class="">
    <div class="row">
            <span class="d-flex">
                <p class="text-warning me-2"> Danh sách hoá đơn</p> / <p class="ms-2">${hoaDon.ma}</p>
            </span>
        <div class="timeline">
            <div class="timeline-item">
                <div class="timeline-content">
                    <i class="fas fa-shopping-cart"></i>
                    <h2>Đặt hàng</h2>
                    <p>Ngày 01/01/2023</p>
                </div>
            </div>
            <div class="timeline-arrow">
                <i class="fas fa-arrow-right"></i>
            </div>
            <div class="timeline-item">
                <div class="timeline-content">
                    <i class="fas fa-clock"></i>
                    <h2>Chờ xác nhận</h2>
                    <p>Ngày 05/01/2023</p>
                </div>
            </div>
            <div class="timeline-arrow">
                <i class="fas fa-arrow-right"></i>
            </div>
            <div class="timeline-item">
                <div class="timeline-content">
                    <i class="fas fa-truck"></i>
                    <h2>Chờ giao</h2>
                    <p>Ngày 10/01/2023</p>
                </div>
            </div>
            <div class="timeline-arrow">
                <i class="fas fa-arrow-right"></i>
            </div>
            <div class="timeline-item">
                <div class="timeline-content">
                    <i class="fas fa-shipping-fast"></i>
                    <h2>Đang giao</h2>
                    <p>Ngày 15/01/2023</p>
                </div>
            </div>
            <div class="timeline-arrow">
                <i class="fas fa-arrow-right"></i>
            </div>
            <div class="timeline-item">
                <div class="timeline-content">
                    <i class="fas fa-check-circle"></i>
                    <h2>Hoàn thành</h2>
                    <p>Ngày 20/01/2023</p>
                </div>
            </div>
        </div>
    </div>

    <div class="row mt-2">
        <div>
            <div class="float-start">
                <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#modalHuy">
                    Huỷ
                </button>
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalXacNhan">
                    Xác nhận
                </button>
            </div>
        </div>
    </div>

    <div class="card mt-4">
        <div class="card-header">
            <p class="fw-bold text-uppercase">Thông tin đơn hàng</p>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-4">
                    <p>Mã hoá đơn: ${hoaDon.ma}</p>
                    <p>Ngày lập: ${hoaDon.ngayTao}</p>
                    <p>Khách hàng: Khách lẻ</p>
                    <p>Nhân viên: ${hoaDon.idNhanVien.hoVaTen}</p>
                </div>
                <div class="col-4">
                    <p>Tổng tiền: 1000000</p>
                    <p>Trạng
                        thái: ${hoaDon.trangThai == 0 ? "Chờ thanh toán" : "Đã thanh toán"}</p>
                    <p>Ngày thanh toán: ${hoaDon.ngayThanhToan}</p>
                    <p>Loại hoá
                        đơn: ${hoaDon.loaiHoaDon == 0 ? "Bán tại quầy" : "Bán Online"}</p>
                </div>
                <div class="col-4">
                        <textarea name="" id="" cols="30" rows="5" class="form-control" placeholder="Ghi chú"
                                  readonly>${hoaDon.ghiChu}
                        </textarea>
                </div>
            </div>
        </div>
    </div>

    <div class="card mt-4">
        <div class="card-header">
            <p class="fw-bold text-uppercase float-start">Lịch sử thanh toán</p>
            <button type="button" class="btn btn-primary float-end" data-bs-toggle="modal"
                    data-bs-target="#exampleModal">
                Xác nhận thanh toán
            </button>

        </div>
        <div class="card-body">

        </div>
    </div>

    <div class="card mt-4 mb-4">
        <div class="card-header">
            <p class="fw-bold text-uppercase">Sản phẩm</p>
        </div>
        <div class="card-body">
            <div class="">
                <table class="table text-center">
                    <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col" style="width: 150px;"><i class="fas fa-image"></i></th>
                        <th scope="col">Sản phẩm</th>
                        <th scope="col">Giá</th>
                        <th scope="col">Số lượng</th>
                        <th scope="col">Tổng tiền</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${listSanPhamTrongGioHang}" var="sp" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>
                                <!-- Ảnh -->
                                <div id="carouselExampleSlidesOnly_${sp.idSanPhamChiTiet}"
                                     class="carousel slide" data-bs-ride="carousel" data-bs-interval="1000">
                                    <div class="carousel-inner" style="width: 150px; height: 150px">
                                        <c:forEach items="${listAnhSanPham}" var="anhSanPham" varStatus="status">
                                            <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                                <img src="${anhSanPham.duongDan}" class="d-block" id="custom-anh" style="width: 150px; height: 150px">
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
                            <td>${sp.soLuong * sp.gia}</td>
                        </tr>
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
                    </c:forEach>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
</div>
<!--modal xác nhận thanh toán-->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Xác nhận thanh toán</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label class="form-label">Tổng tiền cần thanh toán</label>
                    <label class="form-label float-end" id="tong-tien">${tongTien}</label>
                </div>
                <div class="mb-3">
                    <label class="form-label">Tiền khách đưa</label>
                    <input type="number" class="form-control" id="tien-khach-dua" name="tienKhachDua"
                           min="${tongTien}" step="0.01">
                </div>
                <div class="mb-3">
                    <label class="form-label">Ghi chú </label>
                    <textarea class="form-control" name="ghiChu" rows="3"
                              placeholder="Ghi chú"></textarea>
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
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>
<!-- modal xác nhận đơn hàng -->
<div class="modal fade" id="modalXacNhan" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="mb-3">
                    <label class="form-label">Ghi chú </label>
                    <textarea class="form-control" name="ghiChu" rows="3"
                              placeholder="Ghi chú"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>
<!-- modal huỷ -->
<div class="modal fade" id="modalHuy" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="mb-3">
                    <label class="form-label">Ghi chú </label>
                    <textarea class="form-control" id="ghi-chu" name="ghiChu" rows="3"
                              placeholder="Ghi chú"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-danger">Save changes</button>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
<script>
    // Lấy đối tượng hình ảnh ban đầu
    const imgElement = document.getElementById("custom-anh");

    // Tạo một đối tượng hình ảnh mới
    const newImage = new Image();

    // Gán giá trị base64 từ thuộc tính src của thẻ <img> cho đối tượng hình ảnh mới
    newImage.src = imgElement.src;

</script>
</body>

</html>