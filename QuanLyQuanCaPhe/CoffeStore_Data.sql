CREATE TABLE TAIKHOAN
(
	TenDangNhap  VARCHAR(100) PRIMARY KEY,
	MatKhau VARCHAR(100) NOT NULL DEFAULT 0, 
	TenNguoiDung NVARCHAR(100) NOT NULL DEFAULT 'user',
	LoaiTaiKhoan INT NOT NULL DEFAULT 0 --0.Nhan vien --1.Quan ly
);

CREATE TABLE LOAIMON 
(
	MaLoaiMon NVARCHAR(20) PRIMARY KEY,
	TenLoaiMon NVARCHAR(50) NOT NULL
);

CREATE TABLE NHACUNGCAP
(
	MaNCC INT IDENTITY PRIMARY KEY,
	TenNCC NVARCHAR(50) NOT NULL,
	DiaChi NVARCHAR(100) NOT NULL,
	SDT VARCHAR(30) NULL
);

CREATE TABLE BAN 
(
	MaBan INT IDENTITY PRIMARY KEY,
	TenBan NVARCHAR(50) NOT NULL,
	TrangThai NVARCHAR(50) NOT NULL DEFAULT N'Trong',	
);

CREATE TABLE MON 
(
	MaMon NVARCHAR(20) PRIMARY KEY,
	TenMon NVARCHAR(50) NOT NULL,
	Gia  DECIMAL (10, 2)  NOT NULL,
	MaLoaiMon NVARCHAR(20) NOT NULL,
	CONSTRAINT fk_mon_loaimon FOREIGN KEY (MaLoaiMon) REFERENCES LOAIMON(MaLoaiMon)
);

CREATE TABLE NHANVIEN
(
	MaNV INT IDENTITY PRIMARY KEY,
	TenNV NVARCHAR(50) NOT NULL,
	NgaySinh DATE NULL,
	DiaChi NVARCHAR(50) NOT NULL,
	SDT VARCHAR(30),
	HoatDong tinyint NOT NULL,
	BoPhan NVARCHAR(30),
	Luong  DECIMAL (10, 2) 
);


CREATE TABLE HOADON
(
	MaHD INT IDENTITY PRIMARY KEY,
	NgayDat date,
	NgayGiao date,
	MaNV INT  NOT NULL,
	MaBan INT NULL,
	TrangThai TINYINT NOT NULL DEFAULT 1, --1 da thanh toan - 0 chua thanh toan
	CONSTRAINT fk_hoadon_nhanvien FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV),
	CONSTRAINT fk_hoadon_ban FOREIGN KEY (MaBan) REFERENCES BAN(MaBan)
);

CREATE TABLE CHITIETHD
(
	MaHD INT IDENTITY,
	MaMon NVARCHAR(20) NOT NULL,
	SoLuong INT NOT NULL DEFAULT 0,
	CONSTRAINT pk_cthd PRIMARY KEY (MaHD, MaMon),
	CONSTRAINT fk_cthd_mon FOREIGN KEY (MaHD) REFERENCES HOADON(MaHD),
	CONSTRAINT fk_cthd_hd FOREIGN KEY (MaMon) REFERENCES MON(MaMon)
);

CREATE TABLE HANGHOA
(
	MaHH INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	TenHH NVARCHAR(50) NOT NULL,
    DonVi NVARCHAR(20) NOT NULL,
	MoTa NVARCHAR(100) NULL,
	MaNCC INT NOT NULL,
	CONSTRAINT fk_hanghoa_ncc FOREIGN KEY (MaNCC) REFERENCES NHACUNGCAP(MaNCC)
);

CREATE TABLE DONNHAPHANG
(
	MaDNH INT IDENTITY PRIMARY KEY,
	TenDNH NVARCHAR(100) NOT NULL,
	TrangThai NVARCHAR(50) NOT NULL,
	PhuongThucVanChuyen NVARCHAR(50) NOT NULL,
	NgayDatHang DATE, 
	NgayGiaoHang DATE,
    NgayThanhToan DATE,
	GhiChu NVARCHAR(100) NULL,
    ChietKhau DECIMAL (4, 2) NOT NULL DEFAULT 0,
	MaNV INT NOT NULL,
	CONSTRAINT fk_dnh_nv FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
);

CREATE TABLE CHITIETHOADONNHAP
(
	MaDNH INT IDENTITY,
	MaHH INT NOT NULL,
	CONSTRAINT pk_cthdnhap PRIMARY KEY (MaDNH, MaHH),
	DonGia DECIMAL (10, 2) NOT NULL,
	SoLuongNhap INT NOT NULL,
	CONSTRAINT fk_cthdnhap_donnhaphang FOREIGN KEY (MaDNH) REFERENCES DONNHAPHANG(MaDNH),
	CONSTRAINT fk_cthdnhap_hanghoa FOREIGN KEY (MaHH) REFERENCES HANGHOA(MaHH)
);


-- Insert data for all tables
-- Table TAIKHOAN
INSERT INTO TAIKHOAN(TenDangNhap, MatKhau, TenNguoiDung, LoaiTaiKhoan)
VALUES('quanly', '1', 'QUAN LY DEP TRAI', 1);
INSERT INTO TAIKHOAN(TenDangNhap, MatKhau, TenNguoiDung, LoaiTaiKhoan)
VALUES('nhanvien', '1', 'NHAN VIEN XINH GAI', 0);
select * from TAIKHOAN;

-- Table LOAIMON
INSERT INTO LOAIMON(maloaimon, tenloaimon)
VALUES('coffee', 'Ca phe');
INSERT INTO LOAIMON(maloaimon, tenloaimon)
VALUES('juice', 'Nuoc ep');
INSERT INTO LOAIMON(maloaimon, tenloaimon)
VALUES('smoothie', 'Sinh to');
INSERT INTO LOAIMON(maloaimon, tenloaimon)
VALUES('tea', 'Tra');
INSERT INTO LOAIMON(maloaimon, tenloaimon)
VALUES('milktea', 'Tra sua');
INSERT INTO LOAIMON(maloaimon, tenloaimon)
VALUES('soda', 'Nuoc soda');
INSERT INTO LOAIMON(maloaimon, tenloaimon)
VALUES('yogurt','Sua chua');
INSERT INTO LOAIMON(maloaimon, tenloaimon)
VALUES('chocolate', 'So co la');
INSERT INTO LOAIMON(maloaimon, tenloaimon)
VALUES('cake', 'Banh ngot');
INSERT INTO LOAIMON(maloaimon, tenloaimon)
VALUES('cream', 'Kem');
select * from loaimon;
-- Table NHACUNGCAP
--SET IDENTITY_INSERT NHACUNGCAP ON;
INSERT INTO NHACUNGCAP(TenNCC, DiaChi, sdt)
VALUES('Cong Ty TNHH Ca Phe Ngon', '23 Ngo Quyen, Thang Loi, Buon Ma Thuat, Dak Lak','02623950787');
INSERT INTO NHACUNGCAP(TenNCC, DiaChi, sdt)
VALUES('Cong Ty TNHH Nestle Viet Nam', '138-142 Hai Ba Trung, Da Kao, Q1 , Ho Chi Minh','02839113737');
INSERT INTO NHACUNGCAP(TenNCC, DiaChi, sdt)
VALUES('Cong Ty TNHH Tam Chau', N'284 Ton Duc Thang, Hang Bot, Dong Da, Ha Noi','02437916555');
INSERT INTO NHACUNGCAP(TenNCC, DiaChi, sdt)
VALUES('Cong Ty TNHH Thuong mai và Thuc pham Sao Viet', '2/77 Tran Nguyen Dan, Hoang Mai, Ha Noi','02432323658');
INSERT INTO NHACUNGCAP(TenNCC, DiaChi, sdt)
VALUES('Cong Ty CP San xuat va Thuong mai Tomato Viet Nam', '33 BT3, Khu do thi Van Phu, Ha Dong, Ha Noi','0968018334');
INSERT INTO NHACUNGCAP(TenNCC, DiaChi, sdt)
VALUES('Cong Ty nhap khau trai cay Homefarm', '282 Hoang Van Thai, Thanh Xuan, Ha Noi','02471081008');
select * from nhacungcap;
--SET IDENTITY_INSERT NHACUNGCAP OFF;

-- Bang BAN
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
-- Table MON
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('CF001','Capuchino', 50000, 'coffee');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('CF002','Expresso', 50000, 'coffee');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('CF003','Bac xiu', 40000, 'coffee');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('CF004','Mocha Macchiato', 50000, 'coffee');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('CF005','Den da', 35000, 'coffee');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('CF006','Americano', 50000, 'coffee');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('J001','Nuoc ep tao', 40000, 'juice');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('J002','Nuoc ep dua hau', 40000, 'juice');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('J003','Nuoc ep nho', 40000, 'juice');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('J004','Nuoc ep cam', 40000, 'juice');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('J005','Nuoc ep dua leo', 40000, 'juice');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('J006','Nuoc ep kiwi', 40000, 'juice');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('J007','Nuoc ep dau', 40000, 'juice');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('SM001','Sinh to ca chua', 40000, 'smoothie');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('SM002','Sinh to dua hau', 40000, 'smoothie');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('SM003','Sinh to thom', 40000, 'smoothie');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('SM004','Sinh to ca rot', 40000, 'smoothie');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('SM005','Sinh to ca chua', 40000, 'smoothie');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('SM006','Sinh to thap cam', 50000, 'smoothie');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('T001','Tra dao', 40000, 'tea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('T002','Tra dau', 40000, 'tea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('T003','Tra xanh', 30000, 'tea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('T004','Tra hoa lai', 40000, 'tea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('T005','Tra hoa hong', 40000, 'tea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('T006','Tra gung mat ong', 40000, 'tea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('T007','Tra matcha sua', 55000, 'tea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('T008','Tra tac', 30000, 'tea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('T009','Tra bi dao', 30000, 'tea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('MT001','Hong tra sua', 40000, 'milktea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('MT002','Tra sua Panda', 40000, 'milktea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('MT003','Tra sua Hokkaidou', 45000, 'milktea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('MT004','Tra sua bac ha', 40000, 'milktea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('MT005','Tra sua dau tay', 40000, 'milktea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('MT006','Tra sua o long', 40000, 'milktea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('MT007','Tra sua vanilla', 40000, 'milktea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('MT008','Tra sua dau do', 45000, 'milktea');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('SD001','Soda chanh duong', 30000, 'soda');
INSERT INTO MON(mamon, tenmon, gia,  maloaimon)
VALUES('SD002','Soda viet quat', 30000, 'soda');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('SD003','Soda kiwi dau', 30000, 'soda');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('SD004','Soda chanh bac ha', 30000, 'soda');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('SD005','Soda phuc bon tu', 30000, 'soda');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('SD006','Soda nhiet doi', 30000, 'soda');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('YG001','Sua chua chan trau duong den', 25000,'yogurt');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('YG002','Sua chua mit', 25000, 'yogurt');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('YG003','Sua chua dau', 24000, 'yogurt');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('YG004','Sua chua nho', 23000, 'yogurt');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('YG005','Sua chua nha dam', 27000, 'yogurt');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('SC001','So co la nong', 30000, 'chocolate');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('C001','Banh toffee', 80000, 'cake');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('C002','Banh kem pho mai', 69000, 'cake');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('C003','Banh so co la', 59000, 'cake');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('C004','Banh kem dau tay', 63000, 'cake');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('C005','Banh bong lan trung muoi', 57000,'cake');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('CR001','Kem dau tay', 32000, 'cream');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('CR002','Kem so co la', 19000, 'cream');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('CR003','Kem vanilla', 18000, 'cream');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('CR004','Kem sua dua', 15000, 'cream');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('CR005','Kem me den', 29000, 'cream');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('CR006','Kem thap cam', 50000, 'cream');
INSERT INTO MON(mamon, tenmon, gia, maloaimon)
VALUES('CR007','Kem matcha', 31000, 'cream');
select * from MON;

-- Table NHANVIEN
INSERT INTO NHANVIEN( tennv, ngaysinh, diachi, sdt, hoatdong,  bophan,luong)
VALUES('Nguyen Hoai Thu Trang', '1998/2/5', 'Ha Dong, Ha Noi', '0932464213', 1, 'Phuc vu',  4000000);
INSERT INTO NHANVIEN( tennv, ngaysinh, diachi, sdt, hoatdong,  bophan, luong)
VALUES('Truong Thi Thu Thuy', '1998/4/13', 'Cau Giay, Ha Noi', '0964521332', 1, 'Phuc vu', 4000000);
INSERT INTO NHANVIEN( tennv, ngaysinh, diachi, sdt, hoatdong,  bophan, luong)
VALUES('Nguyen Tung Lam', '2000/7/13', 'Hoai Duc, Ha Noi', '0967884223', 1, 'Pha che', 5000000);
INSERT INTO NHANVIEN( tennv, ngaysinh, diachi, sdt, hoatdong,  bophan, luong)
VALUES('Ha Minh Duc', '1997/12/8', 'Cam Pha, Quang Ninh', '0987632436', 1, 'Pha che', 5000000);
INSERT INTO NHANVIEN( tennv, ngaysinh, diachi, sdt, hoatdong,  bophan, luong)
VALUES('Le Hong Anh', '1996/6/19', 'Van Giang, Hung Yen', '0998743215', 1, 'Thu ngân', 6000000);
INSERT INTO NHANVIEN( tennv, ngaysinh, diachi, sdt, hoatdong,  bophan, luong)
VALUES('Tran Thi Thu Phuong', '1996/8/11', 'Thanh Xuan, Ha Noi', '0946342223', 1, 'Thu ngan', 6000000);
INSERT INTO NHANVIEN( tennv, ngaysinh, diachi, sdt, hoatdong,  bophan, luong)
VALUES('Le Ngoc Huyen', '1994/4/17', 'Hoan Kiem, Ha Noi', '0971552222', 1, 'Quan li', 10000000);
INSERT INTO NHANVIEN( tennv, ngaysinh, diachi, sdt, hoatdong,  bophan, luong)
VALUES('Nguyen Huu Da', '1978/9/18', 'Thanh Tri, Ha Noi', '0368836588', 1, 'Bao ve', 5000000);

-- Table HOADON
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

-- table CHITIETHD
SET IDENTITY_INSERT CHITIETHD ON; 

INSERT INTO CHITIETHD(MaHD, MaMon, SoLuong)
VALUES(1,'C001',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(1, 'CF003',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(2, 'SM001',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(3, 'YG001',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(3, 'CR005', 1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(4, 'YG003',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(5, 'SD003',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(5, 'C003',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(6, 'CF006',3);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(7, 'CF006',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(8, 'J006',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(8, 'CR006',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(9, 'MT005',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(9, 'MT003',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(9, 'SD004',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(10, 'MT004',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(11, 'MT007',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(12, 'C001',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(13, 'J002',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(14, 'J001',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(14, 'J005',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(15, 'CR005',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(16, 'CF005',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(17, 'CF001',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(18, 'C005',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(19, 'C004',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(20, 'SD001',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(20, 'SD005',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(21, 'SM004',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(21, 'SM001',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(21, 'T008',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(22, 'SM001',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(23, 'YG005',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(24, 'T006',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(24, 'T002',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(25, 'SM002',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(26, 'SD002',5);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(27, 'SC001',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(28, 'MT003',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(29, 'CF001',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(29, 'CF002',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(30, 'CR004',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(30, 'CR002',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(30, 'J006',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(30, 'MT001',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(31, 'J005',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(32, 'CR001',3);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(33, 'CF006',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(34, 'CF006',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(35, 'YG005',4);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(36, 'YG002',6);
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
VALUES(44, 'YG001',3);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(44, 'SD005',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(45, 'SM002',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(46, 'MT003',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(46, 'MT002',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(47, 'MT006',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(48, 'CR003',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(49, 'J004',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(49, 'C005',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(50, 'CF004',1);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(50, 'CF001',3);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(51, 'CF006',3);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(51, 'C002',3);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(51, 'SD002',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(51, 'SD001',1);
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
VALUES(55, 'MT008',2);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(55, 'YG001',4);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(55, 'MT003',5);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(55, 'C001',5);
INSERT INTO CHITIETHD(MaHD, MaMon,   SoLuong)
VALUES(56, 'T006',2);
INSERT INTO CHITIETHD(MaHD, MaMon,   SoLuong)
VALUES(56, 'MT002',2);
INSERT INTO CHITIETHD(MaHD, MaMon,   SoLuong)
VALUES(56, 'MT007',2);
INSERT INTO CHITIETHD(MaHD, MaMon,   SoLuong)
VALUES(56, 'MT001',2);
INSERT INTO CHITIETHD(MaHD, MaMon,   SoLuong)
VALUES(56, 'C004',6);
INSERT INTO CHITIETHD(MaHD, MaMon,   SoLuong)
VALUES(57, 'C004',3);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(58, 'CF005',5);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(59, 'YG001',4);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(60, 'SC001',5);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(57, 'C001', 3);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(58, 'CF003', 4);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(59, 'SM001', 5);
INSERT INTO CHITIETHD(MaHD, MaMon,  SoLuong)
VALUES(60, 'CR005',6);

SET IDENTITY_INSERT CHITIETHD OFF; 

Select * from CHITIETHD;

-- table DONNHAPHANG
INSERT INTO DONNHAPHANG(TenDNH, TrangThai, PhuongThucVanChuyen, NgayDatHang, NgayGiaoHang, NgayThanhToan, GhiChu, Chietkhau, MaNV)
VALUES('Don nhap trai cay thang 1/1/2022','Da nhan','Xe tai','1/1/2022','1/3/2022','1/1/2022','Da nhan hang vao 6h30p', 0.1, 1);
INSERT INTO DONNHAPHANG(TenDNH, TrangThai, PhuongThucVanChuyen, NgayDatHang, NgayGiaoHang, NgayThanhToan, GhiChu, Chietkhau, MaNV)
VALUES('Don nhap trai cay thang 2/1/2022','Da nhan','Xe tai','1/2/2022','1/4/2022','1/2/2022','Da nhan hang vao 6h45p', 0.05, 2);
INSERT INTO DONNHAPHANG(TenDNH, TrangThai, PhuongThucVanChuyen, NgayDatHang, NgayGiaoHang, NgayThanhToan, GhiChu, Chietkhau, MaNV)
VALUES('Don nhap ca phe thang 3/1/2022 ','Da nhan','Xe tai','1/3/2022','1/5/2022','1/3/2022','Da nhan hang vao 6h32p',0.04, 4);
INSERT INTO DONNHAPHANG(TenDNH, TrangThai, PhuongThucVanChuyen, NgayDatHang, NgayGiaoHang, NgayThanhToan, GhiChu, Chietkhau, MaNV)
VALUES('Don nhap kem thang 4/1/2022','Da nhan','Xe tai','1/4/2022','1/6/2022','1/6/2022','Da nhan hang vao 6h45p', 0.05, 5);
INSERT INTO DONNHAPHANG(TenDNH, TrangThai, PhuongThucVanChuyen, NgayDatHang, NgayGiaoHang, NgayThanhToan, GhiChu, Chietkhau, MaNV)
VALUES('Don nhap bot lam banh thang 5/1/2022','Da nhan','Xe tai','1/5/2022','1/7/2022','1/5/2022','Da nhan hang vao 6h45p',0.08, 1);
INSERT INTO DONNHAPHANG(TenDNH, TrangThai, PhuongThucVanChuyen, NgayDatHang, NgayGiaoHang, NgayThanhToan, GhiChu, Chietkhau, MaNV)
VALUES('Don nhap huong lieu thang 6/1/2022','Da nhan','Xe tai','1/6/2022','1/8/2022','1/6/2022','Da nhan hang vao 6h45p', 0.04, 3);
INSERT INTO DONNHAPHANG(TenDNH, TrangThai, PhuongThucVanChuyen, NgayDatHang, NgayGiaoHang, NgayThanhToan, GhiChu, Chietkhau, MaNV)
VALUES('Don nhap trai cay thang 7/1/2022','Da nhan','Xe oto','1/7/2022','1/9/2022','1/7/2022','Da nhan hang vao 6h23p', 0.1, 6);
INSERT INTO DONNHAPHANG(TenDNH, TrangThai, PhuongThucVanChuyen, NgayDatHang, NgayGiaoHang, NgayThanhToan, GhiChu, Chietkhau, MaNV)
VALUES('Don nhap dung cu 8/1/2022','Da nhan','Xe tai','1/8/2022','1/10/2022','1/8/2022','Da nhan hang vao 6h00p', 0.1, 5);
INSERT INTO DONNHAPHANG(TenDNH, TrangThai, PhuongThucVanChuyen, NgayDatHang, NgayGiaoHang, NgayThanhToan, GhiChu, Chietkhau, MaNV)
VALUES('Don nhap trai cay thang 9/1/2022','Da nhan','Xe tai','1/9/2022','1/10/2022','1/9/2022','Da nhan hang vao 6h00p',0.1, 2);
INSERT INTO DONNHAPHANG(TenDNH, TrangThai, PhuongThucVanChuyen, NgayDatHang, NgayGiaoHang, NgayThanhToan, GhiChu, Chietkhau, MaNV)
VALUES('Don nhap huong lieu thang 10/1/2022','Da nhan','Xe oto','1/10/2022','1/12/2022','1/10/2022','Da nhan hang vao 6h45p',0.1, 3);

select * from DONNHAPHANG;

-- table HANGHOA
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Bot ca phe','goi', 'Bot ca phe nguyen chat loai 750g', 1);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Bot ca cao','goi', 'Bot ca cao nguyen chat loai 500g', 2);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Bot kem tuoi Onemore vi tao','goi', 'Bot kem tuoi vi tao loai 800g', 5);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Bot kem tuoi Onemore vi viet quat', 'goi','Bot kem tuoi vi viet quat loai 800g', 5);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Bot kem tuoi Onemore vi tra xanh', 'goi','Bot kem tuoi vi tra xanh loai 800g', 5);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Bot kem tuoi Onemore vi tra xanh','goi', 'Bot kem tuoi Onemore vi tra xanh loai 800g', 5);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Tra sua o long Savi', 'tui','Tra sua o long thuong hieu Savi dang tui gia 500000/1kg', 4);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Bot sua Almer', 'tui','Bot sua Almer gia 1500000/25kg', 4);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Sua chua deo Onemore','hop', 'Sua chua deo Onemore hop gia 120000/2kg', 4);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Kem pha che Icehot','hop', 'Kem pha che dang hop gia 800000/800g', 4);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Hersey Syrup Chocolate', 'chai', 'Sot siro Hersey vi socola gia 150000/1.36kg', 4);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Hersey Syrup Strawberry', 'chai', 'Sot siro Hersey vi dau tay gia 150000/1.36kg', 4);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Hersey Syrup Caramel','chai', 'Sot siro Hersey vi Caramel gia 150000/1.36kg', 4);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Noi nau chan chau tu dong', 'noi', 'Noi nau gia 3900000', 4);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Binh u tra sua', 'binh','Binh loai 8 lit gia 400000/binh', 3);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('May dap nap coc','may', 'May dap nap coc tu dong gia 8000000', 4);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('May dao tra', 'may','May dao tra e-Blenders gia 3500000', 4);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Tao Ambrosia Newzealand', 'kg', 'Tao nhap khau Newzealand gia 129000/kg', 6);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Nho ngon tay Uc', 'kg', 'Nho nhap khau Uc gia 199000/kg', 6);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Kiwi vang Newzealand','kg', 'Kiwi nhap khau Newzealand gia 149000/kg', 6);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Nho do khong hat My', 'kg','Nho nhap khau My gia 129000/kg', 6);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Nho den khong hat My', 'kg','Nho nhap khau My gia 99000/kg', 6);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Tao Envy Newzealand ', 'kg','Tao nhap khau Newzealand gia 199000/kg', 6);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Nho xanh khong hat My','kg', 'Nho nhap khau My gia 109000/kg', 6);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Cherry do Canada', 'kg','Cherry nhap khau Canada gia 219000/kg', 6);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Cherry do My', 'kg','Cherry nhap khau My gia 250000/kg', 6);
INSERT INTO HANGHOA(TenHH, DonVi, MoTa, MaNCC)
VALUES('Bot lam banh','kg', 'Bot lam banh 500g gia 100000/kg', 3);
select * from hanghoa;

SET IDENTITY_INSERT CHITIETHOADONNHAP ON;
-- table NHAPHANG
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(1, 18, 129000, 30);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(1, 19, 199000, 20);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(2, 20, 149000, 25);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(2, 21, 129000, 30);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(2, 22, 99000, 25);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(7, 23, 199000, 20);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(7, 24, 109000, 20);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(9, 25, 219000, 25);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(9, 26, 250000, 10);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(3, 1, 70000, 50);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(3, 2, 75000, 40);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(4, 3, 80000, 10);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(4, 4, 80000, 10);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(4, 5, 80000, 10);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(4, 6, 80000, 10);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(5, 27, 100000, 10);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(6, 7, 500000, 5);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(6, 8, 1500000, 2);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(10, 9, 120000, 5);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(10, 10, 800000, 2);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(10, 11, 150000, 5);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(10, 12, 150000, 5);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(10, 13, 150000, 5);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(8, 14, 3900000, 1);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(8, 15, 400000, 3);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(8, 16, 8000000, 1);
INSERT INTO CHITIETHOADONNHAP(MaDNH, MaHH, DonGia, SoLuongNhap)
VALUES(8, 17, 3500000, 1);
SET IDENTITY_INSERT CHITIETHOADONNHAP OFF;
select * from chitiethoadonnhap;

--Thu tuc lay thong tin ra tu ban
CREATE PROC USP_GetTableList
AS SELECT * FROM BAN
GO

EXEC dbo.USP_GetTableList;

-- SQL ket hop de Hien thi len listBill
Select TenMon, SoLuong, Gia, SoLuong*Gia as ThanhTien
from HOADON hd, CHITIETHD ct, Mon m
where hd.MaHD = ct.MaHD
and ct.MaMon = m.MaMon
and TrangThai = 0
and MaBan = 4

-- Tao thu tuc insert vao bang HOADON tu dong
CREATE PROC USP_InsertBill(@idTable INT)
AS 
BEGIN
	INSERT INTO HOADON(NgayDat, NgayGiao, MaNV, MaBan, TrangThai)
	VALUES(GETDATE(), null, 6, @idTable, 0);
END;

-- Tao thu tuc them vao bang CHITIETHD tu dong
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

-- Tao trigger khi them mon vao hoa don thi doi trang thai cua ban thanh dang su dung
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

-- Tao trigger cap nhat hoa don thanh da thanh toan
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

--- Test 
drop PROC USP_InsertBillInfo


SELECT MAX(MaHD) FROM HOADON

select * from HOADON;

select * from chitiethd a, HOADON b where a.MaHD = b.MaHD;

select * from loaimon;

select * from MON where MaLoaiMon = 'cake';

UPDATE CHITIETHD SET SoLuong = @foodCount + @count WHERE MaMon = @idFood;

SELECT MaHD, NgayDat, NgayGiao FROM HOADON WHERE MaBan = 3 and TrangThai = 0;

	SET IDENTITY_INSERT HOADON ON;
	INSERT INTO HOADON(NgayDat, NgayGiao, MaNV, MaBan, TrangThai)
	VALUES(GETDATE(), null, 6, 10, 0);
	SET IDENTITY_INSERT CHITIETHOADONNHAP OFF;