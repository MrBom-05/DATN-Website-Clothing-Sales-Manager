<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<style>
    .image-input {
        display: none;
    }

    .image-preview-container {
        position: relative;
        width: 100px;
        height: 100px;
        margin: 10px;
        border: 1px dashed #ccc;
        text-align: center;
        cursor: pointer; /* Sử dụng con trỏ kiểu tay khi di chuột vào */
    }

    .image-preview {
        max-width: 100%;
        max-height: 100%;
        display: none;
    }

    .image-placeholder {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        font-size: 36px;
        color: #333;
    }

    /* Ẩn label khi đã chọn ảnh */
    .image-input-label.selected {
        display: none;
    }


</style>
<script>
    function displayImage(index, imageId, placeholderId) {
        var input = document.getElementById("imageInput" + index);
        var imageDisplay = document.getElementById(imageId);
        var placeholder = document.getElementById(placeholderId);
        var base64ImagesInput = document.getElementById("base64Images" + index);

        var file = input.files[0];
        var reader = new FileReader();

        reader.onload = function (e) {
            var base64Image = e.target.result;
            imageDisplay.style.display = "block";
            imageDisplay.src = base64Image;
            placeholder.style.display = "none";

            // Update the hidden input field with base64 data
            base64ImagesInput.value = base64Image;
            console.log(base64Image);
        };

        reader.readAsDataURL(file);
    }

    // Function to convert an image file to base64
    function convertImageToBase64(index) {
        var input = document.getElementById("imageInput" + index);
        var base64ImagesInput = document.getElementById("base64Images" + index);

        var file = input.files[0];
        var reader = new FileReader();

        reader.onload = function (e) {
            var base64Image = e.target.result;
            // Update the hidden input field with base64 data
            base64ImagesInput.value = base64Image;
        };

        reader.readAsDataURL(file);
    }
</script>

<div class="container mt-3">
    <h1 class="text-center">Quản lý chi tiết sản phẩm</h1>
    <div class="row mt-3">
        <div class="col-12">
            <form:form action="/admin/san-pham-chi-tiet/add" method="post" modelAttribute="sanPhamChiTiet">
                <div class="row">
                    <div class="col-4">
                        <label for="maSanPham" class="form-label">Mã Sản Phẩm</label>
                        <form:input path="maSanPham" id="maSanPham" class="form-control"/>
                    </div>
                    <div class="col-4">
                        <label for="idSanPham" class="form-label">Sản Phẩm</label>
                        <form:select path="idSanPham" id="idSanPham" class="form-select">
                            <c:forEach items="${listSanPham}" var="sanPham">
                                <form:option value="${sanPham.id}" label="${sanPham.ten}"/>
                            </c:forEach>
                        </form:select>
                    </div>
                    <div class="col-4">
                        <label for="idMauSac" class="form-label">Màu Sắc</label>
                        <form:select path="idMauSac" id="idMauSac" class="form-select">
                            <c:forEach items="${listMauSac}" var="mauSac">
                                <form:option value="${mauSac.id}" label="${mauSac.ten}"/>
                            </c:forEach>
                        </form:select>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-4">
                        <label for="idKichCo" class="form-label">Kích Cỡ</label>
                        <form:select path="idKichCo" id="idKichCo" class="form-select">
                            <c:forEach items="${listKichCo}" var="kichCo">
                                <form:option value="${kichCo.id}" label="${kichCo.ten}"/>
                            </c:forEach>
                        </form:select>
                    </div>
                    <div class="col-4">
                        <label for="gia" class="form-label">Giá Bán</label>
                        <form:input path="gia" id="gia" class="form-control" type="number"/>
                    </div>
                    <div class="col-4">
                        <label for="soLuong" class="form-label">Số lượng</label>
                        <form:input path="soLuong" id="soLuong" class="form-control" type="number"/>
                    </div>
                </div>
                <div class="mt-3">
                    <label for="moTa" class="form-label">Mô tả</label>
                    <form:textarea path="moTa" id="moTa" class="form-control" style="height: 130px"/>
                </div>
                <div class="mt-3">
                    <label class="form-label">Ảnh sản phẩm</label>
                    <div>
                        <c:forEach var="i" begin="0" end="2">
                            <label for="imageInput${i}" class="image-preview-container">
                                <img id="imageDisplay${i}" class="image-preview" src="" alt="Image ${i + 1}">
                                <span class="image-placeholder" id="placeholder${i}">+</span>
                            </label>
                            <input type="file" id="imageInput${i}" class="image-input" accept="image/*"
                                   onchange="displayImage(${i}, 'imageDisplay${i}', 'placeholder${i}'); convertImageToBase64(${i});"/>
                            <label class="image-input-label selected" for="imageInput${i}">Chọn ảnh</label>

                            <!-- Thêm hidden input để lưu trữ giá trị base64Images -->
                            <form:input path="duongDan[${i}]" type="hidden" id="base64Images${i}"/>
                        </c:forEach>
                    </div>
                </div>
                <div class="mt-3">
                    <label for="trangThai" class="form-label">Trạng thái</label>
                    <form:select path="trangThai" id="trangThai" class="form-select">
                        <form:option value="1" label="Đang bán"/>
                        <form:option value="0" label="Ngừng bán"/>
                    </form:select>
                </div>
                <div class="mt-3">
                    <button type="button" class="btn btn-secondary">Làm Mới</button>
                    <button type="submit" class="btn btn-primary">Lưu</button>
                </div>
            </form:form>

        </div>
    </div>
</div>



