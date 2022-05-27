using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace CoffeeStore
{
    public partial class frmHoaDon : Form
    {
        DataTable tblHoaDon = new DataTable();
        public frmHoaDon()
        {
            InitializeComponent();
        }

        private void frmHoaDon_Load(object sender, EventArgs e)
        {
            txtMaHoaDon.Enabled = false;
            btnLuu.Enabled = false;
            btnBoQua.Enabled = false;
            string sql1 = "SELECT DISTINCT MaNV FROM NHANVIEN";
            DAO.FillCombo(sql1, cbxMaNhanVien, "MaNV", "MaNV");
            string sql2 = "SELECT DISTINCT MaKH FROM KHACHHANG ORDER BY MAKH";
            DAO.FillCombo(sql2, cbxMaKhach, "MaKH", "MaKH");
            string sql3 = "SELECT DISTINCT MaBan FROM BAN";
            DAO.FillCombo(sql3, cbxMaBan, "MaBan", "MaBan");
            Load_DataGridView();
        }

        private void btnDong_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void Load_DataGridView()
        {
            string sql;
            sql = "SELECT * FROM HOADON";
            tblHoaDon = DAO.LoadDataToTable(sql);
            dataGridView.DataSource = tblHoaDon;
            dataGridView.Columns[1].Width = 200;
        }

        private void btnDong_Click_1(object sender, EventArgs e)
        {
            this.Close();
        }

        private void dataGridView_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            txtMaHoaDon.Text = dataGridView.CurrentRow.Cells[0].Value.ToString();
            mskNgayDat.Text = dataGridView.CurrentRow.Cells[1].Value.ToString();
            mskNgayGiao.Text = dataGridView.CurrentRow.Cells[2].Value.ToString();
            cbxMaNhanVien.Text = dataGridView.CurrentRow.Cells[3].Value.ToString();
            cbxMaKhachHang.Text = dataGridView.CurrentRow.Cells[4].Value.ToString();
            cbxMaBan.Text = dataGridView.CurrentRow.Cells[5].Value.ToString();
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            btnSua.Enabled = false;
            btnXoa.Enabled = false;
            btnBoQua.Enabled = true;
            btnLuu.Enabled = true;
            btnThem.Enabled = false;
            txtMaHoaDon.Enabled = true;
            ResetValues();
            txtMaHoaDon.Focus();
        }

        private void ResetValues()
        {
            txtMaHoaDon.Text = "";
            mskNgayDat.Text = "";
            mskNgayGiao.Text = "";
            cbxMaNhanVien.Text = "";
            cbxMaKhach.Text = "";
            cbxMaBan.Text = "";
        }

        private void btnBoQua_Click(object sender, EventArgs e)
        {
            ResetValues();
            btnBoQua.Enabled = false;
            btnThem.Enabled = true;
            btnXoa.Enabled = true;
            btnSua.Enabled = true;
            btnLuu.Enabled = false;
            txtMaHoaDon.Enabled = false;
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            string sql;
            if (tblHoaDon.Rows.Count == 0)
            {
                MessageBox.Show("Không còn dữ liệu!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if (txtMaHoaDon.Text == "")
            {
                MessageBox.Show("Bạn chưa chọn bản ghi nào", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if (mskNgayDat.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải chọn ngày đặt", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                mskNgayDat.Focus();
                return;
            }
            if (mskNgayGiao.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải chọn ngày giao", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                mskNgayGiao.Focus();
                return;
            }
            if (cbxMaNhanVien.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải chọn mã nhân viên", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                cbxMaNhanVien.Focus();
                return;
            }
            if (cbxMaKhach.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải chọn mã khách hàng", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                cbxMaKhach.Focus();
                return;
            }

            sql = "UPDATE HOADON SET  NgayDat =N'" + mskNgayDat.Text.Trim().ToString() +
                "', NgayGiao = N'" + mskNgayGiao.Text.Trim().ToString() +
                "', MaNV ='" + cbxMaNhanVien.Text.Trim().ToString() +
                "', MaKH ='" + cbxMaKhach.Text.Trim().ToString() +
                "', MaBan ='" + cbxMaBan.Text.Trim().ToString() +
                "' WHERE MaKH =N'" + txtMaHoaDon.Text + "'";
            DAO.RunSql(sql);
            Load_DataGridView();
            ResetValues();
            btnBoQua.Enabled = false;
        }

        private void btnLuu_Click(object sender, EventArgs e)
        {
            string sql;
            if (txtMaHoaDon.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải nhập mã hóa đơn", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtMaHoaDon.Focus();
                return;
            }
            if (mskNgayDat.Text == "  /  /")
            {
                MessageBox.Show("Bạn phải nhập ngày đặt", "Thông báo",MessageBoxButtons.OK, MessageBoxIcon.Warning);
                mskNgayDat.Focus();
                return;
            }

            if (mskNgayGiao.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải chọn ngày giao", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                mskNgayGiao.Focus();
                return;
            }
            sql = "SELECT MaHD FROM HOADON WHERE MaHD =N'" + txtMaHoaDon.Text.Trim() + "'";
            if (DAO.CheckKey(sql))
            {
                MessageBox.Show("Mã hóa đơn này đã có, bạn phải nhập mã khác", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtMaHoaDon.Focus();
                txtMaHoaDon.Text = "";
                return;
            }
            sql = "INSERT INTO HOADON(MaHD,NgayDat, NgayGiao, MaNV, MaKH, MaBan) VALUES(N'" + txtMaHoaDon.Text +
                "',N'" + mskNgayDat.Text +
                "',N'" + mskNgayGiao.Text +
                "',N'" + cbxMaNhanVien.Text +
                "',N'" + cbxMaKhach.Text +
                "',N'" + cbxMaBan.Text + "')";

            DAO.RunSql(sql);
            Load_DataGridView();
            ResetValues();
            btnXoa.Enabled = true;
            btnThem.Enabled = true;
            btnSua.Enabled = true;
            btnBoQua.Enabled = false;
            btnLuu.Enabled = false;
            txtMaHoaDon.Enabled = false;
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            string sql;
            if (tblHoaDon.Rows.Count == 0)
            {
                MessageBox.Show("Không còn dữ liệu!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if (txtMaHoaDon.Text == "")
            {
                MessageBox.Show("Bạn chưa chọn bản ghi nào", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if (MessageBox.Show("Bạn có muốn xóa không?", "Thông báo", MessageBoxButtons.OKCancel, MessageBoxIcon.Question) == DialogResult.OK)
            {
                sql = "DELETE HOADON WHERE MaHD = N'" + txtMaHoaDon.Text + "'";
                DAO.RunSqlDel(sql);
                Load_DataGridView();
                ResetValues();
            }
        }

        private void btnThongKe_Click(object sender, EventArgs e)
        {

        }
    }
}
