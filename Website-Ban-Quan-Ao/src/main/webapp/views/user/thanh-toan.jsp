<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<form>
    <div class="row col-8 container offset-2">
        <div class="col-6">

            <div class="text-center py-3 fw-bold  text-xl-center text-uppercase">
                Thông tin người nhận
            </div>

            <div class="px-md-5 px-3 py-2 form-group">
                <div class="form-label ">Họ và Tên (*)</div>
                <input class="w-100 form-control" type="text" placeholder="Họ và Tên">
            </div>

            <div class="px-md-5 px-3 py-2 form-group">
                <div class="form-label ">Tỉnh/Thành Phố (*)</div>
                <select class="w-100 form-control" name="" id="">
                    <option value="">Bắc Giang</option>
                    <option value="">Hà Nội</option>
                </select>
            </div>

            <div class="px-md-5 px-3 py-2 form-group">
                <div class="form-label ">Quận/Huyện (*)</div>
                <select class="w-100 form-control" name="" id="">
                    <option value="">Bắc Giang</option>
                    <option value="">Hà Nội</option>
                </select>
            </div>

            <div class="px-md-5 px-3 py-2 form-group">
                <div class="form-label ">Xã/Phường (*)</div>
                <select class="w-100 form-control" name="" id="">
                    <option value="">Bắc Giang</option>
                    <option value="">Hà Nội</option>
                </select>
            </div>

            <div class="px-md-5 px-3 py-2 form-group">
                <div class="form-label ">Địa chỉ (*)</div>
                <textarea class="w-100 form-control" placeholder="..." name="" id="" cols="30" rows="3"></textarea>
            </div>

            <div class="px-md-5 px-3 py-2 form-group">
                <div class="form-label ">Số điện thoại (*)</div>
                <input class="w-100 form-control" type="text" placeholder="...">
            </div>

            <div class="px-md-5 px-3 py-2 form-group">
                <div class="form-label ">Email (*)</div>
                <input class="w-100 form-control" type="text" placeholder="...">
            </div>

            <div class="px-md-5 px-3 py-2 form-check  border-bottom">
                <div class="form-label ">Phương thức thanh toán (*)</div>
                <label class="form-check-label text-sm-left fw-bold ">
                    <input class="" type="radio" value="1" name="payment_method" id="" checked>
                    THANH TOÁN KHI NHẬN HÀNG
                </label>
            </div>

            <div class="px-md-5 px-3 py-2 form-check">
                <label class="form-check-label text-sm-left fw-bold ">
                    <input class="" type="radio" value="2" name="payment_method" id="" checked>
                    CHUYỂN KHOẢN NGÂN HÀNG
                </label>
            </div>

            <div class="px-md-5 form-check border-bottom">
                <label class="mb-3">
                    Quý khách chuyển khoản tới tài khoản anh VI VIET HOA<br>
                    Số tài khoản: 4300153944<br>
                    Tại: Ngân hàng BIDV.<br>
                    Số tiền chuyển khoản: 450,000 ₫<br>
                    Nội dung chuyển khoản: Kinh gui anh Hoa Mã vận đơn + Số điện thoại
                </label>
            </div>

            <div class="px-md-5 px-3 py-2 form-group mb-5">
                <div class="form-label ">Ghi chú (*)</div>
                <textarea class="w-100 form-control" placeholder="..." name="" id="" cols="30" rows="5"></textarea>
            </div>

        </div>
        <div class="col-1"></div>
        <div class="col-4 bg-light">
            <div class="ms-3">
                <div class="text-center py-5 fw-bold fs-4 text-xl-center text-uppercase mb-2">
                    GIỎ HÀNG CỦA BẠN
                </div>
                <div class="me-3">
                    <div class="bg-white  border-bottom">
                        <div class="row ms-1 me-1 py-3">
                            <label class="col text-uppercase fw-bold fs-5  ">Sản phẩm</label>
                            <label class="col text-uppercase fw-bold fs-5 text-end">Tạm tính</label>
                        </div>
                    </div>

                    <div class=" bg-white py-3  border-bottom">
                        <div class="row ms-1 me-1">
                            <label class="col-8 text-uppercase ">NGƯỜI DA ĐEN x1</label>
                            <label class="col-4 text-uppercase  text-end">450,000 ₫</label>
                        </div>
                    </div>

                    <div class=" bg-white py-3 border-bottom">
                        <div class="row ms-1 me-1">
                            <label class="col fw-bold fs-6 ">Tạm tính</label>
                            <label class="col text-uppercase fw-bold fs-6 text-end">450,000 ₫</label>
                        </div>
                    </div>

                    <div class="bg-white py-3 border-bottom">
                        <div class="row ms-1 me-1">
                            <label class="col fw-bold fs-6 ">Phí vận chuyển</label>
                            <label class="col text-uppercase fw-bold fs-6 text-end">0 ₫</label>
                        </div>
                    </div>

                    <div class=" bg-white py-3 border-bottom">
                        <div class="row ms-1 me-1">
                            <label class="col fw-bold fs-6 ">Mã khuyến mãi</label>
                            <label class="col text-uppercase  fs-6 text-end">-0 ₫</label>
                        </div>
                    </div>

                    <div class=" bg-white py-3 border-bottom">
                        <div class="row ms-1 me-1">
                            <label class="col fw-bold fs-5  ">Tổng</label>
                            <label class="col text-uppercase fw-bold fs-5 text-end">450,000 ₫</label>
                        </div>
                    </div>
                </div>

            </div>


            <div class="mt-5">
                <label class="fw-bold ">Chính sách</label>
            </div>
            <div class="mt-3 ms-3 bg-light">
                <label>Dữ liệu cá nhân của bạn sẽ được sử dụng để
                    xử lý đơn đặt hàng, hỗ trợ trải nghiệm của
                    bạn trên toàn bộ trang web này và cho các
                    mục đích khác được mô tả trong <a href="">Chính sách bảo mật</a> và <a href="">Chính sách đổi trả</a>.
                </label>
            </div>


            <div class="mt-3 bg-light">
                <label class="form-check-label  ">
                    <input class="" type="checkbox" name="" id="" checked>
                    Tôi đã đọc và đồng ý với các điều khoản và điều kiện của trang web *
                </label>
            </div>

            <div class="mt-3">
                <button class="w-100 bg-dark text-bg-dark fw-bold btn btn-dark">XÁC NHẬN ĐẶT HÀNG</button>
            </div>
        </div>
    </div>
</form>