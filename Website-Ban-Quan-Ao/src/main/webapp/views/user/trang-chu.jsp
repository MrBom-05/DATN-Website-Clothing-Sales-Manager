<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="content">
    <style>
        .discount-percentage {
            position: absolute; /* Vị trí tuyệt đối */
            top: 0; /* Đặt ở đỉnh */
            left: 0; /* Đặt ở bên trái */
            background-color: red; /* Màu nền đỏ */
            color: white; /* Màu chữ trắng */
            padding: 5px; /* Khoảng cách nội dung từ viền */
            font-weight: bold; /* In đậm */
        }
    </style>
    <div class="container ">
        <h3 class="fw-bold text-lg-start mt-4">Sản phẩm mới nhất</h3>
        <div class="row row-cols-2 row-cols-md-4 g-4">
            <c:forEach items="${listTrangChu}" var="sanPham">
                <div class="col">
                    <a href="/san-pham/${sanPham.id}/${sanPham.idMauSac}" class="text-decoration-none text-dark">
                        <div class="card border-0">
                            <img src="${sanPham.anh}" class="card-img-top" alt="${sanPham.ten}">
                            <span class="discount-percentage" id="so-phan-tram-giam_${sanPham.id}"></span>
                            <div class="card-body text-center">
                                <p>${sanPham.ten}</p>
                                <c:choose>
                                    <c:when test="${sanPham.giaNhoNhat eq sanPham.giaLonNhat}">
                                        <p class="fw-bold gia-san-pham"
                                           id="gia-san-pham_${sanPham.id}">${sanPham.giaNhoNhat} vnđ</p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="fw-bold gia-san-pham"
                                           id="gia-san-pham_${sanPham.id}">${sanPham.giaNhoNhat}
                                            -- ${sanPham.giaLonNhat} vnđ</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </a>
                </div>
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                <script>
                    $(document).ready(function () {
                        var idSanPham = '${sanPham.id}';
                        $.ajax({
                            url: "/so-phan-tram-giam/" + idSanPham,
                            method: "GET",
                            success: function (data) {
                                console.log("idSanPham: " + idSanPham);
                                console.log(data);
                                if (data != null) {
                                    var span = $("#so-phan-tram-giam_" + idSanPham);
                                    span.html(data + "% off");

                                    var giaSpan = $("#gia-san-pham_" + idSanPham);
                                    giaSpan.hide();
                                    // Tính giá sản phẩm sau khi giảm và hiển thị nó
                                    var giaSanPham = ${sanPham.giaNhoNhat};
                                    var soPhanTramGiam = data;
                                    var giaSauGiam = giaSanPham - (giaSanPham * soPhanTramGiam / 100);
                                    giaSpan.after('<p class="fw-bold gia-moi">' + giaSauGiam + ' vnđ</p>');
                                } else {
                                    var span = $("#so-phan-tram-giam_" + idSanPham);
                                    span.hide();
                                }
                            },
                            error: function () {
                                // Xử lý lỗi nếu có
                            }
                        });
                    });
                </script>
            </c:forEach>
        </div>
    </div>
</section>
<section>
    <div class="row justify-content-center col-2 offset-5 px-1 ">
        <a href="/san-pham"
           class="text-decoration-none text-dark fw-bold text-center py-3 px-5 border border-none rounded-pill">Xem
            Thêm</a>
    </div>
</section>