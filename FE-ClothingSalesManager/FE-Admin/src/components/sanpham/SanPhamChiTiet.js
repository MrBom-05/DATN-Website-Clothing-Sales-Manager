import React, { useState, useEffect } from 'react';
import {
    Button,
    Select,
    Table,
    TableContainer,
    TableHead,
    TableRow,
    TableCell,
    TableBody,
    Paper,
    Alert,
    AlertTitle,
} from '@mui/material';
import { Pagination, PaginationItem } from '@mui/lab';
import 'bootstrap/dist/css/bootstrap.min.css';
import CloudUploadIcon from '@mui/icons-material/CloudUpload';

export default function ChiTietSanPham() {
    const api = 'http://localhost:8080/api/admin/san-pham-chi-tiet';
    const apiSanPham = 'http://localhost:8080/api/admin/san-pham';
    const apiKichCo = 'http://localhost:8080/api/admin/kich-co';
    const apiMauSac = 'http://localhost:8080/api/admin/mau-sac';
    const apiAnhSanPham = 'http://localhost:8080/api/admin/anh-san-pham';

    const [listSanPham, setListSanPham] = useState([]);
    const [listKichCo, setListKichCo] = useState([]);
    const [listMauSac, setListMauSac] = useState([]);
    const [listChiTietSanPham, setListChiTietSanPham] = useState([]);
    const [chiTietSanPham, setChiTietSanPham] = useState({
        id: null,
        maSanPham: '',
        idSanPham: '',
        idKichCo: 0,
        idMauSac: 0,
        gia: 0,
        soLuong: 0,
        moTa: '',
        trangThai: 0,
        duongDan: [],
    });
    const [isUpdating, setIsUpdating] = useState(false);
    const [selectedProductId, setSelectedProductId] = useState(null);
    const [isAdd, setIsAdd] = useState(false);
    const [filter, setFilter] = useState('');
    const [currentPage, setCurrentPage] = useState(1);
    const [successMessage, setSuccessMessage] = useState('');
    const [errors, setErrors] = useState({});
    const [isAlertOpen, setIsAlertOpen] = useState(false);
    const [alertMessage, setAlertMessage] = useState('');
    const [productImages, setProductImages] = useState([]);

    const fetchData = (url, setter) => {
        fetch(url)
            .then((res) => res.json())
            .then((data) => {
                if (Array.isArray(data)) {
                    setter(data);
                } else {
                    console.error('Data from API is not an array:', data);
                }
            })
            .catch((err) => {
                console.error(err);
            });
    };

    useEffect(() => {
        fetchData(api, (data) => {
            const mergedProducts = {};

            data.forEach((product) => {
                const maSanPham = product.maSanPham;

                if (mergedProducts[maSanPham]) {
                    const existingProduct = mergedProducts[maSanPham];
                    existingProduct.soLuong += product.soLuong;
                } else {
                    mergedProducts[maSanPham] = { ...product };
                }
            });

            const mergedProductArray = Object.values(mergedProducts);

            setListChiTietSanPham(mergedProductArray);
        });
    }, []);

    useEffect(() => {
        fetchData(apiSanPham, setListSanPham);
    }, []);

    useEffect(() => {
        fetchData(apiKichCo, setListKichCo);
    }, []);

    useEffect(() => {
        fetchData(apiMauSac, setListMauSac);
    }, []);

    useEffect(() => {
        if (selectedProductId !== null) {
            fetch(`${apiAnhSanPham}/${selectedProductId}`)
                .then((res) => res.json())
                .then((data) => {
                    const base64Images = data.map((imageUrl) => {
                        const base64Image = imageUrl.split(',')[1];
                        return base64Image;
                    });

                    setProductImages(base64Images);
                })
                .catch((err) => {
                    console.error('Lỗi khi tải danh sách ảnh:', err);
                });

            const modal = document.getElementById('imageModal');
            if (modal) {
                modal.style.display = 'block';
            }
        }
    }, [selectedProductId]);

    const validateForm = () => {
        const newErrors = {};
        if (!chiTietSanPham.maSanPham.trim()) {
            newErrors.maSanPham = 'Mã sản phẩm là bắt buộc';
        }
        setErrors(newErrors);

        const hasErrors = Object.keys(newErrors).length > 0;

        return !hasErrors;
    };

    const showSuccessMessage = (message) => {
        setSuccessMessage(message);
    };

    const handleFileChange = (e) => {
        const files = e.target.files;
        if (files && files.length > 0) {
            const selectedImageUrls = [];
            const base64Images = [];

            for (let i = 0; i < files.length; i++) {
                const fileReader = new FileReader();
                fileReader.onload = (e) => {
                    selectedImageUrls.push(e.target.result);

                    const base64Image = e.target.result.split(',')[1];
                    base64Images.push(base64Image);

                    if (selectedImageUrls.length === files.length) {
                        setProductImages(selectedImageUrls);
                        setChiTietSanPham({ ...chiTietSanPham, duongDan: base64Images });
                    }
                };

                fileReader.readAsDataURL(files[i]);
            }
        }
    };

    const handleAddChiTietSanPham = () => {
        if (!validateForm()) {
            return;
        } else {
            let method = 'POST';
            if (chiTietSanPham.id) {
                method = 'PUT';
            }

            const formData = {
                ...chiTietSanPham,
                duongDan: chiTietSanPham.duongDan,
            };

            fetch(api + (chiTietSanPham.id ? `/${chiTietSanPham.id}` : ''), {
                method: method,
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(formData),
            })
                .then((response) => {
                    if (response.ok) {
                        setSuccessMessage(`Đã ${chiTietSanPham.id ? 'cập nhật' : 'thêm'} thành công!`);
                        setChiTietSanPham({
                            maSanPham: '',
                            idSanPham: '',
                            idKichCo: 0,
                            idMauSac: 0,
                            gia: 0,
                            soLuong: 0,
                            moTa: '',
                            trangThai: 0,
                            duongDan: [],
                        });

                        document.querySelector('#exampleModal .btn-close').click();

                        // Sau khi thêm hoặc cập nhật thành công, gọi fetchData để tải lại dữ liệu
                        fetchData(api, (data) => {
                            const mergedProducts = {};

                            data.forEach((product) => {
                                const maSanPham = product.maSanPham;

                                if (mergedProducts[maSanPham]) {
                                    const existingProduct = mergedProducts[maSanPham];
                                    existingProduct.soLuong += product.soLuong;
                                } else {
                                    mergedProducts[maSanPham] = { ...product };
                                }
                            });

                            const mergedProductArray = Object.values(mergedProducts);

                            setListChiTietSanPham(mergedProductArray);
                        });
                    } else {
                        response.json().then((data) => {
                            setAlertMessage(`Lỗi từ server: ${data.message}`);
                            setIsAlertOpen(true);
                        });
                    }
                })
                .catch((error) => {
                    setAlertMessage(`Lỗi khi gửi yêu cầu: ${error.message}`);
                    setIsAlertOpen(true);
                });
        }
    };


    const handleUpdateChiTietSanPham = (index) => {
        const selectedChiTietSanPham = listChiTietSanPham[index];

        setChiTietSanPham({
            id: selectedChiTietSanPham.id,
            maSanPham: selectedChiTietSanPham.maSanPham,
            idSanPham: selectedChiTietSanPham.idSanPham,
            idKichCo: selectedChiTietSanPham.idKichCo,
            idMauSac: selectedChiTietSanPham.idMauSac,
            gia: selectedChiTietSanPham.gia,
            soLuong: selectedChiTietSanPham.soLuong,
            moTa: selectedChiTietSanPham.moTa,
            trangThai: selectedChiTietSanPham.trangThai,
            duongDan: selectedChiTietSanPham.duongDan,
        });

        const modal = document.getElementById('exampleModal');
        if (modal) {
            modal.style.display = 'block';
        }
    };

    const handleModalClose = () => {
        const modal = document.getElementById('exampleModal');
        if (modal) {
            document.querySelector('#exampleModal .btn-close').click();
            setChiTietSanPham({
                maSanPham: '',
                idSanPham: '',
                idKichCo: 0,
                idMauSac: 0,
                gia: 0,
                soLuong: 0,
                moTa: '',
                trangThai: 0,
                duongDan: [],
            });

            setIsUpdating(false);
            setErrors({});
        }
    };

    const handlePageChange = (event, value) => {
        setCurrentPage(value);
    };

    const openImageModal = (chiTietSanPhamId) => {
        setSelectedProductId(chiTietSanPhamId);

        fetch(`${apiAnhSanPham}/${chiTietSanPhamId}`)
            .then((res) => res.json())
            .then((data) => {
                setProductImages(data);
            })
            .catch((err) => {
                console.error('Lỗi khi tải danh sách ảnh:', err);
            });

        const modal = document.getElementById('imageModal');
        if (modal) {
            modal.style.display = 'block';
        }
    };

    const itemsPerPage = 5;
    const startIndex = (currentPage - 1) * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;
    const filteredData = listChiTietSanPham
        .filter((item) => filter === '' || item.trangThai == filter)
        .slice(startIndex, endIndex);

    return (
        <div className="px-3">
            <h1 className="text-center mt-3">Quản Lý Chi Tiết Sản Phẩm</h1>

            <div className="row mt-3">
                <div className="col-6">
                    <Button
                        variant="contained"
                        color="success"
                        data-bs-toggle="modal"
                        data-bs-target="#exampleModal"
                        onClick={() => {
                            setIsUpdating(false);
                            setIsAdd(true);
                        }}
                    >
                        Thêm Chi Tiết Sản Phẩm
                    </Button>
                </div>
                <div style={{ display: 'flex', alignItems: 'center' }} className="col-2 offset-4">
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
                        <option value="0">Hoạt động</option>
                        <option value="1">Ngừng hoạt động</option>
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
                            <TableCell>Mã Sản Phẩm</TableCell>
                            <TableCell>Tên Sản Phẩm</TableCell>
                            <TableCell>Tên Màu Sắc</TableCell>
                            <TableCell>Tên Kích Cỡ</TableCell>
                            <TableCell>Giá</TableCell>
                            <TableCell>Số Lượng</TableCell>
                            <TableCell>Mô Tả</TableCell>
                            <TableCell>Trạng Thái</TableCell>
                            <TableCell className="text-center">Hành Động</TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {filteredData.map((item, index) => (
                            <TableRow key={item.id}>
                                <TableCell>{index + 1 + startIndex}</TableCell>
                                <TableCell>{item.maSanPham}</TableCell>
                                <TableCell>{item.tenSanPham}</TableCell>
                                <TableCell>{item.tenMauSac}</TableCell>
                                <TableCell>{item.tenKichCo}</TableCell>
                                <TableCell>{item.gia}</TableCell>
                                <TableCell>{item.soLuong}</TableCell>
                                <TableCell>{item.moTa}</TableCell>
                                <TableCell>
                                    {item.trangThai === 1 ? 'Ngừng hoạt động' : 'Hoạt động'}
                                </TableCell>
                                <TableCell>
                                    <Button
                                        variant="contained"
                                        color="primary"
                                        onClick={() => handleUpdateChiTietSanPham(index)}
                                        data-bs-toggle="modal"
                                        data-bs-target="#exampleModal"
                                    >
                                        Sửa
                                    </Button>
                                    <Button
                                        variant="contained"
                                        color="primary"
                                        onClick={() => openImageModal(item.id)}
                                        className="ms-2"
                                        data-bs-toggle="modal"
                                        data-bs-target="#imageModal" // Thêm dòng này
                                    >
                                        Xem Ảnh
                                    </Button>

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
                            <h1 className="modal-title fs-5 text-center" id="exampleModalLabel">
                                {isUpdating ? 'Cập Nhật Chi Tiết Sản Phẩm' : 'Thêm Chi Tiết Sản Phẩm'}
                            </h1>
                            <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close" onClick={handleModalClose}></button>
                        </div>
                        <div className="modal-body text-center">
                            <div className="container">
                                <div className="row">
                                    <div className="col-md-6">
                                        <div className="mb-3">
                                            <input
                                                type="text"
                                                className={`form-control ${errors.maSanPham ? 'is-invalid' : ''}`}
                                                name="maSanPham"
                                                placeholder="Mã Sản Phẩm"
                                                required
                                                value={chiTietSanPham.maSanPham}
                                                onChange={(e) => setChiTietSanPham({ ...chiTietSanPham, maSanPham: e.target.value })}
                                            />
                                            {errors.maSanPham && <div className="invalid-feedback">{errors.maSanPham}</div>}
                                        </div>
                                    </div>
                                    <div className="col-md-6">
                                        <div className="mb-3">
                                            <select
                                                className={`form-select ${errors.idSanPham ? 'is-invalid' : ''}`}
                                                name="idSanPham"
                                                value={chiTietSanPham.idSanPham}
                                                onChange={(e) => setChiTietSanPham({ ...chiTietSanPham, idSanPham: e.target.value })}
                                                required
                                            >
                                                <option value="" disabled hidden>Chọn sản phẩm</option>
                                                {listSanPham.length === 0 ? (
                                                    <option value="" disabled>Không có sản phẩm nào</option>
                                                ) : (
                                                    listSanPham.map((loai) => (
                                                        <option value={loai.id} key={loai.id}>
                                                            {loai.ten}
                                                        </option>
                                                    ))
                                                )}
                                            </select>
                                            {errors.idSanPham && <div className="invalid-feedback">{errors.idSanPham}</div>}
                                        </div>
                                    </div>
                                    <div className="col-md-6">
                                        <div className="mb-3">
                                            <select
                                                className={`form-select ${errors.idKichCo ? 'is-invalid' : ''}`}
                                                name="idKichCo"
                                                value={chiTietSanPham.idKichCo}
                                                onChange={(e) => setChiTietSanPham({ ...chiTietSanPham, idKichCo: e.target.value })}
                                                required
                                            >
                                                <option value="" disabled hidden>Chọn kích cỡ</option>
                                                {listKichCo.length === 0 ? (
                                                    <option value="" disabled>Không có kích cỡ nào</option>
                                                ) : (
                                                    listKichCo.map((loai) => (
                                                        <option value={loai.id} key={loai.id}>
                                                            {loai.ten}
                                                        </option>
                                                    ))
                                                )}
                                            </select>
                                            {errors.idKichCo && <div className="invalid-feedback">{errors.idKichCo}</div>}
                                        </div>
                                    </div>
                                    <div className="col-md-6">
                                        <div className="mb-3">
                                            <select
                                                className={`form-select ${errors.idMauSac ? 'is-invalid' : ''}`}
                                                name="idMauSac"
                                                value={chiTietSanPham.idMauSac}
                                                onChange={(e) => setChiTietSanPham({ ...chiTietSanPham, idMauSac: e.target.value })}
                                                required
                                            >
                                                <option value="" disabled hidden>Chọn màu sắc</option>
                                                {listMauSac.length === 0 ? (
                                                    <option value="" disabled>Không có màu sắc nào</option>
                                                ) : (
                                                    listMauSac.map((loai) => (
                                                        <option value={loai.id} key={loai.id}>
                                                            {loai.ten}
                                                        </option>
                                                    ))
                                                )}
                                            </select>
                                            {errors.idMauSac && <div className="invalid-feedback">{errors.idMauSac}</div>}
                                        </div>
                                    </div>
                                    <div className="col-md-6">
                                        <div className="mb-3">
                                            <input
                                                type="number"
                                                className={`form-control ${errors.gia ? 'is-invalid' : ''}`}
                                                name="gia"
                                                placeholder="Giá"
                                                required
                                                value={chiTietSanPham.gia}
                                                onChange={(e) => setChiTietSanPham({ ...chiTietSanPham, gia: e.target.value })}
                                            />
                                            {errors.gia && <div className="invalid-feedback">{errors.gia}</div>}
                                        </div>
                                    </div>
                                    <div className="col-md-6">
                                        <div className="mb-3">
                                            <input
                                                type="number"
                                                className={`form-control ${errors.soLuong ? 'is-invalid' : ''}`}
                                                name="soLuong"
                                                placeholder="Số Lượng"
                                                required
                                                value={chiTietSanPham.soLuong}
                                                onChange={(e) => setChiTietSanPham({ ...chiTietSanPham, soLuong: e.target.value })}
                                            />
                                            {errors.soLuong && <div className="invalid-feedback">{errors.soLuong}</div>}
                                        </div>
                                    </div>
                                    <div className="col-md-12">
                                        <div className="mb-3">
                                            <input
                                                type="text"
                                                className={`form-control ${errors.moTa ? 'is-invalid' : ''}`}
                                                name="moTa"
                                                placeholder="Mô Tả"
                                                required
                                                value={chiTietSanPham.moTa}
                                                onChange={(e) => setChiTietSanPham({ ...chiTietSanPham, moTa: e.target.value })}
                                            />
                                            {errors.moTa && <div className="invalid-feedback">{errors.moTa}</div>}
                                        </div>
                                    </div>
                                    <div className="col-md-6">
                                        <div className="mb-3">
                                            <select
                                                className="form-select"
                                                name="trangThai"
                                                value={chiTietSanPham.trangThai}
                                                onChange={(e) => setChiTietSanPham({ ...chiTietSanPham, trangThai: e.target.value })}
                                            >
                                                {isAdd ? (
                                                    <>
                                                        <option value="0">Đang bán</option>
                                                    </>
                                                ) : (
                                                    <>
                                                        <option value="0">Đang bán</option>
                                                        <option value="1">Ngừng bán</option>
                                                    </>
                                                )}
                                            </select>
                                        </div>
                                    </div>
                                    <div className="col-md-12">
                                        <input
                                            type="file"
                                            accept="image/*"
                                            multiple
                                            style={{ display: 'none' }}
                                            id="image-upload-input"
                                            onChange={(e) => {
                                                // Kiểm tra nếu đang cập nhật thì không cho phép thay đổi mật khẩu
                                                if (!isUpdating) {
                                                    handleFileChange(e);
                                                }
                                            }}
                                            fullWidth
                                            disabled={isUpdating} // Vô hiệu hóa input khi isUpdating là true
                                        />
                                        <label htmlFor="image-upload-input">
                                            <Button
                                                variant="contained"
                                                component="span"
                                                color="primary"
                                                startIcon={<CloudUploadIcon />}
                                            >
                                                Tải lên ảnh
                                            </Button>

                                        </label>
                                    </div>
                                </div>
                            </div>
                            <button
                                type="button"
                                className="btn btn-success mt-3"
                                onClick={handleAddChiTietSanPham}
                            >
                                Lưu
                            </button>
                        </div>
                    </div>
                </div>

            </div>

            <div className="modal fade" id="imageModal" tabIndex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div className="modal-dialog modal-lg">
                    <div className="modal-content">
                        <div className="modal-header">
                            <h1 className="modal-title fs-5 justify-content-center" id="exampleModalLabel">
                                Ảnh Sản Phẩm
                            </h1>
                            <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close" onClick={() => setProductImages([])}></button>
                        </div>
                        <div className="modal-body text-center">
                            <div className="row">
                                {productImages.map((image) => (
                                    <div key={image.id} className="col-md-6 mb-3">
                                        <img src={`data:image/jpeg;base64,${image.duongDan}`} alt={image.duongDan} className="img-fluid" />
                                    </div>
                                ))}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <Pagination
                count={Math.ceil(listChiTietSanPham.length / itemsPerPage)}
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
}