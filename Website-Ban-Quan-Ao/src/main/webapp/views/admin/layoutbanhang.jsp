<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý hóa đơn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="styles.css" rel="stylesheet">
</head>

<body>
<div class="container">
    <div class="row">
        <div class="col-lg-6">
            <h4>Danh sách hóa đơn</h4>
            <table class="table table-bordered text-center mt-3">
                <thead>
                <tr>
                    <th>STT</th>
                    <th>Mã</th>
                    <th>Họ và tên</th>
                    <th>Email</th>
                    <th>SĐT</th>
                    <th>Thao Tác</th>
                </tr>
                </thead>
                <tbody>
                <!-- Dữ liệu danh sách hóa đơn -->
                </tbody>
            </table>

            <div class="row mt-4">
                <div class="col-12">
                    <h4>Giỏ hàng</h4>
                    <table class="table table-bordered text-center mt-3">
                        <thead>
                        <tr>
                            <th>STT</th>
                            <th>Mã</th>
                            <th>Họ và tên</th>
                            <th>Email</th>
                            <th>Thao Tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- Dữ liệu giỏ hàng -->
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="row mt-4">
                <div class="col-12">
                    <h4>Danh sách sản phẩm</h4>
                    <div class="form-group col-5 mb-2">
                        <label >Tìm kiếm sản phẩm</label>
                        <input type="text" class="form-control">
                    </div>

                    <div class="row">
                        <!-- Thẻ sản phẩm dưới dạng card -->
                        <div class="col-3 mb-4">
                            <div class="card">
                                <img src="product1.jpg" class="card-img-top" alt="Product 1">
                                <div class="card-body">
                                    <h5 class="card-title">Sản phẩm 1</h5>
                                    <p class="card-text">Mô tả sản phẩm 1.</p>
                                    <a href="#" class="btn btn-primary">Thêm vào giỏ hàng</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-3 mb-4">
                            <div class="card">
                                <img src="product2.jpg" class="card-img-top" alt="Product 2">
                                <div class="card-body">
                                    <h5 class="card-title">Sản phẩm 2</h5>
                                    <p class="card-text">Mô tả sản phẩm 2.</p>
                                    <a href="#" class="btn btn-primary">Thêm vào giỏ hàng</a>
                                </div>
                            </div>
                        </div>
                        <!-- Thêm sản phẩm khác tại đây -->
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-2">
            <div class="form-group">
                <label >Quét mã QR code</label>
                <div class="video-container">
                    <video id="qr-video" width="150px"></video>
                    <canvas id="qr-canvas" style="display: none;"></canvas>
                    <div id="qr-result">Chưa có mã QR code được quét.</div>
                </div>
            </div>
        </div>
        <div class="col-lg-4 border">
            <h4>Tạo mới hóa đơn</h4>
            <form>
                <div class="mb-3">
                    <label for="customer-name" class="form-label">Tên khách hàng</label>
                    <input type="text" class="form-control" id="customer-name" placeholder="Nhập tên khách hàng">
                </div>
                <div class="mb-3">
                    <label for="phone" class="form-label">SĐT</label>
                    <input type="text" class="form-control" id="phone" placeholder="Nhập số điện thoại">
                </div>
                <div class="mb-3">
                    <label for="address" class="form-label">Địa chỉ</label>
                    <textarea class="form-control" id="address" rows="3" placeholder="Nhập địa chỉ"></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Lưu</button>
                <button type="button" class="btn btn-secondary">Hủy</button>
            </form>
        </div>
    </div>
</div>

<script src="https://rawgit.com/schmich/instascan-builds/master/instascan.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
    const scanner = new Instascan.Scanner({ video: document.getElementById('qr-video') });

    // Thêm sự kiện cho khi quét QR code thành công
    scanner.addListener('scan', function (content) {
        // Xử lý kết quả quét tại đây (ví dụ: hiển thị nó trong một input)
        if (content) {
            document.getElementById('qr-result').textContent = content;
        }

    });

    // Khi trang web được tải, bắt đầu quét QR code
    Instascan.Camera.getCameras().then(function (cameras) {
        if (cameras.length > 0) {
            scanner.start(cameras[0]);
        } else {
            alert('Không tìm thấy máy ảnh.');
        }
    }).catch(function (e) {
        console.error(e);
    });
</script>

</body>

</html>