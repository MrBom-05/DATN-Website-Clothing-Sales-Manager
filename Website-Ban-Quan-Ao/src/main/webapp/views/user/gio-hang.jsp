<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row g-0 text-center">
    <div class="col-sm-6 col-md-7">
        <table class="table table-fixed">
            <thead>
            <tr>
                <th class="w-2/12 py-3 text-center px-3"></th>
                <th class="w-4/12 py-3 text-left"> Sản phẩm</th>
                <th class="w-2/12 py-3 text-center">Giá</th>
                <th class="w-2/12 py-3 text-center">Số lượng</th>
                <th class="w-2/12 py-3 text-center">Tạm tính</th>
                <th class="w-1/12 py-3 text-center"></th>
            </tr>
            </thead>
            <tbody>
            <tr class="border-b-1 justify-content-center border-gray-300 woocommerce-cart-form_cart-item">
                <td class="py-4 justify-content-center px-4 product-thumbnail">
                    <a href="/product/leninn-stone-washed-bucket-hat">
                        <img src="https://cdn.leninn.com/leninn/products/498f177033a33d6113cf701f95755bca/64ba4a44ec5e0d72ad2a1bc1/lennin-0180a-SfUwRA_100x100.png" alt="sanpham"></a>
                </td>

                <td class="py-5 justify-content-center font-semibold product-name" style="justify-content: start;">
                    <a href="/product/leninn-stone-washed-bucket-hat"><span class="w-full">LENINN STONE WASHED BUCKET HAT</span></a>
                </td>

                <td class="py-5 justify content center text-sm product-price">290,000&nbsp;₫ </td>

                <td class="py-4 justify-content-center text-sm product-quantity">
                    <div class="justify-content-center py-4 d-flex justify-content-center align-items-center border-gray-200 border-2 py-1 w-20">
                        <button class="justify-content-center btn btn-sm btn-light text-dark font-weight-bold">-</button>
                        <input class="justify-content-center w-6 text-center" value="1">
                        <button class="justify-content-center btn btn-sm btn-light text-dark font-weight-bold">+</button>
                    </div>
                </td>

                <td class="py-5 text-center text-sm font-semibold">290,000&nbsp;₫</td>
                <td class="py-5 justify-content-center text-sm product-remove"><button class="text-3xl text-gray-900 font-semibold outline-none">×</button></td>
            </tr>
            </tbody>
        </table>
        <div class="d-md-flex justify-content-between mt-6">
            <form class="flex justify-between md:justify-start">
                <input class="border border-gray-300 py-2 px-3 w-50 mr-3 outline-none" placeholder="Mã khuyến mại" required="" value="">
                <button class="w-full text-center uppercase text-white bg-black text-sm font-semibold py-2 btn btn-dark">Áp dụng</button>
            </form>
        </div>
    </div>

    <div class="col-3 ms-5">
        <div class="p-3 border border-gray-200">
            <h2 class="font-semibold text-xl">Thành tiền</h2>
            <div class="flex justify-between border-b-1 border-gray-200 py-4 text-sm">
                <label class="font-semibold">Tạm tính:</label>
                <span>290,000&nbsp;₫</span>
            </div>
            <div class="flex justify-between border-b-1 border-gray-200 py-4 text-sm">
                <label class="font-semibold">Phí vận chuyển:</label>
                <span>0&nbsp;₫</span>
            </div>
            <div class="flex justify-between border-b-1 border-gray-200 py-4 text-sm">
                <label class="font-semibold">Mã khuyến mại:</label>
                <span>-0&nbsp;₫</span>
            </div>
            <div class="flex justify-between py-4 items-center">
                <label class="font-weight-bold text-xl">Tổng:</label>
                <span class="font-semibold text-xl">290,000&nbsp;₫</span>
            </div>
            <div class="mt-3">
                <button class="w-full text-center uppercase text-white bg-black text-sm font-semibold py-3 btn btn-dark">XÁC NHẬN ĐẶT HÀNG</button>
            </div>
        </div>
    </div>
</div>
