using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace CoffeeStore
{
    public class Bill
    {
        public Bill(int id, DateTime? dateCheckIn, DateTime? dateCheckOut)
        {
            this.ID = id;   
            this.DateCheckIn = dateCheckIn;
            this.dateCheckOut = dateCheckOut;
        }

        public Bill(DataRow row)
        {
            this.ID = (int)row["MaHD"];
            this.DateCheckIn = (DateTime?)row["NgayDat"];
            var dateCheckOutTemp = row["NgayGiao"];
            if(dateCheckOutTemp.ToString() != "")
            {
                this.dateCheckOut = (DateTime?)row["NgayGiao"];
            }

        }

        private int iD;

        public int ID { get => iD; set => iD = value; }

        private DateTime? dateCheckIn;

        public DateTime? DateCheckIn
        {
            get => dateCheckIn; set => dateCheckIn = value; 
        }


        private DateTime? dateCheckOut;

        public DateTime? DateCheckOut
        {
            get => dateCheckOut; set => dateCheckOut = value;
        }
    }
}
