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
                                    <p class="text-truncate text-danger" id="tongTien_${hoaDon.ma}">
                                            ${hoaDon.tongTien}
                                    </p>
                                    <script>
                                        var giaSanPhamElement = document.getElementById("tongTien_${hoaDon.ma}");
                                        var giaSanPhamText = giaSanPhamElement.innerText;
                                        var formattedGia = parseInt(giaSanPhamText.replace(/[^\d]/g, '')).toLocaleString('en-US');
                                        giaSanPhamElement.innerText = formattedGia + " vnđ";
                                    </script>
                                </div>

                                <div class="col-2">
                                    <p>Trạng Thái</p>
                                    <p class="text-truncate text-danger">
                                    <c:if test="${hoaDon.trangThai == 0}">
                                        <span class="text-secondary">Chờ thanh toán</span>
                                    </c:if>
                                    <c:if test="${hoaDon.trangThai == 1}">
                                        <span class="text-success">Đã thanh toán</span>
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
