using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace CoffeeStore
{
    public class Menu
    {
        public Menu(string foodname, int count, decimal price, decimal totalprice)
        {
            this.FoodName = foodname;
            this.Count = count; 
            this.price = price;
            this.TotalPrice = totalprice;
        }

        public Menu(DataRow row)
        {
            this.FoodName = row["TenMon"].ToString();
            this.Count = (int)row["SoLuong"];
            this.price = (decimal)row["Gia"];
            this.TotalPrice = (decimal)row["ThanhTien"];
        }

        public int Count { get => count; set => count = value; }
        public decimal Price { get => price; set => price = value; }
        public decimal TotalPrice { get => totalprice; set => totalprice = value; }
        public string FoodName { get => foodname; set => foodname = value; }

        private string foodname;

        private int count;

        private decimal price;

        private decimal totalprice;
    }
}
