<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="mt-5">
    <div>
        <c:if test="${ f:length(listHoaDon) == 0 }">
            <h4 class="text-center">Không có hoá đơn nào</h4>
        </c:if>
        <c:if test="${ f:length(listHoaDon) != 0 }">
            <c:forEach var="hoaDon" items="${ listHoaDon }" varStatus="status">
                <a href="/hoa-don/${hoaDon.id}" style="text-decoration: none">
                    <div class="card mb-2 border col-8 offset-2 fw-bold">
                        <div class="card-body">
                            <div class="row align-items-center">
                                <div class="col-1">
                                    <p class="text-decoration-none text-black">${status.index + 1}</p>
                                </div>
                                <div class="col-2">
                                    <p>Mã Đơn Hàng:</p>
                                    <p>${hoaDon.ma}</p>
                                </div>
                                <div class="col-3">
                                    <p>Ngày Tạo:</p>
                                    <p class="text-decoration-none text-black">
                                        <span id="formattedDate${hoaDon.ma}"></span>
                                        <script>
                                            var originalDate = "${hoaDon.ngayTao}";
                                            var formattedDate = new Date(originalDate).toLocaleString();
                                            document.getElementById("formattedDate${hoaDon.ma}").textContent = formattedDate;
                                        </script>
                                    </p>
                                </div>

                                <div class="col-2">
                                    <p>Tổng Tiền</p>
                                    <p class="text-truncate text-danger" id="tongTien_${hoaDon.ma}"></p>
                                    <script>
                                        document.addEventListener('DOMContentLoaded', function () {
                                            var giaSanPhamElement = document.getElementById("tongTien_${hoaDon.ma}");

                                            fetch(`/so-phan-tram-giam-gia/${hoaDon.id}`)
                                                .then(response => response.json())
                                                .then(data => {

                                                    var soPhanTramGiam = data;
                                                    var soTienBanDau = ${hoaDon.tongTien};
                                                    var soTienSauGiam = soTienBanDau - (soTienBanDau * (soPhanTramGiam / 100));
                                                    var formattedTienSauGiam = soTienSauGiam.toLocaleString('en-US');
                                                    giaSanPhamElement.innerText = formattedTienSauGiam + " vnđ";
                                                })
                                                .catch(error => console.error('Lỗi:', error));
                                        });
                                    </script>
                                </div>

                                <div class="col-2">
                                    <p>Trạng Thái</p>
                                    <p class="text-truncate text-danger">
                                        <c:if test="${hoaDon.trangThai == 0}">
                                            <span class="text-secondary">Chờ thanh toán</span>
                                        </c:if>
                                        <c:if test="${hoaDon.trangThai == 1}">
                                            <span class="text-success">Đã hoàn thành</span>
                                        </c:if>
                                        <c:if test="${hoaDon.trangThai == 2}">
                                            <span class="text-secondary">Chờ xác nhận</span>
                                        </c:if>
                                        <c:if test="${hoaDon.trangThai == 3}">
                                            <span class="text-secondary">Chờ giao</span>
                                        </c:if>
                                        <c:if test="${hoaDon.trangThai == 4}">
                                            <span class="text-success">Đang giao</span>
                                        </c:if>
                                        <c:if test="${hoaDon.trangThai == 5}">
                                            <span class="text-danger">Đã huỷ</span>
                                        </c:if>
                                        <c:if test="${hoaDon.trangThai == 6}">
                                            <span class="text-secondary">Đã xác nhận</span>
                                        </c:if>
                                        <c:if test="${hoaDon.trangThai == 7}">
                                            <span class="text-secondary">Khách delay giao hàng lần 1</span>
                                        </c:if>
                                        <c:if test="${hoaDon.trangThai == 8}">
                                            <span class="text-secondary">Khách delay giao hàng lần 2</span>
                                        </c:if>
                                        <c:if test="${hoaDon.trangThai == 9}">
                                            <span class="text-secondary">Khách delay giao hàng lần 3</span>
                                        </c:if>
                                        <c:if test="${hoaDon.trangThai == 10}">
                                            <span class="text-secondary">Đã huỷ/Chờ hoàn tiền</span>
                                        </c:if>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </c:if>

    </div>
</div>
