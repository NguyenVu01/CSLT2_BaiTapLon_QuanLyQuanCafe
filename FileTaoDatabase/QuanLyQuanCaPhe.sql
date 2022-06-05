-- 1.Tạo bảng TÀI KHOẢN
CREATE TABLE TAIKHOAN
(
	TenDangNhap  VARCHAR(100) PRIMARY KEY,
	MatKhau VARCHAR(100) NOT NULL DEFAULT 0, 
	TenNguoiDung NVARCHAR(100) NOT NULL DEFAULT 'user',
	LoaiTaiKhoan INT NOT NULL DEFAULT 0 --0.Nhan vien --1.Quan ly
);
-- 2.Tạo bảng LOẠI MÓN
CREATE TABLE LOAIMON 
(
	MaLoaiMon NVARCHAR(20) PRIMARY KEY,
	TenLoaiMon NVARCHAR(50) NOT NULL
);
-- 3.Tạo bảng NHÀ CUNG CẤP
CREATE TABLE NHACUNGCAP
(
	MaNCC INT IDENTITY PRIMARY KEY,
	TenNCC NVARCHAR(50) NOT NULL,
	DiaChi NVARCHAR(100) NOT NULL,
	SDT VARCHAR(30) NULL
);
-- 4.Tạo bảng NGUYÊN LIỆU
CREATE TABLE NGUYENLIEU
(
	MaNL VARCHAR(10) PRIMARY KEY,
	TenNL NVARCHAR(100) NOT NULL, 
	SoLuong INT,
	DonViTinh NVARCHAR(50),
	MaNCC INT, 
	CONSTRAINT fk_nl_ncc FOREIGN KEY (MaNCC) REFERENCES NHACUNGCAP(MaNCC),
	CONSTRAINT check_manl CHECK(SUBSTRING(MaNL,1,2) = 'NL'),
	CONSTRAINT check_soluong CHECK(SoLuong >= 0)
);
-- 5.Tạo bảng BÀN
CREATE TABLE BAN 
(
	MaBan INT IDENTITY PRIMARY KEY,
	TenBan NVARCHAR(50) NOT NULL,
	TrangThai NVARCHAR(50) NOT NULL DEFAULT N'Trong',	
);
-- 6.Tạo bảng MÓN
CREATE TABLE MON 
(
	MaMon NVARCHAR(20) PRIMARY KEY,
	TenMon NVARCHAR(50) NOT NULL,
	Gia  DECIMAL (10, 2)  NOT NULL,
	MaLoaiMon NVARCHAR(20) NOT NULL,
	CONSTRAINT fk_mon_loaimon FOREIGN KEY (MaLoaiMon) REFERENCES LOAIMON(MaLoaiMon)
);
-- 7.Tạo bảng NHÂN VIÊN
CREATE TABLE NHANVIEN
(
	MaNV INT IDENTITY PRIMARY KEY,
	TenNV NVARCHAR(50) NOT NULL,
	NgaySinh DATE NULL,
	DiaChi NVARCHAR(50) NOT NULL,
	SDT VARCHAR(30),
	HoatDong tinyint NOT NULL, -- 0 la dang hoat dong, 1 la khong hoat dong nua
	BoPhan NVARCHAR(30),
	Luong  DECIMAL (10, 2) -- Luong nay la luong co ban  
);
-- 8.Tạo bảng HÓA ĐƠN
CREATE TABLE HOADON
(
	MaHD INT IDENTITY PRIMARY KEY,
	NgayDat date,
	NgayGiao date,
	MaNV INT  NOT NULL,
	MaBan INT NULL,
	TrangThai TINYINT NOT NULL DEFAULT 1, --1 da thanh toan - 0 chua thanh toan
	GiamGia INT DEFAULT 0,
	CONSTRAINT fk_hoadon_nhanvien FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV),
	CONSTRAINT fk_hoadon_ban FOREIGN KEY (MaBan) REFERENCES BAN(MaBan)
);
-- 9.Tạo bảng CHI TIẾT HÓA ĐƠN
CREATE TABLE CHITIETHD
(
	MaHD INT IDENTITY,
	MaMon NVARCHAR(20) NOT NULL,
	SoLuong INT NOT NULL DEFAULT 0,
	CONSTRAINT pk_cthd PRIMARY KEY (MaHD, MaMon),
	CONSTRAINT fk_cthd_mon FOREIGN KEY (MaHD) REFERENCES HOADON(MaHD),
	CONSTRAINT fk_cthd_hd FOREIGN KEY (MaMon) REFERENCES MON(MaMon),
	CONSTRAINT check_ct_soluong CHECK(SoLuong > 0)
);
-- 10.Tạo bảng CÔNG THỨC 
CREATE TABLE CONGTHUC
(
	MaMon NVARCHAR(20),
	MaNL VARCHAR(10),
	HamLuong INT, 
	DonVi VARCHAR(20),
	CONSTRAINT pk_congthuc PRIMARY KEY (MaMon, MaNl),
	CONSTRAINT check_congthuc_hamluong CHECK(HamLuong > 0),
	CONSTRAINT check_congthuc_tong CHECK(HamLuong > 0),
	CONSTRAINT fk_ct_nguyenlieu FOREIGN KEY (MaNL) REFERENCES NGUYENLIEU(MaNL),
	CONSTRAINT fk_ct_mon FOREIGN KEY (MaMon) REFERENCES MON(MaMon),
);

-- 11. Tạo bảng CHẤM CÔNG 
CREATE TABLE CHAMCONG
(
	STT INT IDENTITY PRIMARY KEY,
	MaNV INT NOT NULL, 
	NgayChamCong DATE DEFAULT GETDATE(), 
	SoCa INT, 
	CONSTRAINT fk_chamcong_nhanvien FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
);

-- Insert data for all tables
-- 1.Bảng tài TÀI KHOẢN
INSERT INTO TAIKHOAN(TenDangNhap, MatKhau, TenNguoiDung, LoaiTaiKhoan)
VALUES('quanly', '1', N'Anh quản lý may mắn', 1);
INSERT INTO TAIKHOAN(TenDangNhap, MatKhau, TenNguoiDung, LoaiTaiKhoan)
VALUES('nhanvien', '1', N'Em nhân viên tâm lý', 0);
select * from TAIKHOAN;
-- 2. Bảng LOẠI MÓN
INSERT INTO LOAIMON(maloaimon, tenloaimon)
VALUES('coffee', N'Cà phê');
INSERT INTO LOAIMON(maloaimon, tenloaimon)
VALUES('juice', N'Nước ép');
INSERT INTO LOAIMON(maloaimon, tenloaimon)
VALUES('smoothie', N'Sinh tố');
INSERT INTO LOAIMON(maloaimon, tenloaimon)
VALUES('tea', N'Trà');
INSERT INTO LOAIMON(maloaimon, tenloaimon)
VALUES('cake', N'Bánh ngọt');
select * from loaimon;
-- 3. Bảng NHÀ CUNG CẤP
--SET IDENTITY_INSERT NHACUNGCAP ON;
INSERT INTO NHACUNGCAP(TenNCC, DiaChi, sdt)
VALUES(N'Công Ty TNHH Cà Phê Ngon', N'23 Ngô Quyền, Thắng Lợi, Buôn Ma Thuật, Đắk Lắk','02623950787');
INSERT INTO NHACUNGCAP(TenNCC, DiaChi, sdt)
VALUES(N'CôngTy TNHH Nestle Việt Nam', N'138-142 Hai Bà Trưng, Đa Kao, Q1 , Hồ Chí Minh','02839113737');
INSERT INTO NHACUNGCAP(TenNCC, DiaChi, sdt)
VALUES(N'Công Ty TNHH Tam Châu', N'284 Tôn Đức Thắng, Hàng Bột, Đống Đa, Hà Nội','02437916555');
INSERT INTO NHACUNGCAP(TenNCC, DiaChi, sdt)
VALUES(N'Công Ty TNHH Thương mại và Thực phẩm Sao Việt', N'2/77 Trần Nguyên Đán, Hoàng Mai, Hà Nội','02432323658');
INSERT INTO NHACUNGCAP(TenNCC, DiaChi, sdt)
VALUES(N'Công Ty CP Sản xuất và Thương mại Tomato Việt Nam', N'33 BT3, Khu độ thị Văn Phú, Hà Đông, Hà Nội','0968018334');
INSERT INTO NHACUNGCAP(TenNCC, DiaChi, sdt)
VALUES(N'Công Ty nhập khẩu trái cây Homefarm', N'282 Hoàng Văn Thái, Thanh Xuân, Hà Nội','02471081008');
select * from nhacungcap;
--SET IDENTITY_INSERT NHACUNGCAP OFF;

-- 4. Bảng BÀN
INSERT INTO BAN(tenban, trangthai)
VALUES('Ban 1','Dang su dung');
INSERT INTO BAN( tenban, trangthai)
VALUES('Ban 2','Dang su dung');
INSERT INTO BAN( tenban, trangthai)
VALUES('Ban 3', 'Dang su dung');
INSERT INTO BAN( tenban, trangthai)
VALUES('Ban 4', 'Dang su dung');
INSERT INTO BAN( tenban, trangthai)
VALUES('Ban 5', 'Trong');
INSERT INTO BAN( tenban, trangthai)
VALUES('Ban 6', 'Trong');
INSERT INTO BAN( tenban, trangthai)
VALUES('Ban 7', 'Trong');
INSERT INTO BAN( tenban, trangthai)
VALUES('Ban 8', 'Trong');
INSERT INTO BAN( tenban, trangthai)
VALUES('Ban 9', 'Trong');
INSERT INTO BAN( tenban, trangthai)
VALUES('Ban 10', 'Trong');
select * from ban;
-- 5.Bảng MÓN
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('CF001',N'Capuchino', 50000, 'coffee');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('CF002',N'Expresso', 50000, 'coffee');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('CF003',N'Bạc xỉu', 40000, 'coffee');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('CF004',N'Mocha Macchiato', 50000, 'coffee');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('CF005',N'Đen đá', 35000, 'coffee');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('CF006',N'Americano', 50000, 'coffee');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('J001',N'Nước ép táo', 40000, 'juice');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('J002',N'Nước ép dưa hấu', 40000, 'juice');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('J003',N'Nước ép nho', 40000, 'juice');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('J004',N'Nước ép cam', 40000, 'juice');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('J005',N'Nước ép dưa leo', 40000, 'juice');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('J006',N'Nước ép kiwi', 40000, 'juice');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('J007',N'Nước ép dâu', 40000, 'juice');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('SM001',N'Sinh tố cà chua', 40000, 'smoothie');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('SM002',N'Sinh tố dưa hấu', 40000, 'smoothie');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('SM003',N'Sinh tố dứa', 40000, 'smoothie');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('SM004',N'Sinh tố cà rốt', 40000, 'smoothie');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('SM005',N'Sinh tố cà chua', 40000, 'smoothie');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('SM006',N'Sinh tố thập cẩm', 50000, 'smoothie');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('T001',N'Trà đào', 40000, 'tea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('T002',N'Trà dâu', 40000, 'tea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('T003',N'Trà xanh', 30000, 'tea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('T004',N'Trà hoa lài', 40000, 'tea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('T005',N'Trà hoa hồng', 40000, 'tea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('T006',N'Trà gừng mật ong', 40000, 'tea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('T007',N'Trà matcha sữa', 55000, 'tea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('T008',N'Trà tắc', 30000, 'tea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('T009',N'Trà bí đào', 30000, 'tea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('T010',N'Trà quất nha đam', 35000, 'tea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('C001',N'Bánh toffee', 80000, 'cake');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('C002',N'Bánh kem pho mai', 69000, 'cake');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('C003',N'Bánh socola', 59000, 'cake');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('C004',N'Bánh kem dâu tây', 63000, 'cake');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('C005',N'Bánh bông lan trứng muối', 57000,'cake');
select * from MON;

-- 6. Bảng NHÂN VIÊN
INSERT INTO NHANVIEN( tennv, ngaysinh, diachi, sdt, hoatdong,  bophan,luong)
VALUES(N'Nguyễn Hoài Thu Trang', '1998/2/5', N'Hà Đông, Hà Nội', '0932464213', 1, N'Phục vụ',  2000000);
INSERT INTO NHANVIEN( tennv, ngaysinh, diachi, sdt, hoatdong,  bophan, luong)
VALUES(N'Trương Thị Thu Thủy', '1998/4/13', N'Cầu Giấy, Hà Nội', '0964521332', 1, N'Phục vụ', 2000000);
INSERT INTO NHANVIEN( tennv, ngaysinh, diachi, sdt, hoatdong,  bophan, luong)
VALUES(N'Nguyễn Tùng Lâm', '2000/7/13', N'Hoài Đức, Hà Nội', '0967884223', 1, N'Pha chế', 2000000);
INSERT INTO NHANVIEN( tennv, ngaysinh, diachi, sdt, hoatdong,  bophan, luong)
VALUES(N'Lương Thị Tâm', '1997/12/8', N'Cẩm Phả, Quảng Ninh', '0987632436', 1, N'Pha chế', 2000000);
INSERT INTO NHANVIEN( tennv, ngaysinh, diachi, sdt, hoatdong,  bophan, luong)
VALUES(N'Lê Hồng Anh', '1996/6/19', N'Văn Giang, Hưng Yên', '0998743215', 1, N'Thu ngân', 2000000);
INSERT INTO NHANVIEN( tennv, ngaysinh, diachi, sdt, hoatdong,  bophan, luong)
VALUES(N'Trần Đức Nam', '1996/8/11', N'Thanh Xuân, Hà Nội', '0946342223', 1, N'Thu ngân', 2000000);
INSERT INTO NHANVIEN( tennv, ngaysinh, diachi, sdt, hoatdong,  bophan, luong)
VALUES(N'Lê Ngọc Huyền', '1994/4/17', N'Hoàn Kiếm, Hà Nội', '0971552222', 1, 'Quản lý', 5000000);
select * from NHANVIEN;
-- 7. Bảng HÓA ĐƠN
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/1/2022', '1/1/2022', 5, 1, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/1/2022', '1/1/2022', 5, 2, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/1/2022', '1/1/2022', 5, 3, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/1/2022', '1/1/2022', 5, 4, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/1/2022', '1/2/2022', 5, 5, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/1/2022', '1/2/2022', 5, 6, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/1/2022', '1/1/2022', 5, 7, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/1/2022', '1/3/2022', 5, 8, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/2/2022', '1/2/2022', 5, 9, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/2/2022', '1/2/2022', 5, 10, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/2/2022', '1/2/2022', 6, 1, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/2/2022', '1/2/2022', 6, 2, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/2/2022', '1/2/2022', 6, 3, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/2/2022', '1/2/2022', 6, 4, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/2/2022', '1/2/2022', 6, 5, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/2/2022', '1/2/2022', 6, 6, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/3/2022', '1/3/2022', 6, 7, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/3/2022', '1/3/2022', 6, 8, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/3/2022', '1/3/2022', 6, 9, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/3/2022', '1/3/2022', 6, 10, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/4/2022', '1/4/2022', 5, 1, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/4/2022', '1/4/2022', 5, 2, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/5/2022', null, 5, 3, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/5/2022', null, 5, 4, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/6/2022', '1/6/2022', 5, 5, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/7/2022', '1/7/2022', 5, 6, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/8/2022', '1/8/2022', 5, 7, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/8/2022', '1/8/2022', 5, 8, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/9/2022', '1/9/2022', 5, 9, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/9/2022', '1/10/2022', 5, 10, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/11/2022', '1/11/2022', 6, 1, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/12/2022', '1/12/2022', 6, 2, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/13/2022', '1/13/2022', 6, 3, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/14/2022', '1/14/2022', 6, 4, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/15/2022', '1/15/2022', 6, 5, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/16/2022', '1/16/2022', 6, 6, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/17/2022', '1/17/2022', 6, 7, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/18/2022', '1/18/2022', 6, 8, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/19/2022', '1/19/2022', 6, 9, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/20/2022', '1/20/2022', 6, 10, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/21/2022', '1/21/2022', 6, 1, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/22/2022', '1/22/2022', 6, 2, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/23/2022', '1/23/2022', 5, 3, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/24/2022', '1/24/2022', 5, 4, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/25/2022', '1/25/2022', 5, 5, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/26/2022', '1/26/2022', 6, 6, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/27/2022', '1/27/2022', 6, 7, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/28/2022', '1/28/2022', 5, 8, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/29/2022', '1/29/2022', 5, 9, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/30/2022', '1/30/2022', 6, 10, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('1/31/2022', '1/31/2022', 6, 1, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('2/1/2022', '2/1/2022', 6, 2, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('2/2/2022', '2/2/2022', 6, 3, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('2/3/2022', '2/3/2022', 6, 4, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('2/3/2022', '2/3/2022', 6, 5, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('2/3/2022', '2/3/2022', 6, 6, 1);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('3/3/2022', '3/3/2022', 6, 1, 0);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('3/3/2022', '3/3/2022', 6, 2, 0);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('3/3/2022', '3/3/2022', 6, 3, 0);
INSERT INTO HOADON(NgayDat, NgayGiao, MaNV,  MaBan, TrangThai)
VALUES('3/3/2022', '3/3/2022', 6, 4, 0);
select * from HOADON;
--------------
-- 8. Bảng CHI TIẾT HÓA ĐƠN
-- Con C(1,5), CF(1,6), J(1,7), SM(1,6), T(1,10)
SET IDENTITY_INSERT CHITIETHD ON; 
INSERT INTO CHITIETHD(MaHD, MaMon, SoLuong)
VALUES(1,'C001',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(1, 'CF003',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(2, 'SM001',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(3, 'C001', 1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(4, 'T003',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(5, 'SM003',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(5, 'C003',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(6, 'C005',3);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(7, 'C003',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(8, 'J006',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(8, 'C004',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(9, 'T005',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(9, 'T003',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(9, 'SM004',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(10, 'T004',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(11, 'T007',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(12, 'C001',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(13, 'J002',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(14, 'J001',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(14, 'J005',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(15, 'J005',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(16, 'CF005',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(17, 'CF001',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(18, 'C005',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(19, 'C004',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(20, 'SM001',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(20, 'SM005',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(21, 'SM004',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(21, 'SM001',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(21, 'T008',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(22, 'SM001',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(23, 'T005',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(24, 'T006',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(24, 'T002',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(25, 'SM002',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(26, 'SM002',5);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(27, 'C001',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(28, 'T003',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(29, 'CF001',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(29, 'CF002',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(30, 'C004',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(30, 'C002',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(30, 'J006',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(30, 'T001',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(31, 'J005',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(32, 'C001',3);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(33, 'T006',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(34, 'CF006',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(35, 'T005',4);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(36, 'T002',6);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(37, 'T007',3);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(38, 'T004',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(39, 'T003',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(40, 'SM001',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(41, 'T001',5);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(41, 'SM006',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(42, 'SM002',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(43, 'T006',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(44, 'T004',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(44, 'C001',3);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(44, 'SM005',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(45, 'SM002',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(46, 'T003',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(46, 'T002',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(47, 'T006',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(48, 'T003',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(49, 'J004',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(49, 'T010',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(50, 'CF004',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(50, 'CF001',3);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(51, 'CF006',3);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(51, 'C002',3);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(51, 'SM002',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(51, 'SM001',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(52, 'CF002',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(52, 'CF001',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(52, 'CF003',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(52, 'CF005',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(53, 'CF005',3);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(53, 'SM001',3);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(53, 'SM002',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(54, 'T007',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(54, 'T004',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(54, 'C005',3);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(54, 'CF005',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(55, 'T008',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(55, 'C002',4);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(55, 'C003',5);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(55, 'C001',5);
INSERT INTO CHITIETHD(MaHD, MaMon,   SoLuong)
VALUES(56, 'T006',2);
INSERT INTO CHITIETHD(MaHD, MaMon,   SoLuong)
VALUES(56, 'T002',2);
INSERT INTO CHITIETHD(MaHD, MaMon,   SoLuong)
VALUES(56, 'T010',2);
INSERT INTO CHITIETHD(MaHD, MaMon,   SoLuong)
VALUES(56, 'T001',2);
INSERT INTO CHITIETHD(MaHD, MaMon,   SoLuong)
VALUES(56, 'C004',6);
INSERT INTO CHITIETHD(MaHD, MaMon,   SoLuong)
VALUES(57, 'C004',3);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(58, 'CF005',5);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(59, 'T001',4);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(60, 'SM001',5);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(57, 'C001', 3);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(58, 'CF003', 4);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(59, 'SM001', 5);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(60, 'T005',6);
SET IDENTITY_INSERT CHITIETHD OFF; 
Select * from CHITIETHD;

-- 10. bảng NGUYÊN LIỆU 
INSERT INTO NGUYENLIEU(MaNL, TenNL, SoLuong, DonViTinh, MaNCC) VALUES('NL001', N'Bột cà phê', 100, N'Gói', 1);
INSERT INTO NGUYENLIEU(MaNL, TenNL, SoLuong, DonViTinh, MaNCC) VALUES('NL002', N'Đường', 100, N'Gói', 4);
INSERT INTO NGUYENLIEU(MaNL, TenNL, SoLuong, DonViTinh, MaNCC) VALUES('NL003', N'Bột sữa', 100, N'Gói', 2);
INSERT INTO NGUYENLIEU(MaNL, TenNL, SoLuong, DonViTinh, MaNCC) VALUES('NL004', N'Kem', 100, N'Hộp', 3);
INSERT INTO NGUYENLIEU(MaNL, TenNL, SoLuong, DonViTinh, MaNCC) VALUES('NL005', N'Dâu', 100, N'Quả', 6);
INSERT INTO NGUYENLIEU(MaNL, TenNL, SoLuong, DonViTinh, MaNCC) VALUES('NL006', N'Dưa hấu', 50, N'Quả', 6);
INSERT INTO NGUYENLIEU(MaNL, TenNL, SoLuong, DonViTinh, MaNCC) VALUES('NL007', N'Kiwi', 90, N'Quả', 6);
INSERT INTO NGUYENLIEU(MaNL, TenNL, SoLuong, DonViTinh, MaNCC) VALUES('NL008', N'Nho', 50, N'Quả', 6);
INSERT INTO NGUYENLIEU(MaNL, TenNL, SoLuong, DonViTinh, MaNCC) VALUES('NL009', N'Cam', 80, N'Quả', 6);
INSERT INTO NGUYENLIEU(MaNL, TenNL, SoLuong, DonViTinh, MaNCC) VALUES('NL010', N'Cà rốt', 70, N'Quả', 6);
INSERT INTO NGUYENLIEU(MaNL, TenNL, SoLuong, DonViTinh, MaNCC) VALUES('NL011', N'Dưa chuột', 40, N'Quả', 6);
INSERT INTO NGUYENLIEU(MaNL, TenNL, SoLuong, DonViTinh, MaNCC) VALUES('NL012', N'Cà chua', 50, N'Quả', 6);
INSERT INTO NGUYENLIEU(MaNL, TenNL, SoLuong, DonViTinh, MaNCC) VALUES('NL013', N'Trứng', 200, N'Quả', 6);
INSERT INTO NGUYENLIEU(MaNL, TenNL, SoLuong, DonViTinh, MaNCC) VALUES('NL014', N'Bột mỳ', 30, N'Túi', 2);
INSERT INTO NGUYENLIEU(MaNL, TenNL, SoLuong, DonViTinh, MaNCC) VALUES('NL015', N'Socola', 40, N'Gói', 5);
INSERT INTO NGUYENLIEU(MaNL, TenNL, SoLuong, DonViTinh, MaNCC) VALUES('NL016', N'Phô mai', 60, N'Hộp', 5);
INSERT INTO NGUYENLIEU(MaNL, TenNL, SoLuong, DonViTinh, MaNCC) VALUES('NL017', N'Đào', 40, N'Quả', 6);
INSERT INTO NGUYENLIEU(MaNL, TenNL, SoLuong, DonViTinh, MaNCC) VALUES('NL018', N'Mật ong', 10, N'Hộp', 3);
INSERT INTO NGUYENLIEU(MaNL, TenNL, SoLuong, DonViTinh, MaNCC) VALUES('NL019', N'Bí đao', 10, N'Quả', 6);
INSERT INTO NGUYENLIEU(MaNL, TenNL, SoLuong, DonViTinh, MaNCC) VALUES('NL029', N'Nha đam', 10, N'Quả', 6);
INSERT INTO NGUYENLIEU(MaNL, TenNL, SoLuong, DonViTinh, MaNCC) VALUES('NL030', N'Bột ca cao', 100, N'Gói', 1);
select * from NGUYENLIEU;
-- 11. bảng CÔNG THỨC (đây là công thức pha chế một tách cà phê thông thường nhé)
INSERT INTO CONGTHUC(MaMon, MaNL, HamLuong, DonVi) VALUES('CF001', 'NL030', 5, 'g');
INSERT INTO CONGTHUC(MaMon, MaNL, HamLuong, DonVi) VALUES('CF001', 'NL001', 14, 'g');
INSERT INTO CONGTHUC(MaMon, MaNL, HamLuong, DonVi) VALUES('CF001', 'NL003', 5, 'ml');
INSERT INTO CONGTHUC(MaMon, MaNL, HamLuong, DonVi) VALUES('CF002', 'NL001', 15, 'g');
INSERT INTO CONGTHUC(MaMon, MaNL, HamLuong, DonVi) VALUES('CF002', 'NL002', 10, 'g');
INSERT INTO CONGTHUC(MaMon, MaNL, HamLuong, DonVi) VALUES('CF002', 'NL003', 80, 'ml');
INSERT INTO CONGTHUC(MaMon, MaNL, HamLuong, DonVi) VALUES('CF003', 'NL001', 30, 'g');
INSERT INTO CONGTHUC(MaMon, MaNL, HamLuong, DonVi) VALUES('CF003', 'NL002', 10, 'g');
INSERT INTO CONGTHUC(MaMon, MaNL, HamLuong, DonVi) VALUES('CF003', 'NL003', 30, 'g');
INSERT INTO CONGTHUC(MaMon, MaNL, HamLuong, DonVi) VALUES('CF004', 'NL001', 30, 'g');
INSERT INTO CONGTHUC(MaMon, MaNL, HamLuong, DonVi) VALUES('CF004', 'NL002', 15, 'g');
INSERT INTO CONGTHUC(MaMon, MaNL, HamLuong, DonVi) VALUES('CF004', 'NL015', 30, 'g');
INSERT INTO CONGTHUC(MaMon, MaNL, HamLuong, DonVi) VALUES('CF004', 'NL030', 20, 'g');
INSERT INTO CONGTHUC(MaMon, MaNL, HamLuong, DonVi) VALUES('CF005', 'NL001', 30, 'g');
INSERT INTO CONGTHUC(MaMon, MaNL, HamLuong, DonVi) VALUES('CF006', 'NL001', 10, 'g');
INSERT INTO CONGTHUC(MaMon, MaNL, HamLuong, DonVi) VALUES('CF006', 'NL002', 10, 'g');
select * from CONGTHUC;
select * from MON;
-- 12. bảng CHẤM CÔNG
INSERT INTO CHAMCONG(MaNV, NgayChamCong, SoCa) VALUES(7, GETDATE(), 3);
select * from CHAMCONG;

--Thủ tục lấy thông tin bàn
CREATE PROC USP_GetTableList
AS SELECT * FROM BAN
GO

EXEC dbo.USP_GetTableList;

-- SQL kết hợp để hiển thị lên ListBill
Select TenMon, SoLuong, Gia, SoLuong*Gia as ThanhTien
from HOADON hd, CHITIETHD ct, Mon m
where hd.MaHD = ct.MaHD
and ct.MaMon = m.MaMon
and TrangThai = 0
and MaBan = 4

-- Tạo thủ tục INSERT vào bảng HÓA ĐƠN tự động 
CREATE PROC USP_InsertBill(@idTable INT)
AS 
BEGIN
	INSERT INTO HOADON(NgayDat, NgayGiao, MaNV, MaBan, TrangThai, GiamGia)
	VALUES(GETDATE(), null, 6, @idTable, 0, 0);
END;

-- Tạo thủ tục thêm vào bảng CHI TIẾT HÓA ĐƠN tự động
CREATE PROC USP_InsertBillInfo
(@idBill int, @idFood nvarchar(20), @count int) --khai bao 3 bien: MaHD, MaMon, SoLuong
AS
BEGIN
	 DECLARE @isExitBillInfo int; --Kiem tra trong ban chitiethd
	 DECLARE @foodCount int = 1 --So luong mon trong numeric updown

	 --Lay ra thong tin CHITIETHD voi MaHD duoc truyen vao
	 SELECT @isExitBillInfo = MaHD, @foodCount = SoLuong
	 FROM CHITIETHD
	 WHERE MaHD = @idBill AND MaMon = @idFood

	 -- Neu co ton tai @isExitBillInfo > 0 thi ta se:
	 IF(@isExitBillInfo > 0)
		BEGIN
			DECLARE @newCount INT = @foodCount + @count
			IF(@newCount > 0)
				UPDATE CHITIETHD SET SoLuong = @foodCount + @count WHERE MaMon = @idFood AND MaHD = @idBill;
			ELSE
				DELETE CHITIETHD WHERE MaHD = @idBill and MaMon = @idFood
		END;
	 ELSE
		BEGIN
			SET IDENTITY_INSERT CHITIETHD ON;
			INSERT INTO CHITIETHD(MaHD, MaMon, SoLuong)
			VALUES(@idBill, @idFood, @count);
			SET IDENTITY_INSERT CHITIETHD OFF;
		END;
END;


-- Tạo trigger khi thêm món vào hóa đơn thì đổi trạng thái của bàn thành đang sử dụng
CREATE TRIGGER UTG_UpdateBillInfo
ON CHITIETHD FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @idBill INT
	
	SELECT @idBill = MaHD FROM Inserted
	
	DECLARE @idTable INT
	
	SELECT @idTable = MaBan FROM HOADON WHERE MaHD = @idBill AND TrangThai = 0
	
	UPDATE BAN SET TrangThai = 'Dang su dung' WHERE MaBan = @idTable
END

-- Tạo trigger tự động cập nhật HÓA ĐƠN đã thanh toán
CREATE TRIGGER UTG_UpdateBill
ON HOADON FOR UPDATE
AS
BEGIN
	DECLARE @idBill INT
	
	SELECT @idBill = MaHD FROM Inserted	
	
	DECLARE @idTable INT
	
	SELECT @idTable = MaBan FROM HOADON WHERE MaHD = @idBill
	
	DECLARE @count int = 0
	
	SELECT @count = COUNT(*) FROM HOADON WHERE MaBan = @idTable AND TrangThai = 0
	
	IF (@count = 0)
		UPDATE BAN SET TrangThai = 'Trong' WHERE MaBan = @idTable
END

-- Tạo trigger để CHUYỂN BÀN 
CREATE PROC USP_SwitchTable
@TableID1 INT, @TableID2 INT
AS
BEGIN
	DECLARE @isTable1Null INT = 0
	DECLARE @isTable2Null INT = 0
	SELECT @isTable1Null = MaHD FROM HOADON WHERE MaBan = @TableID1 AND TrangThai = 0
	SELECT @isTable2Null = MaHD FROM HOADON  WHERE MaBan = @TableID2 AND TrangThai = 0

	IF (@isTable1Null = 0 AND @isTable2Null > 0)
		BEGIN
			UPDATE HOADON SET MaBan = @TableID1 WHERE MaHD = @isTable2Null
			UPDATE BAN SET TrangThai = 'Dang su dung' WHERE MaBan = @TableID1
			UPDATE BAN SET TrangThai = 'Trong' WHERE MaBan = @TableID2
        END
	ELSE IF (@isTable1Null > 0 AND @isTable2Null = 0)
		BEGIN
			UPDATE HOADON SET MaBan = @TableID2 WHERE TrangThai = 0 AND MaHD = @isTable1Null
			UPDATE BAN SET TrangThai = 'Dang su dung' WHERE MaBan = @TableID2
			UPDATE BAN SET TrangThai = 'Trong' WHERE MaBan = @TableID1
        END
    ELSE IF (@isTable1Null > 0 AND @isTable2Null > 0)
		BEGIN
			UPDATE HOADON SET MaBan = @TableID2 WHERE MaHD = @isTable1Null
			UPDATE HOADON SET MaBan = @TableID1 WHERE MaHD = @isTable2Null
        END
END

-- Tạo thủ tục đưa ra danh sách hóa đơn và tổng tiền của hóa đơn theo ngày truyền vào 
CREATE PROC USP_GetListBillByDate
@checkIn date, @checkOut date
AS 
BEGIN
	select TenBan, NgayDat, NgayGiao, GiamGia, TongTien from HOADON hd , BAN b
	where NgayDat >= @checkIn AND NgayGiao <= @checkOut AND hd.TrangThai = 1
	and hd.MaBan = b.MaBan;
END;

-- Thêm cột TongTien cho HoaDon
ALTER TABLE HOADON ADD TongTien FLOAT DEFAULT 0;

-- Câu lệnh truy xuất ra công thức của một món
select TenNL, HamLuong, DonVi from nguyenlieu nl, CONGTHUC ct  where nl.MaNL = ct.MaNL and Mamon = 'CF001';

select TenBan, NgayDat, NgayGiao, GiamGia, TongTien from HOADON hd , BAN b
where NgayDat >= '20220302' AND NgayGiao <= '20220605' AND hd.TrangThai = 1
and hd.MaBan = b.MaBan;

-- Câu lệnh cập nhật giá cho các hóa đơn
UPDATE HOADON
SET HOADON.TongTien = B.ThanhTien
FROM (Select MaHD, sum(SoLuong * Gia) as ThanhTien from CHITIETHD ct, MON m where ct.MaMon = m.MaMon group by MaHD) B
where HOADON.MaHD = B.MaHD;

-- Tổng doanh thu của cửa hàng theo khoảng thời gian (từ ngày A đến ngày B)
Select sum(TongTien) as DOANHTHU from HOADON where NgayDat >= '20220302' AND NgayGiao <= '20220605'

-- Tổng doanh thu theo tháng
Select MONTH(NgayGiao) as [Tháng], sum(TongTien) as DoanhThu from HOADON group by MONTH(NgayGiao)

-- Table ThongTinHD
SELECT a.MaHD, a.NgayDat, a.Maban, b.TenNV, GiamGia, TongTien*(100-GiamGia) as ThanhTien
FROM HOADON AS a, Nhanvien AS b
WHERE a.MaHD = 67
AND a.MaNV = b.MaNV

-- Table ThongtinMon
select TenMon, SoLuong, Gia, (SoLuong*Gia) as ThanhTien from chitiethd ct, mon m
where ct.MaMon = m.MaMon
and MaHD = 66;

select * from hoadon;