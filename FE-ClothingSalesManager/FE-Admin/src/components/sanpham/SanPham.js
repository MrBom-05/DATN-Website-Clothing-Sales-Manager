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

export default function SanPham() {
    const api = "http://localhost:8080/api/admin/san-pham";
    const [listSanPham, setListSanPham] = useState([]);
    const [sanPham, setSanPham] = useState({
        id: '',
        ten: '',
        idLoai: ''
    });
    const [errors, setErrors] = useState({});
    const [successMessage, setSuccessMessage] = useState(''); // Thêm state mới cho thông báo thành công
    // Add pagination state
    const [currentPage, setCurrentPage] = useState(1);
    const itemsPerPage = 5;

    useEffect(() => {
        fetch(api)
            .then((res) => res.json())
            .then((data) => {
                if (Array.isArray(data)) {
                    setListSanPham(data);
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

        if (!sanPham.ten) {
            newErrors.ten = 'Vui lòng nhập tên Sản Phẩm';
        }

        if (!sanPham.idLoai) {
            newErrors.idLoai = 'Vui lòng chọn Loại';
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
        setSanPham({...sanPham, [name]: value});
    };

    const handleAddSanPham = () => {
        if (!validateForm()) {
            return;
        } else {
            let method = 'POST';
            if (sanPham.id) {
                method = 'PUT';
            }

            fetch(api + `${sanPham.id ? `/${sanPham.id}` : ''}`, {
                method: method,
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(sanPham),
            })
                .then(() => {
                    fetch(api)
                        .then((res) => res.json())
                        .then((data) => {
                            if (Array.isArray(data)) {
                                listSanPham(data);
                                document.querySelector('#exampleModal .btn-close').click();
                                setSanPham({
                                    id: '',
                                    ten: '',
                                    idLoai: ''
                                });
                                showSuccessMessage(`Đã ${sanPham.id ? 'cập nhật' : 'thêm'} thành công!`); // Hiển thị thông báo thành công
                            } else {
                                console.error('Data from API is not an array:', data);
                            }
                        })
                        .catch((error) => {
                            console.error(`Lỗi khi lấy danh sách sau khi ${sanPham.id ? 'cập nhật' : 'thêm'}:`, error);
                        });
                })
                .catch((error) => {
                    console.error(`Lỗi khi gửi yêu cầu ${method}:`, error);
                });
        }
    };

    const handleDeleteSanPham = (id) => {
        fetch(api + `/${id}`, {
            method: 'DELETE',
        })
            .then(() => {
                fetch(api)
                    .then((res) => res.json())
                    .then((data) => {
                        if (Array.isArray(data)) {
                            setListSanPham(data);
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

    // Calculate startIndex and endIndex
    const startIndex = (currentPage - 1) * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;

    return (
        <div className='px-3'>
            <h1 className="text-center mt-3">Quản Lý Sản Phẩm</h1>
            <Grid container spacing={2} className="mt-3">
                <Grid item xs={8}>
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
                                    <TableCell>Tên</TableCell>
                                    <TableCell>Ngày Tạo</TableCell>
                                    <TableCell>Loại</TableCell>
                                    <TableCell className="text-center">Hành Động</TableCell>
                                </TableRow>
                            </TableHead>
                            <TableBody>
                                {listSanPham.slice(startIndex, endIndex).map((sanPham, index) => (
                                    <TableRow key={sanPham.id}>
                                        <TableCell>{index + 1}</TableCell>
                                        <TableCell>{sanPham.ten}</TableCell>
                                        <TableCell>{sanPham.ngayTao}</TableCell>
                                        <TableCell>{sanPham.tenLoai}</TableCell>
                                        <TableCell className="text-center">
                                            <button
                                                className="btn btn-danger"
                                                onClick={() => {
                                                    if (window.confirm('Bạn có chắc chắn muốn xoá ' + sanPham.ten + ' không?')) {
                                                        handleDeleteSanPham(sanPham.id);
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
                </Grid>
                <Grid item xs={4} className="text-center">
                    <h4>Thêm Mới</h4>
                    <Grid container spacing={2} className="mt-2">
                        <Grid item xs={6}>
                            <TextField
                                type="text"
                                name="ten"
                                required
                                value={sanPham.ten}
                                onChange={handleInputChange}
                                fullWidth
                                label="Tên Màu Sắc"
                                InputLabelProps={{
                                    shrink: true,
                                    style: {position: 'top'} // Hiển thị label phía trên
                                }}
                                error={!!errors.ten}
                                helperText={errors.ten}
                            />
                        </Grid>
                        <Grid item xs={6}>
                            <TextField
                                type="text"
                                name="maMauSac"
                                required
                                value={sanPham.idLoai}
                                onChange={handleInputChange}
                                fullWidth
                                label="Mã Màu Sắc"
                                InputLabelProps={{
                                    shrink: true,
                                    style: {position: 'top'} // Hiển thị label phía trên
                                }}
                                error={!!errors.maMauSac}
                                helperText={errors.maMauSac}
                            />
                        </Grid>
                    </Grid>
                    <Button variant="contained" color="success" onClick={handleAddSanPham}
                            className="mt-3 text-center">
                        Save
                    </Button>
                </Grid>
            </Grid>
        </div>
    );
};
