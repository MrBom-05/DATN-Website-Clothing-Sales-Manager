<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<style>
    .image-input {
        display: none;
    }

    .image-preview-container {
        position: relative;
        width: 100px;
        height: 100px;
        margin: 10px;
        border: 1px dashed #ccc; /* Đổi border thành nét đứt */
        text-align: center;
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
        font-size: 36px; /* Đặt kích thước lớn hơn */
        color: #333;
    }

    .image-input-label {
        display: block;
        cursor: pointer;
    }

    .image-input-label::before {
        font-size: 36px;
        color: #333;
    }

    .image-input-label input[type="file"] {
        display: none;
    }

    /* Ẩn label khi đã chọn ảnh */
    .image-input-label.selected {
        display: none;
    }

    /* Hiển thị label khi chưa chọn ảnh */
    .image-input-label {
        display: block;
        cursor: pointer;
    }

</style>

<div>
    <h1 class="text-center mt-3">Quản lý chi tiết sản phẩm</h1>
    <div class="row mt-3">
        <div class="col-3">
            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal">
                Thêm chi tiết sản phẩm
            </button>

            <!-- Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                 aria-hidden="true">

                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Thêm chi tiết sản phẩm</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <sf:form action="/admin/san-pham-chi-tiet/add" method="post" modelAttribute="ctsp">
                            <div class="row">
                                <div class="col-4">
                                    <label class="form-label">Mã Sản Phẩm</label>
                                    <sf:input type="text" class="form-control" path="maSanPham"/>
                                </div>
                                <div class="col-4">
                                    <label class="form-label">Sản Phẩm</label>
                                    <sf:select class="form-select" path="idSanPham">
                                        <c:forEach items="${listSanPham}" var="sanPham">
                                            <option value="${sanPham.id}">${sanPham.ten}</option>
                                        </c:forEach>
                                    </sf:select>
                                </div>
                                <div class="col-4">
                                    <label class="form-label">Màu Sắc</label>
                                    <sf:select class="form-select" path="idMauSac">
                                        <c:forEach items="${listMauSac}" var="mauSac">
                                            <option value="${mauSac.id}">${mauSac.ten}</option>
                                        </c:forEach>
                                    </sf:select>
                                </div>
                            </div>
                            <div class="row mt-2">
                                <div class="col-4">
                                    <label class="form-label">Kích Cỡ</label>
                                    <sf:select class="form-select" path="idKichCo">
                                        <c:forEach items="${listKichCo}" var="kichCo">
                                            <option value="${kichCo.id}">${kichCo.ten}</option>
                                        </c:forEach>
                                    </sf:select>
                                </div>
                                <div class="col-4">
                                    <label class="form-label">Giá Bán</label>
                                    <sf:input type="number" class="form-control" path="gia"/>
                                </div>
                                <div class="col-4">
                                    <label class="form-label">Số lượng</label>
                                    <sf:input type="number" class="form-control" path="soLuong"/>
                                </div>
                            </div>
                            <div class="mt-3">
                                <label class="form-label">Mô tả</label>
                                <sf:textarea class="form-control" style="height: 130px" path="moTa"/>
                            </div>
                            <div class="mt-3">
                                <label class="form-label">Ảnh sản phẩm</label>

                                <div>
                                    <label for="imageInput1" class="image-preview-container">
                                        <img id="imageDisplay1" class="image-preview" src="" alt="Image 1">
                                        <span class="image-placeholder" id="placeholder1">+</span>
                                    </label>
                                    <sf:input path="duongDan[0]" type="file" id="imageInput1" class="image-input"
                                              accept="image/*" onchange="displayImage(1, 'placeholder1')"/>
                                    <label class="image-input-label selected" for="imageInput1">Chọn ảnh</label>


                                    <!-- Ô input 2 -->
                                    <label for="imageInput2" class="image-preview-container">
                                        <img id="imageDisplay2" class="image-preview" src="" alt="Image 2">
                                        <span class="image-placeholder" id="placeholder2">+</span>
                                    </label>
                                    <sf:input path="duongDan[1]" type="file" id="imageInput2" class="image-input"
                                              accept="image/*" onchange="displayImage(2, 'placeholder2')"/>
                                    <label class="image-input-label selected" for="imageInput2">Chọn ảnh</label>

                                    <!-- Ô input 3 -->
                                    <label for="imageInput3" class="image-preview-container">
                                        <img id="imageDisplay3" class="image-preview" src="" alt="Image 3">
                                        <span class="image-placeholder" id="placeholder3">+</span>
                                    </label>
                                    <sf:input path="duongDan[2]" type="file" id="imageInput3" class="image-input"
                                              accept="image/*" onchange="displayImage(3, 'placeholder3')"/>
                                    <label class="image-input-label selected" for="imageInput3">Chọn ảnh</label>

                                    <!-- Ô input 4 -->
                                    <label for="imageInput4" class="image-preview-container">
                                        <img id="imageDisplay4" class="image-preview" src="" alt="Image 4">
                                        <span class="image-placeholder" id="placeholder4">+</span>
                                    </label>
                                    <sf:input path="duongDan[3]" type="file" id="imageInput4" class="image-input"
                                              accept="image/*" onchange="displayImage(4, 'placeholder4')"/>
                                    <label class="image-input-label selected" for="imageInput4">Chọn ảnh</label>

                                    <!-- Ô input 5 -->
                                    <label for="imageInput5" class="image-preview-container">
                                        <img id="imageDisplay5" class="image-preview" src="" alt="Image 5">
                                        <span class="image-placeholder" id="placeholder5">+</span>
                                    </label>
                                    <sf:input path="duongDan[4]" type="file" id="imageInput5" class="image-input"
                                              accept="image/*" onchange="displayImage(5, 'placeholder5')"/>
                                    <label class="image-input-label selected" for="imageInput5">Chọn ảnh</label>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                                <%--<button type="button" class="btn btn-secondary">Làm Mới</button>--%>
                            <button type="submit"  class="btn btn-primary">Lưu</button>

                        </div>
                        </sf:form>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <div class="mt-3">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th>STT</th>
                <th>Mã sản phẩm</th>
                <th>Tên sản phẩm</th>
                <th>Màu Sắc</th>
                <th>Kích cỡ</th>
                <th>Giá</th>
                <th>Số lương</th>
                <th>Mô tả</th>
                <th>Trạng thái</th>
                <th>Ảnh sản phẩm</th>
                <th>Thao tác</th>
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
                    <td>${sanPhamChiTiet.trangThai}</td>
                    <td>
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
<div class="row">
    111111
    <c:forEach items="${list_anh}" var="sanPhamChiTiet">
        <div class="col-md-4">
            <div class="card mb-3">
                <img src="data:image/jpeg;base64,${sanPhamChiTiet.duongDanAnh}" class="card-img-top" alt="Ảnh sản phẩm">
                <div class="card-body">
                    <h5 class="card-title">${sanPhamChiTiet.tenSanPham}</h5>
                    <p class="card-text">Màu Sắc: ${sanPhamChiTiet.tenMauSac}</p>
                    <p class="card-text">Kích Cỡ: ${sanPhamChiTiet.tenKichCo}</p>
                    <p class="card-text">Giá: ${sanPhamChiTiet.gia}</p>
                    <p class="card-text">Số Lượng: ${sanPhamChiTiet.soLuong}</p>
                    <p class="card-text">Mô Tả: ${sanPhamChiTiet.moTa}</p>
                    <p class="card-text">Trạng Thái: ${sanPhamChiTiet.trangThai}</p>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
<script>
    function displayImage(inputNumber, placeholderId) {
        var input = document.getElementById('imageInput' + inputNumber);
        var imageDisplay = document.getElementById('imageDisplay' + inputNumber);
        var placeholder = document.getElementById(placeholderId);

        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                imageDisplay.src = e.target.result;
                imageDisplay.style.display = 'block';
                placeholder.style.display = 'none';
                // Chuyển đổi ảnh thành base64 và hiển thị nó
                convertToBase64(input.files[0], function (base64Image) {
                    // Lưu base64Image vào một biến hoặc gửi nó điều kiện cần thiết
                });
            };

            reader.readAsDataURL(input.files[0]);
        }
    }

    function convertToBase64(file, callback) {
        var reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = function () {
            var base64Image = reader.result.split(',')[1];
            callback(base64Image);
        };
        reader.onerror = function (error) {
            console.error('Error reading file: ', error);
        };
    }
</script>
