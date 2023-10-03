import * as React from 'react';
import {Route, Routes} from "react-router-dom";
import styles from "./css/BanHang.css";
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min';


export default function BanHang() {

    return (
        <div className="all">
            <header className="container-fluid custom-header">
                <div className="row align-items-center">
                    <div className="col-2">
                        <div className="input-group">
                            <span className="input-group-text"><i className="fa-solid fa-magnifying-glass" /></span>
                            <input type="text" className="form-control" placeholder="Search"/>
                        </div>
                    </div>


                    <div className="col-1">
                        <input type="number" className="form-control" placeholder="Số lượng"/>
                    </div>


                    <div className="col-1">
                        <i className="fa-solid fa-barcode small"></i>
                    </div>

                    <div className="col-3 ">
                        <ul className="nav nav-tabs" id="myTabs">
                            <li className="nav-item">
                                <a href="#" tabIndex="-1" className="nav-link">
                                    <span>Tab 1</span>
                                    <button className="close-tab border-0 bg-transparent" data-bs-toggle="modal"
                                            data-bs-target="#exampleModal">
                                        <i className="fa-solid fa-minus small"></i>
                                    </button>
                                </a>
                                <div className="modal fade" id="exampleModal" tabIndex="-1"
                                     aria-labelledby="exampleModalLabel"
                                     aria-hidden="true">
                                    <div className="modal-dialog">
                                        <div className="modal-content">
                                            <div className="modal-header">
                                                <h1 className="modal-title fs-5 text-danger" id="exampleModalLabel">Đóng
                                                    <span className="fw-bold">Hóa đơn 2</span>
                                                </h1>
                                                <button type="button" className="btn-close" data-bs-dismiss="modal"
                                                        aria-label="Close"></button>
                                            </div>
                                            <div className="modal-body">
                                       <span className="text-dark">Thông tin của
                                        <span className="fw-bold"> Hóa đơn 2</span>
                                        sẽ không được lưu lại. Bạn có chắc chắn muốn đóng không?</span>
                                            </div>
                                            <div className="modal-footer">
                                                <button type="button" className="btn btn-secondary"
                                                        data-bs-dismiss="modal">Bỏ qua
                                                </button>
                                                <button type="button" className="btn btn-primary">Xoá</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li className="nav-item">
                                <a href="#" tabIndex="-1" className="nav-link">
                                    <span>Tab 2</span>
                                    <button className="close-tab border-0 bg-transparent" onClick="closeTab(this)">
                                        <i className="fa-solid fa-minus small"></i>
                                    </button>
                                </a>
                            </li>
                            <li className="nav-item">
                                <a href="#" tabIndex="-1" className="nav-link">
                                    <span>Tab 3</span>
                                    <button className="close-tab border-0 bg-transparent" onClick="closeTab(this)">
                                        <i className="fa-solid fa-minus small"></i>
                                    </button>
                                </a>
                            </li>
                            <a className="ms-2 text-decoration-none text-dark" href="" tabIndex="-1" title="Thêm mới">
                                <i className="fa-solid fa-plus small "></i>
                            </a>
                        </ul>
                    </div>

                    <div className="col-3 d-flex justify-content-end">
                        <i className="fa-brands fa-shopify me-4"></i>
                        <i className="fa-brands fa-shopify me-4"></i>
                        <i className="fa-brands fa-shopify me-4"></i>
                        <i className="fa-brands fa-shopify"></i>
                    </div>

                    <div className="col-1">
                        <span>0356617931</span>
                    </div>

                    <div className="col-1">
                        <div className="dropdown">
                            <button className="bg-transparent border-0" type="button" data-bs-toggle="dropdown"
                                    aria-expanded="false">
                                <i className="fa-solid fa-bars"></i>
                            </button>
                            <ul className="dropdown-menu">
                                <li><a className="dropdown-item" href="#">Action</a></li>
                                <li><a className="dropdown-item" href="#">Another action</a></li>
                                <li><a className="dropdown-item" href="#">Something else here</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </header>
            <div className="row px-3">
                <section className="col-6 custom-scroll">
                    {/*Repeat*/}
                    <div className="card mt-2 mb-2 ">
                        <div className="card-body ">
                            <div className="input-group align-items-center">
                                <div className="d-table-cell col-1">
                                    1
                                </div>
                                <div className="col-md-1 col-1">
                                    <a href="" style={{ color: 'inherit' }}> <i className="fa-solid fa-trash small"></i></a>
                                </div>
                                <div className="d-table-cell col-3">
                                    <small>NAM020</small>
                                </div>
                                <div className="col-lg-5">
                                    <span id="priceProduct" className="text-center">Quần kaki nam màu đen</span>
                                </div>
                                <div className="col-1">
                                    <button className="btn btn-default btn-more me-auto" type="button"
                                            data-bs-toggle="popover"
                                            data-bs-placement="bottom" data-bs-trigger="click"
                                            data-bs-content="Vui lòng nhập số lượng">
                                        <i className="fa-solid fa-ellipsis-v"></i>
                                    </button>
                                </div>

                                <div className="input-group">
                                    <div className="col-md-4 mt-4">
                                        <div className="input-group input-group-sm">
                                            <button type="button" className="btn">
                                                <i className="fa-solid fa-minus small"></i>
                                            </button>
                                            <input id="note-cartitem-0" type="text" title="Tồn: 91 - Đặt: 0"
                                                   style={{ width: '60px', textAlign: 'center' }}/>
                                                <button type="button" className="btn btn-icon btn-icon-bg-default up">
                                                    <i className="fa-solid fa-plus small"></i>
                                                </button>
                                                <span className="sub-label d-none">/ 0</span>
                                        </div>
                                    </div>
                                    <div className="col-md-4 mt-4">
                                        <button className="btn btn-toolbar">
                                            1111111
                                        </button>
                                    </div>
                                    <div className="col-md-4 mt-4 d-flex align-items-center">
                                        <span className="fw-bold">$999</span>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                    <div className="card mt-2 mb-2 ">
                        <div className="card-body ">
                            <div className="input-group align-items-center">
                                <div className="d-table-cell col-1">
                                    1
                                </div>
                                <div className="col-md-1 col-1">
                                    <a href="" style={{ color: 'inherit' }}> <i className="fa-solid fa-trash small"></i></a>
                                </div>
                                <div className="d-table-cell col-3">
                                    <small>NAM020</small>
                                </div>
                                <div className="col-lg-5">
                                    <span id="priceProduct" className="text-center">Quần kaki nam màu đen</span>
                                </div>
                                <div className="col-1">
                                    <button className="btn btn-default btn-more me-auto" type="button"
                                            data-bs-toggle="popover"
                                            data-bs-placement="bottom" data-bs-trigger="click"
                                            data-bs-content="Vui lòng nhập số lượng">
                                        <i className="fa-solid fa-ellipsis-v"></i>
                                    </button>
                                </div>

                                <div className="input-group">
                                    <div className="col-md-4 mt-4">
                                        <div className="input-group input-group-sm">
                                            <button type="button" className="btn">
                                                <i className="fa-solid fa-minus small"></i>
                                            </button>
                                            <input id="note-cartitem-0" type="text" title="Tồn: 91 - Đặt: 0"
                                                   style={{ width: '60px', textAlign: 'center' }}/>
                                                <button type="button" className="btn btn-icon btn-icon-bg-default up">
                                                    <i className="fa-solid fa-plus small"></i>
                                                </button>
                                                <span className="sub-label d-none">/ 0</span>
                                        </div>
                                    </div>
                                    <div className="col-md-4 mt-4">
                                        <button className="btn btn-toolbar">
                                            1111111
                                        </button>
                                    </div>
                                    <div className="col-md-4 mt-4 d-flex align-items-center">
                                        <span className="fw-bold">$999</span>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                    {/* End Repeat*/}
                    <div className="bottom-input">
                        <div className="row mt-2">
                            <div className="col-md-6">
                                <div className="card border-opacity-10">
                                    <div className="card-body row">
                                        <div className="col-5">
                                    <textarea className="form-control" rows="2" id="comment"
                                              placeholder="Ghi chú đơn hàng"></textarea>
                                        </div>
                                        <div className="col-3">
                                            <span>Tổng tiền hàng</span>
                                        </div>
                                        <div className="col-1">
                                            <span>1</span>
                                        </div>
                                        <div className="col-3 text-end">
                                            <span>111111$</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <section className="col-6">
                    <div className="card mt-2 mb-2">
                        <div className="card-header">
                            <div className="row align-items-center">
                                <div className="col-8">
                                    <div className="input-group">
                                        <span className="input-group-text"><i className="fas fa-search"></i></span>
                                        <input type="text" className="form-control" placeholder="Search"/>
                                            <span className="input-group-text">
                                                <i className="fas fa-plus"></i>
                                            </span>
                                    </div>
                                </div>
                                <div className="col 1">
                                    <button className="btn border-0">
                                        <i className="fa-solid fa-list"></i>
                                    </button>
                                </div>
                                <div className="col 1">
                                    <button className="btn border-0">
                                        <i className="fa-solid fa-filter"></i>
                                    </button>
                                </div>
                                <div className="col 1">
                                    <button className="btn border-0">
                                        <i className="fa-solid fa-image"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div className="card-body">
                            <div className="row row-cols-4 row-cols-md-4 g-2">
                                {/*Repeat*/}
                                <button className="btn btn-custom">
                                    <div className="col">
                                        <div className="product">
                                            <img loading="lazy" src="https://cdn-app.kiotviet.vn/sample/fashion/2.png"
                                                 className="img-fluid small custom-img" alt="Ảnh sản phẩm"/>
                                                <div className="product-info">
                                                    <span className="product-name">Áo vest nữ</span>
                                                    <br/>
                                                        <span className="product-price text-primary">500đ</span>
                                                </div>
                                        </div>
                                    </div>
                                </button>
                            {/* End Repeat*/}
                            </div>

                        </div>

                        <div className="card-footer">
                            <div className="row ">
                                <div className="col-3">
                                    <div className="input-group">
                                        <button type="button" title="Trang trước" className="btn ">
                                            <i className="fa fa-angle-left"></i>
                                        </button>
                                        <span className="number-pages">1/3</span>
                                        <button type="button" title="Trang sau" className="btn">
                                            <i className="fa fa-angle-right"></i>
                                        </button>
                                    </div>
                                </div>
                                <div className="col-8 justify-content-end">
                                    <button className="btn btn-primary w-100" type="button" data-bs-toggle="offcanvas"
                                            data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">Thanh toán
                                    </button>

                                    <div className="offcanvas offcanvas-end" tabIndex="-1" id="offcanvasRight"
                                         aria-labelledby="offcanvasRightLabel">
                                        <div className="offcanvas-header">
                                            <div className="dropdown">
                                                <a className="btn btn-primary dropdown-toggle" href="#" role="button"
                                                   data-bs-toggle="dropdown" aria-expanded="false">
                                                    Nhân viên
                                                </a>

                                                <ul className="dropdown-menu">
                                                    <li className="border-3">
                                                        <input className="dropdown-item" placeholder="Tìm kiếm tên NV"/>
                                                    </li>
                                                    <li><a className="dropdown-item" href="#">Nguyễn Ngọc Kỳ</a></li>
                                                    <li><a className="dropdown-item" href="#">Đặng Thành Trung</a></li>
                                                </ul>
                                            </div>
                                            <span>13/08/2023</span>
                                            <span>13:08</span>
                                            <button type="button" className="btn-close" data-bs-dismiss="offcanvas"
                                                    aria-label="Close"></button>
                                        </div>
                                        <div className="offcanvas-body">
                                            <h4>Khách Lẻ</h4>
                                            <div className="input-group row">
                                        <span className="col-5">
                                            Tổng tiền hàng
                                        </span>
                                                <span className="col-2 text-end">
                                            0
                                        </span>
                                                <span className="col-5 text-end">
                                            0
                                        </span>
                                            </div>
                                            <div className="input-group row mt-2">
                                        <span className="col-5">
                                            Giảm giá
                                        </span>
                                                <span className="col-2 text-end">
                                        </span>
                                                <span className="col-5 text-end">
                                            <input type="number" className="form-control" placeholder="0"/>
                                        </span>
                                            </div>
                                            <div className="input-group row mt-2">
                                        <span className="col-5">
                                            Voucher
                                        </span>
                                                <span className="col-2 text-end">
                                        </span>
                                                <span className="col-5 text-end">
                                            <input type="text" className="form-control" placeholder="0"/>
                                        </span>
                                            </div>
                                            <div className="input-group row mt-2">
                                        <span className="col-5">
                                            Khách cần trả
                                        </span>
                                                <span className="col-2 text-end">
                                        </span>
                                                <span className="col-5 text-end">
                                            0
                                        </span>
                                            </div>
                                            <div className="input-group row mt-2">
                                        <span className="col-5">
                                            Tiền khách đưa
                                        </span>
                                                <span className="col-2 text-end">
                                        </span>
                                                <span className="col-5 text-end">
                                            <input type="number" className="form-control" placeholder="0"/>
                                        </span>
                                            </div>
                                            <div className="input-group row mt-3">
                                        <span className="col-4">
                                            <input type="radio" className="form-check-input" name="radio" id="radio1"
                                                   value="option1" checked/>
                                            <label htmlFor="radio1">Tiền mặt</label>
                                        </span>
                                                <span className="col-3">
                                            <input type="radio" className="form-check-input" name="radio" id="radio2"
                                                   value="option2"/>
                                            <label htmlFor="radio2">Thẻ</label>
                                        </span>
                                                <span className="col-5">
                                            <input type="radio" className="form-check-input" name="radio" id="radio3"
                                                   value="option3"/>
                                            <label htmlFor="radio3">Chuyển khoản</label>
                                        </span>
                                            </div>
                                        </div>
                                        <div className="offcanvas-footer px-3 pb-5">
                                            <button className="btn btn-primary w-100" type="button">Thanh toán</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </section>
            </div>
        </div>

    );
}
