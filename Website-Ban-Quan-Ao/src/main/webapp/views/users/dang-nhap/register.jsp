
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Title</title>
  <link rel="stylesheet" href="/../css/bootstrap.min.css">

</head>
<body>
<c:if test="${not empty message}">
  <div class="alert alert-success" role="alert">
      ${message}
  </div>
</c:if>
<div class="container">
  <h1>Register</h1>
  <sf:form method="post" action="/user/register" modelAttribute="kh">
    <div class="form-group">
      <label>Họ:</label>
      <sf:input path="ho" type="text" class="form-control" />
    </div>
    <div class="form-group">
      <label >Tên đệm:</label>
        <sf:input path="tenDem" type="text" class="form-control" />
    </div>
    <div class="form-group">
      <label>Tên:</label>
        <sf:input path="ten" type="text" class="form-control" />
    </div>
    <div class="form-group">
      <label>Email:</label>
        <sf:input path="email" type="email" class="form-control" />
    </div>
    <div class="form-group">
      <label>Mật khẩu:</label>
        <sf:input path="matKhau" type="password" class="form-control" />
    </div>
    <button type="submit" class="btn btn-primary">Đăng ký</button>
  </sf:form>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.0.2/js/bootstrap.min.js"></script>
</body>
</body>
</html>
