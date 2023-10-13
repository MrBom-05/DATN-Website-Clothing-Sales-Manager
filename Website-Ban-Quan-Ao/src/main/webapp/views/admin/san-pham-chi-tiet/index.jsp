<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div>
    <h1 class="text-center mt-3">Quản lý chi tiết sản phẩm</h1>
    <div class="row col-2 ms-1 float-start">
        <a href="/admin/san-pham-chi-tiet/create" class="btn btn-success">Thêm chi tiết sản phẩm</a>
    </div>
    <div class="ms-1 mt-5">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th>STT</th>
                <th>Mã sản phẩm</th>
                <th>Tên sản phẩm</th>
                <th>Màu Sắc</th>
                <th>Kích cỡ</th>
                <th>Giá</th>
                <th>Số lượng</th>
                <th>Mô tả</th>
                <th>Trạng thái</th>
                <th colspan="2">Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${list}" var="sanPhamChiTiet" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${sanPhamChiTiet.maSanPham}</td>
                    <td>${sanPhamChiTiet.tenSanPham}</td>
                    <td>${sanPhamChiTiet.tenMauSac}</td>
                    <td>${sanPhamChiTiet.tenKichCo}</td>
                    <td>${sanPhamChiTiet.gia}</td>
                    <td>${sanPhamChiTiet.soLuong}</td>
                    <td>${sanPhamChiTiet.moTa}</td>
                    <td>
                        <c:if test="${sanPhamChiTiet.trangThai == 1}">
                            <span class="badge bg-success">Còn hàng</span>
                        </c:if>
                        <c:if test="${sanPhamChiTiet.trangThai == 0}">
                            <span class="badge bg-danger">Hết hàng</span>
                        </c:if>
                    </td>
                    <td>
                        <a href="edit-product?id=${product.id}" class="btn btn-warning">Sửa</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
