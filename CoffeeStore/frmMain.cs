using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CoffeeStore
{
    public partial class frmMain : Form
    {
        public frmMain()
        {
            InitializeComponent();
            DAO.Connect();
        }

        private void mnuThongTinCaNhan_Click(object sender, EventArgs e)
        {
            frmThongTinCaNhan f = new frmThongTinCaNhan();
            f.ShowDialog();
        }

        private void mnuNhanVien_Click(object sender, EventArgs e)
        {
            frmNhanVien f = new frmNhanVien();
            f.ShowDialog();
        }

        private void mnuThoat_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Bạn có thật sự muốn thoát chương trình?", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
            {
                DAO.Disconnect();
                Environment.Exit(0);
            }
        }

        private void mnuMon_Click(object sender, EventArgs e)
        {
            frnMon f = new frnMon();
            f.ShowDialog();
        }

        private void mnuHoaDon_Click(object sender, EventArgs e)
        {
            frmHoaDon f = new frmHoaDon();
            f.ShowDialog();
        }

        private void mnuTroGiup_Click(object sender, EventArgs e)
        {
            frmTroGiup f = new frmTroGiup();
            f.ShowDialog();
        }

        private void mnuKhachHang_Click(object sender, EventArgs e)
        {
            frmKhachHang f = new frmKhachHang();
            f.ShowDialog();
        }

        private void mnuNhaCungCap_Click(object sender, EventArgs e)
        {
            frmNhaCungCap f = new frmNhaCungCap();
            f.ShowDialog();
        }

        private void mnuLoaiMon_Click(object sender, EventArgs e)
        {
            frmLoaiMon f = new frmLoaiMon();
            f.ShowDialog();
        }

        private void mnuBan_Click(object sender, EventArgs e)
        {
            frmBan f = new frmBan();
            f.ShowDialog();
        }

        private void mnuHoaDonNhap_Click(object sender, EventArgs e)
        {
            frmHoaDonNhap f = new frmHoaDonNhap();
            f.ShowDialog();
        }
    }
}
