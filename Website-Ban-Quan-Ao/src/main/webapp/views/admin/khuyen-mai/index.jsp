<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="container mt-3">
    <h1 class="text-center">Quản Lý Khuyến Mãi</h1>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>
    <div class="row mt-3">
        <div class="col-6">
            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal">
                Thêm Khuyến Mại
            </button>
        </div>
    </div>

    <table class="table table-bordered mt-3 text-center">
        <thead>
        <tr>
            <th>STT</th>
            <th>Mã</th>
            <th>Tên trương trình</th>
            <th>Số phần trăm giảm</th>
            <th>Ngày bắt đầu</th>
            <th>Ngày kết thúc</th>
            <th>Trạng thái</th>
            <th>Thao Tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach varStatus="index" items="${khuyenMaiPage.content}" var="km">
            <tr>
                <td>${index.index + khuyenMaiPage.number * khuyenMaiPage.size + 1}</td>
                <td>${km.ma}</td>
                <td>${km.ten}</td>
                <td>${km.soPhanTramGiam}</td>
                <td>${km.ngayBatDau}</td>
                <td>${km.ngayKetThuc}</td>
                <td>
                    <c:if test="${km.trangThai == '0'}">
                        <a href="/admin/khuyen-mai/update-trang-thai/${km.id}/1" class="btn btn-success"
                           onclick="return confirm('Bạn có chắc chắn muốn dừng hoạt động không?')">Đang hoạt
                            động</a>
                    </c:if>
                    <c:if test="${km.trangThai == '1'}">
                        <a class="btn btn-warning">Dừng hoạt động</a>
                    </c:if>
                </td>
                <td>
                    <a href="#" class="btn btn-primary update-button"
                       data-bs-toggle="modal" data-bs-target="#exampleModal"
                       data-id="${km.id}" data-ten="${km.ten}" data-km.soPhanTramGiam="${km.soPhanTramGiam}"
                       data-km.ngayBatDau="${km.ngayBatDau}" data-km.ngayKetThuc="${km.ngayKetThuc}">
                        Cập Nhật
                    </a>
<%--                    <a href="/admin/khuyen-mai/delete/${km.id}" class="btn btn-danger"--%>
<%--                       onclick="return confirm('Bạn có chắc chắn muốn xoá không?')">Xoá</a>--%>
                    <a href="/admin/khuyen-mai/chi-tiet/${km.id}" class="btn btn-success">Thêm</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true"
         data-bs-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Thêm Khuyến Mãi</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form:form id="edit-form" modelAttribute="km" method="post" action="/admin/khuyen-mai/store">
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="ma" class="form-label">Mã</label>
                                    <form:input type="text" path="ma" id="ma" class="form-control"
                                                required="true"/>
                                    <form:errors path="ma" cssClass="text-danger"/>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="ten" class="form-label">Tên chương trình</label>
                                    <form:input type="text" path="ten" id="ten" class="form-control"
                                                required="true"/>
                                    <form:errors path="ten" cssClass="text-danger"/>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="soPhanTramGiam" class="form-label">Số phần trăm giảm</label>
                                    <form:input type="number" path="soPhanTramGiam" id="soPhanTramGiam"
                                                class="form-control"
                                                required="true" min="1" max="100"/>
                                    <form:errors path="soPhanTramGiam" cssClass="text-danger"/>
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

    <div class="mt-3">
        <div class="text-center">
            <c:if test="${khuyenMaiPage.totalPages > 1}">
                <ul class="pagination">
                    <li class="page-item <c:if test="${khuyenMaiPage.number == 0}">disabled</c:if>">
                        <a class="page-link" href="?page=1">First</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${khuyenMaiPage.totalPages}">
                        <li class="page-item <c:if test="${khuyenMaiPage.number + 1 == i}">active</c:if>">
                            <a class="page-link" href="?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item <c:if test="${khuyenMaiPage.number == khuyenMaiPage.totalPages - 1}">disabled</c:if>">
                        <a class="page-link" href="?page=${khuyenMaiPage.totalPages - 1}">Last</a>
                    </li>
                </ul>
            </c:if>
        </div>
    </div>

</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(".update-button").click(function () {
        let id = $(this).data("id");

        $.ajax({
            url: "/admin/khuyen-mai/get/" + id,
            type: "GET",
            success: function (data) {
                // Đặt giá trị cho các trường trong modal bằng dữ liệu từ yêu cầu AJAX
                $("#ma").val(data.ma);
                $("#ten").val(data.ten);
                $("#soPhanTramGiam").val(data.soPhanTramGiam);
                $("#ngayBatDau").val(data.ngayBatDau);
                $("#ngayKetThuc").val(data.ngayKetThuc);

                $("#edit-form").attr("action", "/admin/khuyen-mai/update/" + id);
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
                modalTitle.textContent = "Cập Nhật khuyến Mãi";
            });
        });
        clickClose.addEventListener("click", function () {
            var modalTitle = document.querySelector(".modal-title");
            modalTitle.textContent = "Thêm khuyến Mãi";

            $("#edit-form").trigger("reset");
            $("#edit-form").attr("action", "/admin/khach-hang/store");

        });
    });


    $(document).ready(function () {
        var form = $("#edit-form");
        var ngayBatDau = $("#ngayBatDau");
        var ngayKetThuc = $("#ngayKetThuc");

        form.submit(function (event) {
            var startDate = new Date(ngayBatDau.val());
            var endDate = new Date(ngayKetThuc.val());

            if (endDate <= startDate) {
                event.preventDefault(); // Ngăn chặn việc gửi form nếu ngày kết thúc không hợp lệ
                alert('Ngày kết thúc phải sau ngày bắt đầu.');
            }
        });
    });
</script>
