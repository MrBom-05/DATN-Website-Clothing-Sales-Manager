<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin</title>
    <link href="/../views/admin/css/styles.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" />
</head>
<body>
<div class="d-flex " id="wrapper">
    <!-- Sidebar-->
    <div class="border-end bg-white" id="sidebar-wrapper">
        <div class="sidebar-heading border-bottom bg-light">ADMIN</div>
        <div class="list-group list-group-flush">
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
            <a
                class="list-group-item list-group-item-action list-group-item-light p-3"
                href="/admin/hoa-don/index">Quản lí hoá đơn</a>
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
                        <li class="nav-item active"><a class="nav-link" href="#!">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="#!">Link</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button"
                               data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Dropdown</a>
                            <div class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item" href="#!">Action</a>
                                <a class="dropdown-item" href="#!">Another action</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#!">Something else here</a>
                            </div>
                        </li>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="/../js/bootstrap.min.js"></script>
<!-- Core theme JS-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>

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
