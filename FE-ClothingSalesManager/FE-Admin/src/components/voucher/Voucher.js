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

export default function Voucher() {
    const [listGiamGia, setListGiamGia] = useState([]);
    const [giamGia, setGiamGia] = useState({
        id: '',
        ma: '',
        soPhanTramGiam: '',
        soLuong: '',
        ngayBatDau: '',
        ngayKetThuc: '',
    });
    const [isUpdating, setIsUpdating] = useState(false);
    const [errors, setErrors] = useState({});
    const [successMessage, setSuccessMessage] = useState(''); // Thêm state mới cho thông báo thành công
    // Add pagination state
    const [currentPage, setCurrentPage] = useState(1);
    const itemsPerPage = 5;

    useEffect(() => {
        fetch('http://localhost:8080/api/admin/giam-gia')
            .then((res) => res.json())
            .then((data) => {
                if (Array.isArray(data)) {
                    setListGiamGia(data);
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

        if (!giamGia.ma) {
            newErrors.ma = 'Vui lòng nhập mã Voucher';
        }
        if (!giamGia.soPhanTramGiam) {
            newErrors.soPhanTramGiam = 'Vui lòng nhập số phần trăm giảm';
        }
        if (!giamGia.soLuong) {
            newErrors.soLuong = 'Vui lòng nhập số lượng';
        }
        if (!giamGia.ngayBatDau) {
            newErrors.ngayBatDau = 'Vui lòng nhập ngày bắt đầu';
        } else {
            const today = new Date();
            const startDate = new Date(giamGia.ngayBatDau);
            // So sánh ngày và tháng của ngày bắt đầu và ngày hiện tại
            if (startDate.getUTCDate() !== today.getUTCDate() || startDate.getUTCMonth() !== today.getUTCMonth()) {
                newErrors.ngayBatDau = 'Ngày bắt đầu phải là ngày hiện tại hoặc sau ngày hiện tại';
            }
        }
        if (!giamGia.ngayKetThuc) {
            newErrors.ngayKetThuc = 'Vui lòng nhập ngày kết thúc';
        } else if (giamGia.ngayKetThuc <= giamGia.ngayBatDau) {
            newErrors.ngayKetThuc = 'Ngày kết thúc phải sau ngày bắt đầu';
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
        setGiamGia({...giamGia, [name]: value});
    };

    const handleAddGiamGia = () => {
        if (!validateForm()) {

            return;
        } else {
            let method = 'POST';
            if (giamGia.id) {
                method = 'PUT';
            }

            fetch(`http://localhost:8080/api/admin/giam-gia${giamGia.id ? `/${giamGia.id}` : ''}`, {
                method: method,
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(giamGia),
            })
                .then(() => {
                    fetch('http://localhost:8080/api/admin/giam-gia')
                        .then((res) => res.json())
                        .then((data) => {
                            if (Array.isArray(data)) {
                                setListGiamGia(data);
                                document.querySelector('#exampleModal .btn-close').click();
                                setGiamGia({
                                    id: '',
                                    ma: '',
                                    soPhanTramGiam: '',
                                    soLuong: '',
                                    ngayBatDau: '',
                                    ngayKetThuc: '',
                                });
                                showSuccessMessage(`Đã ${giamGia.id ? 'cập nhật' : 'thêm'} thành công!`); // Hiển thị thông báo thành công
                            } else {
                                console.error('Data from API is not an array:', data);
                            }
                        })
                        .catch((error) => {
                            console.error(`Lỗi khi lấy danh sách Voucher sau khi ${giamGia.id ? 'cập nhật' : 'thêm'}:`, error);
                        });
                })
                .catch((error) => {
                    console.error(`Lỗi khi gửi yêu cầu ${method}:`, error);
                });
        }
    };

    const handleDeleteGiamGia = (id) => {
        fetch(`http://localhost:8080/api/admin/giam-gia/${id}`, {
            method: 'DELETE',
        })
            .then(() => {
                fetch('http://localhost:8080/api/admin/giam-gia')
                    .then((res) => res.json())
                    .then((data) => {
                        if (Array.isArray(data)) {
                            setListGiamGia(data);
                            showSuccessMessage('Xoá thành công!'); // Hiển thị thông báo thành công
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

    const handleUpdateGiamGia = (index) => {
        const selectedGiamGia = listGiamGia[index];

        setGiamGia({
            id: selectedGiamGia.id,
            ma: selectedGiamGia.ma,
            soPhanTramGiam: selectedGiamGia.soPhanTramGiam,
            soLuong: selectedGiamGia.soLuong,
            ngayBatDau: selectedGiamGia.ngayBatDau,
            ngayKetThuc: selectedGiamGia.ngayKetThuc,
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
            setGiamGia({
                id: '',
                ma: '',
                soPhanTramGiam: '',
                soLuong: '',
                ngayBatDau: '',
                ngayKetThuc: '',
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
            <h1 className="text-center mt-3">Quản Lý Voucher</h1>
            <div className="row mt-3">
                <div className="col-6">
                    <Button variant="contained" color="success" data-bs-toggle="modal" data-bs-target="#exampleModal">
                        Thêm Voucher
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
                            <TableCell>Mã Voucher</TableCell>
                            <TableCell>Số Phần Trăm Giảm</TableCell>
                            <TableCell>Số Lượng</TableCell>
                            <TableCell>Ngày Bắt Đầu</TableCell>
                            <TableCell>Ngày Kết Thúc</TableCell>
                            <TableCell className="text-center">Hành Động</TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {listGiamGia.slice(startIndex, endIndex).map((giamGia, index) => (
                            <TableRow key={giamGia.id}>
                                <TableCell>{index + 1}</TableCell>
                                <TableCell>{giamGia.ma}</TableCell>
                                <TableCell>{giamGia.soPhanTramGiam}</TableCell>
                                <TableCell>{giamGia.soLuong}</TableCell>
                                <TableCell>{giamGia.ngayBatDau}</TableCell>
                                <TableCell>{giamGia.ngayKetThuc}</TableCell>
                                <TableCell className="text-center">
                                    <button
                                        className="btn btn-primary"
                                        data-bs-toggle="modal"
                                        data-bs-target="#exampleModal"
                                        onClick={() => handleUpdateGiamGia(index)}
                                    >
                                        Update
                                    </button>
                                    <button
                                        className="btn btn-danger ms-2"
                                        onClick={() => {
                                            if (window.confirm('Bạn có chắc chắn muốn xoá Mã  ' + giamGia.ma + ' không?')) {
                                                handleDeleteGiamGia(giamGia.id);
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
                                {isUpdating ? 'Cập Nhật Voucher' : 'Thêm Voucher'}
                            </h1>
                            <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close"
                                    onClick={handleModalClose}></button>
                        </div>
                        <div className="modal-body text-center">
                            <Grid container spacing={3}>
                                <Grid item xs={7}>
                                    <TextField
                                        type="number"
                                        name="ma"
                                        required
                                        value={giamGia.ma}
                                        onChange={handleInputChange}
                                        fullWidth
                                        label="Mã Voucher"
                                        InputLabelProps={{
                                            shrink: true,
                                            style: {position: 'top'} // Hiển thị label phía trên
                                        }}
                                        error={!!errors.ma}
                                        helperText={errors.ma}
                                    />
                                </Grid>
                                <Grid item xs={4}>
                                    <TextField
                                        type="number"
                                        name="soPhanTramGiam"
                                        required
                                        value={giamGia.soPhanTramGiam}
                                        onChange={handleInputChange}
                                        label="Số Phần Trăm Giảm"
                                        InputLabelProps={{
                                            shrink: true,
                                            style: {position: 'top'} // Hiển thị label phía trên
                                        }}
                                        error={!!errors.soPhanTramGiam}
                                        helperText={errors.soPhanTramGiam}
                                    />
                                </Grid>
                                <Grid item xs={3}>
                                    <TextField
                                        type="number"
                                        name="soLuong"
                                        required
                                        value={giamGia.soLuong}
                                        onChange={handleInputChange}
                                        label="Số Lượng"
                                        InputLabelProps={{
                                            shrink: true,
                                            style: {position: 'top'} // Hiển thị label phía trên
                                        }}
                                        error={!!errors.soLuong}
                                        helperText={errors.soLuong}
                                    />
                                </Grid>
                                <Grid item xs={3}>
                                    <TextField
                                        type="date"
                                        name="ngayBatDau"
                                        required
                                        value={giamGia.ngayBatDau}
                                        onChange={handleInputChange}
                                        label="Ngày Bắt Đầu"
                                        InputLabelProps={{
                                            shrink: true,
                                            style: {position: 'top'} // Hiển thị label phía trên
                                        }}
                                        error={!!errors.ngayBatDau}
                                        helperText={errors.ngayBatDau}
                                    />
                                </Grid>
                                <Grid item xs={3}>
                                    <TextField
                                        type="date"
                                        name="ngayKetThuc"
                                        required
                                        value={giamGia.ngayKetThuc}
                                        onChange={handleInputChange}
                                        label="Ngày Kết Thúc"
                                        InputLabelProps={{
                                            shrink: true,
                                            style: {position: 'top'} // Hiển thị label phía trên
                                        }}
                                        error={!!errors.ngayKetThuc}
                                        helperText={errors.ngayKetThuc}
                                    />
                                </Grid>
                            </Grid>
                            <Button variant="contained" color="success" onClick={handleAddGiamGia}
                                    className="mt-3 text-center">
                                Save
                            </Button>
                        </div>
                    </div>
                </div>
            </div>
            <Pagination
                count={Math.ceil(listGiamGia.length / itemsPerPage)}
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
