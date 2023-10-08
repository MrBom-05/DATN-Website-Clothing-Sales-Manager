
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/../css/bootstrap.min.css">
</head>
<style>
    .container {
        max-width: 1000px;
    }

    body {
        background-color: #f8f9fa;
    }
</style>
<body>
<div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1 class="mt-5">Cảm ơn bạn đã đặt hàng!</h1>
                <p class="lead">Hoá đơn của bạn đã được ghi nhận và đang được xử lý.</p>
                <hr>
                <p class="lead">Thông tin hoá đơn:</p>
                <c:forEach var="hd" items="${mapHoaDonChiTietViewModel}" varStatus="status">
                    <table class="table">
                        <tr>
                            <td>Mã hoá đơn:</td>
                            <td>${hd.key}</td>
                        </tr>
                        <tr>
                            <td>Tên khách hàng:</td>
                            <td>${hd.value[0].hoaDon.tenNguoiNhan}</td>
                        </tr>
                        <tr>
                            <td>Địa chỉ:</td>
                            <td>${hd.value[0].hoaDon.diaChi}</td>
                        </tr>
                        <tr>
                            <td>Số điện thoại:</td>
                            <td>${hd.value[0].hoaDon.sdt}</td>
                        </tr>
                        <tr>
                            <td>Tình trạng:</td>
                            <td>${hd.value[0].hoaDon.tinhTrang == 0 ? "Chờ giao hàng" : hd.value[0].hoaDon.tinhTrang == 1 ? "Đang giao hàng" : "Đã giao hàng"}</td>
                        </tr>
                    </table>
                    <table class="table">
                        <thead>
                        <tr>
                            <th>Tên sản phẩm</th>
                            <th>Số lượng</th>
                            <th>Đơn giá</th>
                            <th>Thành tiền</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="ct" items="${hd.value}" varStatus="status">
                            <tr>
                                <td>${ct.chiTietSp.sanPham.ten}</td>
                                <td>${ct.soLuongTon}</td>
                                <td>${ct.donGia}</td>
                                <td>${ct.soLuongTon * ct.donGia}</td>
                            </tr>
                            <c:set var="sum" value="${sum + ct.soLuongTon * ct.donGia}" />
                        </c:forEach>
                        <tr>
                            <td colspan="3" align="right"><b>Tổng tiền:</b></td>
                            <td><b>${sum}</b></td>
                        </tr>
                        </tbody>
                    </table>
                </c:forEach>

            <p class="lead">Thông tin liên hệ:</p>
            <p class="lead">Nếu bạn có bất kỳ câu hỏi nào, vui lòng liên hệ với chúng tôi:</p>
            <ul class="list-unstyled">
                <li><strong>Địa chỉ:</strong> 123 Đường ABC, Quận XYZ, Thành phố HCM</li>
                <li><strong>Điện thoại:</strong> 0123456789</li>
                <li><strong>Email:</strong> innisfree@gmail.com</li>
            </ul>
            <a href="/user/san-pham" class="btn btn-primary">Quay lại trang chủ</a>
        </div>
    </div>
</div>

<script src="/../js/bootstrap.min.js"></script>
</body>
</html>
