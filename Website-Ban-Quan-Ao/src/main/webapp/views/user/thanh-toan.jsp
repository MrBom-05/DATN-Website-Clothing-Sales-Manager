<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<form:form modelAttribute="formThanhToan" action="/thanh-toan" method="post">
    <div class="row col-10 container offset-1 mt-1">
        <div class="col-6">
            <div class="text-center py-3 fw-bold  text-xl-center text-uppercase">
                Thông tin người nhận
            </div>
            <div class="px-md-5 px-3 py-2 form-group">
                <div class="form-label ">Họ và Tên (*)</div>
                <form:input path="hoTen" class="w-100 form-control" type="text" placeholder="Họ và Tên"/>
            </div>
            <div class="px-md-5 px-3 py-2 form-group">
                <div class="form-label ">Tỉnh/Thành Phố (*)</div>
                <select id="provinceSelect" class="w-100 form-control">
                    <option value="" disabled selected>Chọn tỉnh/thành phố</option>
                </select>
                <form:input path="tinhThanhPho" type="hidden" id="provinceName" name="tinhThanh"/>
            </div>
            <div class="px-md-5 px-3 py-2 form-group">
                <div class="form-label ">Quận/Huyện (*)</div>
                <select id="districtSelect" class="w-100 form-control">
                    <option value="" disabled selected>Chọn quận/huyện</option>
                </select>
                <form:input path="quanHuyen" type="hidden" id="districtName" name="quanHuyen"/>
            </div>
            <div class="px-md-5 px-3 py-2 form-group">
                <div class="form-label ">Xã/Phường (*)</div>
                <select id="wardSelect" class="w-100 form-control">
                    <option value="" disabled selected>Chọn xã/phường</option>
                </select>
                <form:input path="xaPhuong" type="hidden" id="wardName" name="xaPhuong"/>
            </div>
            <div class="px-md-5 px-3 py-2 form-group">
                <div class="form-label ">Địa chỉ (*)</div>
                <form:textarea path="diaChi" class="w-100 form-control" placeholder="..." name="" cols="30"
                               rows="3"></form:textarea>
            </div>
            <div class="px-md-5 px-3 py-2 form-group">
                <div class="form-label ">Số điện thoại (*)</div>
                <form:input path="soDienThoai" class="w-100 form-control" type="text" placeholder="..."/>
            </div>
            <div class="px-md-5 px-3 py-2 form-group">
                <div class="form-label ">Email (*)</div>
                <form:input path="email" class="w-100 form-control" type="text" placeholder="..."/>
            </div>
            <div class="px-md-5 px-3 py-2 form-check  border-bottom">
                <div class="form-label ">Phương thức thanh toán (*)</div>
                <label class="form-check-label text-sm-left fw-bold ">
                    <form:radiobutton path="hinhThucThanhToan" value="1" name="payment_method"/>
                    THANH TOÁN KHI NHẬN HÀNG
                </label>
            </div>

            <div class="px-md-5 px-3 py-2 form-check">
                <label class="form-check-label text-sm-left fw-bold ">
                    <form:radiobutton path="hinhThucThanhToan" value="2" name="payment_method" checked="true"/>
                    THANH TOÁN QUA VNPay
                </label>
            </div>

            <div class="px-md-5 px-3 py-2 form-group mb-5">
                <div class="form-label ">Ghi chú (*)</div>
                <form:textarea path="ghiChu" class="w-100 form-control" placeholder="..." name="" cols="30"
                               rows="5"></form:textarea>
            </div>

        </div>
        <div class="col-6 bg-light">
            <div class="ms-3">
                <div class="text-center py-5 fw-bold fs-4 text-xl-center text-uppercase mb-2">
                    GIỎ HÀNG CỦA BẠN
                </div>
                <div class="me-3">
                    <div class="bg-white  border-bottom">
                        <div class="row ms-1 me-1 py-3">
                            <label class="col text-uppercase fw-bold fs-5">Sản phẩm</label>
                            <label class="col text-uppercase fw-bold fs-5 text-end">Tạm tính</label>
                        </div>
                    </div>

                    <div class="bg-white py-3  border-bottom">
                        <c:forEach items="${listGioHang}" var="gioHang">
                            <div class="row ms-1 me-1">
                                <label class="col-8 text-uppercase">${gioHang.tenSanPham} - ${gioHang.tenMauSac}
                                    - ${gioHang.tenKichCo}
                                    x${gioHang.soLuong}</label>
                                <label class="col-4 text-end">${gioHang.soLuong * gioHang.gia}
                                    vn₫</label>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="bg-white py-3 border-bottom">
                        <div class="row ms-1 me-1">
                            <label class="col fw-bold fs-6 ">Tạm tính</label>
                            <label class="col fw-bold fs-6 text-end">${tongTien} vn₫</label>
                        </div>
                    </div>

                    <div class="bg-white py-3 border-bottom">
                        <div class="row ms-1 me-1">
                            <label class="col fw-bold fs-6">Phí vận chuyển</label>
                            <label class="col fw-bold fs-6 text-end">0 vn₫</label>
                        </div>
                    </div>

                    <div class="bg-white py-3 border-bottom">
                        <div class="row ms-1 me-1">
                            <label class="col fw-bold fs-6">Mã khuyến mãi</label>
                            <label class="col fs-6 text-end">${soTienDuocGiam} vn₫</label>
                        </div>
                    </div>

                    <div class="bg-white py-3 border-bottom">
                        <div class="row ms-1 me-1">
                            <label class="col fw-bold fs-5">Tổng</label>
                            <label class="col fw-bold fs-5 text-end">${soTienSauKhiGiam} vn₫</label>
                        </div>
                    </div>
                </div>

            </div>
            <div class="mt-5">
                <label class="fw-bold">Chính sách</label>
            </div>
            <div class="mt-3 ms-3 bg-light">
                <label>Dữ liệu cá nhân của bạn sẽ được sử dụng để
                    xử lý đơn đặt hàng, hỗ trợ trải nghiệm của
                    bạn trên toàn bộ trang web này và cho các
                    mục đích khác được mô tả trong <a href="">Chính sách bảo mật</a> và <a href="">Chính sách đổi
                        trả</a>.
                </label>
            </div>
            <div class="mt-3 bg-light">
                <label class="form-check-label">
                    <input class="" type="checkbox" name="" id="" checked>
                    Tôi đã đọc và đồng ý với các điều khoản và điều kiện của trang web *
                </label>
            </div>
            <div class="mt-3">
                <button type="submit" class="w-100 bg-dark text-bg-dark fw-bold btn btn-dark">XÁC NHẬN ĐẶT HÀNG</button>
            </div>
        </div>
    </div>
</form:form>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>

<script>
    $(document).ready(function () {
        // Biến kiểm tra trạng thái đã chọn
        var isDistrictSelected = false;
        var isWardSelected = false;
        var isServiceSelected = false;
        // Gọi API để lấy dữ liệu tỉnh/thành phố
        $.ajax({
            url: 'https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/province',
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'Token': 'a76df0d2-77a1-11ee-b1d4-92b443b7a897'
            },
            success: function (data) {
                if (data.code === 200) {
                    const select = document.getElementById('provinceSelect');
                    const input = document.getElementById('provinceName'); // Get the input element

                    data.data.forEach(province => {
                        const option = document.createElement('option');
                        option.value = province.ProvinceID;
                        option.text = province.ProvinceName;
                        select.appendChild(option);
                    });

                    // Set province name in the input field when a province is selected
                    $('#provinceSelect').change(function () {
                        const selectedProvinceName = $('#provinceSelect option:selected').text();
                        input.value = selectedProvinceName; // Set the value of the input field
                    });
                }
            },
            error: function (error) {
                console.error(error);
            }
        });

        // Gọi API để lấy dữ liệu quận/huyện khi thay đổi tỉnh/thành phố
        $('#provinceSelect').change(function () {
            isDistrictSelected = false; // Đặt lại trạng thái khi thay đổi tỉnh/thành phố
            isWardSelected = false; // Đặt lại trạng thái khi thay đổi tỉnh/thành phố

            const provinceID = $(this).val();
            $.ajax({
                url: 'https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/district',
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'Token': 'a76df0d2-77a1-11ee-b1d4-92b443b7a897'
                },
                data: {
                    province_id: provinceID
                },
                success: function (data) {
                    if (data.code === 200) {
                        const select = document.getElementById('districtSelect');
                        const input = document.getElementById('districtName');
                        select.innerHTML = '';
                        data.data.forEach(district => {
                            const option = document.createElement('option');
                            option.value = district.DistrictID;
                            option.text = district.DistrictName;
                            select.appendChild(option);
                        });
                        $('#districtSelect').change(function () {
                            const selectedDistrictName = $('#districtSelect option:selected').text();
                            input.value = selectedDistrictName; // Set the value of the input field
                        });
                    }
                },
                error: function (error) {
                    console.error(error);
                }
            });
        });

        // Gọi API để lấy dữ liệu phường/xã khi thay đổi quận/huyện
        $('#districtSelect').change(function () {
            isDistrictSelected = true; // Đánh dấu trạng thái khi đã chọn quận/huyện
            isWardSelected = false; // Đặt lại trạng thái khi thay đổi quận/huyện

            const districtID = $(this).val();
            $.ajax({
                url: 'https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/ward?district_id=' + districtID,
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'Token': 'a76df0d2-77a1-11ee-b1d4-92b443b7a897'
                },
                data: {
                    district_id: districtID
                },
                success: function (data) {
                    if (data.code === 200) {
                        const select = document.getElementById('wardSelect');
                        const input = document.getElementById('wardName');
                        select.innerHTML = '';
                        data.data.forEach(ward => {
                            const option = document.createElement('option');
                            option.value = ward.WardCode;
                            option.text = ward.WardName;
                            select.appendChild(option);
                        })
                        $('#wardSelect').change(function () {
                            const selectedWardName = $('#wardSelect option:selected').text();
                            input.value = selectedWardName; // Set the value of the input field
                        });
                    }
                },
                error: function (error) {
                    console.error(error);
                }
            });
            // get api dịch vụ
            $.ajax({
                url: 'https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/available-services',
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'Token': 'a76df0d2-77a1-11ee-b1d4-92b443b7a897'
                },
                data: {
                    from_district: 1482,
                    to_district: districtID,
                    shop_id: 190221,
                },
                success: function (data) {
                    if (data.code === 200) {
                        const select = document.getElementById('service_id');
                        select.innerHTML = '';
                        data.data.forEach(service => {
                            const option = document.createElement('option');
                            option.value = service.service_id;
                            option.text = service.short_name;
                            select.appendChild(option);

                        });
                    }
                },
                error: function (error) {
                    console.error(error);
                }
            });
        });

        // Gọi API để lấy dữ liệu dịch vụ khi thay đổi dịch vụ
        var feeCalculated = false; // Biến cờ để kiểm tra xem đã tính phí hay chưa

        $('#service_id').change(function () {
            callAPItoCalculateLeadTime();
            if (!feeCalculated) {
                callAPItoFee();
                feeCalculated = true; // Đánh dấu rằng đã tính phí
            }
        });

        function callAPItoCalculateLeadTime() {
            const districtID = $('#districtSelect').val();
            const wardCode = $('#wardSelect').val();
            const wardCodeString = wardCode.toString();
            $.ajax({
                url: 'https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/leadtime',
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'Token': 'a76df0d2-77a1-11ee-b1d4-92b443b7a897'
                },
                data: {
                    ShopID: 190221,
                    from_district_id: 1482,
                    from_ward_code: "11008",
                    to_district_id: districtID,
                    to_ward_code: wardCodeString,
                    service_id: 53320,
                },
                success: function (data) {
                    if (data.code === 200) {
                        const leadtime = data.data.leadtime;
                        const orderDate = data.data.order_date;
                        // Chuyển đổi timestamp thành định dạng ngày giờ của Việt Nam
                        const leadtimeDate = moment.unix(leadtime).format("DD-MM-YYYY");
                        $('#leadtime').text(leadtimeDate);
                    }
                },
                error: function (error) {
                    console.error(error);
                }
            });
        }

        // function tính phí
        function callAPItoFee() {
            const districtID = $('#districtSelect').val();
            const wardCode = $('#wardSelect').val();
            const wardCodeString = wardCode.toString();
            const feeInput = $('#feeInput');
            const sl = $('#quantity').val();
            console.log(sl + "số lượng");
            // Gọi API GHN với danh sách sản phẩm đã tạo
            $.ajax({
                url: 'https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee',
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'Token': 'a76df0d2-77a1-11ee-b1d4-92b443b7a897'
                },
                data: {
                    ShopID: 190221,
                    service_type_id: 2,
                    to_district_id: districtID,
                    weight: 150 * sl,
                    to_ward_code: wardCodeString,
                    // item: items // Sử dụng danh sách sản phẩm ở đây
                },
                success: function (data) {
                    if (data.code === 200) {
                        const fee = data.data.total;
                        const currentTotal = parseFloat($('#tong-tien').val());
                        const newTotal = currentTotal + fee;
                        $('#feeInput').val(fee); // Đặt giá trị phí vận chuyển vào trường feeInput
                        $('#tong-tien').val(newTotal); // Đặt giá trị mới của tổng tiền
                    }
                },
                error: function (error) {
                    console.error(error);
                }
            });
        }
    });
</script>