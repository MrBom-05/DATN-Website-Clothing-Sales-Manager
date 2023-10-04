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
    Select,
    Alert,
    AlertTitle,
} from '@mui/material';
import {Pagination, PaginationItem} from '@mui/lab';


export default function NhanVien() {
    const [employeeList, setEmployeeList] = useState([]);
    const [employee, setEmployee] = useState({
        id: '',
        ma: '',
        email: '',
        hoVaTen: '',
        soDienThoai: '',
        diaChi: '',
        xaPhuong: '',
        quanHuyen: '',
        tinhThanhPho: '',
        chucVu: '',
        trangThai: 0,
        matKhau: '',
    });
    const [isUpdating, setIsUpdating] = useState(false);
    const [filter, setFilter] = useState('');
    const [currentPage, setCurrentPage] = useState(1);

    const [errors, setErrors] = useState({});
    const [isAlertOpen, setIsAlertOpen] = useState(false);
    const [alertMessage, setAlertMessage] = useState('');

    useEffect(() => {

        fetch('http://localhost:8080/api/admin/nhan-vien')
            .then((res) => res.json())
            .then((data) => {
                if (Array.isArray(data)) {
                    setEmployeeList(data);
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
        if (!employee.ma.trim()) {
            newErrors.ma = 'Mã is required';
        }
        if (!employee.hoVaTen.trim()) {
            newErrors.hoVaTen = 'Họ và tên is required';
        }
        if (!employee.soDienThoai.trim()) {
            newErrors.soDienThoai = 'Số điện thoại is required';
        }
        if (!employee.email.trim()) {
            newErrors.email = 'Email is required';
        }
        if (!employee.diaChi.trim()) {
            newErrors.diaChi = 'Địa chỉ is required';
        }
        if (!employee.xaPhuong.trim()) {
            newErrors.xaPhuong = 'Xã/Phường is required';
        }
        if (!employee.quanHuyen.trim()) {
            newErrors.quanHuyen = 'Quận/Huyện is required';
        }
        if (!employee.tinhThanhPho.trim()) {
            newErrors.tinhThanhPho = 'Thành phố/Tỉnh is required';
        }
        if (!employee.matKhau.trim()) {
            newErrors.matKhau = 'Mật khẩu is required';
        }

        setErrors(newErrors);
        return Object.keys(newErrors).length === 0;
    };

    const showAlert = (message) => {
        setAlertMessage(message);
        setIsAlertOpen(true);
    };
    const handleAddEmployee = () => {
        if (!validateForm()) {
            showAlert('Vui lòng điền đầy đủ thông tin');
            return;
        } else {
            let method = 'POST';
            if (employee.id) {
                method = 'PUT';
            }

            fetch(`http://localhost:8080/api/admin/nhan-vien${employee.id ? `/${employee.id}` : ''}`, {
                method: method,
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(employee),
            })
                .then(() => {
                    fetch('http://localhost:8080/api/admin/nhan-vien')
                        .then((res) => res.json())
                        .then((data) => {
                            if (Array.isArray(data)) {
                                setEmployeeList(data);
                                document.querySelector('#exampleModal .btn-close').click();
                                setEmployee({
                                    id: '',
                                    ma: '',
                                    email: '',
                                    hoVaTen: '',
                                    soDienThoai: '',
                                    diaChi: '',
                                    xaPhuong: '',
                                    quanHuyen: '',
                                    tinhThanhPho: '',
                                    chucVu: '',
                                    trangThai: 0,
                                    matKhau: '',
                                });
                            } else {
                                console.error('Data from API is not an array:', data);
                            }
                        })
                        .catch((error) => {
                            console.error(`Lỗi khi lấy danh sách nhân viên sau khi ${employee.id ? 'cập nhật' : 'thêm'}:`, error);
                        });
                })
                .catch((error) => {
                    console.error(`Lỗi khi gửi yêu cầu ${method}:`, error);
                });
        }
    };

    const handleDeleteEmployee = (id) => {
        fetch(`http://localhost:8080/api/admin/nhan-vien/${id}`, {
            method: 'DELETE',
        })
            .then(() => {
                fetch('http://localhost:8080/api/admin/nhan-vien')
                    .then((res) => res.json())
                    .then((data) => {
                        if (Array.isArray(data)) {
                            setEmployeeList(data);
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

    const handleUpdateEmployee = (index) => {
        const selectedEmployee = employeeList[index];

        setEmployee({
            id: selectedEmployee.id,
            ma: selectedEmployee.ma,
            email: selectedEmployee.email,
            hoVaTen: selectedEmployee.hoVaTen,
            soDienThoai: selectedEmployee.soDienThoai,
            diaChi: selectedEmployee.diaChi,
            xaPhuong: selectedEmployee.xaPhuong,
            quanHuyen: selectedEmployee.quanHuyen,
            tinhThanhPho: selectedEmployee.tinhThanhPho,
            chucVu: selectedEmployee.chucVu,
            trangThai: selectedEmployee.trangThai,
            matKhau: selectedEmployee.matKhau,
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
            setEmployee({
                id: '',
                ma: '',
                email: '',
                hoVaTen: '',
                soDienThoai: '',
                diaChi: '',
                xaPhuong: '',
                quanHuyen: '',
                tinhThanhPho: '',
                chucVu: '',
                trangThai: '',
                matKhau: '',
            });

            setIsUpdating(false);
        }
    };

    const handlePageChange = (event, value) => {
        setCurrentPage(value);
    };

    const itemsPerPage = 5;
    const startIndex = (currentPage - 1) * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;
    const filteredData = employeeList
        .filter((emp) => filter === '' || emp.trangThai == filter)
        .slice(startIndex, endIndex);

    return (

        <div className='px-3'>
            <h1 className="text-center mt-3">Quản Lý Nhân Viên</h1>

            <div className="row mt-3">
                <div className="col-6">
                    <Button variant="contained" color="success" data-bs-toggle="modal" data-bs-target="#exampleModal">
                        Thêm Nhân Viên
                    </Button>

                </div>
                <div style={{display: 'flex', alignItems: 'center'}} className='col-2 offset-4'>
                    <i className="fas fa-filter"></i>
                    <Select
                        native
                        value={filter}
                        onChange={(e) => setFilter(e.target.value)}
                        inputProps={{
                            name: 'filter',
                            id: 'filter',
                        }}
                        style={{width: '100%', height: '30px', padding: '4px', marginLeft: '10px'}}
                    >
                        <option value="">Tất cả</option>
                        <option value="0">Đang làm</option>
                        <option value="1">Đã nghỉ</option>
                    </Select>
                </div>
            </div>

            <TableContainer component={Paper} className="text-center mt-2">
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
                                        onClick={() => handleUpdateEmployee(index)}
                                    >
                                        Update
                                    </button>
                                    <button
                                        className="btn btn-danger ms-2"
                                        onClick={() => {
                                            if (window.confirm('Bạn có chắc chắn muốn xoá nhân viên ' + emp.hoVaTen + ' không?')) {
                                                handleDeleteEmployee(emp.id);
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
                                        value={employee.ma}
                                        onChange={(e) => setEmployee({...employee, ma: e.target.value})}
                                        fullWidth
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="hoVaTen"
                                        required
                                        label="Họ và tên"
                                        value={employee.hoVaTen}
                                        onChange={(e) => setEmployee({...employee, hoVaTen: e.target.value})}
                                        fullWidth
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="soDienThoai"
                                        required
                                        label="Số điện thoại"
                                        value={employee.soDienThoai}
                                        onChange={(e) => setEmployee({...employee, soDienThoai: e.target.value})}
                                        fullWidth
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="email"
                                        name="email"
                                        required
                                        label="Email"
                                        value={employee.email}
                                        onChange={(e) => setEmployee({...employee, email: e.target.value})}
                                        fullWidth
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="diaChi"
                                        required
                                        label="Địa chỉ"
                                        value={employee.diaChi}
                                        onChange={(e) => setEmployee({...employee, diaChi: e.target.value})}
                                        fullWidth
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="xaPhuong"
                                        label="Xã/Phường"
                                        value={employee.xaPhuong}
                                        onChange={(e) => setEmployee({...employee, xaPhuong: e.target.value})}
                                        fullWidth
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="quanHuyen"
                                        label="Quận/Huyện"
                                        value={employee.quanHuyen}
                                        onChange={(e) => setEmployee({...employee, quanHuyen: e.target.value})}
                                        fullWidth
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <TextField
                                        type="text"
                                        name="tinhThanhPho"
                                        label="Thành phố/Tỉnh"
                                        required
                                        value={employee.tinhThanhPho}
                                        onChange={(e) => setEmployee({...employee, tinhThanhPho: e.target.value})}
                                        fullWidth
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <Select
                                        native
                                        value={employee.chucVu}
                                        onChange={(e) => setEmployee({...employee, chucVu: e.target.value})}
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
                                        value={employee.matKhau}
                                        onChange={(e) => setEmployee({...employee, matKhau: e.target.value})}
                                        fullWidth
                                    />
                                </Grid>
                                <Grid item xs={12} sm={6}>
                                    <Select
                                        native
                                        value={employee.trangThai}
                                        onChange={(e) => setEmployee({...employee, trangThai: e.target.value})}
                                        inputProps={{
                                            name: 'trangThai',
                                            id: 'trangThai',
                                        }}
                                        fullWidth
                                    >

                                        <option value="0">Đang làm</option>
                                        <option value="1">Đã nghỉ</option>
                                    </Select>
                                </Grid>
                            </Grid>
                            <Button variant="contained" color="success" onClick={handleAddEmployee}
                                    className="mt-3 text-center">
                                Save
                            </Button>
                        </div>
                    </div>
                </div>
            </div>

            <Pagination
                count={Math.ceil(employeeList.length / itemsPerPage)}
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