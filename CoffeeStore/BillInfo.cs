using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace CoffeeStore
{
    public class BillInfo
    {
        public BillInfo(string billID, string foodID, int count, decimal price)
        {
            this.billID = billID;
            this.foodID = foodID;
            this.Count = count; 
            this.Price = price;
        }

        public BillInfo(DataRow row)
        {
            this.billID = row["MaHD"].ToString();
            this.foodID = row["MaMon"].ToString();
            this.Count = (int)row["SoLuong"];
            this.Price = (decimal)row["DonGia"];
            //this.Totalprice = (decimal)row["ThanhTien"];
        }
        private string billID;

        public string BillID { get => billID; set => billID = value; }
        public int Count { get => count; set => count = value; }
        public string FoodID { get => foodID; set => foodID = value; }
        public decimal Price { get => price; set => price = value; }

        private int count;

        private string foodID;

        private decimal price;

       

    }
}
