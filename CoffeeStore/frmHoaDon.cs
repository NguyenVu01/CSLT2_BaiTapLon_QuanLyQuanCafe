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
    }
}
