using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.BLL;
using ZoomLa.Common;
using ZoomLa.Model;

namespace ZoomLaCMS.Cart
{
    public partial class FastOrder : System.Web.UI.Page
    {
        /*
         * 生成快速代购订单
         */
        B_User buser = new B_User();
        B_CartPro cartBll = new B_CartPro();
        B_OrderList orderBll = new B_OrderList();
        B_Payment payBll = new B_Payment();
        public string Method { get { return Request["method"]; } }
        protected void Page_Load(object sender, EventArgs e)
        {
            B_User.CheckIsLogged();
            if (!IsPostBack)
            {
                M_FastOrder model = new M_FastOrder()
                {
                    ProUrl = Request["ProUrl"],
                    ProName = Request["ProName"],
                    Price = Convert.ToDouble(Request["Price"]),
                    Pronum = DataConverter.CLng(Request["Pronum"]),
                    ProClass = DataConverter.CLng(Request["ProClass"]),
                    Phone = Request["Phone"],
					Proinfo =  Request["name"],
					Jiedao =  Request["idcard"],
                    Attribute = Request["Attribute"]
                };
                model.Pronum = model.Pronum < 1 ? 1 : model.Pronum;
                if (model.Price < 19) { function.WriteErrMsg("金额不正确"); }
                CreateOrder(model);
            }
        }
        public void CreateOrder(M_FastOrder model)
        {
            M_UserInfo mu = buser.GetLogin(false);
            M_OrderList Odata = new M_OrderList();
            Odata.Ordertype = 10;
            Odata.OrderNo = B_OrderList.CreateOrderNo((M_OrderList.OrderEnum)Odata.Ordertype);
            Odata.Mobile = DataConverter.CLng(model.Phone);
            Odata.Rename = mu.UserName;
            Odata.Ordermessage = model.Jiedao;
            Odata.Jiedao = model.Proinfo;
            //-----金额计算
            Odata.Balance_price = model.Price;
            Odata.Ordersamount = Odata.Balance_price + Odata.Freight;//订单金额
            Odata.Specifiedprice = Odata.Ordersamount; //订单金额;
            Odata.AddUser = mu.UserName; ;
            Odata.Userid = mu.UserID;
            Odata.id = orderBll.Adds(Odata);
            //-----购物车记录
            M_CartPro cartMod = new M_CartPro();
            cartMod.Orderlistid = Odata.id;
            cartMod.Username = mu.UserName;
            cartMod.Proname = model.ProName;
            cartMod.Pronum = model.Pronum;
            cartMod.ProClass = model.ProClass;
            cartMod.FarePrice = model.Price.ToString("F2");
            cartBll.Add(cartMod);
            //-----支付单 
            M_Payment payMod = new M_Payment();
            payMod.PaymentNum = Odata.OrderNo;
            payMod.MoneyPay = Odata.Ordersamount;
            payMod.Remark = model.ProName;
            payMod.PayNo = payBll.CreatePayNo();
            payMod.UserID = mu.UserID;
            payMod.Status = 1;
            payMod.PaymentID = payBll.Add(payMod);
            if (string.IsNullOrEmpty(Method))
            {
                Response.Redirect("/PayOnline/Orderpay.aspx?PayNo=" + payMod.PayNo);
            }
            else
            {
                Response.Redirect("/PayOnline/PayOnline.aspx?Method=" + Method + "&PayNo=" + payMod.PayNo);
            }
        }
        public class M_FastOrder
        {
            //商品网址
            public string ProUrl;
            //商品名
            public string ProName;
            //来源卖家
            public string ProSeller;
            //总金额,非商品单价
            public double Price;
            public int Pronum;
            //商品类型
            public int ProClass;
            public string Proinfo;
            public string Phone;
			public string Jiedao;
            //商品属性
            public string Attribute;
        }
    }
}