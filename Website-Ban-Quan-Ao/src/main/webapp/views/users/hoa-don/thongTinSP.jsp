
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<html>
  <head>
    <title>Title</title>
    <link rel="stylesheet" href="/../css/bootstrap.min.css">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="xxx"
          crossorigin="anonymous"/>
  </head>
<body>
<div class="container">
  <div class="row">
    <div class="col-md-12">
      <h1 class="mt-5">Cảm ơn bạn đã đặt hàng!</h1>
      <p class="lead">Thông tin hoá đơn:</p>
      <c:forEach var="hd" items="${mapHoaDonChiTietViewModel}" varStatus="status">
        <table class="table">
          <tr>
            <td>Mã hoá đơn:</td>
            <td>${hd.key}</td>
          </tr>
          <tr>
            <td>Tên khách hàng:</td>
            <td>${hd.value[0].tenNguoiNhan}</td>
          </tr>
          <tr>
            <td>Địa chỉ:</td>
            <td>${hd.value[0].diaChi}</td>
          </tr>
          <tr>
            <td>Số điện thoại:</td>
            <td>${hd.value[0].sdt}</td>
          </tr>
          <tr>
            <td>Tình trạng:</td>
            <td>${hd.value[0].tinhTrang}</td>
          </tr>
        </table>
        <table class="table">
          <thead>
          <tr>
            <th>Tên sản phẩm</th>
            <th>Số lượng</th>
            <th>Đơn giá</th>
            <th>Thành tiền</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="ct" items="${hd.value}" varStatus="status">
            <tr>
              <td>${ct.tenSP}</td>
              <td>${ct.soLuong}</td>
              <td>${ct.donGia}</td>
              <td>${ct.soLuong * ct.donGia}</td>
            </tr>
            <c:set var="sum" value="${sum + ct.soLuong * ct.donGia}" />
          </c:forEach>
          <tr>
            <td colspan="3" align="right"><b>Tổng tiền:</b></td>
            <td><b>${sum}</b></td>
          </tr>
          </tbody>
        </table>
      </c:forEach>
    </div>
  </div>
</div>
</body>
</html>
