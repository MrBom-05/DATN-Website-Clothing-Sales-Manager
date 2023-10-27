<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row col-10 offset-1 mt-3">
    <div class="col-8">
        <table class="table align-middle">
            <thead class="text-center">
            <tr>
                <th colspan="2">Sản phẩm</th>
                <th>Giá</th>
                <th>Số lượng</th>
                <th>Tạm tính</th>
                <th></th>
            </tr>
            </thead>
            <tbody class="text-center">
            <c:forEach items="${listGioHang}" var="gioHang">
                <tr>
                    <td>
                        <img src="${gioHang.anh}" style="width: 100px; height: 100px"
                             alt="sanpham">
                    </td>

                    <td>
                        <a class="link-dark" style="text-decoration: none"
                           href="/san-pham/${gioHang.id}/${gioHang.idMauSac}">${gioHang.tenSanPham}-${gioHang.tenMauSac}-${gioHang.tenKichCo}</a>
                    </td>

                    <td>${gioHang.gia} ₫</td>

                    <td>
                        <form action="/gio-hang/update/${gioHang.idSanPhamChiTiet}" method="post">
                            <div class="input-group mt-3">
                                <button type="submit" class="btn btn-outline-dark" type="button"
                                        onclick="decrement()">-
                                </button>
                                <input type="number" class="form-control text-center" style="width: 50px" id="quantity"
                                       name="soLuong" value="${gioHang.soLuong}" min="1">
                                <button type="submit" class="btn btn-outline-dark" type="button"
                                        onclick="increment()">+
                                </button>
                            </div>
                        </form>
                    </td>
                    <td>${gioHang.soLuong * gioHang.gia} ₫</td>
                    <td>
                        <a href="/gio-hang/${gioHang.idSanPhamChiTiet}" type="button" class="btn-close"
                           aria-label="Close"></a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="row">
            <div class="col-3">
                <input class="form-control" placeholder="Mã khuyến mại"
                       required="" value="">
            </div>
            <div class="col-6">
                <button class="btn btn-dark">Áp dụng</button>
            </div>
        </div>
    </div>

    <div class="col-4 border">
        <div class="ms-3">
            <div class="py-5 fw-bold fs-4 text-xl text-uppercase">
                Thành tiền
            </div>
            <div class="me-3">
                <div class="py-3 border-bottom">
                    <div class="row ms-1 me-1">
                        <label class="col fw-bold fs-6 ">Tạm tính</label>
                        <label class="col  fs-6 text-end">${tongTien} vnđ</label>
                    </div>
                </div>

                <div class="bg-white py-3 border-bottom">
                    <div class="row ms-1 me-1">
                        <label class="col fw-bold fs-6">Phí vận chuyển</label>
                        <label class="col text-uppercase fs-6 text-end">0 ₫</label>
                    </div>
                </div>

                <div class="bg-white py-3 border-bottom">
                    <div class="row ms-1 me-1">
                        <label class="col fw-bold fs-6">Mã khuyến mãi</label>
                        <label class="col text-uppercase fs-6 text-end">-0 ₫</label>
                    </div>
                </div>

                <div class="bg-white py-3 border-bottom">
                    <div class="row ms-1 me-1">
                        <label class="col fw-bold fs-5">Tổng</label>
                        <label class="col text-uppercase fw-bold fs-5 text-end">${tongTien} vnđ</label>
                    </div>
                </div>
            </div>
            <div class="mt-3 mb-3 text-center">
                <button class="bg-dark text-bg-dark fw-bold btn btn-dark">XÁC NHẬN ĐẶT HÀNG</button>
            </div>
        </div>
    </div>
</div>
<script>
    function decrement() {
        var quantityInput = document.getElementById("quantity");
        var currentValue = parseInt(quantityInput.value);
        if (currentValue > 1) {
            quantityInput.value = currentValue - 1;
        }
    }

    function increment() {
        var quantityInput = document.getElementById("quantity");
        var currentValue = parseInt(quantityInput.value);
        quantityInput.value = currentValue + 1;
    }
</script>