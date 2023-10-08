<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Khách Hàng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center">Quản Lý Khách Hàng</h1>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>
    <div class="row mt-3">
        <div class="col-6">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
                Thêm Khách Hàng
            </button>
        </div>
    </div>

    <table class="table mt-3">
        <thead>
        <tr>
            <th>STT</th>
            <th>Họ Tên</th>
            <th>Email</th>
            <th>Số Điện Thoại</th>
            <th>Địa Chỉ</th>
            <th>Xã/Phường</th>
            <th>Quận/Huyện</th>
            <th>Tỉnh/Thành Phố</th>
            <th>Thao Tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach varStatus="index" items="${list}" var="kh">
            <tr>
                <td>${index.count}</td>
                <td>${kh.hoVaTen}</td>
                <td>${kh.email}</td>
                <td>${kh.soDienThoai}</td>
                <td>${kh.diaChi}</td>
                <td>${kh.xaPhuong}</td>
                <td>${kh.quanHuyen}</td>
                <td>${kh.tinhThanhPho}</td>

                <td>
                    <a href="/admin/khach-hang/delete/${kh.id}" class="btn btn-danger"
                       onclick="return confirm('Bạn có chắc chắn muốn xoá không?')">Xoá</a>
                    <a href="#" class="btn btn-success update-button"
                       data-bs-toggle="modal" data-bs-target="#exampleModal"
                       data-id="${kh.id}" data-hoVaTen="${kh.hoVaTen}" data-soDienThoai="${kh.soDienThoai}"
                       data-email="${kh.email}" data-diaChi="${kh.diaChi}" data-xaPhuong="${kh.xaPhuong}"
                       data-quanHuyen="${kh.quanHuyen}" data-tinhThanhPho="${kh.tinhThanhPho}">
                        Cập Nhật
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Modal Thêm và Cập Nhật -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Thêm Khách Hàng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form:form id="edit-form" modelAttribute="kh" method="post" action="/admin/khach-hang/store">
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="hoVaTen">Họ và tên</label>
                                    <form:input type="text" path="hoVaTen" id="hoVaTen" class="form-control" required="true"/>
                                    <form:errors path="hoVaTen" cssClass="text-danger"/>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="soDienThoai">Số điện thoại</label>
                                    <form:input type="tel" path="soDienThoai" id="soDienThoai" class="form-control" required="true"/>
                                    <form:errors path="soDienThoai" cssClass="text-danger"/>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <form:input type="email" path="email" id="email" class="form-control" required="true"/>
                                    <form:errors path="email" cssClass="text-danger"/>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="diaChi">Địa chỉ</label>
                                    <form:input type="text" path="diaChi" id="diaChi" class="form-control" required="true"/>
                                    <form:errors path="diaChi" cssClass="text-danger"/>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="xaPhuong">Xã/Phường</label>
                                    <form:input type="text" path="xaPhuong" id="xaPhuong" class="form-control" required="true"/>
                                    <form:errors path="xaPhuong" cssClass="text-danger"/>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="quanHuyen">Quận/Huyện</label>
                                    <form:input type="text" path="quanHuyen" id="quanHuyen" class="form-control" required="true"/>
                                    <form:errors path="quanHuyen" cssClass="text-danger"/>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="tinhThanhPho">Thành phố/Tỉnh</label>
                                    <form:input type="text" path="tinhThanhPho" id="tinhThanhPho" class="form-control"
                                                required="true"/>
                                    <form:errors path="tinhThanhPho" cssClass="text-danger"/>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="matKhau">Mật khẩu</label>
                                    <form:input type="password" path="matKhau" id="matKhau" class="form-control" required="true"/>
                                    <form:errors path="matKhau" cssClass="text-danger"/>
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

<!-- Bao gồm các tập lệnh Spring form và các tập lệnh khác -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script>
    $(".update-button").click(function () {
        let id = $(this).data("id");

        // Thực hiện yêu cầu AJAX để lấy dữ liệu khách hàng dựa trên id
        $.ajax({
            url: "/admin/khach-hang/get/" + id,
            type: "GET",
            success: function (data) {
                // Đặt giá trị cho các trường trong modal bằng dữ liệu từ yêu cầu AJAX
                $("#hoVaTen").val(data.hoVaTen);
                $("#soDienThoai").val(data.soDienThoai);
                $("#email").val(data.email);
                $("#diaChi").val(data.diaChi);
                $("#xaPhuong").val(data.xaPhuong);
                $("#quanHuyen").val(data.quanHuyen);
                $("#tinhThanhPho").val(data.tinhThanhPho);
                $("#matKhau").val(data.matKhau);

                // Đặt action của form trong modal (action cập nhật với ID của khách hàng)
                $("#edit-form").attr("action", "/admin/khach-hang/update/" + id);
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
                var matKhauInput = document.querySelector("#matKhau");

                // Đặt tiêu đề modal thành "Cập Nhật Khách Hàng"
                modalTitle.textContent = "Cập Nhật Khách Hàng";

                // Vô hiệu hoá ô input mật khẩu
                matKhauInput.setAttribute("disabled", "disabled");
            });
        });
        clickClose.addEventListener("click", function () {
            var modalTitle = document.querySelector(".modal-title");
            var matKhauInput = document.querySelector("#matKhau");

            // Đặt tiêu đề modal thành "Thêm Khách Hàng"
            modalTitle.textContent = "Thêm Khách Hàng";

            // Bỏ vô hiệu hoá ô input mật khẩu
            matKhauInput.removeAttribute("disabled");
            // reset form
            $("#edit-form").trigger("reset");
            $("#edit-form").attr("action", "/admin/khach-hang/store");

        });
    });
</script>
</body>
</html>
