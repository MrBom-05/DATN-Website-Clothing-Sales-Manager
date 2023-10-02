import './App.css';
import {Route, Routes} from "react-router-dom";
import Navbar from "./components/layouts/Navbar";
import BanHang from "./components/banhang/BanHang";
import HoaDon from "./components/hoadon/HoaDon";
import KhachHang from "./components/khachhang/KhachHang";
import KhuyenMai from "./components/khuyenmai/KhuyenMai";
import NhanVien from "./components/nhanvien/NhanVien";
import KichCo from "./components/sanpham/KichCo";
import Loai from "./components/sanpham/Loai";
import MauSac from "./components/sanpham/MauSac";
import SanPham from "./components/sanpham/SanPham";
import SanPhamChiTiet from "./components/sanpham/SanPhamChiTiet";
import ThongKe from "./components/thongke/ThongKe";
import Voucher from "./components/voucher/Voucher";

function App() {
    return (
        <div className="App">
            <Navbar/>
            <Routes>
                <Route path="/" element={<BanHang/>}/>
                <Route path="/hoa-don" element={<HoaDon/>}/>
                <Route path="/khach-hang" element={<KhachHang/>}/>
                <Route path="/khuyen-mai" element={<KhuyenMai/>}/>
                <Route path="/nhan-vien" element={<NhanVien/>}/>
                <Route path="/kich-co" element={<KichCo/>}/>
                <Route path="/loai" element={<Loai/>}/>
                <Route path="/mau-sac" element={<MauSac/>}/>
                <Route path="/san-pham" element={<SanPham/>}/>
                <Route path="/san-pham-chi-tiet" element={<SanPhamChiTiet/>}/>
                <Route path="/thong-ke" element={<ThongKe/>}/>
                <Route path="/voucher" element={<Voucher/>}/>
            </Routes>
        </div>
    );
}

export default App;
