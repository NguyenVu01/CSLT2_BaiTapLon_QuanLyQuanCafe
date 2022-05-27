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
    public partial class frmHoaDonNhap : Form
    {
        DataTable tblDonNhapHang = new DataTable();
        public frmHoaDonNhap()
        {
            InitializeComponent();
        }

        private void Load_DataGridView()
        {
            string sql;
            sql = "SELECT * FROM DONNHAPHANG";
            tblDonNhapHang = DAO.LoadDataToTable(sql);
            dataGridView.DataSource = tblDonNhapHang;
            dataGridView.Columns[1].Width = 200;
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {

        }

        private void frmHoaDonNhap_Load(object sender, EventArgs e)
        {

        }

        private void btnDong_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void dataGridView_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
