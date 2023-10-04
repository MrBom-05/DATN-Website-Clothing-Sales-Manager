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

export default function KichCo() {
    const api = "http://localhost:8080/api/admin/kich-co";
    const [listKichCo, setListKichCo] = useState([]);
    const [kichCo, setKichCo] = useState({
        id: '',
        ten: ''
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
                    setListKichCo(data);
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

        if (!kichCo.ten) {
            newErrors.ten = 'Vui lòng nhập tên Loại';
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
        setKichCo({...kichCo, [name]: value});
    };

    const handleAddKichCo = () => {
        if (!validateForm()) {
            return;
        } else {
            let method = 'POST';
            if (kichCo.id) {
                method = 'PUT';
            }

            fetch(api + `${kichCo.id ? `/${kichCo.id}` : ''}`, {
                method: method,
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(kichCo),
            })
                .then(() => {
                    fetch(api)
                        .then((res) => res.json())
                        .then((data) => {
                            if (Array.isArray(data)) {
                                setListKichCo(data);
                                document.querySelector('#exampleModal .btn-close').click();
                                setKichCo({
                                    id: '',
                                    ten: ''
                                });
                                showSuccessMessage(`Đã ${kichCo.id ? 'cập nhật' : 'thêm'} thành công!`); // Hiển thị thông báo thành công
                            } else {
                                console.error('Data from API is not an array:', data);
                            }
                        })
                        .catch((error) => {
                            console.error(`Lỗi khi lấy danh sách sau khi ${kichCo.id ? 'cập nhật' : 'thêm'}:`, error);
                        });
                })
                .catch((error) => {
                    console.error(`Lỗi khi gửi yêu cầu ${method}:`, error);
                });
        }
    };

    const handleDeleteKichCo = (id) => {
        fetch(api + `/${id}`, {
            method: 'DELETE',
        })
            .then(() => {
                fetch(api)
                    .then((res) => res.json())
                    .then((data) => {
                        if (Array.isArray(data)) {
                            setListKichCo(data);
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
            <h1 className="text-center mt-3">Quản Lý Màu Sắc</h1>
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
                                    <TableCell className="text-center">Hành Động</TableCell>
                                </TableRow>
                            </TableHead>
                            <TableBody>
                                {listKichCo.slice(startIndex, endIndex).map((kichCo, index) => (
                                    <TableRow key={kichCo.id}>
                                        <TableCell>{index + 1}</TableCell>
                                        <TableCell>{kichCo.ten}</TableCell>
                                        <TableCell className="text-center">
                                            <button
                                                className="btn btn-danger"
                                                onClick={() => {
                                                    if (window.confirm('Bạn có chắc chắn muốn xoá ' + kichCo.ten + ' không?')) {
                                                        handleDeleteKichCo(kichCo.id);
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
                        <Grid item xs={3}></Grid>
                        <Grid item xs={6}>
                            <TextField
                                type="text"
                                name="ten"
                                required
                                value={kichCo.ten}
                                onChange={handleInputChange}
                                fullWidth
                                label="Tên Loại"
                                InputLabelProps={{
                                    shrink: true,
                                    style: {position: 'top'} // Hiển thị label phía trên
                                }}
                                error={!!errors.ten}
                                helperText={errors.ten}
                            />
                        </Grid>
                    </Grid>
                    <Button variant="contained" color="success" onClick={handleAddKichCo}
                            className="mt-3 text-center">
                        Save
                    </Button>
                </Grid>
            </Grid>
        </div>
    );
};
