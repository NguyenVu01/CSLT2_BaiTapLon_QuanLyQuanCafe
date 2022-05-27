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
    public partial class frmLoaiMon : Form
    {
        DataTable tblLoaiMon = new DataTable();
        public frmLoaiMon()
        {
            InitializeComponent();
        }

        private void Load_DataGridView()
        {
            string sql;
            sql = "SELECT * FROM LOAIMON";
            tblLoaiMon = DAO.LoadDataToTable(sql);
            dataGridView.DataSource = tblLoaiMon;
            dataGridView.Columns[0].Width = 200;
            dataGridView.Columns[1].Width = 150;
            dataGridView.Columns[0].HeaderText = "Mã món";
            dataGridView.Columns[1].HeaderText = "Tên món";
        }
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
            txtMaLoaiMon.Enabled = true;
            ResetValues();
            txtMaLoaiMon.Focus();
        }

        private void ResetValues()
        {
            txtMaLoaiMon.Text = "";
            txtTenLoaiMon.Text = "";
        }

        private void frmLoaiMon_Load(object sender, EventArgs e)
        {
            txtMaLoaiMon.Enabled = false;
            btnLuu.Enabled = false;
            btnBoQua.Enabled = false;
            Load_DataGridView();
        }

        private void btnLuu_Click(object sender, EventArgs e)
        {
            string sql;
            if (txtMaLoaiMon.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải nhập mã loại món", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtMaLoaiMon.Focus();
                return;
            }
            if (txtTenLoaiMon.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải nhập tên mã loại món", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtTenLoaiMon.Focus();
                return;
            }
            sql = "SELECT MaLoaiMon FROM LOAIMON WHERE MaLoaiMon =N'" + txtMaLoaiMon.Text.Trim() + "'";
            if (DAO.CheckKey(sql))
            {
                MessageBox.Show("Mã loại món này đã có, bạn phải nhập mã loại món khác", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtMaLoaiMon.Focus();
                txtMaLoaiMon.Text = "";
                return;
            }

            DAO.RunSql(sql);
            sql = "INSERT INTO LOAIMON(MaLoaiMon, TenLoaiMon) VALUES(N'" + txtMaLoaiMon.Text + "',N'" + txtTenLoaiMon.Text +  "')";
            DAO.RunSql(sql);
            Load_DataGridView();
            ResetValues();
            btnXoa.Enabled = true;
            btnThem.Enabled = true;
            btnSua.Enabled = true;
            btnBoQua.Enabled = false;
            btnLuu.Enabled = false;
            txtMaLoaiMon.Enabled = false;
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            string sql;
            if (tblLoaiMon.Rows.Count == 0)
            {
                MessageBox.Show("Không còn dữ liệu!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if (txtMaLoaiMon.Text == "")
            {
                MessageBox.Show("Bạn chưa chọn bản ghi nào", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if (txtTenLoaiMon.Text.Trim().Length == 0)
            {
                MessageBox.Show("Bạn phải nhập tên loại món", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtTenLoaiMon.Focus();
                return;
            }

            sql = "UPDATE LOAIMON SET  TenLoaiMon =N'" + txtTenLoaiMon.Text.Trim().ToString() +
                     "' WHERE MaLoaiMon =N'" + txtMaLoaiMon.Text + "'";
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
            txtMaLoaiMon.Enabled = false;
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            string sql;
            if (tblLoaiMon.Rows.Count == 0)
            {
                MessageBox.Show("Không còn dữ liệu!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if (txtMaLoaiMon.Text == "")
            {
                MessageBox.Show("Bạn chưa chọn bản ghi nào", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if (MessageBox.Show("Bạn có muốn xóa không?", "Thông báo", MessageBoxButtons.OKCancel, MessageBoxIcon.Question) == DialogResult.OK)
            {
                sql = "DELETE LOAIMON WHERE MaLoaiMon = N'" + txtMaLoaiMon.Text + "'";
                DAO.RunSqlDel(sql);
                Load_DataGridView();
                ResetValues();
            }
        }

        private void btnTimKiem_Click(object sender, EventArgs e)
        {
            string sql;
            if (txtTimKiem.Text == "")
            {
                MessageBox.Show("Hãy nhập tên loại món cần tìm kiếm!!!", "Yêu cầu ...", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            sql = "SELECT * FROM LOAIMON WHERE 1=1";
            if (txtTimKiem.Text != "")
                sql = sql + " AND TenLoaiMon Like N'%" + txtTimKiem.Text + "%'";
            tblLoaiMon = DAO.LoadDataToTable(sql);
            if (tblLoaiMon.Rows.Count == 0)
                MessageBox.Show("Không có bản ghi thỏa mãn điều kiện!!!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            else
                MessageBox.Show("Có " + tblLoaiMon.Rows.Count + " bản ghi thỏa mãn điều kiện!!!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            dataGridView.DataSource = tblLoaiMon;
            ResetValues();
        }

        private void dataGridView_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            txtMaLoaiMon.Text = dataGridView.CurrentRow.Cells[0].Value.ToString();
            txtTenLoaiMon.Text = dataGridView.CurrentRow.Cells[1].Value.ToString();
        }

        private void btnHienThi_Click(object sender, EventArgs e)
        {
            Load_DataGridView();
        }
    }
}
