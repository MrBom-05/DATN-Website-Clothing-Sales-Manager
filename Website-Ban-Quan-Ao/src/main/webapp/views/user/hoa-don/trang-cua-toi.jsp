<%--
  Created by IntelliJ IDEA.
  User: anhkon
  Date: 4/3/2023
  Time: 7:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/../css/bootstrap.min.css">
</head>
<body>
    <div class="row">
        <div class="col-12">
            <c:forEach var="ghct" items="${listHoaDonChiTietViewModel}" varStatus="status">
                <div class="card mb-2">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <span id="deal">Deal Sốc</span>
                        <input type="hidden" name="maHD" value="${ghct.hoaDon.ma}">
                        <a href="/Assignment_Sof3011_war_exploded/TrangCuaToiServlet/detail?maHD=${ghct.hoaDon.ma}"><i class="fas fa-eye">Xem chi tiết</i></a>
                    </div>
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col-md-1 col-2">
                                <img src="${ghct.chiTietSp.sanPham.srcImage}" alt="ảnh sản phẩm" class="img-fluid d-flex">
                            </div>
                            <div class="col-md-3 col-7">
                                <span class="fw-bold">${ghct.chiTietSp.sanPham.ten}</span>
                                <img src="/../images/freeShip.png" class="img-fluid"
                                     alt="Miễn phí vận chuyển">
                                <img src="/../images/7.png" class="img-fluid "
                                     alt="Miễn phí vận chuyển">
                                <span id="textProduct">7 ngày miễn phí trả hàng</span>
                            </div>
                            <div class="col-md-1 col-2">
                                <span id="priceProduct" class="text-center">${ghct.donGia}</span>
                            </div>
                            <div class="col-md-2 col-3">
                                <div class="input-group">
                                    <label>Số lượng</label>
                                    <input type="text" class="form-control" id="quantity-input" value="${ghct.soLuongTon}" readonly>
                                </div>
                            </div>
                            <div class="col-md-1 col-2">
                                <span class="text-center text-truncate text-danger">${ghct.donGia * ghct.soLuongTon}</span>
                            </div>
                            <div class="col-md-1 col-2">
                                <label>Tình trạng</label>
                                <span class="text-center text-truncate text-danger">${ghct.hoaDon.tinhTrang == 0 ? "Chờ giao hàng" : ghct.hoaDon.tinhTrang == 1 ? "Đang giao hàng" : "Đã giao hàng"}</span>
                            </div>
                            <c:if test="${ghct.hoaDon.tinhTrang == 1}">
                                <div class="col-md-1 col-2 ms-4">
                                    <form action="/Assignment_Sof3011_war_exploded/TrangCuaToiServlet/update?maHD=${ghct.hoaDon.ma}" method="post">
                                        <input  type="hidden" name="maHD" value="${ghct.maHD}">
                                        <button type="submit" class="btn ">
                                            <i class="fas fa-edit text-primary">Tôi đã nhận được hàng</i>
                                        </button>
                                    </form>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

</body>
</html>
