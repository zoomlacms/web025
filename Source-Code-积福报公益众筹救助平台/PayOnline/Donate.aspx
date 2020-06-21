﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Donate.aspx.cs" Inherits="ZoomLaCMS.PayOnline.Donate" MasterPageFile="~/Common/Master/Empty.master"%>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>捐赠打赏</title>
<style>
.donate_con_c { padding-top:5em;}
.donate_con_c a { height:5em;}
</style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div class="Search_top"><div class="Search_top_overlay"></div></div>
<div class="Search_header">
<div class="container ">
<p class="pull-right">
<a href="/search/default.aspx"><i class="fa fa-search"></i></a>
</p>
<h1 class="search_logo"><a href="/"><img src="<%= Call.LogoUrl %>" alt="<%= Call.SiteName %>" class="img-responsive" style="height:1em;" /></a></h1>
</div>
</div>
<div id="donate_body">
<div class="container">
<div class="donate_con">
<div class="row">
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<div class="donate_con_c"><a href="javascript:;" data-money="19"><span><i class="fa fa-rmb"></i>19元</span></a></div>
</div>
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<div class="donate_con_c"><a href="javascript:;" data-money="130"><span><i class="fa fa-rmb"></i>130元</span></a></div>
</div>
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<div class="donate_con_c"><a href="javascript:;" data-money="413"><span><i class="fa fa-rmb"></i>413元</span></a></div>
</div>
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<div class="donate_con_c"><a href="javascript:;" data-money="custom"><span>任性捐赠</span></a></div>
</div>
</div>
</div>
</div>
<div class="custom_div">
<div class="custom_div_c">
<div class="custom_div_ct">任性捐赠</div>
<div class="custom_div_close"><a class="btn btn-sm" onclick="CloseFun();"><i class="fa fa-close"></i></a></div>
<div class="custom_div_cf">
<ZL:TextBox ID="Money_T" Text="10" runat="server" CssClass="form-control" placeholder="请输入要捐赠的金额" AllowEmpty="false" ValidType="FloatPostive" />
<asp:Button ID="Donate_B" runat="server" CssClass="btn btn-info btn-block" Text="捐赠" OnClick="Donate_B_Click" />
</div>
</div>
</div>
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
<style>
.Search_top_overlay { background:rgba(255, 0, 0, 0.3);}
</style>
<script>
$(".donate_con_c a").click(function () {
    var $this = $(this);
    var money = $this.data("money");
    switch (money) {
        case "custom"://自定义金额
            $("#Money_T").val("");
            $(".custom_div").show();
            break;
        default:
            $("#Money_T").val(money);
            $("#Donate_B").click();
            break;
    }
});
function CloseFun(){
    $(".custom_div").hide();
}
$("#wxqrcode").popover({animation: true,html:true,trigger:"hover",placement: 'right',
    content:function(){return '<div style="width:150px;"><img src="/common/common.ashx?url=<%=HttpUtility.HtmlEncode(Request.RawUrl)%>" style="width:150px;height:150px;" /><div class="text-center" style="margin-top:5px;">微信扫描二维码打赏</div></div>';}});
</script>
</asp:Content>