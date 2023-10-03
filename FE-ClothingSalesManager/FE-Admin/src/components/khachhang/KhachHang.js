import React, { useState, useEffect } from 'react';
import {
    Grid,
    TextField,
    Button,
    Paper,
    Table,
    TableContainer,
    TableHead,
    TableRow,
    TableCell,
    TableBody,
    Select,
    MenuItem,
    Alert,
    AlertTitle,
} from '@mui/material';
import { Pagination, PaginationItem } from '@mui/lab';



const App = () => {
    const [listKhachHang, setListKhachHang] = useState([]);
    const [khachHang, setKhachHang] = useState({
        id: '',
        hoVaTen: '',
        soDienThoai: '',
        diaChi: '',
        xaPhuong: '',
        quanHuyen: '',
        tinhThanhPho: '',
        matKhau: '',
    });
    const [isUpdating, setIsUpdating] = useState(false);
    const [errors, setErrors] = useState({});
    const [isAlertOpen, setIsAlertOpen] = useState(false);
    const [alertMessage, setAlertMessage] = useState('');
    // Add pagination state
    const [currentPage, setCurrentPage] = useState(1);
    const itemsPerPage = 5;

    useEffect(() => {

        fetch('http://localhost:8080/api/admin/khach-hang')
            .then((res) => res.json())
            .then((data) => {
                if (Array.isArray(data)) {
                    setListKhachHang(data);
                } else {
                    console.error('Data from API is not an array:', data);
                }
            })
            .catch((err) => {
                console.error(err);
            });
    }, []);
    const validateForm = () => {
        const newErrors = {};
        if (!khachHang.hoVaTen) {
            newErrors.hoVaTen = 'Vui lòng nhập họ và tên';
        }
        if (!khachHang.soDienThoai) {
            newErrors.soDienThoai = 'Vui lòng nhập số điện thoại';
        }
        if (!khachHang.diaChi) {
            newErrors.diaChi = 'Vui lòng nhập địa chỉ';
        }
        if (!khachHang.xaPhuong) {
            newErrors.xaPhuong = 'Vui lòng nhập xã/phường';
        }
        if (!khachHang.quanHuyen) {
            newErrors.quanHuyen = 'Vui lòng nhập quận/huyện';
        }
        if (!khachHang.tinhThanhPho) {
            newErrors.tinhThanhPho = 'Vui lòng nhập thành phố/tỉnh';
        }
        setErrors(newErrors);
        return Object.keys(newErrors).length === 0;
    };

    const showAlert = (message) => {
        setAlertMessage(message);
        setIsAlertOpen(true);
    };
    const handleAddKhachHang = () => {
        if (!validateForm()) {
            showAlert('Vui lòng điền đầy đủ thông tin');
            return;
        } else {
            let method = 'POST';
            if (khachHang.id) {
                method = 'PUT';
            }

            fetch(`http://localhost:8080/api/admin/khach-hang${khachHang.id ? `/${khachHang.id}` : ''}`, {
                method: method,
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(khachHang),
            })
                .then(() => {
                    fetch('http://localhost:8080/api/admin/khach-hang')
                        .then((res) => res.json())
                        .then((data) => {
                            if (Array.isArray(data)) {
                                setListKhachHang(data);
                                document.querySelector('#exampleModal .btn-close').click();
                                setKhachHang({
                                    id: '',
                                    hoVaTen: '',
                                    soDienThoai: '',
                                    diaChi: '',
                                    xaPhuong: '',
                                    quanHuyen: '',
                                    tinhThanhPho: '',
                                    matKhau: '',
                                });
                            } else {
                                console.error('Data from API is not an array:', data);
                            }
                        })
                        .catch((error) => {
                            console.error(`Lỗi khi lấy danh sách Khách hàng sau khi ${khachHang.id ? 'cập nhật' : 'thêm'}:`, error);
                        });
                })
                .catch((error) => {
                    console.error(`Lỗi khi gửi yêu cầu ${method}:`, error);
                });
        }
    };

    const handleDeleteKhachHang = (id) => {
        fetch(`http://localhost:8080/api/admin/khach-hang/${id}`, {
            method: 'DELETE',
        })
            .then(() => {
                fetch('http://localhost:8080/api/admin/khach-hang')
                    .then((res) => res.json())
                    .then((data) => {
                        if (Array.isArray(data)) {
                            setListKhachHang(data);
                        } else {
                            console.error('Data from API is not an array:', data);
                        }
                    })
                    .catch((error) => {
                        console.error('Lỗi khi lấy danh sách nhân viên sau khi xoá:', error);
                    });
            })
            .catch((error) => {
                console.error('Lỗi khi gửi yêu cầu DELETE:', error);
            });
    };

    const handleUpdateKhahHang = (index) => {
        const selectedKhachHang = listKhachHang[index];

        setKhachHang({
            id: selectedKhachHang.id,
            ma: selectedKhachHang.ma,
            email: selectedKhachHang.email,
            hoVaTen: selectedKhachHang.hoVaTen,
            soDienThoai: selectedKhachHang.soDienThoai,
            diaChi: selectedKhachHang.diaChi,
            xaPhuong: selectedKhachHang.xaPhuong,
            quanHuyen: selectedKhachHang.quanHuyen,
            tinhThanhPho: selectedKhachHang.tinhThanhPho,
            matKhau: selectedKhachHang.matKhau,

        });

        const modal = document.getElementById('exampleModal');
        if (modal) {
            modal.style.display = 'block';
        }

        setIsUpdating(true);
    };

    const handleModalClose = () => {
        const modal = document.getElementById('exampleModal');
        if (modal) {
            document.querySelector('#exampleModal .btn-close').click();
            setKhachHang({
                id: '',
                email: '',
                hoVaTen: '',
                soDienThoai: '',
                diaChi: '',
                xaPhuong: '',
                quanHuyen: '',
                tinhThanhPho: '',
                matKhau: '',
            });

            setIsUpdating(false);
        }
    };
    // Create a function to handle page changes
    const handlePageChange = (event, value) => {
        setCurrentPage(value);
    };

    // Calculate startIndex and endIndex
    const startIndex = (currentPage - 1) * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;

    return (

        <div className='px-3'>
            <h1 className="text-center mt-3">Quản Lý Khách Hàng</h1>

            <div className="row mt-3">
                <div className="col-6">
                    <Button variant="contained" color="success" data-bs-toggle="modal" data-bs-target="#exampleModal">
                        Thêm Khách Hàng
                    </Button>

                </div>
            </div>

            <TableContainer component={Paper} className="text-center mt-2">
                <Table>
                    <TableHead>
                        <TableRow>
                            <TableCell>STT</TableCell>
                            <TableCell>Tên</TableCell>
                            <TableCell>Số Điện Thoại</TableCell>
                            <TableCell>Địa Chỉ</TableCell>
                            <TableCell>Xã/Phường</TableCell>
                            <TableCell>Quận/Huyện</TableCell>
                            <TableCell>Thành phố/Tỉnh</TableCell>
                            <TableCell >Hành động</TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {listKhachHang.slice(startIndex, endIndex).map((kh, index) => (
                            <TableRow key={kh.id}>
                                <TableCell>{index + 1}</TableCell>
                                <TableCell>{kh.hoVaTen}</TableCell>
                                <TableCell>{kh.soDienThoai}</TableCell>
                                <TableCell>{kh.diaChi}</TableCell>
                                <TableCell>{kh.xaPhuong}</TableCell>
                                <TableCell>{kh.quanHuyen}</TableCell>
                                <TableCell>{kh.tinhThanhPho}</TableCell>
                                <TableCell>
                                    <button
                                        className="btn btn-primary me-2"
                                        data-bs-toggle="modal"
                                        data-bs-target="#exampleModal"
                                        onClick={() => handleUpdateKhahHang(index)}
                                    >
                                        Update
                                    </button>
                                    <button
                                        className="btn btn-danger"
                                        onClick={() => {
                                            if (window.confirm('Bạn có chắc chắn muốn xoá Khách Hàng ' + kh.hoVaTen + ' không?')) {
                                                handleDeleteKhachHang(kh.id);
                                            }
                                        }}
                                    >
                                        Delete
                                    </button>
                                </TableCell>
                            </TableRow>
                        ))}
                    </TableBody>
                </Table>
            </TableContainer>

            <div className="modal fade" id="exampleModal" tabIndex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                {isAlertOpen && (
                    <Alert severity="error" onClose={() => setIsAlertOpen(false)}>
                        <AlertTitle>Error</AlertTitle>
                        {alertMessage}
                    </Alert>
                )}
                <div className="modal-dialog modal-lg">
                    <div className="modal-content">
                        <div className="modal-header">
                            <h1 className="modal-title fs-5 justify-content-center" id="exampleModalLabel">
                                {isUpdating ? 'Cập Nhật Khách Hàng' : 'Thêm Khách Hàng'}
                            </h1>
                            <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close" onClick={handleModalClose}></button>
                        </div>
                        <div className="modal-body">
                            <Grid container spacing={2}>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="hoVaTen"
                                        required
                                        label="Họ và tên"
                                        value={khachHang.hoVaTen}
                                        onChange={(e) => setKhachHang({ ...khachHang, hoVaTen: e.target.value })}
                                        fullWidth
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="soDienThoai"
                                        required
                                        label="Số điện thoại"
                                        value={khachHang.soDienThoai}
                                        onChange={(e) => setKhachHang({ ...khachHang, soDienThoai: e.target.value })}
                                        fullWidth
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="email"
                                        name="email"
                                        required
                                        label="Email"
                                        value={khachHang.email}
                                        onChange={(e) => setKhachHang({ ...khachHang, email: e.target.value })}
                                        fullWidth
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="diaChi"
                                        required
                                        label="Địa chỉ"
                                        value={khachHang.diaChi}
                                        onChange={(e) => setKhachHang({ ...khachHang, diaChi: e.target.value })}
                                        fullWidth
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="xaPhuong"
                                        label="Xã/Phường"
                                        value={khachHang.xaPhuong}
                                        onChange={(e) => setKhachHang({ ...khachHang, xaPhuong: e.target.value })}
                                        fullWidth
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="quanHuyen"
                                        label="Quận/Huyện"
                                        value={khachHang.quanHuyen}
                                        onChange={(e) => setKhachHang({ ...khachHang, quanHuyen: e.target.value })}
                                        fullWidth
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="tinhThanhPho"
                                        label="Thành phố/Tỉnh"
                                        required
                                        value={khachHang.tinhThanhPho}
                                        onChange={(e) => setKhachHang({ ...khachHang, tinhThanhPho: e.target.value })}
                                        fullWidth
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="password"
                                        name="matKhau"
                                        label="Mật khẩu"
                                        value={khachHang.matKhau}
                                        onChange={(e) => setKhachHang({ ...khachHang, matKhau: e.target.value })}
                                        fullWidth
                                        // Disable the input if in update mode
                                        disabled={isUpdating}
                                    />
                                </Grid>
                            </Grid>
                            <Button variant="contained" color="primary" onClick={handleAddKhachHang} className="mt-3 text-center">
                                Save
                            </Button>
                        </div>
                    </div>
                </div>
            </div>
            <Pagination
                count={Math.ceil(listKhachHang.length / itemsPerPage)}
                page={currentPage}
                onChange={handlePageChange}
                renderItem={(item) => (
                    <PaginationItem
                        {...item}
                        onClick={() => setCurrentPage(item.page)}
                        sx={{
                            backgroundColor: currentPage === item.page ? 'primary.main' : 'background.paper',
                            color: currentPage === item.page ? 'primary.contrastText' : 'text.secondary',
                        }}
                    />
                )}
                className="mt-3"
            />
        </div>
    );
};

export default App;
