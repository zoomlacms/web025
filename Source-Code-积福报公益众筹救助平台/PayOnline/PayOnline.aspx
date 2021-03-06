﻿<%@ Page Language="C#" ResponseEncoding="utf-8" AutoEventWireup="true" CodeFile="PayOnline.aspx.cs" Inherits="ZoomLaCMS.PayOnline.PayOnline" EnableViewStateMac="false" Debug="true" %><!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="renderer" content="webkit" />
<title>在线支付</title>
<script src="/JS/jquery-1.11.1.min.js"></script>
<script src="/JS/Controls/ZL_Dialog.js"></script>
<script src="/JS/Modal/APIResult.js"></script>
<script src="/dist/js/bootstrap.min.js"></script>
<link href="/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="/dist/css/font-awesome.min.css" rel="stylesheet" />
<link href="/App_Themes/User.css" rel="stylesheet" />
<style type="text/css">
@media (max-width:768px) {.minwidth {width:100%;}}
</style>
</head>
<body>
<form id="form1" runat="server">
<div class="main_div">
    <div class="container padding_r10">
	<div runat="server" id="logged_div" visible="false" class="pull-right">
	    <a href="#" class="grayremind" runat="server" id="logged_a" ></a>
	    <a href="/User/Order/OrderList" target="_blank" class="btn btn-primary btn-xs">我的订单</a>
	    <a href="/User/User/Logout" class="btn btn-primary btn-xs">退出</a>
	</div>
    </div>
</div>
<div class="mainpay_div container">
    <div class="head_div"><img src="<%=Call.LogoUrl %>" /></div>
    <div class="paytable" runat="server" id="payinfo_div">
        <div><strong>订单提交成功，请您尽快付款!</strong></div>
        <div>订单号：<asp:Label ID="OrderNo_L" runat="server"></asp:Label></div>
        <div>应付金额：<asp:Label ID="LblPayMoney" runat="server" CssClass="r_red"></asp:Label></div>
        <div>
            <asp:Label runat="server" ID="Fee" Text="帐户余额："></asp:Label><asp:Label ID="LblRate" CssClass="r_red" runat="server" Text="XX元"></asp:Label></div>
        <div>
            <span>支付方式：</span>
            <asp:Label ID="VMoneyPayed_L" runat="server" CssClass="r_orange"></asp:Label>
            <a href="/PayOnline/Orderpay.aspx?PayNo=<%:PayNo %>" class="margin_l5">重新选择</a>
            <div class="margin_t10" runat="server" visible="false" id="Alipay_Btn">
                <input type="button" value="确定付款" class="btn btn-primary" style="width:120px;" onclick="alipaySubmit();" />
            </div>
            <div class="margin_t10">
                <div id="spwd_div" runat="server" visible="false" class="shortPwd_div">
                    <link href="/JS/Plugs/shortPwd/shortPwd.css" rel="stylesheet" />
                    <script src="/JS/Plugs/shortPwd/shortPwd.js"></script>
                    <span class="shortPwd" node-type="shortPassword">
                        <input type="password" class="shortPwd-input" node-type="shortPassword-input" autocomplete="new-password" maxlength="1" autofocus/>
                        <input type="password" class="shortPwd-input" node-type="shortPassword-input" autocomplete="new-password" maxlength="1" />
                        <input type="password" class="shortPwd-input" node-type="shortPassword-input" autocomplete="new-password" maxlength="1" />
                        <input type="password" class="shortPwd-input" node-type="shortPassword-input" autocomplete="new-password" maxlength="1" />
                        <input type="password" class="shortPwd-input" node-type="shortPassword-input" autocomplete="new-password" maxlength="1" />
                        <input type="password" class="shortPwd-input" node-type="shortPassword-input" autocomplete="new-password" maxlength="1" />
                        <input type="password" name="pwd_t" id="pwd_t" class="shortPwd-hidden" node-type="shortPassword-value" maxlength="6" />
                    </span>
                    <div class="r_red" id="spwd_remind_div"></div>
                    <input type="button" id="surepay_btn" value="确定支付" class="btn btn-info margin_t5" style="width: 120px;" onclick="shortPwdCheck();" />
                    <asp:Button runat="server" Style="display: none;" ID="Confirm_VMoney_Btn" OnClick="Confirm_Click" />
                    <script>
                        shortPassword();
                        function shortPwdCheck() {
                            var spwd = $("#pwd_t").val();
                            var $remind = $("#spwd_remind_div"); $remind.text("");
                            if (spwd == "") { $remind.text("支付密码不能为空"); return; }
                            if (spwd.length != 6) { $remind.text("请将支付密码输入完整"); return; }
                            setTimeout(function () { document.getElementById("surepay_btn").disabled = true; }, 50);
                            $.post("/api/usercheck.ashx?action=spwd", { "spwd": spwd }, function (data) {
                                var model = APIResult.getModel(data);
                                if (APIResult.isok(model)) { $("#Confirm_VMoney_Btn").click(); }
                                else { $remind.text(model.retmsg); }
                                setTimeout(function () { document.getElementById("surepay_btn").disabled = false; }, 50);
                            });
                        }
                    </script>
                </div>
                <div id="nospwd_div" runat="server" visible="false">
                    <asp:Button runat="server" Text="确定支付" class="btn btn-info" style="width:120px;" OnClick="Confirm_Click" />
                </div>
            </div>
        </div>
    </div>
    <div class="paytable" runat="server" id="AfterPay_Tb">
        <div class="p_center">
            <div class="pay_tab">
                <strong>恭喜您,下单成功！</strong><br />
            </div>
            <div class="PayPlat_s payed">
                <h3 class="r_green">确认款项：</h3>
                <div>支付方式：<asp:Label ID="zfpt" runat="server" CssClass="r_orange"></asp:Label></div>
                <div>订单号：<asp:Label ID="ddh" runat="server"></asp:Label></div>
                <div>支付金额：<asp:Label ID="PayNum_L2" runat="server" CssClass="r_red"></asp:Label></div>
                <div>
                    <asp:Label ID="fees" runat="server" Text="帐户余额："></asp:Label><asp:Label ID="sxf" runat="server" CssClass="r_red">></asp:Label>
                </div>
                <div id="ActualAmount" runat="server" visible="false"><span>实际金额：</span><asp:Label ID="sjhbje" runat="server" CssClass="r_red">></asp:Label></div>
                <asp:Literal runat="server" ID="remindHtml" EnableViewState="false"></asp:Literal>
                <div>
                    <asp:HyperLink runat="server" ID="Rurl_Href" CssClass="btn btn-primary">我的订单</asp:HyperLink>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="payremind_div" style="display:none;">
    <div class="panel panel-primary">
        <div class="panel-heading"><span class="fa fa-bookmark"></span><span class="margin_l5">登录平台支付</span></div>
        <div class="panel-body">
            <div style="padding-bottom: 15px; padding-left: 10px;">请您在新打开的支付平台页面进行支付,支付完成前请不要关闭该窗口</div>
            <div class="text-center">
                <a id="PayComp_Href" runat="server" href="/User/Order/OrderList" class="btn btn-primary">已完成支付</a>
                <a href="OrderPay.aspx?PayNo=<%:PayNo %>" class="btn btn-primary margin_l20">重选支付平台</a>
            </div>
        </div>
    </div>
</div>
</form>
<asp:Panel runat="server" ID="alipay_form" style="display:none;"><div class="margin_t5" runat="server" id="LblHiddenValue"></div></asp:Panel>
<script>
function alipaySubmit() {
    $("#payform").submit();
    var diag = new ZL_Dialog();
    diag.maxbtn = false;
    diag.closebtn = false;
    diag.backdrop = true;
    diag.width = "minwidth";
    diag.title = "正在支付";
    diag.body = $("#payremind_div").show().html(); $("#payremind_div").remove();
    diag.ShowModal();
}
</script>
</body>
</html>