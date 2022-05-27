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
    public partial class frmNhaCungCap : Form
    {
        DataTable tblNCC = new DataTable();

        public frmNhaCungCap()
        {
            InitializeComponent();
        }

        private void Load_DataGridView()
        {
            string sql;
            sql = "SELECT * FROM NHACUNGCAP";
            tblNCC = DAO.LoadDataToTable(sql);
            dataGridView.DataSource = tblNCC;
            dataGridView.Columns[1].Width = 200;
            dataGridView.Columns[3].Width = 150;
            dataGridView.Columns[0].HeaderText = "Mã cung cấp";
            dataGridView.Columns[1].HeaderText = "Tên nhà cung cấp";
            dataGridView.Columns[2].HeaderText = "Địa chỉ";
            dataGridView.Columns[3].HeaderText = "SĐT";
        }

        private void ResetValues()
        {
            txtMaNCC.Text = "";
            txtTenNCC.Text = "";
            txtDiaChi.Text = "";
            mskSoDienThoai.Text = "";
        }

        private void btnDong_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void frmNhaCungCap_Load(object sender, EventArgs e)
        {
            txtMaNCC.Enabled = false;
            btnLuu.Enabled = false;
            btnBoQua.Enabled = false;
            Load_DataGridView();
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            btnSua.Enabled = false;
            btnXoa.Enabled = false;
            btnBoQua.Enabled = true;
            btnLuu.Enabled = true;
            btnThem.Enabled = false;
            txtMaNCC.Enabled = true;
            ResetValues();
            txtMaNCC.Focus();
        }

        private void btnHienThi_Click(object sender, EventArgs e)
        {
            Load_DataGridView();
        }

        private void btnLuu_Click(object sender, EventArgs e)
        {
            string sql;
            if (txtMaNCC.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải nhập mã nhà cung cấp", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtMaNCC.Focus();
                return;
            }
            if (txtTenNCC.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải nhập tên nhà cung cấp", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtTenNCC.Focus();
                return;
            }
            if (mskSoDienThoai.Text == "(   )     -")
            {
                MessageBox.Show("Bạn phải nhập điện thoại", "Thông báo",MessageBoxButtons.OK, MessageBoxIcon.Warning);
                mskSoDienThoai.Focus();
                return;
            }
            sql = "SELECT MaNCC FROM NHACUNGCAP WHERE MaNCC =N'" + txtMaNCC.Text.Trim() + "'";
            if (DAO.CheckKey(sql))
            {
                MessageBox.Show("Mã khách hàng này đã có, bạn phải nhập mã khác", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtMaNCC.Focus();
                txtMaNCC.Text = "";
                return;
            }
            sql = "SET IDENTITY_INSERT NHACUNGCAP ON;";
            DAO.RunSql(sql);
            sql = "INSERT INTO NHACUNGCAP(MaNCC,TenNCC, DiaChi, SDT) VALUES(N'" + txtMaNCC.Text + "',N'" + txtTenNCC.Text + "',N'" + txtDiaChi.Text + "',N'" + mskSoDienThoai.Text + "')";
            DAO.RunSql(sql);
            sql = "SET IDENTITY_INSERT NHACUNGCAP OFF;";
            DAO.RunSql(sql);
            Load_DataGridView();
            ResetValues();
            btnXoa.Enabled = true;
            btnThem.Enabled = true;
            btnSua.Enabled = true;
            btnBoQua.Enabled = false;
            btnLuu.Enabled = false;
            txtMaNCC.Enabled = false;
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            string sql;
            if (tblNCC.Rows.Count == 0)
            {
                MessageBox.Show("Không còn dữ liệu!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if (txtMaNCC.Text == "")
            {
                MessageBox.Show("Bạn chưa chọn bản ghi nào", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if (txtTenNCC.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải nhập tên nhà cung cấp", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtTenNCC.Focus();
                return;
            }
            if (txtDiaChi.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải nhập địa chỉ", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtDiaChi.Focus();
                return;
            }
            if (mskSoDienThoai.Text == "(   )     -")
            {
                MessageBox.Show("Bạn phải nhập điện thoại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                mskSoDienThoai.Focus();
                return;
            }
            sql = "UPDATE NHACUNGCAP SET  TenNCC = N'" + txtTenNCC.Text.Trim().ToString() +
                "', DiaChi = N'" + txtDiaChi.Text.Trim().ToString() +
                "', SDT = N'" + mskSoDienThoai.Text + "' WHERE MaNCC =N'" + txtMaNCC.Text + "'";
            DAO.RunSql(sql);
            Load_DataGridView();
            ResetValues();
            btnBoQua.Enabled = false;
        }

        private void btnBoQua_Click(object sender, EventArgs e)
        {
            ResetValues();
            btnBoQua.Enabled = false;
            btnThem.Enabled = true;
            btnXoa.Enabled = true;
            btnSua.Enabled = true;
            btnLuu.Enabled = false;
            txtMaNCC.Enabled = false;
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            string sql;
            if (tblNCC.Rows.Count == 0)
            {
                MessageBox.Show("Không còn dữ liệu!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if (txtMaNCC.Text == "")
            {
                MessageBox.Show("Bạn chưa chọn bản ghi nào", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if (MessageBox.Show("Bạn có muốn xóa không?", "Thông báo", MessageBoxButtons.OKCancel, MessageBoxIcon.Question) == DialogResult.OK)
            {
                sql = "DELETE NHACUNGCAP WHERE MaNCC = N'" + txtMaNCC.Text + "'";
                DAO.RunSqlDel(sql);
                Load_DataGridView();
                ResetValues();
            }
        }

        private void dataGridView_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            txtMaNCC.Text = dataGridView.CurrentRow.Cells[0].Value.ToString();
            txtTenNCC.Text = dataGridView.CurrentRow.Cells[1].Value.ToString();
            txtDiaChi.Text = dataGridView.CurrentRow.Cells[2].Value.ToString();
            mskSoDienThoai.Text = dataGridView.CurrentRow.Cells[3].Value.ToString();
        }

        private void btnTimKiem_Click(object sender, EventArgs e)
        {
            string sql;
            if (txtTimKiem.Text == "")
            {
                MessageBox.Show("Hãy nhập tên nhà cung cấp cần tìm kiếm!!!", "Yêu cầu ...", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            sql = "SELECT * FROM NHACUNGCAP WHERE 1=1";
            if (txtTimKiem.Text != "")
                sql = sql + " AND TenNCC Like N'%" + txtTimKiem.Text + "%'";
            tblNCC = DAO.LoadDataToTable(sql);
            if (tblNCC.Rows.Count == 0)
                MessageBox.Show("Không có bản ghi thỏa mãn điều kiện!!!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            else
                MessageBox.Show("Có " + tblNCC.Rows.Count + " bản ghi thỏa mãn điều kiện!!!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            dataGridView.DataSource = tblNCC;
            ResetValues();
        }
    }
}
