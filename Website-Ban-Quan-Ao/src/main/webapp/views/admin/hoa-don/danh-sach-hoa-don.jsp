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


<body>
<c:set var="tongTien" value="0" />
<c:forEach items="${listSanPhamTrongGioHang}" var="sp" varStatus="status">
    <c:set var="tongTien" value="${tongTien + (sp.soLuong * sp.gia)}" />
</c:forEach>
<c:set var="tongTien" value="${tongTien + hoaDon.phiVanChuyen}" />
<div class="">
    <div class="row">
            <span class="d-flex">
                <p class="text-warning me-2"> Danh sách hoá đơn</p> / <p class="ms-2">${hoaDon.ma}</p>
            </span>

    </div>
    <div class="row">
       <span class="text-uppercase">
           Trạng thái hiện tại:
            <c:if test="${hoaDon.trangThai == 0}">
                <span class="text-secondary">Chờ thanh toán</span>
            </c:if>
            <c:if test="${hoaDon.trangThai == 1}">
                <span class="text-success">Đã thanh toán</span>
            </c:if>
           <c:if test="${hoaDon.trangThai == 2}">
               <span class="text-secondary">Chờ xác nhận</span>
           </c:if>
              <c:if test="${hoaDon.trangThai == 3}">
                <span class="text-secondary">Chờ giao</span>
            </c:if>
            <c:if test="${hoaDon.trangThai == 4}">
                <span class="text-success">Đang giao</span>
            </c:if>
            <c:if test="${hoaDon.trangThai == 5}">
                <span class="text-danger">Đã huỷ</span>
            </c:if>
       </span>
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
                    <p>Địa chỉ: ${hoaDon.diaChi}</p>

                </div>
                <div class="col-4">
                    <p>Phí vận chuyển: ${hoaDon.phiVanChuyen}</p>
                    <p id="tong_tien_1">Tổng tiền: ${tongTien}</p>
                    <p>Trạng thái:
                        <c:if test="${hoaDon.trangThai == 0}">
                            <span class="text-secondary">Chờ thanh toán</span>
                        </c:if>
                        <c:if test="${hoaDon.trangThai == 1}">
                            <span class="text-success">Đã thanh toán</span>
                        </c:if>
                        <c:if test="${hoaDon.trangThai == 2}">
                            <span class="text-secondary">Chờ xác nhận</span>
                        </c:if>
                        <c:if test="${hoaDon.trangThai == 3}">
                            <span class="text-secondary">Chờ giao</span>
                        </c:if>
                        <c:if test="${hoaDon.trangThai == 4}">
                            <span class="text-success">Đang giao</span>
                        </c:if>
                        <c:if test="${hoaDon.trangThai == 5}">
                            <span class="text-danger">Đã huỷ</span>
                        </c:if>
                    </p>
                    <p>Ngày thanh toán: ${hoaDon.ngayThanhToan}</p>
                    <p>Loại hoá
                        đơn:
                        <c:if test="${hoaDon.loaiHoaDon == 0}">
                            <span class="text-secondary">Bán tại quầy</span>
                        </c:if>
                        <c:if test="${hoaDon.loaiHoaDon == 1}">
                            <span class="text-success">Bán Online</span>
                        </c:if>
                        <c:if test="${hoaDon.loaiHoaDon == 2}">
                            <span class="text-secondary">Giao Hàng</span>
                        </c:if>
                    </p>
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
            <c:if test="${hoaDon.trangThai == 1}">
                <p class="fw-bold text-success float-end">Đơn hàng đã được thanh toán</p>
            </c:if>
            <c:if test="${hoaDon.trangThai !=1}">
                <button type="button" class="btn btn-primary float-end" data-bs-toggle="modal"
                        data-bs-target="#exampleModal">
                    Thanh toán
                </button>
            </c:if>

        </div>
        <div class="card-body">
            <c:if test="${hoaDon.trangThai == 1}">
                <div class="">
                    <table class="table text-center">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Số tiền</th>
                            <th scope="col">Thời gian</th>
                            <th scope="col">Phương thức thanh toán</th>
                            <th scope="col">Nhân viên xác nhận</th>
                            <th scope="col">Ghi chú</th>
                        </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>${tongTien}</td>
                                <td>${hoaDon.ngayThanhToan}</td>
                                <td>${hoaDon.hinhThucThanhToan == 1 ? 'Tiền mặt' : 'Chuyển khoản'}</td>
                                <td>${hoaDon.idNhanVien.hoVaTen}</td>
                                <td>${hoaDon.ghiChu}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </c:if>
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
                                                <img src="${anhSanPham.duongDan}" class="d-block" id="custom-anh"
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
                            <td>${sp.soLuong * sp.gia}</td>
                        </tr>
                        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                        <script>

                            // get Anh sp
                            $(document).ready(function () {
                                var idSanPham = '${sp.idSanPhamChiTiet}';
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
</script>
</body>

</html>