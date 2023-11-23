<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>






<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>


    <%--    bieu do--%>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', {'packages':['bar']});
        google.charts.setOnLoadCallback(drawStuff);

        function drawStuff() {
            var data = new google.visualization.arrayToDataTable([
                ['Move', 'Vnđ:'],
                ["${Tru0ThangTruoc}", ${TongDoanhThuThangHienTai}],
                ["${Tru1ThangTruoc}", ${TongDoanhThuThangHienTaiTru1}],
                ["${Tru2ThangTruoc}", ${TongDoanhThuThangHienTaiTru2}],
                ["${Tru3ThangTruoc}", ${TongDoanhThuThangHienTaiTru3}],
                ["${Tru4ThangTruoc}", ${TongDoanhThuThangHienTaiTru4}],
                ["${Tru5ThangTruoc}", ${TongDoanhThuThangHienTaiTru5}],
                ["${Tru6ThangTruoc}", ${TongDoanhThuThangHienTaiTru6}]
            ]);

            var options = {
                width: 1050,
                legend: { position: 'none' },
                chart: {
                    title: 'Biểu đồ :',
                    subtitle: '' },
                axes: {
                    x: {
                        0: { side: 'top', label: 'Biểu đồ thống kê doanh thu theo từng tháng.'} // Top x-axis.
                    }
                },
                bar: { groupWidth: "90%" }
            };

            var chart = new google.charts.Bar(document.getElementById('top_x_div'));
            // Convert the Classic options to Material options.
            chart.draw(data, google.charts.Bar.convertOptions(options));
        };
    </script>

</head>
<body class="bg-light">


<div class="col-8 offset-2 py-5">
    <div class="row ">
        <div class="fw-bold text-xl text-uppercase py-2 ">
            Thống kê
        </div>

        <div class="row">
            <div class="form-group py-1 col">
                <select id="selectOption" class="w-50 form-control">
                    <option value="TongDoanhThu" >Doanh thu</option>
                    <option value="TongDoanhThuNgayHienTai" >Ngày</option>
                    <option value="TongDoanhThuTuanHienTai" >Tuần này</option>
                    <option value="TongDoanhThuThangHienTai" >Tháng này</option>
                    <option value="TongDoanhThuNamHienTai" >Năm này</option>
                    <option value="TongDoanhThu6ThangQua" >6 tháng qua</option>
                    <option value="TongDoanhThu1NamQua" >1 năm qua</option>
                </select>
            </div>
            <div class="col-1"></div>
            <div class="form-group py-1 col">
                <select id="selectOption2" class="w-50 form-control">
                    <option value="SanPhamBanChayNhat" >Sản phẩm chạy nhất</option>
                    <option value="SanPhamBanChayNhatTrongNgay" >Ngày</option>
                    <option value="SanPhamBanChayNhatTrongTuan" >Tuần này</option>
                    <option value="SanPhamBanChayNhatTrongThang" >Tháng này</option>

                </select>
            </div>
            <div class="col-4"></div>
        </div>


    </div>

    <div class="row">
        <!-- Định dạng doanh thu thành kiểu số -->
        <fmt:formatNumber value="${TongDoanhThu}" pattern="#,##0" var="formattedTongDoanhThu" />
        <fmt:formatNumber value="${TongDoanhThuNgayHienTai}" pattern="#,##0" var="formattedTongDoanhThuNgayHienTai" />
        <fmt:formatNumber value="${TongDoanhThuTuanHienTai}" pattern="#,##0" var="formattedTongDoanhThuTuanHienTai" />
        <fmt:formatNumber value="${TongDoanhThuThangHienTai}" pattern="#,##0" var="formattedTongDoanhThuThangHienTai" />
        <fmt:formatNumber value="${TongDoanhThuNamHienTai}" pattern="#,##0" var="formattedTongDoanhThuNamHienTai" />
        <fmt:formatNumber value="${TongDoanhThu6ThangQua}" pattern="#,##0" var="formattedTongDoanhThu6ThangQua" />
        <fmt:formatNumber value="${TongDoanhThu1NamQua}" pattern="#,##0" var="formattedTongDoanhThu1NamQua" />

        <div class="col bg-white">
            <h4 class="col py-2">Doanh thu</h4>
                <div class="col-2"></div>
                <h2  id="displayValue" class="col py-1"> ${formattedTongDoanhThu} vnđ</h2>




        </div>

        <div class="col-1"></div>

        <div class=" col bg-white">
            <h4 class="py-2">Sản phẩm chạy nhất</h4>
            <h2 id="displayValue2" class="col py-1">${SanPhamBanChayNhat}</h2>
        </div>

        <div class="col-1"></div>

        <div class="col bg-white">
            <h5 class="py-2">Nhân viên chăm chỉ</h5>
            <h2 class="col py-1">${NhanVienBanDcNhieuNhat}</h2>
        </div>

    </div>


    <%--    bieu do--%>
    <div class="py-5" id="top_x_div" style="width: 800px; height: 600px;"></div>

</div>

<script>
    // Sử dụng JavaScript để xử lý sự kiện thay đổi của thẻ select
    document.getElementById('selectOption').addEventListener('change', function () {
        var selectedOption = this.value;
        var displayValue = document.getElementById('displayValue');

        // Cập nhật giá trị trong thẻ h2 tương ứng với lựa chọn
        switch (selectedOption) {
            case 'TongDoanhThu':
                displayValue.innerText = "${formattedTongDoanhThu} vnđ";
                break;
            case 'TongDoanhThuNgayHienTai':
                displayValue.innerText = "${formattedTongDoanhThuNgayHienTai} vnđ";
                break;
            case 'TongDoanhThuTuanHienTai':
                displayValue.innerText = "${formattedTongDoanhThuTuanHienTai} vnđ";
                break;
            case 'TongDoanhThuThangHienTai':
                displayValue.innerText = "${formattedTongDoanhThuThangHienTai} vnđ";
                break;
            case 'TongDoanhThuNamHienTai':
                displayValue.innerText = "${formattedTongDoanhThuNamHienTai} vnđ";
                break;

            case 'TongDoanhThu6ThangQua':
                displayValue.innerText = "${formattedTongDoanhThu6ThangQua} vnđ";
                break;

            case 'TongDoanhThu1NamQua':
                displayValue.innerText = "${formattedTongDoanhThu1NamQua} vnđ";
                break;
            // Các trường hợp khác...
            default:
                displayValue.innerText = "";
                break;
        }
    });

    document.getElementById('selectOption2').addEventListener('change', function () {
        var selectedOption2 = this.value;
        var displayValue2 = document.getElementById('displayValue2');

        // Cập nhật giá trị trong thẻ h2 tương ứng với lựa chọn
        switch (selectedOption2) {
            case 'SanPhamBanChayNhat':
                displayValue2.innerText = "${SanPhamBanChayNhat}";
                break;
            case 'SanPhamBanChayNhatTrongNgay':
                displayValue2.innerText = "${SanPhamBanChayNhatTrongNgay}";
                break;
            case 'SanPhamBanChayNhatTrongTuan':
                displayValue2.innerText = "${SanPhamBanChayNhatTrongTuan}";
                break;
            case 'SanPhamBanChayNhatTrongThang':
                displayValue2.innerText = "${SanPhamBanChayNhatTrongThang}";
                break;
            // Các trường hợp khác...
            default:
                displayValue2.innerText = "";
                break;
        }
    });
</script>
</body>
</html>