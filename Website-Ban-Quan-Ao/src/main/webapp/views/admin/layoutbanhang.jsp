<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý hóa đơn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<%-- Tạo biến tổng tiền --%>
<c:set var="tongTien" value="0"/>
<c:if test="${not empty sessionScope.successMessage}">
    <div class="alert alert-success" role="alert">
            ${sessionScope.successMessage}
    </div>
    <% session.removeAttribute("successMessage"); %>
</c:if>
<c:if test="${not empty sessionScope.errorMessage}">
    <div class="alert alert-danger" role="alert">
            ${sessionScope.errorMessage}
    </div>
    <% session.removeAttribute("errorMessage"); %>
</c:if>

<div class="container mt-5">
    <div class="row">
        <div class="col-lg-6">
            <h4>Danh sách hóa đơn</h4>
            <form method="post" action="/admin/ban-hang/add-hoa-don">
                <input type="hidden" name="id" value="${admin.id}">
                <button type="submit" class="btn btn-primary">Tạo mới</button>
            </form>
            <table class="table table-bordered text-center mt-3">
                <thead>
                <tr>
                    <th>STT</th>
                    <th>Mã Hoá Đơn</th>
                    <th>Nhân Viên</th>
                    <th>Ngày tạo</th>
                    <th>Trạng thái</th>
                    <th colspan="2">Thao Tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${listHoaDon}" var="hoaDon" varStatus="index">
                    <tr>
                        <td>${index.count}</td>
                        <td>${hoaDon.ma}</td>
                        <td>${hoaDon.idNhanVien.hoVaTen}</td>

                        <td>
<%--                            format ngày tạo--%>
                            <span id="formattedDate${index.count}"></span>
                            <script>
                                var originalDate = "${hoaDon.ngayTao}";
                                var formattedDate = new Date(originalDate).toLocaleString();
                                document.getElementById("formattedDate${index.count}").textContent = formattedDate;
                            </script>
                        </td>

                        <td>${hoaDon.trangThai == 0 ? "Chờ thanh toán" : "Đã thanh toán"}</td>
                        <td>
                            <a href="/admin/ban-hang/view-hoa-don/${hoaDon.id}" class="btn btn-primary">Xem</a>
                        </td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>

            <div class="row mt-4">
                <div class="col-12">
                    <h4>Giỏ hàng</h4>
                    <table class="table table-bordered text-center mt-3">
                        <thead>
                        <tr>
                            <th>STT</th>
                            <th>Mã sản phẩm</th>
                            <th>Tên sản phẩm</th>
                            <th>Số lượng</th>
                            <th>Đơn giá</th>
                            <th>Thành tiền</th>
                            <th>Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${listSanPhamTrongGioHang}" var="gioHang" varStatus="index">
                            <tr>
                                <td>${index.count}</td>
                                <td>${gioHang.maSanPham}</td>
                                <td>${gioHang.tenSanPham}/${gioHang.tenMau}/${gioHang.tenSize}</td>
                                <td>${gioHang.soLuong}</td>
                                <td>${gioHang.gia}</td>
                                <td>${gioHang.soLuong * gioHang.gia}</td>
                                <c:set var="tongTien" value="${tongTien + (gioHang.soLuong * gioHang.gia)}"/>
                                <td>
                                    <c:if test="${hoaDon.trangThai == 0}">
                                        <form method="post"
                                              action="/admin/ban-hang/delete-gio-hang/${gioHang.idHoaDonChiTiet}">
                                            <div class="input-group">
                                                <input type="number" name="soLuong" class="w-50 form-control" min="1"
                                                       max="${gioHang.soLuong}" value="1" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                                                <div class="input-group-append mt-2">
                                                    <button type="submit" class="btn btn-danger">Xóa</button>
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
            </div>

            <div class="row mt-4">
                <div class="col-12">
                    <h4>Danh sách sản phẩm</h4>

                    <div class="row">
                        <!-- repeat -->
                        <c:forEach items="${listProduct.content}" var="product">
                            <div class="col-4 mb-4">
                                <div class="card">
                                    <div class="card-body text-center">
                                        <span class="card-title fw-bold">${product.sanPham.ten}/${product.mauSac.ten}/${product.kichCo.ten}</span>
                                        <p class="fw-bold gia-san-pham"
                                           id="gia-san-pham_${product.id}">${product.gia} vnđ</p>
                                        <p class="fw-bold gia-moi" id="gia-moi_${product.id}"></p>
                                        <p class="card-text">Số lượng: ${product.soLuong}</p>
                                        <c:if test="${hoaDon.trangThai == 0}"> <!-- Kiểm tra trạng thái hóa đơn (0 là chờ thanh toán) -->
                                            <form method="post" action="/admin/ban-hang/add-gio-hang/${idHoaDon}">
                                                <input type="hidden" name="idSanPhamChiTiet" value="${product.id}"/>
                                                <input type="hidden" name="gia" value="${product.gia} " id="gia_${product.id}"/>
                                                <input type="hidden" name="soLuong" value="${product.soLuong}"/>
                                                <!-- Giữ nguyên số lượng hiện tại -->
                                                <div class="form-group">
                                                    <label>Số lượng:</label>
                                                    <input type="number" name="soLuongMoi" id="soLuongMoi"
                                                           class="form-control" min="1" max="${product.soLuong}"
                                                           value="1"/>
                                                </div>
                                                <button type="submit" class="btn btn-primary mt-1 ">Thêm vào giỏ hàng
                                                </button>
                                            </form>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                            <script>
                                $(document).ready(function () {
                                    var idSanPhamChiTiet = '${product.id}';
                                    var giaInput = $("#gia_${product.id}"); // Lấy ô input dựa trên id
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
                                                    var giaSanPham = ${product.gia};
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
                        <!-- end repeat -->
                    </div>
                </div>
            </div>
        </div>



        <div class="col-lg-2">
            <div class="form-group">
                <label>Quét mã QR code</label>
                <div class="video-container">
                    <video id="qr-video" width="150px"></video>
                    <canvas id="qr-canvas" style="display: none;"></canvas>
                    <div id="qr-result">Chưa có mã QR code được quét.</div>
                </div>
            </div>
        </div>
        <div class="col-lg-4 border">
            <h4 class="text-center">Thanh toán</h4>
            <form method="post" action="/admin/ban-hang/thanh-toan/${idHoaDon}">
                <div class="mb-3">
                    <label class="form-label">Tổng tiền</label>
                    <label class="form-label float-end" id="tong-tien">${tongTien}</label>
                </div>
                <c:if test="${hoaDon.trangThai == 0}">
                    <div class="mb-3">
                        <label class="form-label">Hình thức thanh toán</label>
                        <select class="form-select" id="hinh-thuc-thanh-toan" name="httt"
                                aria-label="Default select example">
                            <option selected value="0">Chọn hình thức thanh toán</option>
                            <option value="1">Tiền mặt</option>
                            <option value="2">Chuyển khoản</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Tiền khách đưa</label>
                        <input type="number" class="form-control" id="tien-khach-dua" name="tienKhachDua"
                               min="${tongTien}" step="0.01">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Tiền Thừa</label>
                        <label class="form-label float-end" id="tien-thua">0</label>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Ghi chú</label>
                        <textarea class="form-control" id="ghi-chu" name="ghiChu" rows="3"
                                  placeholder="Nhập địa chỉ"></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Thanh toán</button>
                </c:if>
                <c:if test="${hoaDon.trangThai == 1}">
                    <span class="text-danger">Hóa đơn đã thanh toán</span>
                </c:if>
            </form>
        </div>

    </div>
</div>


<script src="https://rawgit.com/schmich/instascan-builds/master/instascan.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script>
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
        // Đảm bảo mã JavaScript sẽ được thực thi sau khi trang tải xong.

        // Lấy phần tử HTML
        var selectElement = $("#hinh-thuc-thanh-toan");
        var tienKhachDuaInput = $("#tien-khach-dua");
        var tongTienLabel = $("#tong-tien");
        var tienThuaLabel = $("#tien-thua");

        // Thêm sự kiện "change" cho phần tử select (dropdown)
        selectElement.on("change", function () {
            // Xử lý khi lựa chọn thay đổi

            // Lấy giá trị của hình thức thanh toán
            var hinhThucThanhToan = selectElement.val();

            // Xử lý logic ở đây, ví dụ tính tổng tiền và tiền thừa dựa trên hình thức thanh toán
            if (hinhThucThanhToan === "2" || hinhThucThanhToan === "3") { // Chuyển khoản hoặc Thẻ
                var tongTien = parseFloat(tongTienLabel.text());
                tienKhachDuaInput.val(tongTien);
            } else {
                tienKhachDuaInput.val(""); // Đặt giá trị về trống nếu chọn hình thức thanh toán khác
            }
        });
        // Thêm sự kiện "blur" cho phần tử "Tiền khách đưa"
        tienKhachDuaInput.on("blur", function () {
            // Xử lý khi người dùng rời khỏi trường nhập tiền khách đưa

            // Lấy giá trị của "Tiền khách đưa" sau khi người dùng đã nhập
            var tienKhachDua = parseFloat(tienKhachDuaInput.val());
            var tongTien = parseFloat(tongTienLabel.text());

            if (tienKhachDua >= tongTien) {
                var tienThua = tienKhachDua - tongTien;
                tienThuaLabel.text(tienThua);
            } else {
                // Nếu tiền khách đưa không đủ, đặt tiền thừa về 0 và cảnh báo
                tienThuaLabel.text("0");
                alert("Tiền khách đưa phải lớn hơn hoặc bằng tổng tiền!");
            }
        });
    });
    //
</script>


</body>

</html>
