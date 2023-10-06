
import React, { useState } from 'react';
import {
    Grid,
    Paper,
    Typography,
    AppBar,
    Toolbar,
    Button,
    IconButton,
    Drawer,
    List,
    ListItem,
    ListItemText,
    TextField,
    Dialog,
    DialogTitle,
    DialogContent,
    DialogActions,
    CircularProgress,
    Snackbar,
    Pagination,
} from '@mui/material';
import MenuIcon from '@mui/icons-material/Menu';
import SearchIcon from '@mui/icons-material/Search';
import { DataGrid } from '@mui/x-data-grid'; // Import DataGrid from @mui/x-data-grid
const App = () => {
    const [openSidebar, setOpenSidebar] = useState(false);
    const [openDialog, setOpenDialog] = useState(false);
    const [openSnackbar, setOpenSnackbar] = useState(false);
    const [selectedInvoice, setSelectedInvoice] = useState(null);
    const [isLoading, setIsLoading] = useState(false);

    // Dữ liệu giả mạo (fake data)
    const invoices = [
        {
            id: 1,
            ma: 'INV001',
            ngay_tao: '2023-10-01',
            nguoi_mua: 'Khách hàng A',
            tong_tien: 1000,
            trang_thai_thanh_toan: 'Chưa thanh toán',
        },
        {
            id: 2,
            ma: 'INV002',
            ngay_tao: '2023-10-02',
            nguoi_mua: 'Khách hàng B',
            tong_tien: 1500,
            trang_thai_thanh_toan: 'Đã thanh toán',
        },
        // Thêm dữ liệu giả mạo khác ở đây
    ];

    const columns = [
        { field: 'ma', headerName: 'Mã hóa đơn', width: 100 },
        { field: 'ngay_tao', headerName: 'Ngày tạo', width: 100 },
        { field: 'nguoi_mua', headerName: 'Người mua', width: 150 },
        { field: 'tong_tien', headerName: 'Tổng tiền', width: 100 },
        { field: 'trang_thai_thanh_toan', headerName: 'Trạng thái thanh toán', width: 150 },
        {
            field: 'actions',
            headerName: 'Thao tác',
            width: 100,
            renderCell: (params) => (
                <Button onClick={() => handleOpenDialog(params.row)}>Xem</Button>
            ),
        },
        {
            field: 'pdf',
            headerName: 'PDF',
            width: 150,
            renderCell: () => (
                <Button variant="outlined" color="primary" fullWidth>
                    Xuất file PDF
                </Button>
            ),
        }
    ];

    const handleOpenSidebar = () => {
        setOpenSidebar(true);
    };

    const handleCloseSidebar = () => {
        setOpenSidebar(false);
    };

    const handleOpenDialog = (invoice) => {
        setSelectedInvoice(invoice);
        setOpenDialog(true);
    };

    const handleCloseDialog = () => {
        setSelectedInvoice(null);
        setOpenDialog(false);
    };

    const handleSnackbarClose = () => {
        setOpenSnackbar(false);
    };

    const handleDeleteInvoice = () => {
        // Xử lý xóa hóa đơn ở đây và hiển thị thông báo thành công/thất bại
        setIsLoading(true);
        setTimeout(() => {
            setIsLoading(false);
            setOpenSnackbar(true);
            handleCloseDialog();
        }, 2000);
    };

    // Tính tổng số lượng hóa đơn và doanh thu
    const totalInvoices = invoices.length;
    const totalRevenue = invoices.reduce((total, invoice) => total + invoice.tong_tien, 0);

    return (
        <div>
            <IconButton edge="start" color="inherit" aria-label="menu" onClick={handleOpenSidebar}>
                <MenuIcon />
            </IconButton>
            <Drawer open={openSidebar} onClose={handleCloseSidebar}>

                <List>
                    <ListItem>
                        <TextField
                            placeholder="Tìm kiếm"
                            InputProps={{
                                endAdornment: (
                                    <IconButton>
                                        <SearchIcon />
                                    </IconButton>
                                ),
                            }}
                        />
                    </ListItem>
                    <ListItem>
                    </ListItem>
                    <ListItem>
                    </ListItem>
                    {/* Thêm các tính năng lọc nâng cao ở đây */}
                </List>
            </Drawer>

            <Grid container spacing={3}>
                <Grid item xs={12} sm={3}>
                    <Paper>
                        <Typography variant="h6">Tổng quan</Typography>
                        <Typography>Số lượng hóa đơn: {totalInvoices}</Typography>
                        <Typography>Doanh thu: {totalRevenue} VND</Typography>
                    </Paper>
                </Grid>
                <Grid item xs={12} sm={9}>
                    <Paper>
                        <div style={{ height: 500, width: '100%' }}>
                            {isLoading ? (
                                <CircularProgress />
                            ) : (
                                <DataGrid
                                    rows={invoices}
                                    columns={columns}
                                    pageSize={5}
                                    rowsPerPageOptions={[5, 10, 20]}
                                />
                            )}
                            <Pagination count={Math.ceil(invoices.length / 5)} />
                        </div>
                    </Paper>
                </Grid>
            </Grid>

            <Dialog open={openDialog} onClose={handleCloseDialog}>
                <DialogTitle>Chi tiết hóa đơn</DialogTitle>
                <DialogContent>
                    {selectedInvoice && (
                        <div>
                            <Typography variant="subtitle1">Mã hóa đơn: {selectedInvoice.ma}</Typography>
                            <Typography variant="subtitle1">Ngày tạo: {selectedInvoice.ngay_tao}</Typography>
                            <Typography variant="subtitle1">Người mua: {selectedInvoice.nguoi_mua}</Typography>
                            <Typography variant="subtitle1">Tổng tiền: {selectedInvoice.tong_tien} VND</Typography>
                            <Typography variant="subtitle1">Trạng thái thanh toán: {selectedInvoice.trang_thai_thanh_toan}</Typography>
                            {/* Thêm thông tin chi tiết hơn ở đây */}
                        </div>
                    )}
                </DialogContent>
                <DialogActions>
                    <Button onClick={handleCloseDialog}>Đóng</Button>
                </DialogActions>
            </Dialog>

            <Snackbar
                open={openSnackbar}
                autoHideDuration={3000}
                onClose={handleSnackbarClose}
                message="Thao tác thành công/thất bại"
            />

            {/* Form nhập thông tin khi tạo mới hóa đơn */}
        </div>
    );
};

export default App;
