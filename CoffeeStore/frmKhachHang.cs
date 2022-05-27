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
    public partial class frmKhachHang : Form
    {
        DataTable tblKhachHang = new DataTable();
        public frmKhachHang()
        {
            InitializeComponent();
        }

        private void Load_DataGridView()
        {
            string sql;
            sql = "SELECT * FROM KhachHang";
            tblKhachHang = DAO.LoadDataToTable(sql);
            dataGridView.DataSource = tblKhachHang;
            dataGridView.Columns[1].Width = 200;
            dataGridView.Columns[3].Width = 150;
            dataGridView.Columns[0].HeaderText = "Mã khách hàng";
            dataGridView.Columns[1].HeaderText = "Tên khách hàng";
            dataGridView.Columns[2].HeaderText = "Địa chỉ";
            dataGridView.Columns[3].HeaderText = "Điểm tích lũy";
            dataGridView.Columns[4].HeaderText = "SĐT";
        }

        private void btnDong_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnBoQua_Click(object sender, EventArgs e)
        {
            ResetValues();
            btnBoQua.Enabled = false;
            btnThem.Enabled = true;
            btnXoa.Enabled = true;
            btnSua.Enabled = true;
            btnLuu.Enabled = false;
            txtMaKhach.Enabled = false;
        }

        private void ResetValues()
        {
            txtMaKhach.Text = "";
            txtHoTen.Text = "";
            txtDiaChi.Text = "";
            txtSoDienThoai.Text = "";
            txtDiemTichLuy.Text = "";
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            btnSua.Enabled = false;
            btnXoa.Enabled = false;
            btnBoQua.Enabled = true;
            btnLuu.Enabled = true;
            btnThem.Enabled = false;
            txtMaKhach.Enabled = true;
            ResetValues();
            txtMaKhach.Focus();
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            string sql;
            if (tblKhachHang.Rows.Count == 0)
            {
                MessageBox.Show("Không còn dữ liệu!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if (txtMaKhach.Text == "")
            {
                MessageBox.Show("Bạn chưa chọn bản ghi nào", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if (MessageBox.Show("Bạn có muốn xóa không?", "Thông báo", MessageBoxButtons.OKCancel, MessageBoxIcon.Question) == DialogResult.OK)
            {
                sql = "DELETE KhachHang WHERE MaKH= N'" + txtMaKhach.Text + "'";
                DAO.RunSqlDel(sql);
                Load_DataGridView();
                ResetValues();
            }
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            string sql;
            if (tblKhachHang.Rows.Count == 0)
            {
                MessageBox.Show("Không còn dữ liệu!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if (txtMaKhach.Text == "")
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
            if (txtDiemTichLuy.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải nhập điểm tích lũy", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtDiemTichLuy.Focus();
                return;
            }
            sql = "UPDATE KHACHHANG SET  TenKH =N'" + txtHoTen.Text.Trim().ToString() +
                "', DiaChi = N'" + txtDiaChi.Text.Trim().ToString() +
                "', DiemTichLuy ='" + txtDiemTichLuy.Text.Trim().ToString() +
                "',SDT = N'" + txtSoDienThoai.Text + "' WHERE MaKH =N'" + txtMaKhach.Text + "'";
            DAO.RunSql(sql);
            Load_DataGridView();
            ResetValues();
            btnBoQua.Enabled = false;
        }

        private void btnLuu_Click(object sender, EventArgs e)
        {
            string sql;
            if (txtMaKhach.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải nhập mã khách", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtMaKhach.Focus();
                return;
            }
            if (txtHoTen.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải nhập họ tên", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtHoTen.Focus();
                return;
            }
            sql = "SELECT MaKH FROM KHACHHANG WHERE MaKH =N'" + txtMaKhach.Text.Trim() + "'";
            if (DAO.CheckKey(sql))
            {
                MessageBox.Show("Mã khách hàng này đã có, bạn phải nhập mã khác", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtMaKhach.Focus();
                txtMaKhach.Text = "";
                return;
            }
            sql = "INSERT INTO KHACHHANG(MaKH,TenKH, DiaChi, DiemTichLuy, SDT) VALUES(N'" + txtMaKhach.Text + "',N'" + txtHoTen.Text + "',N'" + txtDiaChi.Text + "',N'" + txtDiemTichLuy.Text + "',N'" + txtSoDienThoai.Text + "')";
            DAO.RunSql(sql);
            Load_DataGridView();
            ResetValues();
            btnXoa.Enabled = true;
            btnThem.Enabled = true;
            btnSua.Enabled = true;
            btnBoQua.Enabled = false;
            btnLuu.Enabled = false;
            txtMaKhach.Enabled = false;
        }

        private void dataGridView_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            txtMaKhach.Text = dataGridView.CurrentRow.Cells[0].Value.ToString();
            txtHoTen.Text = dataGridView.CurrentRow.Cells[1].Value.ToString();
            txtDiaChi.Text = dataGridView.CurrentRow.Cells[2].Value.ToString();
            txtDiemTichLuy.Text = dataGridView.CurrentRow.Cells[3].Value.ToString();
            txtSoDienThoai.Text = dataGridView.CurrentRow.Cells[4].Value.ToString();
        }

        private void frmKhachHang_Load(object sender, EventArgs e)
        {
            txtMaKhach.Enabled = false;
            btnLuu.Enabled = false;
            btnBoQua.Enabled = false;
            Load_DataGridView();
        }

        private void btnTimKiem_Click(object sender, EventArgs e)
        {
            string sql;
            if (txtTimKiem.Text == "")
            {
                MessageBox.Show("Hãy nhập tên khách hàng cần tìm kiếm!!!", "Yêu cầu ...", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            sql = "SELECT * FROM KHACHHANG WHERE 1=1";
            if (txtTimKiem.Text != "")
                sql = sql + " AND TenKH Like N'%" + txtTimKiem.Text + "%'";
            tblKhachHang = DAO.LoadDataToTable(sql);
            if (tblKhachHang.Rows.Count == 0)
                MessageBox.Show("Không có bản ghi thỏa mãn điều kiện!!!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            else
                MessageBox.Show("Có " + tblKhachHang.Rows.Count + " bản ghi thỏa mãn điều kiện!!!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            dataGridView.DataSource = tblKhachHang;
            ResetValues();
        }

        private void btnHienThi_Click(object sender, EventArgs e)
        {
            Load_DataGridView();
        }
    }
}
