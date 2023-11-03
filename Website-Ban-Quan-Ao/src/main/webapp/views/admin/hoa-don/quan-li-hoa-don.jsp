<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/bootstrap.min.css">

</head>
<style>
    .selected {
        text-decoration: underline;
    }
</style>
<script>
    function filterByStatus(trangThai) {
        var url;
        if (trangThai === '') {
            url = "/admin/hoa-don"; // Trả về trang chủ nếu không có trạng thái
        } else {
            url = "/admin/hoa-don/filter?trangThai=" + trangThai;
        }
        window.location.href = url;
    }
</script>
<body>
<div class="px-4">
    <div class="row mt-2">
        <div class="col-lg-3">
            <h3>Hoá đơn</h3>
        </div>
    </div>
    <div class="row mt-2">
        <div class="col-lg-4">
            <div class="btn-group">
                <button class="btn btn-toolbar ms-2 ${param.trangThai == null ? 'selected' : ''}" onclick="filterByStatus('')">Tất cả</button>
                <button class="btn btn-toolbar ms-2 ${param.trangThai == '1' ? 'selected' : ''}" onclick="filterByStatus('1')">Đã thanh toán</button>
                <button class="btn btn-toolbar ms-2 ${param.trangThai == '0' ? 'selected' : ''}" onclick="filterByStatus('0')">Chờ thanh toán</button>
            </div>
        </div>
    </div>
    <hr>
    <div class="row mt-3">
        <section class="col-lg-12">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                    <tr>
                        <th>STT</th>
                        <th>Mã Hoá Đơn</th>
                        <th>Nhân Viên</th>
                        <th>Khách Hàng</th>
                        <th>Ngày tạo</th>
                        <th>Loại hoá đơn</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
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
                            <td>
                                    ${hoaDon.loaiHoaDon == 0 ? "Tại quầy" : "Online"}
                            </td>
                            <td>${hoaDon.trangThai == 0 ? "Chờ thanh toán" : "Đã thanh toán"}</td>
                            <td>
                                <a href="/admin/hoa-don/${hoaDon.id}" class="btn btn-primary detail-link"
                                   data-tab="tabs-${index.count}">Chi tiết</a>
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

</body>
</html>

