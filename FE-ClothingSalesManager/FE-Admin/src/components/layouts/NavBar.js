import * as React from 'react';
import AppBar from '@mui/material/AppBar';
import Box from '@mui/material/Box';
import Toolbar from '@mui/material/Toolbar';
import IconButton from '@mui/material/IconButton';
import Typography from '@mui/material/Typography';
import Menu from '@mui/material/Menu';
import MenuIcon from '@mui/icons-material/Menu';
import Container from '@mui/material/Container';
import Avatar from '@mui/material/Avatar';
import Button from '@mui/material/Button';
import Tooltip from '@mui/material/Tooltip';
import MenuItem from '@mui/material/MenuItem';
import {Link} from 'react-router-dom';

export default function Navbar() {
    const [anchorElNav, setAnchorElNav] = React.useState(null);
    const [anchorElUser, setAnchorElUser] = React.useState(null);
    const [anchorElProduct, setAnchorElProduct] = React.useState(null);

    const handleOpenNavMenu = (event) => {
        setAnchorElNav(event.currentTarget);
    };
    const handleOpenUserMenu = (event) => {
        setAnchorElUser(event.currentTarget);
    };

    const handleOpenProductMenu = (event) => {
        setAnchorElProduct(event.currentTarget);
    };

    const handleCloseNavMenu = () => {
        setAnchorElNav(null);
    };

    const handleCloseUserMenu = () => {
        setAnchorElUser(null);
    };

    const handleCloseProductMenu = () => {
        setAnchorElProduct(null);
    };

    return (<AppBar position="static">
        <Container maxWidth="xl">
            <Toolbar disableGutters>
                <Typography
                    variant="h4"
                    noWrap
                    component={Link}
                    to="/"
                    sx={{
                        mr: 2,
                        display: {xs: 'none', md: 'flex'},
                        fontWeight: 700,
                        letterSpacing: '.3rem',
                        color: 'inherit',
                        textDecoration: 'none',
                    }}
                >
                    Admin
                </Typography>

                <Box sx={{flexGrow: 1, display: {xs: 'flex', md: 'none'}}}>
                    <IconButton
                        size="large"
                        aria-label="account of current user"
                        aria-controls="menu-appbar"
                        aria-haspopup="true"
                        onClick={handleOpenNavMenu}
                        color="inherit"
                    >
                        <MenuIcon/>
                    </IconButton>
                    <Menu
                        id="menu-appbar"
                        anchorEl={anchorElNav}
                        anchorOrigin={{
                            vertical: 'bottom', horizontal: 'left',
                        }}
                        keepMounted
                        transformOrigin={{
                            vertical: 'top', horizontal: 'left',
                        }}
                        open={Boolean(anchorElNav)}
                        onClose={handleCloseNavMenu}
                        sx={{
                            display: {xs: 'block', md: 'none'},
                        }}
                    >
                        <MenuItem onClick={handleCloseNavMenu}>
                            <Typography textAlign="center">Bán Hàng</Typography>
                        </MenuItem>
                        <MenuItem onClick={handleCloseNavMenu}>
                            <Typography textAlign="center">Hoá Đơn</Typography>
                        </MenuItem>
                        <MenuItem onClick={handleCloseNavMenu}>
                            <Typography textAlign="center">Sản Phẩm</Typography>
                        </MenuItem>
                        <MenuItem onClick={handleCloseNavMenu}>
                            <Typography textAlign="center">Khuyến Mại</Typography>
                        </MenuItem>
                        <MenuItem onClick={handleCloseNavMenu}>
                            <Typography textAlign="center">Voucher</Typography>
                        </MenuItem>
                        <MenuItem onClick={handleCloseNavMenu}>
                            <Typography textAlign="center">Khách Hàng</Typography>
                        </MenuItem>
                        <MenuItem onClick={handleCloseNavMenu}>
                            <Typography textAlign="center">Nhân Viên</Typography>
                        </MenuItem>
                        <MenuItem onClick={handleCloseNavMenu}>
                            <Typography textAlign="center">Thống Kê</Typography>
                        </MenuItem>
                    </Menu>
                </Box>
                <Typography
                    variant="h5"
                    noWrap
                    component="a"
                    href="#app-bar-with-responsive-menu"
                    sx={{
                        mr: 2,
                        display: {xs: 'flex', md: 'none'},
                        flexGrow: 1,
                        fontWeight: 700,
                        letterSpacing: '.3rem',
                        color: 'inherit',
                        textDecoration: 'none',
                    }}
                >
                    Admin
                </Typography>
                <Box sx={{flexGrow: 1, display: {xs: 'none', md: 'flex'}}}>

                    <Button component={Link}
                            to="/"
                            onClick={handleCloseNavMenu}
                            sx={{my: 2, color: 'white', display: 'block', marginLeft: '10px'}}
                    >
                        Bán Hàng
                    </Button>

                    <Button component={Link}
                            to="/hoa-don"
                            onClick={handleCloseNavMenu}
                            sx={{my: 2, color: 'white', display: 'block', marginLeft: '10px'}}
                    >
                        Hoá Đơn
                    </Button>

                    <Button component={Link}
                            to="/san-pham"
                            onMouseEnter={handleOpenProductMenu}
                            sx={{my: 2, color: 'white', display: 'block', marginLeft: '10px'}}
                    >
                        Sản Phẩm
                    </Button>

                    <Menu
                        sx={{mt: '45px'}}
                        id="menu-appbar"
                        anchorEl={anchorElProduct}
                        anchorOrigin={{
                            vertical: 'top', horizontal: 'center',
                        }}
                        keepMounted
                        transformOrigin={{
                            vertical: 'top', horizontal: 'center',
                        }}
                        open={Boolean(anchorElProduct)}
                        onClose={handleCloseProductMenu}
                        onMouseLeave={handleCloseProductMenu}
                    >

                        <Link to="/san-pham" style={{textDecoration: 'none', color: 'inherit'}}>
                            <MenuItem onClick={handleCloseProductMenu}>
                                <Typography textAlign="center">Sản Phẩm</Typography>
                            </MenuItem>
                        </Link>

                        <Link to="/san-pham-chi-tiet" style={{textDecoration: 'none', color: 'inherit'}}>
                            <MenuItem onClick={handleCloseProductMenu}>
                                <Typography textAlign="center">Sản Phẩm Chi Tiết</Typography>
                            </MenuItem>
                        </Link>

                        <Link to="/loai" style={{textDecoration: 'none', color: 'inherit'}}>
                            <MenuItem onClick={handleCloseProductMenu}>
                                <Typography textAlign="center">Loại</Typography>
                            </MenuItem>
                        </Link>

                        <Link to="/mau-sac" style={{textDecoration: 'none', color: 'inherit'}}>
                            <MenuItem onClick={handleCloseProductMenu}>
                                <Typography textAlign="center">Màu Sắc</Typography>
                            </MenuItem>
                        </Link>

                        <Link to="/kich-co" style={{textDecoration: 'none', color: 'inherit'}}>
                            <MenuItem onClick={handleCloseProductMenu}>
                                <Typography textAlign="center">Kích Cỡ</Typography>
                            </MenuItem>
                        </Link>


                    </Menu>

                    <Button component={Link}
                            to="/khuyen-mai"
                            onClick={handleCloseNavMenu}
                            sx={{my: 2, color: 'white', display: 'block', marginLeft: '10px'}}
                    >
                        Khuyến Mãi
                    </Button>

                    <Button component={Link}
                            to="/voucher"
                            onClick={handleCloseNavMenu}
                            sx={{my: 2, color: 'white', display: 'block', marginLeft: '10px'}}
                    >
                        Voucher
                    </Button>

                    <Button component={Link}
                            to="/khach-hang"
                            onClick={handleCloseNavMenu}
                            sx={{my: 2, color: 'white', display: 'block', marginLeft: '10px'}}
                    >
                        Khách Hàng
                    </Button>

                    <Button component={Link}
                            to="/nhan-vien"
                            onClick={handleCloseNavMenu}
                            sx={{my: 2, color: 'white', display: 'block', marginLeft: '10px'}}
                    >
                        Nhân Viên
                    </Button>

                    <Button component={Link}
                            to="/thong-ke"
                            onClick={handleCloseNavMenu}
                            sx={{my: 2, color: 'white', display: 'block', marginLeft: '10px'}}
                    >
                        Thống Kê
                    </Button>

                </Box>

                <Box sx={{flexGrow: 0}}>
                    <Tooltip title="Open settings">
                        <IconButton onClick={handleOpenUserMenu} sx={{p: 0}}>
                            <Avatar alt="" src=""/>
                        </IconButton>
                    </Tooltip>
                    <Menu
                        sx={{mt: '45px'}}
                        id="menu-appbar"
                        anchorEl={anchorElUser}
                        anchorOrigin={{
                            vertical: 'top', horizontal: 'right',
                        }}
                        keepMounted
                        transformOrigin={{
                            vertical: 'top', horizontal: 'right',
                        }}
                        open={Boolean(anchorElUser)}
                        onClose={handleCloseUserMenu}
                    >

                        <MenuItem onClick={handleCloseUserMenu}>
                            <Typography textAlign="center">Đổi Mật Khẩu</Typography>
                        </MenuItem>
                        <MenuItem onClick={handleCloseUserMenu}>
                            <Typography textAlign="center">Đăng Xuất</Typography>
                        </MenuItem>

                    </Menu>
                </Box>
            </Toolbar>
        </Container>
    </AppBar>);
}
