<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="container mt-5">
    <h1 class="text-center">Quản Lý Khách Hàng</h1>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>
    <div class="row mt-3">
        <div class="col-6">
            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal">
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
        <c:forEach varStatus="index" items="${khachHangPage.content}" var="kh">
            <tr>
                <td>${index.index + khachHangPage.number * khachHangPage.size + 1}</td>
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
                    <a href="#" class="btn btn-primary update-button"
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
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true"
         data-bs-backdrop="static">
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
                                    <label for="hoVaTen" class="form-label">Họ và tên</label>
                                    <form:input type="text" path="hoVaTen" id="hoVaTen" class="form-control"
                                                required="true"/>
                                    <form:errors path="hoVaTen" cssClass="text-danger"/>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="soDienThoai" class="form-label">Số điện thoại</label>
                                    <form:input type="tel" path="soDienThoai" id="soDienThoai" class="form-control"
                                                required="true"/>
                                    <form:errors path="soDienThoai" cssClass="text-danger"/>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="email" class="form-label">Email</label>
                                    <form:input type="email" path="email" id="email" class="form-control"
                                                required="true"/>
                                    <form:errors path="email" cssClass="text-danger"/>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="diaChi" class="form-label">Địa chỉ</label>
                                    <form:input type="text" path="diaChi" id="diaChi" class="form-control"
                                                required="true"/>
                                    <form:errors path="diaChi" cssClass="text-danger"/>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="xaPhuong" class="form-label">Xã/Phường</label>
                                    <form:input type="text" path="xaPhuong" id="xaPhuong" class="form-control"
                                                required="true"/>
                                    <form:errors path="xaPhuong" cssClass="text-danger"/>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="quanHuyen" class="form-label">Quận/Huyện</label>
                                    <form:input type="text" path="quanHuyen" id="quanHuyen" class="form-control"
                                                required="true"/>
                                    <form:errors path="quanHuyen" cssClass="text-danger"/>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="tinhThanhPho" class="form-label">Thành phố/Tỉnh</label>
                                    <form:input type="text" path="tinhThanhPho" id="tinhThanhPho" class="form-control"
                                                required="true"/>
                                    <form:errors path="tinhThanhPho" cssClass="text-danger"/>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="matKhau" class="form-label">Mật khẩu</label>
                                    <form:input type="password" path="matKhau" id="matKhau" class="form-control"
                                                required="true"/>
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

    <div class="mt-3">
        <div class="text-center">
            <c:if test="${khachHangPage.totalPages > 1}">
                <ul class="pagination">
                    <li class="page-item <c:if test="${khachHangPage.number == 0}">disabled</c:if>">
                        <a class="page-link" href="?page=1">First</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${khachHangPage.totalPages}">
                        <li class="page-item <c:if test="${khachHangPage.number + 1 == i}">active</c:if>">
                            <a class="page-link" href="?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item <c:if test="${khachHangPage.number == khachHangPage.totalPages - 1}">disabled</c:if>">
                        <a class="page-link" href="?page=${khachHangPage.totalPages - 1}">Last</a>
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
