<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Loại Sản Phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .form-container {
            margin-left: 10px;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center">Quản Lý Loại Sản Phẩm</h1>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>

    <div class="row mt-3">
        <div class="col-9">
            <table class="table mt-3">
                <thead>
                <tr>
                    <th>STT</th>
                    <th>Tên Loại</th>
                    <th>Thao Tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach varStatus="index" items="${loaiPage.content}" var="l">
                    <tr>
                        <td>${index.index + loaiPage.number * loaiPage.size + 1}</td>
                        <td>${l.ten}</td>
                        <td>
                            <a href="/admin/loai/delete/${l.id}" class="btn btn-danger"
                               onclick="return confirm('Bạn có chắc chắn muốn xoá không?')">Xoá</a>
                            <a href="#" class="btn btn-success update-button"
                               data-bs-toggle="modal" data-bs-target="#exampleModal"
                               data-id="${l.id}" data-ten="${l.ten}">
                                Cập Nhật
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="col-3 mt-4 ">
            <form:form id="edit-form" modelAttribute="l" method="post" action="/admin/loai/store">
                <div class="form-group">
                    <label for="ten">Tên Loại</label>
                    <form:input type="text" path="ten" id="ten" class="form-control" required="true"/>
                    <form:errors path="ten" cssClass="text-danger"/>
                </div>
                <button type="submit" class="btn btn-success mt-3">Lưu</button>
            </form:form>
        </div>
    </div>
    <div class="mt-3">
        <div class="text-center">
            <c:if test="${loaiPage.totalPages > 1}">
                <ul class="pagination">
                    <li class="page-item <c:if test="${loaiPage.number == 0}">disabled</c:if>">
                        <a class="page-link" href="?page=1">First</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${loaiPage.totalPages}">
                        <li class="page-item <c:if test="${loaiPage.number + 1 == i}">active</c:if>">
                            <a class="page-link" href="?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item <c:if test="${loaiPage.number == loaiPage.totalPages - 1}">disabled</c:if>">
                        <a class="page-link" href="?page=${loaiPage.totalPages - 1}">Last</a>
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
            url: "/admin/loai/get/" + id,
            type: "GET",
            success: function (data) {
                $("#ten").val(data.ten);
                $("#edit-form").attr("action", "/admin/loai/update/" + id);
            },
            error: function (error) {
                console.error("Error:", error);
            },
        });
    });
</script>
</body>
</html>