<%-- This file was created using IntelliJ IDEA. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Đăng nhập hoặc đăng ký thành viên</title>
    <link rel="stylesheet" href="/../css/bootstrap.min.css">
</head>
<body>
<div class="container">

    <h2 class="mt-4">Đăng nhập hoặc đăng ký thành viên</h2>
    <hr>
    <div class="timeline">
        <div class="row">
            <div class="col-6 text-center mt-5">
                <sf:form modelAttribute="user" method="post" action="/user/check-login" >
                    <h3>Đăng nhập thành viên</h3>
                    <div class="input-group mb-3 pe-5">
                        <sf:input type="email" path="email" class="form-control" placeholder="Email" />
                        <sf:errors path="email" cssClass="text-danger" />
                    </div>
                    <div class="input-group mb-3 pe-5">
                        <sf:input type="password" path="matKhau" class="form-control" placeholder="Mật khẩu" />
                        <sf:errors path="matKhau" cssClass="text-danger" />
                    </div>
                    <c:if test="${not empty error}">
                        <p style="color: red">${error}</p>
                    </c:if>
                    <button class="btn btn-success w-75 h-30 mt-3 fs-4">Đăng nhập</button>
                    <p class="fw-semibold mt-2">Đăng nhập nhanh/Đăng ký thành viên bằng tài khoản mạng xã hội:</p>
                    <a class="btn text-white me-2" href="#" role="button" style="background-color: #3B5998;">Facebook</a>
                    <a class="btn text-white" href="#" role="button" style="background-color: #EA4335;">Google</a>
                    <br>
                    <span>
                                <p>* Có thể đăng nhập nhanh hoặc đăng ký thành viên mới bằng tài khoản mạng xã hội.</p>
                                <p>* Thành viên Innisfree chưa liên kết với tài khoản mạng xã hội có thể đăng nhập và thiết lập liên kết một cách nhanh chóng</p>
                            </span>
                </sf:form>
                <a href="/Assignment_Sof3011_war_exploded/LoginServlet/forgot-password" class="text-decoration-none col-10 offset-8">
                    <span class="text-primary">Quên mật khẩu?</span>
                </a>
            </div>
            <div class="col-5 text-center ps-5 mt-5">
                <h3>Đăng ký thành viên mới</h3>
                <br>
                <span class="ms-3">Đăng ký ngay để mua sắm dễ dàng hơn và tận hưởng thêm nhiều ưu đãi độc quyền cho thành viên Innisfree.</span>
                <br>
               <a href="/user/register">Đăng ký</a>
            </div>
        </div>
    </div>
</div>
<script src="/Assignment_Sof3011_war_exploded/js/bootstrap.min.js"></script>
</body>
</html>