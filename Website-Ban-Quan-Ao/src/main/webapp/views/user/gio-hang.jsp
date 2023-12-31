<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        hideErrorMessage();
    });

    function hideErrorMessage() {
        setTimeout(function () {
            $('.alert-success').fadeOut('slow');
        }, 5000);
    }
</script>
<div class="row container mt-3 ms-5">
    <div class="col-8">
        <table class="table align-middle">
            <thead class="text-center">
            <tr>
                <th colspan="2">Sản phẩm</th>
                <th>Giá</th>
                <th>Số lượng</th>
                <th>Tạm tính</th>
                <th></th>
            </tr>
            </thead>
            <tbody class="text-center">
            <c:forEach items="${listGioHang}" var="gioHang">
                <tr>
                    <td>
                        <div id="carouselExampleSlidesOnly_${gioHang.idSanPhamChiTiet}"
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

                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <script>
                        $(document).ready(function () {
                            var idSanPham = '${gioHang.idSanPhamChiTiet}';
                            $.ajax({
                                url: '/get-anh-san-pham/' + idSanPham,
                                type: 'GET',
                                dataType: 'json',
                                success: function (data) {
                                    // Xử lý phản hồi từ máy chủ và cập nhật danh sách ảnh
                                    var listAnhSanPham = data;
                                    var carouselInner = $('#carouselExampleSlidesOnly_${gioHang.idSanPhamChiTiet} .carousel-inner');
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

                    <td style="width: 70px">
                        <a class="link-dark text-uppercase" style="text-decoration: none"
                           href="/san-pham/${gioHang.id}/${gioHang.idMauSac}">${gioHang.tenSanPham}-${gioHang.tenMauSac}-${gioHang.tenKichCo}</a>
                    </td>

                    <td id="giaSP_${gioHang.maSanPham}">${gioHang.gia}</td>
                    <script>
                        var giaSanPhamElement = document.getElementById("giaSP_${gioHang.maSanPham}");
                        var giaSanPhamText = giaSanPhamElement.innerText;
                        var formattedGia = parseInt(giaSanPhamText.replace(/[^\d]/g, '')).toLocaleString('en-US');
                        giaSanPhamElement.innerText = formattedGia + " vnđ";
                    </script>


                    <td>
                        <form action="/gio-hang/update/${gioHang.idSanPhamChiTiet}" method="post">
                            <div class="input-group mt-3">
                                <button type="submit" class="btn btn-outline-dark" type="button"
                                        onclick="decrement_${gioHang.maSanPham}()">-
                                </button>
                                <input type="number" class="form-control text-center" style="width: 50px"
                                       id="quantity_${gioHang.maSanPham}"
                                       name="soLuong" value="${gioHang.soLuong}" min="1" max="${gioHang.soLuongTonKho}"
                                       readonly>
                                <button type="submit" class="btn btn-outline-dark" type="button"
                                        onclick="increment_${gioHang.maSanPham}()">+
                                </button>
                            </div>
                        </form>
                    </td>
                    <td id="tongGiaSP_${gioHang.maSanPham}">${gioHang.soLuong * gioHang.gia}</td>
                    <script>
                        var tongGiaSanPhamElement = document.getElementById("tongGiaSP_${gioHang.maSanPham}");
                        var tongGiaSanPhamText = tongGiaSanPhamElement.innerText;
                        var formattedTongGia = parseInt(tongGiaSanPhamText.replace(/[^\d]/g, '')).toLocaleString('en-US');
                        tongGiaSanPhamElement.innerText = formattedTongGia + " vnđ";
                    </script>
                    <td>
                        <a href="/gio-hang/${gioHang.idSanPhamChiTiet}" type="button" class="btn-close"
                           aria-label="Close"></a>
                    </td>
                </tr>
                <script>
                    function decrement_${gioHang.maSanPham}() {
                        var quantityInput = document.getElementById("quantity_${gioHang.maSanPham}");
                        var currentValue = parseInt(quantityInput.value);
                        if (currentValue > 1) {
                            quantityInput.value = currentValue - 1;
                        }
                    }

                    function increment_${gioHang.maSanPham}() {
                        var quantityInput = document.getElementById("quantity_${gioHang.maSanPham}");
                        var currentValue = parseInt(quantityInput.value);
                        var maxValue = parseInt(quantityInput.getAttribute('max'));

                        if (currentValue < maxValue) {
                            quantityInput.value = currentValue + 1;
                        }
                    }
                </script>
            </c:forEach>
            </tbody>
        </table>
        <form action="/ap-dung-voucher" method="post">
            <div class="row">
                <div class="col-3">
                    <input type="text" name="ma" class="form-control" placeholder="Mã giảm giá">
                </div>
                <div class="col-3">
                    <button id="ap-dung-btn" type="submit" class="btn btn-dark">Áp dụng</button>
                </div>
            </div>
            <c:if test="${not empty thongBaoGiamGia}">
                <div class="alert alert-success col-6 mt-2 text-center">${thongBaoGiamGia}</div>
            </c:if>
        </form>
    </div>

    <div class="col-4 border">
        <div class="ms-3">
            <div class="py-5 fw-bold fs-4 text-xl text-uppercase">
                Thành tiền
            </div>
            <div class="me-3">
                <div class="py-3 border-bottom">
                    <div class="row ms-1 me-1">
                        <label class="col fw-bold fs-6 ">Tạm tính</label>
                        <label class="col fs-6 text-end" id="tongTien">${tongTien}</label>
                        <script>
                            var tongTienElement = document.getElementById("tongTien");
                            var tongTienText = tongTienElement.innerText;
                            var formattedTongTien = parseInt(tongTienText.replace(/[^\d]/g, '')).toLocaleString('en-US');
                            tongTienElement.innerText = formattedTongTien + " vnđ";
                        </script>
                    </div>
                </div>

                <div class="bg-white py-3 border-bottom">
                    <div class="row ms-1 me-1">
                        <label class="col fw-bold fs-6">Mã khuyến mãi</label>
                        <label class="col fs-6 text-end" id="soTienDuocGiam">${soTienDuocGiam}</label>
                        <script>
                            var soTienDuocGiamElement = document.getElementById("soTienDuocGiam");
                            var soTienDuocGiamText = soTienDuocGiamElement.innerText;
                            var formattedSoTienDuocGiam = parseInt(soTienDuocGiamText.replace(/[^\d]/g, '')).toLocaleString('en-US');
                            soTienDuocGiamElement.innerText = formattedSoTienDuocGiam + " vnđ";
                        </script>
                    </div>
                </div>

                <div class="bg-white py-3 border-bottom">
                    <div class="row ms-1 me-1">
                        <label class="col-3 fw-bold fs-5">Tổng</label>
                        <label class="col fw-bold fs-5 text-end" id="soTienSauKhiGiam">${soTienSauKhiGiam}</label>
                        <script>
                            var soTienSauKhiGiamElement = document.getElementById("soTienSauKhiGiam");
                            var soTienSauKhiGiamText = soTienSauKhiGiamElement.innerText;
                            var formattedSoTienSauKhiGiam = parseInt(soTienSauKhiGiamText.replace(/[^\d]/g, '')).toLocaleString('en-US');
                            soTienSauKhiGiamElement.innerText = formattedSoTienSauKhiGiam + " vnđ";
                        </script>
                    </div>
                </div>
            </div>
            <div class="mt-3 mb-3 text-center">
                <a id="thanh-toan-link" href="/thanh-toan" class="bg-dark text-bg-dark fw-bold btn btn-dark">XÁC NHẬN
                    ĐẶT HÀNG</a>
            </div>
            <script>
                var thanhToanLink = document.getElementById('thanh-toan-link');

                var nutThanhToan = ${nutThanhToan};

                if (nutThanhToan === 0) {
                    thanhToanLink.classList.add('disabled');
                    thanhToanLink.removeAttribute('href');
                }

                var apDungBtn = document.getElementById('ap-dung-btn');

                if (nutThanhToan === 0) {
                    apDungBtn.disabled = true;
                } else {
                    apDungBtn.disabled = false;
                }
            </script>
        </div>
    </div>
</div>