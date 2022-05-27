namespace CoffeeStore
{
    partial class frmMain
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmMain));
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.mnuDanhMuc = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuHoaDon = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuHoaDonNhap = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuBan = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuMon = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuNhanVien = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuNhaCungCap = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuKhachHang = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuLoaiMon = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuThongTinTaiKhoan = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuThongTinCaNhan = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuDangXuat = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuTroGiup = new System.Windows.Forms.ToolStripMenuItem();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.pictureBox2 = new System.Windows.Forms.PictureBox();
            this.mnuThoat = new System.Windows.Forms.ToolStripMenuItem();
            this.quanrToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.menuStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).BeginInit();
            this.SuspendLayout();
            // 
            // menuStrip1
            // 
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mnuDanhMuc,
            this.mnuThongTinTaiKhoan,
            this.mnuTroGiup,
            this.mnuThoat});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(950, 24);
            this.menuStrip1.TabIndex = 0;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // mnuDanhMuc
            // 
            this.mnuDanhMuc.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mnuHoaDon,
            this.mnuHoaDonNhap,
            this.mnuBan,
            this.mnuMon,
            this.mnuNhanVien,
            this.mnuNhaCungCap,
            this.mnuKhachHang,
            this.mnuLoaiMon,
            this.quanrToolStripMenuItem});
            this.mnuDanhMuc.Name = "mnuDanhMuc";
            this.mnuDanhMuc.Size = new System.Drawing.Size(74, 20);
            this.mnuDanhMuc.Text = "Danh mục";
            // 
            // mnuHoaDon
            // 
            this.mnuHoaDon.Name = "mnuHoaDon";
            this.mnuHoaDon.Size = new System.Drawing.Size(222, 22);
            this.mnuHoaDon.Text = "Thông tin hóa đơn xuất";
            this.mnuHoaDon.Click += new System.EventHandler(this.mnuHoaDon_Click);
            // 
            // mnuHoaDonNhap
            // 
            this.mnuHoaDonNhap.Name = "mnuHoaDonNhap";
            this.mnuHoaDonNhap.Size = new System.Drawing.Size(222, 22);
            this.mnuHoaDonNhap.Text = "Quản lý hóa đơn nhập hàng";
            this.mnuHoaDonNhap.Click += new System.EventHandler(this.mnuHoaDonNhap_Click);
            // 
            // mnuBan
            // 
            this.mnuBan.Name = "mnuBan";
            this.mnuBan.Size = new System.Drawing.Size(222, 22);
            this.mnuBan.Text = "Quản lý bàn";
            this.mnuBan.Click += new System.EventHandler(this.mnuBan_Click);
            // 
            // mnuMon
            // 
            this.mnuMon.Name = "mnuMon";
            this.mnuMon.Size = new System.Drawing.Size(222, 22);
            this.mnuMon.Text = "Quản lý món";
            this.mnuMon.Click += new System.EventHandler(this.mnuMon_Click);
            // 
            // mnuNhanVien
            // 
            this.mnuNhanVien.Name = "mnuNhanVien";
            this.mnuNhanVien.Size = new System.Drawing.Size(200, 22);
            this.mnuNhanVien.Text = "Thông tin nhân viên";
            this.mnuNhanVien.Click += new System.EventHandler(this.mnuNhanVien_Click);
            // 
            // mnuNhaCungCap
            // 
            this.mnuNhaCungCap.Name = "mnuNhaCungCap";
            this.mnuNhaCungCap.Size = new System.Drawing.Size(200, 22);
            this.mnuNhaCungCap.Text = "Thông tin nhà cung cấp";
            this.mnuNhaCungCap.Click += new System.EventHandler(this.mnuNhaCungCap_Click);
            // 
            // mnuKhachHang
            // 
            this.mnuKhachHang.Name = "mnuKhachHang";
            this.mnuKhachHang.Size = new System.Drawing.Size(200, 22);
            this.mnuKhachHang.Text = "Thông tin khách hàng";
            this.mnuKhachHang.Click += new System.EventHandler(this.mnuKhachHang_Click);
            // 
            // mnuLoaiMon
            // 
            this.mnuLoaiMon.Name = "mnuLoaiMon";
            this.mnuLoaiMon.Size = new System.Drawing.Size(222, 22);
            this.mnuLoaiMon.Text = "Quản lý loại món";
            this.mnuLoaiMon.Click += new System.EventHandler(this.mnuLoaiMon_Click);
            // 
            // mnuThongTinTaiKhoan
            // 
            this.mnuThongTinTaiKhoan.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mnuThongTinCaNhan,
            this.mnuDangXuat});
            this.mnuThongTinTaiKhoan.Name = "mnuThongTinTaiKhoan";
            this.mnuThongTinTaiKhoan.Size = new System.Drawing.Size(122, 20);
            this.mnuThongTinTaiKhoan.Text = "Thông tin tài khoản";
            // 
            // mnuThongTinCaNhan
            // 
            this.mnuThongTinCaNhan.Name = "mnuThongTinCaNhan";
            this.mnuThongTinCaNhan.Size = new System.Drawing.Size(170, 22);
            this.mnuThongTinCaNhan.Text = "Thông tin cá nhân";
            this.mnuThongTinCaNhan.Click += new System.EventHandler(this.mnuThongTinCaNhan_Click);
            // 
            // mnuDangXuat
            // 
            this.mnuDangXuat.Name = "mnuDangXuat";
            this.mnuDangXuat.Size = new System.Drawing.Size(170, 22);
            this.mnuDangXuat.Text = "Đăng xuất";
            // 
            // mnuTroGiup
            // 
            this.mnuTroGiup.Name = "mnuTroGiup";
            this.mnuTroGiup.Size = new System.Drawing.Size(62, 20);
            this.mnuTroGiup.Text = "Trợ giúp";
            this.mnuTroGiup.Click += new System.EventHandler(this.mnuTroGiup_Click);
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
            this.pictureBox1.Location = new System.Drawing.Point(0, 27);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(472, 549);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pictureBox1.TabIndex = 1;
            this.pictureBox1.TabStop = false;
            // 
            // pictureBox2
            // 
            this.pictureBox2.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox2.Image")));
            this.pictureBox2.Location = new System.Drawing.Point(469, 28);
            this.pictureBox2.Name = "pictureBox2";
            this.pictureBox2.Size = new System.Drawing.Size(481, 548);
            this.pictureBox2.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pictureBox2.TabIndex = 2;
            this.pictureBox2.TabStop = false;
            // 
            // mnuThoat
            // 
            this.mnuThoat.Name = "mnuThoat";
            this.mnuThoat.Size = new System.Drawing.Size(49, 20);
            this.mnuThoat.Text = "Thoát";
            this.mnuThoat.Click += new System.EventHandler(this.mnuThoat_Click);
            // 
            // quanrToolStripMenuItem
            // 
            this.quanrToolStripMenuItem.Name = "quanrToolStripMenuItem";
            this.quanrToolStripMenuItem.Size = new System.Drawing.Size(222, 22);
            this.quanrToolStripMenuItem.Text = "Quản lý hàng hóa";
            // 
            // frmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(950, 571);
            this.Controls.Add(this.pictureBox2);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.menuStrip1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Fixed3D;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MainMenuStrip = this.menuStrip1;
            this.Name = "frmMain";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Quản lý quán cà phê";
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem mnuDanhMuc;
        private System.Windows.Forms.ToolStripMenuItem mnuThongTinTaiKhoan;
        private System.Windows.Forms.ToolStripMenuItem mnuThongTinCaNhan;
        private System.Windows.Forms.ToolStripMenuItem mnuDangXuat;
        private System.Windows.Forms.ToolStripMenuItem mnuHoaDon;
        private System.Windows.Forms.ToolStripMenuItem mnuHoaDonNhap;
        private System.Windows.Forms.ToolStripMenuItem mnuBan;
        private System.Windows.Forms.ToolStripMenuItem mnuMon;
        private System.Windows.Forms.ToolStripMenuItem mnuNhanVien;
        private System.Windows.Forms.ToolStripMenuItem mnuNhaCungCap;
        private System.Windows.Forms.ToolStripMenuItem mnuKhachHang;
        private System.Windows.Forms.ToolStripMenuItem mnuLoaiMon;
        private System.Windows.Forms.ToolStripMenuItem mnuTroGiup;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.PictureBox pictureBox2;
        private System.Windows.Forms.ToolStripMenuItem mnuThoat;
        private System.Windows.Forms.ToolStripMenuItem quanrToolStripMenuItem;
    }
}