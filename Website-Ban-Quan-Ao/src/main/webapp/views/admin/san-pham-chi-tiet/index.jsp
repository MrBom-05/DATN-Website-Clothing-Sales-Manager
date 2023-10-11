<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div>
    <h1 class="text-center mt-3">Quản lý chi tiết sản phẩm</h1>
    <div class="row col-2 ms-2 float-start">
        <a href="/admin/san-pham-chi-tiet/create">
            <button class="btn btn-success ">Thêm sản phẩm</button>
        </a>
    </div>
    <div class="mt-5">
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
                <th>Ảnh sản phẩm</th>
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
                        <a href="javascript:void(0);" onclick="showModal('${sanPhamChiTiet.id}')">Xem ảnh</a>
                    </td>
                    <td>
                        <a href="edit-product?id=${product.id}" class="btn btn-warning">Sửa</a>
                        <a href="delete-product?id=${product.id}" class="btn btn-danger">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal -->
<div id="imageModal" class="modal">
    <span class="close" onclick="closeModal()">&times;</span>
    <img id="modalImage" class="modal-content">
</div>

<script>
    function showModal(imageId) {
        var modal = document.getElementById('imageModal');
        var modalImage = document.getElementById('modalImage');

        // Set the image source to the URL of the image you want to display
        modalImage.src = '/admin/san-pham-chi-tiet/get-anh/' + imageId;
        modal.style.display = 'block';
        console.log(modalImage.src);
        console.log(imageId);
    }

    function closeModal() {
        var modal = document.getElementById('imageModal');
        modal.style.display = 'none';
    }
</script>

<style>
    /* Add your modal styles here */
    .modal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.9);
    }

    .modal-content {
        display: block;
        margin: 10% auto;
        max-width: 80%;
        max-height: 80%;
    }

    .close {
        position: absolute;
        top: 0;
        right: 0;
        padding: 10px;
        color: #fff;
        cursor: pointer;
    }
</style>
