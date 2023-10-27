<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <style>
        /* Thêm kiểu CSS tùy chỉnh của bạn ở đây */
        .k-tabstrip-items {
            list-style-type: none;
            display: flex; /* Hiển thị các tab liền kề nhau */
            padding: 0;
            margin: 0;
        }

        .k-item {
            border: 1px solid #ccc;
            margin: 5px;
            padding: 5px 10px;
            cursor: pointer;
            flex: 1; /* Đảm bảo mỗi tab chiếm cùng một phần */
        }

        .k-item:hover {
            background-color: #f0f0f0;
        }

        .k-state-active {
            background-color: #007bff;
            color: white;
        }

        .k-link {
            margin-left: 5px;
        }

        .k-loading {
            display: none;
        }

        .tabbed-content {
            display: none;
        }
    </style>
</head>
<body>
<div class="px-4">
    <div class="row mt-2">
        <div class="col-lg-3">
            <h3>Hoá đơn</h3>
        </div>
<%--        <div class="col-lg-3">--%>
<%--            <input type="text" class="form-control" placeholder="Tìm kiếm">--%>
<%--        </div>--%>
<%--        <div class="col-lg-6 float-end">--%>
<%--            <button class="btn btn-success">Xuất file</button>--%>
<%--        </div>--%>
    </div>

    <div class="row mt-3">
        <%--    lọc đang bán-ngừng bán--%>
<%--        <div class="col-2 ms-1 mt-3">--%>
<%--            <select id="statusSelect" class="form-select" aria-label="Default select example"--%>
<%--                    onchange="filterByStatus()">--%>
<%--                <option value="" ${param.status == null ? 'selected' : ''}>Tất cả</option>--%>
<%--                <option value="1" ${param.status == '1' ? 'selected' : ''}>Đang bán</option>--%>
<%--                <option value="0" ${param.status == '0' ? 'selected' : ''}>Ngừng bán</option>--%>
<%--            </select>--%>
<%--        </div>--%>
        <section class="col-lg-12">
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th>STT</th>
                        <th>Mã Hoá Đơn</th>
                        <th>Nhân Viên</th>
                        <th>Khách Hàng</th>
                        <th>Ngày tạo</th>
                        <th>Trạng thái</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${listHoaDon}" var="hoaDon" varStatus="index">
                        <tr class="show-tabs" data-tab="tabs-${index.count}">
                            <td>${index.count}</td>
                            <td>${hoaDon.ma}</td>
                            <td>${hoaDon.idNhanVien.hoVaTen}</td>
                            <td>Khách Lẻ</td>
                            <td>${hoaDon.ngayTao}</td>
                            <td>${hoaDon.trangThai == 0 ? "Chờ thanh toán" : "Đã thanh toán"}</td>
                            <td>
                                <a href="/view-hoa-don/${hoaDon.id}" class="btn btn-primary detail-link" data-tab="tabs-${index.count}">Chi tiết</a>
                            </td>
                        </tr>
                        <tr class="tab-row">
                            <td colspan="8">
                                <div class="tabbed-content" id="tabs-${index.count}">
                                    <ul class="k-tabstrip-items k-reset">
                                        <li class="k-item" role="tab" aria-controls="tab-${index.count}-1"
                                            aria-selected="true">
                                            <span class="k-loading "></span>
                                            <span class="k-link">Thông tin</span>
                                        </li>
                                        <li class="k-item" role="tab" aria-controls="tab-${index.count}-2">
                                            <span class="k-loading "></span>
                                            <span class="k-link">Lịch sử trả hàng</span>
                                        </li>
                                        <li class="k-item" role="tab" aria-controls="tab-${index.count}-3">
                                            <span class="k-loading "></span>
                                            <span class="k-link">Lịch sử thanh toán</span>
                                        </li>
                                    </ul>
                                    <!-- Thêm nội dung cho từng tab dưới hàng bảng -->
                                    <div id="tab-${index.count}-1-content" class="tab-content">
                                        <section class="row">
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
                                            <textarea name="" id="" cols="30" rows="5" class="form-control"
                                                      placeholder="Ghi chú" readonly>
                                                    ${hoaDon.ghiChu}
                                            </textarea>
                                            </div>
                                        </section>
                                        <section class="row">
                                            <table class="table table-bordered text-center mt-3">
                                                <thead>
                                                <tr>
                                                    <th>STT</th>
                                                    <th>Mã sản phẩm</th>
                                                    <th>Tên sản phẩm</th>
                                                    <th>Số lượng</th>
                                                    <th>Đơn giá</th>
                                                    <th>Thành tiền</th>
                                                </tr>
                                                </thead>
                                                <c:forEach items="${listSanPhamTrongGioHang}" var="gioHang" varStatus="index">
                                                    <tr>
                                                        <td>${index.count}</td>
                                                        <td>${gioHang.maSanPham}</td>
                                                        <td>${gioHang.tenSanPham}/${gioHang.tenMau}/${gioHang.tenSize}</td>
                                                        <td>${gioHang.soLuong}</td>
                                                        <td>${gioHang.gia}</td>
                                                        <td>${gioHang.soLuong * gioHang.gia}</td>
                                                        <c:set var="tongTien" value="${tongTien + (gioHang.soLuong * gioHang.gia)}"/>
                                                    </tr>
                                                </c:forEach>

                                            </table>
                                        </section>
                                    </div>
                                    <div id="tab-${index.count}-2-content" class="tab-content" style="display: none">
                                        <!-- Nội dung cho tab "Lịch sử trả hàng" -->
                                        <p>Đây là nội dung cho tab "Lịch sử trả hàng".</p>
                                    </div>
                                    <div id="tab-${index.count}-3-content" class="tab-content" style="display: none">
                                        <!-- Nội dung cho tab "Lịch sử thanh toán" -->
                                        <p>Đây là nội dung cho tab "Lịch sử thanh toán".</p>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <!-- Bạn có thể thêm nhiều hàng và giao diện tab liên quan khác ở đây -->
        </section>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function () {

        $(".show-tabs").click(function () {

            // Lấy container tab liên quan đến hàng bị nhấp
            var tabContainer = $("#" + $(this).data("tab"));
            // Kiểm tra xem tabContainer đang ẩn không
            var isHidden = tabContainer.is(":hidden");

            // Ẩn tất cả các container tab ngoại trừ container của hàng bị nhấp
            $(".tabbed-content").hide();
            // Loại bỏ trạng thái active khỏi tất cả các tab
            $(".k-item").removeClass("k-state-active");
            // Thêm trạng thái active cho tab đầu tiên của container tab của hàng bị nhấp
            tabContainer.find(".k-item:first").addClass("k-state-active");

            // Hiển thị container tab liên quan đến hàng bị nhấp nếu đang bị ẩn, ngược lại thì ẩn nó đi
            if (isHidden) {
                tabContainer.show();
            } else {
                tabContainer.hide();
            }
            // khi click vào chi tiết thì tự động showtab :
            tabContainer.find(".k-item:first").click();

        });


        // Xử lý khi tab được nhấp trong container tab
        $(".k-item").click(function () {
            // Loại bỏ trạng thái active khỏi tất cả các tab trong cùng container
            $(this).siblings().removeClass("k-state-active");
            // Thêm trạng thái active cho tab được nhấp
            $(this).addClass("k-state-active");
            // Ẩn tất cả container nội dung trong cùng container tab
            $(this).closest(".tabbed-content").find(".tab-content").hide();
            // Lấy container nội dung liên quan đến tab được nhấp
            var contentContainer = $("#" + $(this).attr("aria-controls") + "-content");
            // Hiển thị container nội dung liên quan đến tab được nhấp
            contentContainer.show();
        });
    });
</script>
</body>
</html>

