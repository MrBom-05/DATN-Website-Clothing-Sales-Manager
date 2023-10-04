import React, {useState, useEffect} from 'react';
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
    Alert,
    AlertTitle,
} from '@mui/material';
import {Pagination, PaginationItem} from '@mui/lab';

export default function KhachHang() {
    const [listKhachHang, setListKhachHang] = useState([]);
    const [khachHang, setKhachHang] = useState({
        id: '',
        hoVaTen: '',
        email: '',
        soDienThoai: '',
        diaChi: '',
        xaPhuong: '',
        quanHuyen: '',
        tinhThanhPho: '',
    });
    const [isUpdating, setIsUpdating] = useState(false);
    const [errors, setErrors] = useState({});
    const [successMessage, setSuccessMessage] = useState(''); // Thêm state mới cho thông báo thành công
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
            newErrors.hoVaTen = 'Họ và tên không được để trống';
        }
        if (!khachHang.email) {
            newErrors.email = 'Email không được để trống';
        }
        if (!khachHang.soDienThoai) {
            newErrors.soDienThoai = 'Số điện thoại không được để trống';
        }
        if (!khachHang.diaChi) {
            newErrors.diaChi = 'Địa chỉ không được để trống';
        }
        if (!khachHang.xaPhuong) {
            newErrors.xaPhuong = 'Xã phường không được để trống';
        }
        if (!khachHang.quanHuyen) {
            newErrors.quanHuyen = 'Quận huyện không được để trống';
        }
        if (!khachHang.tinhThanhPho) {
            newErrors.tinhThanhPho = 'Tỉnh thành phố không được để trống';
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

    const handleInputChange = (e) => {
        const {name, value} = e.target;
        setKhachHang({...khachHang, [name]: value});
    };

    const handleAddKhachHang = () => {
        if (!validateForm()) {
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
                                    email: '',
                                    soDienThoai: '',
                                    diaChi: '',
                                    xaPhuong: '',
                                    quanHuyen: '',
                                    tinhThanhPho: '',
                                });
                                showSuccessMessage(`Đã ${khachHang.id ? 'cập nhật' : 'thêm'} thành công!`); // Hiển thị thông báo thành công
                            } else {
                                console.error('Data from API is not an array:', data);
                            }
                        })
                        .catch((error) => {
                            console.error(`Lỗi khi lấy danh sách sau khi ${khachHang.id ? 'cập nhật' : 'thêm'}:`, error);
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
                            showSuccessMessage('Xoá thành công!'); // Hiển thị thông báo thành công
                        } else {
                            console.error('Data from API is not an array:', data);
                        }
                    })
                    .catch((error) => {
                        console.error('Lỗi khi lấy danh sách sau khi xoá:', error);
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
                hoVaTen: '',
                email: '',
                soDienThoai: '',
                diaChi: '',
                xaPhuong: '',
                quanHuyen: '',
                tinhThanhPho: '',
            });

            setIsUpdating(false);
            setErrors({});
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
                            <TableCell>Họ Và Tên</TableCell>
                            <TableCell>Email</TableCell>
                            <TableCell>Số Điện Thoại</TableCell>
                            <TableCell>Địa Chỉ</TableCell>
                            <TableCell>Xã Phường</TableCell>
                            <TableCell>Quận Huyện</TableCell>
                            <TableCell>Tỉnh Thành Phố</TableCell>
                            <TableCell className="text-center">Hành động</TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {listKhachHang.slice(startIndex, endIndex).map((khachHang, index) => (
                            <TableRow key={khachHang.id}>
                                <TableCell>{index + 1}</TableCell>
                                <TableCell>{khachHang.hoVaTen}</TableCell>
                                <TableCell>{khachHang.email}</TableCell>
                                <TableCell>{khachHang.soDienThoai}</TableCell>
                                <TableCell>{khachHang.diaChi}</TableCell>
                                <TableCell>{khachHang.xaPhuong}</TableCell>
                                <TableCell>{khachHang.quanHuyen}</TableCell>
                                <TableCell>{khachHang.tinhThanhPho}</TableCell>
                                <TableCell className="text-center">
                                    <button
                                        className="btn btn-primary"
                                        data-bs-toggle="modal"
                                        data-bs-target="#exampleModal"
                                        onClick={() => handleUpdateKhahHang(index)}
                                    >
                                        Update
                                    </button>
                                    <button
                                        className="btn btn-danger ms-2"
                                        onClick={() => {
                                            if (window.confirm('Bạn có chắc chắn muốn xoá ' + khachHang.hoVaTen + ' không?')) {
                                                handleDeleteKhachHang(khachHang.id);
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
                <div className="modal-dialog modal-lg">
                    <div className="modal-content">
                        <div className="modal-header">
                            <h1 className="modal-title fs-5 justify-content-center" id="exampleModalLabel">
                                {isUpdating ? 'Cập Nhật Khách Hàng' : 'Thêm Khách Hàng'}
                            </h1>
                            <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close"
                                    onClick={handleModalClose}></button>
                        </div>
                        <div className="modal-body text-center">
                            <Grid container spacing={2}>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="hoVaTen"
                                        required
                                        label="Họ và tên"
                                        value={khachHang.hoVaTen}
                                        onChange={handleInputChange}
                                        fullWidth
                                        error={!!errors.hoVaTen}
                                        helperText={errors.hoVaTen}
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="email"
                                        name="email"
                                        required
                                        label="Email"
                                        value={khachHang.email}
                                        onChange={handleInputChange}
                                        fullWidth
                                        error={!!errors.email}
                                        helperText={errors.email}
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="soDienThoai"
                                        required
                                        label="Số điện thoại"
                                        value={khachHang.soDienThoai}
                                        onChange={handleInputChange}
                                        fullWidth
                                        error={!!errors.soDienThoai}
                                        helperText={errors.soDienThoai}
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="diaChi"
                                        required
                                        label="Địa chỉ"
                                        value={khachHang.diaChi}
                                        onChange={handleInputChange}
                                        fullWidth
                                        error={!!errors.diaChi}
                                        helperText={errors.diaChi}
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="xaPhuong"
                                        required
                                        label="Xã phường"
                                        value={khachHang.xaPhuong}
                                        onChange={handleInputChange}
                                        fullWidth
                                        error={!!errors.xaPhuong}
                                        helperText={errors.xaPhuong}
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="quanHuyen"
                                        required
                                        label="Quận huyện"
                                        value={khachHang.quanHuyen}
                                        onChange={handleInputChange}
                                        fullWidth
                                        error={!!errors.quanHuyen}
                                        helperText={errors.quanHuyen}
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="tinhThanhPho"
                                        required
                                        label="Tỉnh thành phố"
                                        value={khachHang.tinhThanhPho}
                                        onChange={handleInputChange}
                                        fullWidth
                                        error={!!errors.tinhThanhPho}
                                        helperText={errors.tinhThanhPho}
                                    />
                                </Grid>

                            </Grid>
                            <Button variant="contained" color="success" onClick={handleAddKhachHang}
                                    className="mt-3 text-center">
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