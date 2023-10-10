<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="container mt-5">
    <h1 class="text-center">Quản Lý Giảm Giá</h1>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>
    <div class="row mt-3">
        <div class="col-6">
            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal">
                Thêm Giảm Giá
            </button>
        </div>
    </div>

    <table class="table table-bordered mt-3">
        <thead>
        <tr>
            <th>STT</th>
            <th>Mã</th>
            <th>Số phần trăm giảm</th>
            <th>Số lượng</th>
            <th>Ngày bắt đầu</th>
            <th>Ngày kết thúc</th>
            <th>Thao Tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach varStatus="index" items="${giamGiaPage.content}" var="gg">
            <tr>
                <td>${index.index + giamGiaPage.number * giamGiaPage.size + 1}</td>
                <td>${gg.ma}</td>
                <td>${gg.soPhanTramGiam}</td>
                <td>${gg.soLuong}</td>
                <td>${gg.ngayBatDau}</td>
                <td>${gg.ngayKetThuc}</td>

                <td>
                    <a href="/admin/giam-gia/delete/${gg.id}" class="btn btn-danger"
                       onclick="return confirm('Bạn có chắc chắn muốn xoá không?')">Xoá</a>
                    <a href="#" class="btn btn-primary update-button"
                       data-bs-toggle="modal" data-bs-target="#exampleModal"
                       data-id="${gg.id}" data-hoVaTen="${gg.ma}" data-soDienThoai="${gg.soPhanTramGiam}"
                       data-email="${gg.soLuong}" data-diaChi="${gg.ngayBatDau}" data-xaPhuong="${gg.ngayKetThuc}">
                        Cập Nhật
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Modal Thêm và Cập Nhật -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true"
         data-bs-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Thêm Giảm Giá</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <%--@elvariable id="gg" type="java"--%>
                    <form:form id="edit-form" modelAttribute="gg" method="post" action="/admin/giam-gia/store">
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="ma">Mã</label>
                                    <form:input type="text" path="ma" id="ma" class="form-control" required="true"/>
                                    <form:errors path="ma" cssClass="text-danger"/>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">

                            <div class="col">
                                <div class="form-group">
                                    <label for="soPhanTramGiam">Số phần trăm</label>
                                    <form:input type="text" path="soPhanTramGiam" id="soPhanTramGiam"
                                                class="form-control" required="true"/>
                                    <form:errors path="soPhanTramGiam" cssClass="text-danger"/>
                                </div>
                            </div>

                            <div class="col">
                                <div class="form-group">
                                    <label for="soLuong">Số lượng</label>
                                    <form:input type="text" path="soLuong" id="soLuong" class="form-control"
                                                required="true"/>
                                    <form:errors path="soLuong" cssClass="text-danger"/>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="ngayBatDau">Ngày Bắt Đầu</label>
                                    <form:input type="date" path="ngayBatDau" id="ngayBatDau" class="form-control"
                                                required="true"/>
                                    <form:errors path="ngayBatDau" cssClass="text-danger"/>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="ngayKetThuc">Ngày Kết Thúc</label>
                                    <form:input type="date" path="ngayKetThuc" id="ngayKetThuc" class="form-control"
                                                required="true"/>
                                    <form:errors path="ngayKetThuc" cssClass="text-danger"/>
                                </div>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-success mt-3">Lưu</button>
                    </form:form>
                </div>
            </div>
        </div>
    </div>

</div>
</div>
<div class="mt-6">
    <div class="text-center">
        <c:if test="${giamGiaPage.totalPages > 1}">
            <ul class="pagination justify-content-center">
                <c:forEach var="i" begin="1" end="${giamGiaPage.totalPages}">
                    <li class="page-item${giamGiaPage.number + 1 == i ? ' active' : ''}">
                        <a class="page-link" href="?page=${i}">${i}</a>
                    </li>
                </c:forEach>
            </ul>
        </c:if>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(".update-button").click(function () {
        let id = $(this).data("id");

        // Thực hiện yêu cầu AJAX để lấy dữ liệu giảm giá dựa trên id
        $.ajax({
            url: "/admin/giam-gia/get/" + id,
            type: "GET",
            success: function (data) {
                // Đặt giá trị cho các trường trong modal bằng dữ liệu từ yêu cầu AJAX
                $("#ma").val(data.ma);
                $("#soPhanTramGiam").val(data.soPhanTramGiam);
                $("#soLuong").val(data.soLuong);
                $("#ngayBatDau").val(data.ngayBatDau);
                $("#ngayKetThuc").val(data.ngayKetThuc);

                // Đặt action của form trong modal (action cập nhật với ID của giảm giá)
                $("#edit-form").attr("action", "/admin/giam-gia/update/" + id);
            },
            error: function (error) {
                console.error("Error:", error);
            },
        });
    });
    document.addEventListener("DOMContentLoaded", function () {
        var updateButtons = document.querySelectorAll(".update-button");
        var clickClose = document.querySelector(".btn-close");

        updateButtons.forEach(function (button) {
            button.addEventListener("click", function () {
                var modalTitle = document.querySelector(".modal-title");

                // Đặt tiêu đề modal thành "Cập Nhật Giảm Giá"
                modalTitle.textContent = "Cập Nhật Giảm Giá";
            });
        });
        clickClose.addEventListener("click", function () {
            var modalTitle = document.querySelector(".modal-title");

            // Đặt tiêu đề modal thành "Thêm Khách Hàng"
            modalTitle.textContent = "Thêm Giảm Giá";

        });
    });

    // Lấy các trường input và form
    const form = document.getElementById('edit-form');
    const ma = document.getElementById('ma');
    const soPhanTramGiam = document.getElementById('soPhanTramGiam');
    const soLuong = document.getElementById('soLuong');
    const ngayBatDau = document.getElementById('ngayBatDau');
    const ngayKetThuc = document.getElementById('ngayKetThuc');

    // Thêm sự kiện submit form
    form.addEventListener('submit', function (event) {
        if (!form.checkValidity()) {
            event.preventDefault(); // Ngăn chặn việc gửi form nếu có lỗi
        }
    });

</script>

