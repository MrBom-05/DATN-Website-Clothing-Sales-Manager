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
    Alert,
    AlertTitle,
} from '@mui/material';
import { Pagination, PaginationItem } from '@mui/lab';


export default function NhanVien() {
    const [listNhanVien, setlistNhanVien] = useState([]);
    const [nhanVien, setnhanVien] = useState({
        id: '',
        ma: '',
        email: '',
        hoVaTen: '',
        soDienThoai: '',
        diaChi: '',
        xaPhuong: '',
        quanHuyen: '',
        tinhThanhPho: '',
        chucVu: '0',
        trangThai: '0',
        matKhau: '',
    });
    const [isUpdating, setIsUpdating] = useState(false);
    const [isAdd, setIsAdd] = useState(false);
    const [filter, setFilter] = useState('');
    const [currentPage, setCurrentPage] = useState(1);
    const [successMessage, setSuccessMessage] = useState('');
    const [errors, setErrors] = useState({});
    const [isAlertOpen, setIsAlertOpen] = useState(false);
    const [alertMessage, setAlertMessage] = useState('');

    useEffect(() => {

        fetch('http://localhost:8080/api/admin/nhan-vien')
            .then((res) => res.json())
            .then((data) => {
                if (Array.isArray(data)) {
                    setlistNhanVien(data);
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
        if (!nhanVien.ma.trim()) {
            newErrors.ma = 'Mã nhân viên là bắt buộc';
        }
        if (!nhanVien.hoVaTen.trim()) {
            newErrors.hoVaTen = 'Họ và tên là bắt buộc';
        }
        if (!nhanVien.soDienThoai.trim()) {
            newErrors.soDienThoai = 'Số điện thoại là bắt buộc';
        }
        if (!nhanVien.email.trim()) {
            newErrors.email = 'Email là bắt buộc';
        }
        if (!nhanVien.diaChi.trim()) {
            newErrors.diaChi = 'Địa chỉ là bắt buộc';
        }
        if (!nhanVien.xaPhuong.trim()) {
            newErrors.xaPhuong = 'Xã/Phường là bắt buộc';
        }
        if (!nhanVien.quanHuyen.trim()) {
            newErrors.quanHuyen = 'Quận/Huyện là bắt buộc';
        }
        if (!nhanVien.tinhThanhPho.trim()) {
            newErrors.tinhThanhPho = 'Thành phố/Tỉnh là bắt buộc';
        }
        setErrors(newErrors);

        // Kiểm tra xem có lỗi nào không
        const hasErrors = Object.keys(newErrors).length > 0;

        // Trả về true nếu không có lỗi và ngược lại
        return !hasErrors;
    };

    const showSuccessMessage = (message) => {
        setSuccessMessage(message);
    };
    const handleAddnhanVien = () => {
        if (!validateForm()) {
            return;
        } else {
            let method = 'POST';
            if (nhanVien.id) {
                method = 'PUT';
                // Không cho phép thay đổi mật khẩu khi cập nhật
                delete nhanVien.matKhau;
            } else {
                // Thiết lập giá trị mặc định cho trường trangThai
                nhanVien.trangThai = '0'; // Đang làm
            }

            fetch(`http://localhost:8080/api/admin/nhan-vien${nhanVien.id ? `/${nhanVien.id}` : ''}`, {
                method: method,
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(nhanVien),
            })
                .then(() => {
                    fetch('http://localhost:8080/api/admin/nhan-vien')
                        .then((res) => res.json())
                        .then((data) => {
                            if (Array.isArray(data)) {
                                setlistNhanVien(data);
                                document.querySelector('#exampleModal .btn-close').click();
                                setnhanVien({
                                    id: '',
                                    ma: '',
                                    email: '',
                                    hoVaTen: '',
                                    soDienThoai: '',
                                    diaChi: '',
                                    xaPhuong: '',
                                    quanHuyen: '',
                                    tinhThanhPho: '',
                                    chucVu: '0',
                                    trangThai: '1',
                                    matKhau: '',
                                });
                                showSuccessMessage(`Đã ${nhanVien.id ? 'cập nhật' : 'thêm'} thành công!`);
                            } else {
                                console.error('Data from API is not an array:', data);
                            }
                        })
                        .catch((error) => {
                            console.error(`Lỗi khi lấy danh sách nhân viên sau khi ${nhanVien.id ? 'cập nhật' : 'thêm'}:`, error);
                        });
                })
                .catch((error) => {
                    console.error(`Lỗi khi gửi yêu cầu ${method}:`, error);
                });
        }
    };

    const handleDeletenhanVien = (id) => {
        fetch(`http://localhost:8080/api/admin/nhan-vien/${id}`, {
            method: 'DELETE',
        })
            .then(() => {
                fetch('http://localhost:8080/api/admin/nhan-vien')
                    .then((res) => res.json())
                    .then((data) => {
                        if (Array.isArray(data)) {
                            setlistNhanVien(data);
                            showSuccessMessage('Đã xoá thành công!');
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

    const handleUpdatenhanVien = (index) => {
        const selectednhanVien = listNhanVien[index];

        setnhanVien({
            id: selectednhanVien.id,
            ma: selectednhanVien.ma,
            email: selectednhanVien.email,
            hoVaTen: selectednhanVien.hoVaTen,
            soDienThoai: selectednhanVien.soDienThoai,
            diaChi: selectednhanVien.diaChi,
            xaPhuong: selectednhanVien.xaPhuong,
            quanHuyen: selectednhanVien.quanHuyen,
            tinhThanhPho: selectednhanVien.tinhThanhPho,
            chucVu: selectednhanVien.chucVu,
            trangThai: selectednhanVien.trangThai,
            matKhau: selectednhanVien.matKhau,
        });

        const modal = document.getElementById('exampleModal');
        if (modal) {
            modal.style.display = 'block';
        }

        setIsUpdating(true);
        setIsAdd(false);
    };

    const handleModalClose = () => {
        const modal = document.getElementById('exampleModal');
        if (modal) {
            document.querySelector('#exampleModal .btn-close').click();
            setnhanVien({
                id: '',
                ma: '',
                email: '',
                hoVaTen: '',
                soDienThoai: '',
                diaChi: '',
                xaPhuong: '',
                quanHuyen: '',
                tinhThanhPho: '',
                chucVu: '0',
                trangThai: '1',
                matKhau: '',
            });

            setIsUpdating(false);
            setErrors({});
        }
    };

    const handlePageChange = (event, value) => {
        setCurrentPage(value);
    };

    const itemsPerPage = 5;
    const startIndex = (currentPage - 1) * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;
    const filteredData = listNhanVien
        .filter((emp) => filter === '' || emp.trangThai == filter)
        .slice(startIndex, endIndex);

    return (

        <div className='px-3'>
            <h1 className="text-center mt-3">Quản Lý Nhân Viên</h1>

            <div className="row mt-3">
                <div className="col-6">
                    <Button variant="contained" color="success" data-bs-toggle="modal" data-bs-target="#exampleModal"
                    onClick={() => {
                        setIsUpdating(false);
                        setIsAdd(true);
                    }}
                    >
                        Thêm Nhân Viên
                    </Button>

                </div>
                <div style={{ display: 'flex', alignItems: 'center' }} className='col-2 offset-4'>
                    <i className="fas fa-filter"></i>
                    <Select
                        native
                        value={filter}
                        onChange={(e) => setFilter(e.target.value)}
                        inputProps={{
                            name: 'filter',
                            id: 'filter',
                        }}
                        style={{ width: '100%', height: '30px', padding: '4px', marginLeft: '10px' }}
                    >
                        <option value="">Tất cả</option>
                        <option value="0">Đang làm</option>
                        <option value="1">Đã nghỉ</option>
                    </Select>
                </div>
            </div>

            <TableContainer component={Paper} className="text-center mt-2">
                {successMessage && (
                    <Alert severity="success" onClose={() => setSuccessMessage('')}>
                        <AlertTitle>Success</AlertTitle>
                        {successMessage}
                    </Alert>
                )}
                <Table>
                    <TableHead>
                        <TableRow>
                            <TableCell>STT</TableCell>
                            <TableCell>Mã</TableCell>
                            <TableCell>Tên</TableCell>
                            <TableCell>Số Điện Thoại</TableCell>
                            <TableCell>Địa Chỉ</TableCell>
                            <TableCell>Xã/Phường</TableCell>
                            <TableCell>Quận/Huyện</TableCell>
                            <TableCell>Thành phố/Tỉnh</TableCell>
                            <TableCell>Chức vụ</TableCell>
                            <TableCell>Trạng thái</TableCell>
                            <TableCell className="text-center">Hành động</TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {filteredData.map((emp, index) => (
                            <TableRow key={emp.id}>
                                <TableCell>{index + 1 + startIndex}</TableCell>
                                <TableCell>{emp.ma}</TableCell>
                                <TableCell>{emp.hoVaTen}</TableCell>
                                <TableCell>{emp.soDienThoai}</TableCell>
                                <TableCell>{emp.diaChi}</TableCell>
                                <TableCell>{emp.xaPhuong}</TableCell>
                                <TableCell>{emp.quanHuyen}</TableCell>
                                <TableCell>{emp.tinhThanhPho}</TableCell>
                                <TableCell>{emp.chucVu == '1' ? 'Nhân Viên' : 'Quản lý'}</TableCell>
                                <TableCell>{emp.trangThai == '1' ? 'Đã nghỉ' : 'Đang làm'}</TableCell>
                                <TableCell>
                                    <button
                                        className="btn btn-primary"
                                        data-bs-toggle="modal"
                                        data-bs-target="#exampleModal"
                                        onClick={() => handleUpdatenhanVien(index)}
                                    >
                                        Update
                                    </button>
                                    <button
                                        className="btn btn-danger ms-2"
                                        onClick={() => {
                                            if (window.confirm('Bạn có chắc chắn muốn xoá nhân viên ' + emp.hoVaTen + ' không?')) {
                                                handleDeletenhanVien(emp.id);
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

            <div className="modal fade" id="exampleModal" tabIndex="-1" aria-labelledby="exampleModalLabel"
                aria-hidden="true">
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
                                {isUpdating ? 'Cập Nhật Nhân Viên' : 'Thêm Nhân Viên'}
                            </h1>
                            <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close"
                                onClick={handleModalClose}></button>
                        </div>
                        <div className="modal-body text-center">
                            <Grid container spacing={2}>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="ma"
                                        label="Mã"
                                        required
                                        value={nhanVien.ma}
                                        onChange={(e) => setnhanVien({ ...nhanVien, ma: e.target.value })}
                                        fullWidth
                                        error={!!errors.ma}
                                        helperText={errors.ma}
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="hoVaTen"
                                        required
                                        label="Họ và tên"
                                        value={nhanVien.hoVaTen}
                                        onChange={(e) => setnhanVien({ ...nhanVien, hoVaTen: e.target.value })}
                                        fullWidth
                                        error={!!errors.hoVaTen}
                                        helperText={errors.hoVaTen}
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="soDienThoai"
                                        required
                                        label="Số điện thoại"
                                        value={nhanVien.soDienThoai}
                                        onChange={(e) => setnhanVien({ ...nhanVien, soDienThoai: e.target.value })}
                                        fullWidth
                                        error={!!errors.soDienThoai}
                                        helperText={errors.soDienThoai}
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="email"
                                        name="email"
                                        required
                                        label="Email"
                                        value={nhanVien.email}
                                        onChange={(e) => setnhanVien({ ...nhanVien, email: e.target.value })}
                                        fullWidth
                                        error={!!errors.email}
                                        helperText={errors.email}

                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="diaChi"
                                        required
                                        label="Địa chỉ"
                                        value={nhanVien.diaChi}
                                        onChange={(e) => setnhanVien({ ...nhanVien, diaChi: e.target.value })}
                                        fullWidth
                                        error={!!errors.diaChi}
                                        helperText={errors.diaChi}
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="xaPhuong"
                                        label="Xã/Phường"
                                        value={nhanVien.xaPhuong}
                                        onChange={(e) => setnhanVien({ ...nhanVien, xaPhuong: e.target.value })}
                                        fullWidth
                                        error={!!errors.xaPhuong}
                                        helperText={errors.xaPhuong}
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="quanHuyen"
                                        label="Quận/Huyện"
                                        value={nhanVien.quanHuyen}
                                        onChange={(e) => setnhanVien({ ...nhanVien, quanHuyen: e.target.value })}
                                        fullWidth
                                        error={!!errors.quanHuyen}
                                        helperText={errors.quanHuyen}
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="tinhThanhPho"
                                        label="Thành phố/Tỉnh"
                                        required
                                        value={nhanVien.tinhThanhPho}
                                        onChange={(e) => setnhanVien({ ...nhanVien, tinhThanhPho: e.target.value })}
                                        fullWidth
                                        error={!!errors.tinhThanhPho}
                                        helperText={errors.tinhThanhPho}
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <Select
                                        native
                                        value={nhanVien.chucVu}
                                        onChange={(e) => setnhanVien({ ...nhanVien, chucVu: e.target.value })}
                                        inputProps={{
                                            name: 'chucVu',
                                            id: 'chucVu',
                                        }}
                                        fullWidth
                                    >
                                        <option value="0">Quản lý</option>
                                        <option value="1">Nhân viên</option>
                                    </Select>
                                </Grid>

                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="password"
                                        name="matKhau"
                                        label="Mật khẩu"
                                        value={nhanVien.matKhau}
                                        onChange={(e) => {
                                            // Kiểm tra nếu đang cập nhật thì không cho phép thay đổi mật khẩu
                                            if (!isUpdating) {
                                                setnhanVien({ ...nhanVien, matKhau: e.target.value });
                                            }
                                        }}
                                        fullWidth
                                        disabled={isUpdating} // Vô hiệu hóa input khi isUpdating là true
                                    />
                                </Grid>

                                <Grid item xs={12} sm={6}>
                                    <Select
                                        native
                                        value={nhanVien.trangThai}
                                        onChange={(e) => setnhanVien({ ...nhanVien, trangThai: e.target.value })}
                                        inputProps={{
                                            name: 'trangThai',
                                            id: 'trangThai',
                                        }}
                                        fullWidth
                                    >
                                        {isAdd ? (
                                            <>
                                                <option value="0">Đang làm</option>
                                            </>
                                        ) : (
                                            <>
                                                <option value="0">Đang làm</option>
                                                <option value="1">Đã nghỉ</option>
                                            </>
                                        )}
                                    </Select>
                                </Grid>


                            </Grid>
                            <Button variant="contained" color="success" onClick={handleAddnhanVien}
                                className="mt-3 text-center">
                                Save
                            </Button>
                        </div>
                    </div>
                </div>
            </div>

            <Pagination
                count={Math.ceil(listNhanVien.length / itemsPerPage)}
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