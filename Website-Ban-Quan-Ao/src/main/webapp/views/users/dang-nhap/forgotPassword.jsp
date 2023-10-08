<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Lấy lại mật khẩu</title>
  <link rel="stylesheet" href="/Assignment_Sof3011_war_exploded/css/bootstrap.min.css">
  <style>
    .container {
      max-width: 600px;
      margin: auto;
    }
    h2 {
      text-align: center;
    }
    form {
      background-color: #f4f4f4;
      padding: 20px;
      border-radius: 5px;
      box-shadow: 0px 0px 5px 0px rgba(0,0,0,0.5);
    }
    input[type=email], input[type=text] {
      width: 100%;
      padding: 12px 20px;
      margin: 8px 0;
      display: inline-block;
      border: 1px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box;
    }
    button[type=submit] {
      width: 100%;
      background-color: #4CAF50;
      color: white;
      padding: 14px 20px;
      margin: 8px 0;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    button[type=submit]:hover {
      background-color: #45a049;
    }
  </style>
</head>
<body>
<div>
  <h2 class="mt-4">
    Lấy lại mật khẩu
  </h2>
  <hr>
  <div class="container">
    <form method="post" action="/forgot_password.jsp">
      <div class="row mb-3">
        <div class="col-8">
          <input type="email" class="form-control" placeholder="Nhập địa chỉ email" name="email">
        </div>
        <div class="col-4">
          <button type="submit" class="btn btn-primary">Gửi</button>
        </div>
      </div>

      <div class="row mb-3">
        <div class="col-8">
          <input type="text" class="form-control" placeholder="Nhập mã xác nhận" name="code">
        </div>
        <div class="col-4">
          <button type="submit" class="btn btn-primary">Xác nhận</button>
        </div>
      </div>
    </form>
  </div>
</div>
</body>
</html>