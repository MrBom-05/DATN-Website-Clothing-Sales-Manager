<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item" role="presentation">
                    <a class="nav-link active" id="login-tab" data-bs-toggle="tab" href="#login" role="tab"
                       aria-controls="login" aria-selected="true">Đăng Nhập</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="register-tab" data-bs-toggle="tab" href="#register" role="tab"
                       aria-controls="register" aria-selected="false">Đăng Ký</a>
                </li>
            </ul>
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="login" role="tabpanel" aria-labelledby="login-tab">
                    <form>
                        <div class="mb-3">
                            <label for="loginEmail" class="form-label">Email </label>
                            <input type="email" class="form-control" id="loginEmail" aria-describedby="emailHelp">

                        </div>
                        <div class="mb-3">
                            <label for="loginPassword" class="form-label">Mật Khẩu</label>
                            <input type="password" class="form-control" id="loginPassword">
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="loginRemember">
                            <label class="form-check-label" for="loginRemember">Ghi nhớ</label>
                        </div>
                        <button type="submit" class="btn btn-primary">Đăng Nhập</button>
                    </form>
                </div>
                <div class="tab-pane fade" id="register" role="tabpanel" aria-labelledby="register-tab">
                    <form>
                        <div class="mb-3">
                            <label for="registerName" class="form-label">Họ Và Tên</label>
                            <input type="text" class="form-control" id="registerName">
                        </div>
                        <div class="mb-3">
                            <label for="registerEmail" class="form-label">Email </label>
                            <input type="email" class="form-control" id="registerEmail"
                                   aria-describedby="emailHelp">

                        </div>
                        <div class="mb-3">
                            <label for="registerPassword" class="form-label">Mật Khẩu</label>
                            <input type="password" class="form-control" id="registerPassword">
                        </div>
                        <div class="mb-3">
                            <label for="registerPassword" class="form-label">Xác nhận Mật Khẩu</label>
                            <input type="password" class="form-control" id="registerPassword">
                        </div>
                        <div class="flex items-center">
                            <input type="checkbox" id="accept" name="accept" value="ok" class="hidden-checkbox">
                            <div class="flex items-center">
                                <label class="label-nho text-base">
                                    <input type="checkbox" id="accept" name="accept" value="ok"
                                           class="hidden-checkbox">
                                    <span class="checkmark rounded"></span>
                                    Tôi đồng ý với Chính sách bảo mật và Chính sách đổi trả của Leninn Skateshop
                                </label>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">Đăng Ký</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
