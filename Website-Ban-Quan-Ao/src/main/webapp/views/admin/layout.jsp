<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Admin</title>
    <link href="/../views/admin/css/styles.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<div class="d-flex " id="wrapper">
    <!-- Sidebar-->
    <div class="border-end bg-white" id="sidebar-wrapper">
        <div class="sidebar-heading border-bottom bg-light">
                <c:if test="${admin.chucVu == 0}">
                    <h3>Quản lý</h3>
                </c:if>
                <c:if test="${admin.chucVu == 1}">
                    <h3>Nhân viên</h3>
                </c:if>
        </div>
        <div class="list-group list-group-flush">
            <c:if test="${admin.chucVu == 0}">
                <!-- Hiển thị menu cho quản lý -->
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/san-pham/index">Sản phẩm</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/san-pham-chi-tiet">Sản Phẩm Chi Tiết</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/dong-sp/index">Dòng sản phẩm</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/khach-hang/index">Khách Hàng</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/nhan-vien/index">Nhân Viên</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/cua-hang/index">Cửa Hàng</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/mau-sac/index">Màu sắc</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/nsx/index">Nhà sản xuất</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/chuc-vu/index">Chức vụ</a>
            </c:if>
            <c:if test="${admin.chucVu == 1}">
                <!-- Hiển thị menu cho nhân viên -->
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/san-pham/index">Sản phẩm</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/san-pham-chi-tiet">Sản Phẩm Chi Tiết</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/dong-sp/index">Dòng sản phẩm</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/khach-hang/index">Khách Hàng</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/cua-hang/index">Cửa Hàng</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/mau-sac/index">Màu sắc</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/nsx/index">Nhà sản xuất</a>
            </c:if>
        </div>
    </div>
    <!-- Page content wrapper-->
    <div id="page-content-wrapper">
        <!-- Top navigation-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
            <div class="container-fluid">
                <button class="btn btn-primary" id="sidebarToggle">Menu</button>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                        aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mt-2 mt-lg-0">
                        <li class="nav-item active"><a class="nav-link" href="/admin/ban-hang">
                            <i class="fa-solid fa-cart-shopping"></i>
                            Bán hàng tại quầy
                        </a></li>
                        <li class="nav-item active"><a class="nav-link" href="/admin/hoa-don">
                            <i class="fa-solid fa-file-invoice"></i>
                            Hoá đơn
                        </a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Page content-->
        <div class="container-fluid">
            <h1></h1>
            <jsp:include page="${ view }"/>
        </div>
    </div>
</div>
<!-- Bootstrap core JS-->
<script src="/../js/bootstrap.min.js"></script>
<!-- Core theme JS-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
<!-- Bao gồm các tập lệnh Spring form và các tập lệnh khác -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script>
    window.addEventListener('DOMContentLoaded', event => {
        const sidebarToggle = document.body.querySelector('#sidebarToggle');
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', event => {
                event.preventDefault();
                document.body.classList.toggle('sb-sidenav-toggled');
                localStorage.setItem('sb|sidebar-toggle', document.body.classList.contains('sb-sidenav-toggled'));
            });
        }
    });

</script>
</body>
</html>
