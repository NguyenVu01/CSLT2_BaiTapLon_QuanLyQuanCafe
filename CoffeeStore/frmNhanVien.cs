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
    public partial class frmNhanVien : Form
    {
        //datatable chinh 1 la the hien cua dataset. dataset chua cac datatable
        DataTable tblNhanVien = new DataTable();
        public frmNhanVien()
        {
            InitializeComponent();
        }

        private void frmNhanVien_Load(object sender, EventArgs e)
        {
            txtMaNhanVien.Enabled = false;
            btnLuu.Enabled = false;
            btnBoQua.Enabled = false;
            Load_DataGridView();
        }

        private void Load_DataGridView()
        {
            string sql;
            sql = "SELECT * FROM NhanVien";
            tblNhanVien = DAO.LoadDataToTable(sql);
            dataGridView.DataSource = tblNhanVien;
            /*            dataGridView.Columns[1].Width = 200;
                        dataGridView.Columns[3].Width = 150;*/
            dataGridView.EditMode = DataGridViewEditMode.EditProgrammatically;
        }

/*        private void dataGridView_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            txtMaNhanVien.Text = dataGridView.CurrentRow.Cells[0].Value.ToString();
            txtHoTen.Text = dataGridView.CurrentRow.Cells[1].Value.ToString();
            mskNgaySinh.Text = dataGridView.CurrentRow.Cells[2].Value.ToString();
            txtDiaChi.Text = dataGridView.CurrentRow.Cells[3].Value.ToString();
            mskSoDienThoai.Text = dataGridView.CurrentRow.Cells[4].Value.ToString();
            cbxHoatDong.Text = dataGridView.CurrentRow.Cells[5].Value.ToString();
            cbxBoPhan.Text = dataGridView.CurrentRow.Cells[6].Value.ToString();
            txtLuong.Text = dataGridView.CurrentRow.Cells[7].Value.ToString();
        }*/

        private void btnDong_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            btnSua.Enabled = false;
            btnXoa.Enabled = false;
            btnBoQua.Enabled = true;
            btnLuu.Enabled = true;
            btnThem.Enabled = false;
            txtMaNhanVien.Enabled = true;
            ResetValues(); 
            txtMaNhanVien.Focus();
        }

        private void ResetValues()
        {
            txtMaNhanVien.Text = "";
            txtHoTen.Text = "";
            mskNgaySinh.Text = "";
            txtDiaChi.Text = "";
            mskSoDienThoai.Text = "";
            cbxHoatDong.Text = "";
            cbxBoPhan.Text = "";
            txtLuong.Text = "";
        }

        private void btnLuu_Click(object sender, EventArgs e)
        {
            string sql;
            if (txtMaNhanVien.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải nhập mã nhân viên", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtMaNhanVien.Focus();
                return;
            }
            if (txtHoTen.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải nhập họ tên", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtHoTen.Focus();
                return;
            }
            sql = "SELECT MaNV FROM NhanVien WHERE MaNV =N'" + txtMaNhanVien.Text.Trim() + "'";
            if (DAO.CheckKey(sql))
            {
                MessageBox.Show("Mã nhân viên này đã có, bạn phải nhập mã khác", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtMaNhanVien.Focus();
                txtMaNhanVien.Text = "";
                return;
            }
            sql = "SET IDENTITY_INSERT NHANVIEN ON";
            DAO.RunSql(sql);
            sql = "INSERT INTO NhanVien(MaNV,TenNV, NgaySinh, DiaChi, SDT, HoatDong, BoPhan, Luong) VALUES(N'" + txtMaNhanVien.Text + "',N'" + txtHoTen.Text + "',N'" +mskNgaySinh.Text + "',N'" 
                + txtDiaChi.Text + "',N'" + mskSoDienThoai.Text + "',N'" + cbxHoatDong.Text + "',N'" + cbxBoPhan.Text + "', '" + txtLuong.Text + "')";
            DAO.RunSql(sql);
            Load_DataGridView();
            sql = "SET IDENTITY_INSERT NHANVIEN OFF";
            DAO.RunSql(sql);
            ResetValues();
            btnXoa.Enabled = true;
            btnThem.Enabled = true;
            btnSua.Enabled = true;
            btnBoQua.Enabled = false;
            btnLuu.Enabled = false;
            txtMaNhanVien.Enabled = false;
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            string sql;
            if (tblNhanVien.Rows.Count == 0)
            {
                MessageBox.Show("Không còn dữ liệu!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if (txtMaNhanVien.Text == "")
            {
                MessageBox.Show("Bạn chưa chọn bản ghi nào", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if (MessageBox.Show("Bạn có muốn xóa không?", "Thông báo", MessageBoxButtons.OKCancel, MessageBoxIcon.Question) == DialogResult.OK)
            {
                sql = "DELETE NhanVien WHERE MaNV = N'" + txtMaNhanVien.Text + "'";
                DAO.RunSqlDel(sql);
                Load_DataGridView();
                ResetValues();
            }
        }

        private void btnBoQua_Click(object sender, EventArgs e)
        {
            ResetValues();
            btnBoQua.Enabled = false;
            btnThem.Enabled = true;
            btnXoa.Enabled = true;
            btnSua.Enabled = true;
            btnLuu.Enabled = false;
            txtMaNhanVien.Enabled = false;
        }

        private void btnTimKiem_Click(object sender, EventArgs e)
        {
            string sql;
            if (txtTimKiem.Text == "")
            {
                MessageBox.Show("Hãy nhập tên nhân viên cần tìm kiếm!!!", "Yêu cầu ...", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            sql = "SELECT * FROM NHANVIEN WHERE 1=1";
            if (txtTimKiem.Text != "")
                sql = sql + " AND TenNV Like N'%" + txtTimKiem.Text + "%'";
            tblNhanVien = DAO.LoadDataToTable(sql);
            if (tblNhanVien.Rows.Count == 0)
                MessageBox.Show("Không có bản ghi thỏa mãn điều kiện!!!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            else
                MessageBox.Show("Có " + tblNhanVien.Rows.Count + " bản ghi thỏa mãn điều kiện!!!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            dataGridView.DataSource = tblNhanVien;
            ResetValues();
        }

        private void btnHienThi_Click(object sender, EventArgs e)
        {
            Load_DataGridView();
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            string sql;
            if (tblNhanVien.Rows.Count == 0)
            {
                MessageBox.Show("Không còn dữ liệu!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if (txtMaNhanVien.Text == "")
            {
                MessageBox.Show("Bạn chưa chọn bản ghi nào", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if (txtHoTen.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải nhập tên khách hàng", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtHoTen.Focus();
                return;
            }
            if (txtDiaChi.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải nhập địa chỉ", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtDiaChi.Focus();
                return;
            }
            if (mskNgaySinh.Text == "  /  /")
            {
                MessageBox.Show("Bạn phải nhập ngày sinh", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                mskNgaySinh.Focus();
                return;
            }
            if (!DAO.IsDate(mskNgaySinh.Text))
            {
                MessageBox.Show("Bạn phải nhập lại ngày sinh", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                mskNgaySinh.Text = "";
                mskNgaySinh.Focus();
                return;
            }

            if (mskSoDienThoai.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải nhập số điện thoại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                mskSoDienThoai.Focus();
                return;
            }
            if (cbxHoatDong.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải chọn hoạt động! 1.Hoạt động, 0.Không hoạt động", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                cbxHoatDong.Focus();
                return;
            }
            if (cbxBoPhan.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải chọn bộ phận làm việc của nhân viên đó!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                cbxBoPhan.Focus();
                return;
            }
            sql = "UPDATE NHANVIEN SET  TenNV =N'" + txtHoTen.Text.Trim().ToString() +
                "', NgaySinh = N'" + txtDiaChi.Text.Trim().ToString() +
                "', DiaChi = N'" +  mskNgaySinh.Text.Trim().ToString() +
                "', SDT ='" + mskSoDienThoai.Text.Trim().ToString() +
                "', HoatDong = N'" + cbxHoatDong.Text +
                "', BoPhan ='" + cbxBoPhan.Text.Trim().ToString() +
                "', Luong ='" + txtLuong.Text.Trim().ToString() +
                "' WHERE MaNV =N'" + txtMaNhanVien.Text + "'";
            DAO.RunSql(sql);
            Load_DataGridView();
            ResetValues();
            btnBoQua.Enabled = false;
        }

        private void dataGridView_Click(object sender, EventArgs e)
        {
            if (btnThem.Enabled == false)
            {
                MessageBox.Show("Đang ở chế độ thêm mới!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                txtMaNhanVien.Focus();
                return;
            }
            if (tblNhanVien.Rows.Count == 0)
            {
                MessageBox.Show("Không có dữ liệu!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            txtMaNhanVien.Text = dataGridView.CurrentRow.Cells["MaNV"].Value.ToString();
            txtHoTen.Text = dataGridView.CurrentRow.Cells["TenNV"].Value.ToString();
            txtDiaChi.Text = dataGridView.CurrentRow.Cells["DiaChi"].Value.ToString();
            mskSoDienThoai.Text = dataGridView.CurrentRow.Cells["SDT"].Value.ToString();
            mskNgaySinh.Text = dataGridView.CurrentRow.Cells["NgaySinh"].Value.ToString();
            txtLuong.Text = dataGridView.CurrentRow.Cells["Luong"].Value.ToString();
            cbxHoatDong.Text = dataGridView.CurrentRow.Cells["HoatDong"].Value.ToString();
            cbxBoPhan.Text = dataGridView.CurrentRow.Cells["BoPhan"].Value.ToString();
            btnSua.Enabled = true;
            btnXoa.Enabled = true;
            btnBoQua.Enabled = true;

        }
    }
}
