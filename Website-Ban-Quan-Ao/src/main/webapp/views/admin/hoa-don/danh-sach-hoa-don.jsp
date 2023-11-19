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

<c:set var="tongTien" value="0"/>
<c:forEach items="${listSanPhamTrongGioHang}" var="sp" varStatus="status">
    <c:set var="tongTien" value="${tongTien + (sp.soLuong * sp.gia)}"/>
</c:forEach>
<c:set var="tongTien" value="${tongTien + hoaDon.phiVanChuyen}"/>
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
                <c:if test="${hoaDon.trangThai == 0 || hoaDon.trangThai == 2 || hoaDon.trangThai == 3}">
                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#modalHuy">
                        Huỷ đơn hàng
                    </button>
                </c:if>
                <c:if test="${hoaDon.trangThai == 0 || hoaDon.trangThai == 2 || hoaDon.trangThai == 3 }">
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalXacNhan">
                        Xác nhận
                    </button>
                </c:if>
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
                    <p>Ngày tạo:
                        <%--format ngày tạo--%>
                        <span id="ngay-tao-1"></span>
                        <script>
                            var originalDate = "${hoaDon.ngayTao}";
                            var formattedDate = new Date(originalDate).toLocaleString();
                            document.getElementById("ngay-tao-1").textContent = formattedDate;
                        </script>
                    </p>
                    <p>Khách hàng:
                        <c:if test="${hoaDon.idKhachHang != null}">
                            ${hoaDon.idKhachHang.hoVaTen}
                        </c:if>
                        <c:if test="${hoaDon.idKhachHang == null}">
                            Khách lẻ
                        </c:if>
                    </p>
                    <p>Nhân viên: ${hoaDon.idNhanVien.hoVaTen}</p>
                    <p>Địa chỉ: ${hoaDon.diaChi}</p>
                    <c:if test="${hoaDon.trangThai == 3}">
                        <p>Số điện thoại: ${hoaDon.soDienThoai}</p>
                        <p>Mã vận đơn: ${hoaDon.maVanChuyen}</p>
                        <p>Đơn vị vận chuyển: ${hoaDon.tenDonViVanChuyen}</p>
                    </c:if>

                </div>
                <div class="col-4">
                    <p id="phi-van-chuyen">Phí vận chuyển: ${hoaDon.phiVanChuyen}</p>
                    <p id="tong_tien_1">${tongTien}</p>
                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            var giaElement = document.getElementById('tong_tien_1');
                            // Lấy giá trị không định dạng từ thẻ p
                            var giaValue = parseFloat(giaElement.textContent.replace(/[^\d.]/g, '')) || 0;
                            // Định dạng lại giá trị và gán lại vào thẻ p
                            giaElement.textContent = giaValue.toLocaleString('en-US');
                            // thêm chữ tônhr tiền trước giá trị
                            giaElement.insertAdjacentText('afterbegin', 'Tổng tiền: ');
                            giaElement.insertAdjacentHTML('beforeend', 'VNĐ ');

                            // format phí vânj chuyển
                            var phiVanChuyenElement = document.getElementById('phi-van-chuyen');
                            // Lấy giá trị không định dạng từ thẻ p
                            var phiVanChuyenValue = parseFloat(phiVanChuyenElement.textContent.replace(/[^\d.]/g, '')) || 0;
                            // Định dạng lại giá trị và gán lại vào thẻ p
                            phiVanChuyenElement.textContent = phiVanChuyenValue.toLocaleString('en-US');
                            // thêm chữ tônhr tiền trước giá trị
                            phiVanChuyenElement.insertAdjacentText('afterbegin', 'Phí vận chuyển: ');
                            phiVanChuyenElement.insertAdjacentHTML('beforeend', 'VNĐ ');
                        });
                    </script>
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
                    <p>Ngày thanh toán:
                        <%--format ngày tạo--%>
                        <span id="ngay-tt-1"></span>
                        <script>
                            var originalDate = "${hoaDon.ngayThanhToan}";
                            var formattedDate = new Date(originalDate).toLocaleString();
                            document.getElementById("ngay-tt-1").textContent = formattedDate;
                        </script>
                    </p>
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
            <c:if test="${hoaDon.trangThai !=1 && hoaDon.trangThai != 5}">
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
                            <td id="tong_tien_2">${tongTien}</td>
                            <script>
                                // format giá
                                document.addEventListener('DOMContentLoaded', function () {
                                    var giaElement = document.getElementById('tong_tien_2');
                                    // Lấy giá trị không định dạng từ thẻ p
                                    var giaValue = parseFloat(giaElement.textContent.replace(/[^\d.]/g, '')) || 0;
                                    // Định dạng lại giá trị và gán lại vào thẻ p
                                    giaElement.textContent = giaValue.toLocaleString('en-US');

                                });
                            </script>
                            <td>
                                    <%--format ngày tạo--%>
                                <span id="ngay-tt-2"></span>
                                <script>
                                    var originalDate = "${hoaDon.ngayThanhToan}";
                                    var formattedDate = new Date(originalDate).toLocaleString();
                                    document.getElementById("ngay-tt-2").textContent = formattedDate;
                                </script>
                            </td>
                            <td>
                                <c:if test="${hoaDon.loaiHoaDon == 2}">
                                    <span class="text-success">Đã thanh toán trước</span>
                                </c:if>
                                <c:if test="${hoaDon.loaiHoaDon != 2}">
                                    <c:if test="${hoaDon.hinhThucThanhToan == 1}">
                                        Tiền mặt
                                    </c:if>
                                    <c:if test="${hoaDon.hinhThucThanhToan == 0}">
                                        Chuyển khoản
                                    </c:if>
                                    <c:if test="${hoaDon.hinhThucThanhToan == 2}">
                                        Thanh toán VNPay
                                    </c:if>
                                </c:if>
                            </td>
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
                            <td id="gia_sp_${sp.idSanPhamChiTiet}">${sp.gia}</td>
                            <td>${sp.soLuong}</td>
                            <td id="tong_tien_${sp.idSanPhamChiTiet}">
                                    ${sp.soLuong * sp.gia}</td>
                            <script>
                                // format tổng tiền
                                document.addEventListener('DOMContentLoaded', function () {
                                    var giaElement = document.getElementById('tong_tien_${sp.idSanPhamChiTiet}');
                                    // Lấy giá trị không định dạng từ thẻ p
                                    var giaValue = parseFloat(giaElement.textContent.replace(/[^\d.]/g, '')) || 0;
                                    // Định dạng lại giá trị và gán lại vào thẻ p
                                    giaElement.textContent = giaValue.toLocaleString('en-US');
                                    // format giá
                                    var giaElement = document.getElementById('gia_sp_${sp.idSanPhamChiTiet}');
                                    // Lấy giá trị không định dạng từ thẻ p
                                    var giaValue = parseFloat(giaElement.textContent.replace(/[^\d.]/g, '')) || 0;
                                    // Định dạng lại giá trị và gán lại vào thẻ p
                                    giaElement.textContent = giaValue.toLocaleString('en-US');
                                });



                            </script>
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
                <button type="button" class="btn-Đóng" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <form action="/admin/hoa-don/xac-nhan-thanh-toan/${hoaDon.id}" method="post">
                <input type="hidden" name="trangThai" value="1">
                <c:if test="${hoaDon.trangThai == 4}">
                    <input type="hidden" name="httt" value="0">
                </c:if>
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
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-primary">Lưu</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- modal xác nhận đơn hàng -->
<div class="modal fade" id="modalXacNhan" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <c:if test="${hoaDon.trangThai != 2}">
                <form action="/admin/hoa-don/update-trang-thai/${hoaDon.id}" method="post">
                    <input type="hidden" name="trangThai" value="" id="trang-thai">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Ghi chú </label>
                            <textarea class="form-control" name="ghiChu" rows="3"
                                      placeholder="Ghi chú"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" class="btn btn-primary">Lưu</button>
                    </div>
                </form>
            </c:if>
            <c:if test="${hoaDon.trangThai == 2}">
                <form action="/admin/hoa-don/update-trang-thai-online/${hoaDon.id}" method="post">
                    <input type="hidden" name="trangThai" value="" id="trang-thai">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Ghi chú </label>
                            <textarea class="form-control" name="ghiChu" rows="3"
                                      placeholder="Ghi chú"></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mã vận đơn </label>
                            <input type="text" class="form-control" name="maVanChuyen" placeholder="Mã vận đơn">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Đơn vị vận chuyển </label>
                            <input type="text" class="form-control" name="tenDonViVanChuyen"
                                   placeholder="Đơn vị vận chuyển">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Phí vận chuyển </label>
                            <input type="number" class="form-control" name="phiVanChuyen" placeholder="Phí vận chuyển">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" class="btn btn-primary">Lưu</button>
                    </div>
                </form>
            </c:if>
        </div>
    </div>
</div>
<!-- modal huỷ -->
<div class="modal fade" id="modalHuy" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="/admin/hoa-don/update-trang-thai/${hoaDon.id}" method="post">
                <input type="hidden" name="trangThai" value="5">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Ghi chú </label>
                        <textarea class="form-control" id="ghi-chu" name="ghiChu" rows="3"
                                  placeholder="Ghi chú"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-danger">Lưu</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    const trangThai = document.getElementById('trang-thai');
    const trangThaiHoaDon = ${hoaDon.trangThai};
    if (trangThaiHoaDon == 2) {
        trangThai.value = 3;
    }
    if (trangThaiHoaDon == 3) {
        trangThai.value = 4;
    }

</script>

</body>

</html>