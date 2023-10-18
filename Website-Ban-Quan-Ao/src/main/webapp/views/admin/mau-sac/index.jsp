<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="container mt-3">
    <h1 class="text-center">Quản Lý Màu Sắc</h1>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>

    <div class="row mt-3">
        <div class="col-7">
            <table class="table table-bordered mt-3 text-center">
                <thead>
                <tr>
                    <th>STT</th>
                    <th>Tên Màu</th>
                    <th>Mã Màu Sắc</th>
                    <th>Thao Tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach varStatus="index" items="${mauSacPage.content}" var="ms">
                    <tr>
                        <td>${index.index + mauSacPage.number * mauSacPage.size + 1}</td>
                        <td>${ms.ten}</td>
                        <td>
                            <div
                                    style="width: 70px; height: 20px; background-color: ${ms.maMauSac};">
                            </div>
                        </td>
                        <td>
                            <a href="#" class="btn btn-primary update-button"
                               data-bs-toggle="modal" data-bs-target="#exampleModal"
                               data-id="${ms.id}" data-maMauSac="${ms.maMauSac}" data-ten="${ms.ten}">
                                Cập Nhật
                            </a>
                            <a href="/admin/mau-sac/delete/${ms.id}" class="btn btn-danger"
                               onclick="return confirm('Bạn có chắc chắn muốn xoá không?')">Xoá</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="col-5 mt-4">
            <form:form id="edit-form" modelAttribute="ms" method="post" action="/admin/mau-sac/store">
                <div class="row mb-3">
                    <div class="form-group row">
                        <div class="col-6">
                            <label for="ten" class="form-label">Tên Màu</label>
                            <form:input type="text" path="ten" id="ten" class="form-control" required="true"/>
                            <form:errors path="ten" cssClass="text-danger"/>
                        </div>
                        <div class="col-6">
                            <label for="maMauSac" class="form-label">Mã Màu</label>
                            <form:input type="text" path="maMauSac" id="maMauSac" class="form-control" required="true"/>
                            <form:errors path="maMauSac" cssClass="text-danger"/>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-success mt-3 col-2 offset-5">Lưu</button>
                </div>
            </form:form>
        </div>
    </div>

    <div class="mt-3">
        <div class="text-center">
            <c:if test="${mauSacPage.totalPages > 1}">
                <ul class="pagination">
                    <li class="page-item <c:if test="${mauSacPage.number == 0}">disabled</c:if>">
                        <a class="page-link" href="?page=1">First</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${mauSacPage.totalPages}">
                        <li class="page-item <c:if test="${mauSacPage.number + 1 == i}">active</c:if>">
                            <a class="page-link" href="?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item <c:if test="${mauSacPage.number == mauSacPage.totalPages - 1}">disabled</c:if>">
                        <a class="page-link" href="?page=${mauSacPage.totalPages - 1}">Last</a>
                    </li>
                </ul>
            </c:if>
        </div>
    </div>
</div>


<!-- Bao gồm các tập lệnh Spring form và các tập lệnh khác -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(".update-button").click(function () {
        let id = $(this).data("id");

        // Thực hiện yêu cầu AJAX để lấy dữ liệu khách hàng dựa trên id
        $.ajax({
            url: "/admin/mau-sac/get/" + id,
            type: "GET",
            success: function (data) {
                $("#maMauSac").val(data.maMauSac);
                $("#ten").val(data.ten);

                $("#edit-form").attr("action", "/admin/mau-sac/update/" + id);
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

                modalTitle.textContent = "Cập Nhật Màu Sắc";

            });
        });
        clickClose.addEventListener("click", function () {
            var modalTitle = document.querySelector(".modal-title");

            modalTitle.textContent = "Thêm Màu Sắc";

            $("#edit-form").trigger("reset");
            $("#edit-form").attr("action", "/admin/mau-sac/store");

        });
    });
</script>
</body>
</html>
