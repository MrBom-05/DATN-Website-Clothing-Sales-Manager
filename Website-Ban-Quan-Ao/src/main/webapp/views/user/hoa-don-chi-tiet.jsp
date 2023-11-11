<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-8 offset-2 mt-5">
    <div class="row">
            <span class="d-flex">
                <p class="me-2">Hoá đơn chi tiết</p> / <p class="ms-2">${hoaDon.ma}</p>
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

    <div class="card mt-4">
        <div class="card-header">
            <p class="fw-bold text-uppercase">Thông tin đơn hàng</p>
        </div>
        <div class="card-body">
            <div class="row fw-bold">
                <div class="col-4">
                    <p>Mã hoá đơn: ${hoaDon.ma}</p>
                    <p>Ngày lập: <span id="formattedDate${index.count}"></span>
                        <script>
                            var originalDate = "${hoaDon.ngayTao}";
                            var formattedDate = new Date(originalDate).toLocaleString();
                            document.getElementById("formattedDate${index.count}").textContent = formattedDate;
                        </script>
                    </p>
                    <p>Khách hàng: ${hoaDon.nguoiNhan}</p>
                    <p>Địa chỉ: ${hoaDon.diaChi} / ${hoaDon.xaPhuong} / ${hoaDon.quanHuyen} / ${hoaDon.tinhThanhPho}</p>
                </div>
                <div class="col-5">
                    <p id="tongTien">${tongTien}</p>
                    <script>
                        var giaSanPhamElement = document.getElementById("tongTien");
                        var giaSanPhamText = giaSanPhamElement.innerText;
                        var formattedGia = parseInt(giaSanPhamText.replace(/[^\d]/g, '')).toLocaleString('en-US');
                        giaSanPhamElement.innerText = "Tổng tiền: " + formattedGia + " vnđ";
                    </script>
                    <p>Ngày thanh toán: <span id="formattedDate1${index.count}"></span>
                        <script>
                            var originalDate = "${hoaDon.ngayThanhToan}";
                            var formattedDate = new Date(originalDate).toLocaleString();
                            document.getElementById("formattedDate1${index.count}").textContent = formattedDate;
                        </script>
                    </p>
                </div>
                <div class="col-3">
                        <textarea cols="30" rows="5" class="form-control" placeholder="Ghi chú"
                                  readonly>${hoaDon.ghiChu}
                        </textarea>
                </div>
            </div>
            <c:if test="${hoaDon.maVanChuyen != null}">
                <hr>
                <div class="row fw-bold">
                    <div class="col-4">
                        <p>Mã Vận Chuyển: ${hoaDon.maVanChuyen}</p>
                    </div>
                    <div class="col-4">
                        <p>Tên Đơn Vị Vận Chuyển: ${hoaDon.tenDonViVanChuyen}</p>
                    </div>
                    <div class="col-4">
                        <p id="phiVanChuyen">${hoaDon.phiVanChuyen}</p>
                        <script>
                            var giaSanPhamElement = document.getElementById("phiVanChuyen");
                            var giaSanPhamText = giaSanPhamElement.innerText;
                            var formattedGia = parseInt(giaSanPhamText.replace(/[^\d]/g, '')).toLocaleString('en-US');
                            giaSanPhamElement.innerText = "Phí Giao Hàng: " + formattedGia + " vnđ";
                        </script>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <div class="card mt-4 mb-4">
        <div class="card-header">
            <p class="fw-bold text-uppercase">Sản phẩm</p>
        </div>
        <div class="card-body">
            <table class="table text-center align-middle">
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
                <c:forEach items="${listSanPhamTrongHoaDon}" var="sp" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>
                            <div id="carouselExampleSlidesOnly_${sp.idSanPhamChiTiet}"
                                 class="carousel slide" data-bs-ride="carousel" data-bs-interval="2000">
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
                            <p>${sp.tenMauSac}/${sp.tenKichCo}</p>
                        </td>
                        <td id="giaSP_${sp.id}">${sp.gia}</td>
                        <script>
                            var giaSanPhamElement = document.getElementById("giaSP_${sp.id}");
                            var giaSanPhamText = giaSanPhamElement.innerText;
                            var formattedGia = parseInt(giaSanPhamText.replace(/[^\d]/g, '')).toLocaleString('en-US');
                            giaSanPhamElement.innerText = formattedGia + " vnđ";
                        </script>
                        <td>${sp.soLuong}</td>
                        <td id="tongGia_${sp.id}">${sp.soLuong * sp.gia}</td>
                        <script>
                            var giaSanPhamElement = document.getElementById("tongGia_${sp.id}");
                            var giaSanPhamText = giaSanPhamElement.innerText;
                            var formattedGia = parseInt(giaSanPhamText.replace(/[^\d]/g, '')).toLocaleString('en-US');
                            giaSanPhamElement.innerText = formattedGia + " vnđ";
                        </script>
                    </tr>
                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <script>
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
    <div>
        <form action="/submit-payment/${id}" method="post">
            <button type="submit" class="btn btn-success">Xác nhận đã thanh toán</button>
        </form>
    </div>
</div>