<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SelectPayPlat.aspx.cs" Inherits="ZoomLaCMS.PayOnline.SelectPayPlat" EnableViewStateMac="false" MasterPageFile="~/Common/Master/User.Master"%>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>用户充值</title>
<style>
#BtnSubmit { text-align:center; margin-top:10px;}
.money_list li { margin-top:10px;}
.money_list li a { display:block; padding:15px 15px; box-shadow:0 0 5px rgba(0,0,0,0.40); border-radius:4px; color:#666; line-height:50px; text-decoration:none;}
.money_list li a span.pull-right { margin-top:3px;}
.money_list li a i { color:#999; font-size:2em;}
.money_list li a span.pull-left { display:block; margin-right:5px; width:50px; height:50px; background:#ff7000; border-radius:50px; text-align:center; color:#fff; font-size:1.5em;}
.money_list li:nth-child(1) a span.pull-left { background:#ff302d;}
.money_list li:nth-child(2) a span.pull-left { background:#8e00fe;}
.money_list li:nth-child(3) a span.pull-left { background:#19b2ff;}
.money_list li:nth-child(4) a span.pull-left { background:#ff3968;}
.money_list li:nth-child(5) a span.pull-left { background:#f02c2b;}
.home_top { position:relative;}
</style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div class="container">
<ul class="money_list">
<ZL:ExRepeater runat="server" ID="RPT" PageSize="14" PagePre="<div class='clearfix'></div><div class='text-center'>" PageEnd="</div>">
<ItemTemplate>
<li>
<a href="/PayOnline/OrderPay.aspx?Money=<%# Eval("Min","{0:f2}") %>">
<span class="pull-left"><%# GetIcon() %></span>
充值<%# Eval("Min","{0:f2}") %>元送<%# Eval("Purse","{0:f2}") %>元+<%# Eval("Point","{0:f2}") %>积分 <span class="pull-right"><i class="fa fa-angle-right"></i></span>
</a></li>
</ItemTemplate>
</ZL:ExRepeater>
</ul>
	<div class="panel panel-primary hidden" style="width:500px;margin:0 auto;">
		<div class="panel-heading text-center"><b>用户充值</b></div>
		<div class="panel-body">
			<span class="pull-left" style="line-height:32px; margin-left:70px;">充值金额：</span>
			<asp:TextBox ID="Money_T" CssClass="form-control text_md" Text="100" runat="server"></asp:TextBox>
			<asp:RequiredFieldValidator ID="R2" CssClass="tips" runat="server" ControlToValidate="Money_T" Display="Dynamic" ForeColor="Red" ErrorMessage="金额不能为空" />
			<asp:RegularExpressionValidator CssClass="tips" ID="R1" runat="server" ControlToValidate="Money_T" Display="Dynamic" ForeColor="Red" ErrorMessage="金额数值不正确" ValidationExpression="^\d+(\.\d{1,2})?$" />
			<div class="clearfix"></div>
		</div>
		<div class="panel-footer text-center">
			 <asp:Button ID="BtnSubmit" CssClass="btn btn-primary" runat="server" Text="前往充值" OnClick="BtnSubmit_Click" />
		</div>
	</div>
</div>
<%Call.Label("{ZL.Label id=\"微信底部\"/}");%>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<script>
//手机下右侧导航菜单效果
$(function () {
    $('button.navbar-toggle').click(function () {
        $('body').toggleClass('out');
        $('nav.navbar-fixed-top').toggleClass('out');
        if ($('body').hasClass('out')) {
            $(this).focus();
        }
        else {
            $(this).blur();
        }
    });
});
$(document).click(function (e) {
    if (!$(e.target).closest('.navbar-collapse, button.navbar-toggle').length && $('body').hasClass('out')) {
        e.preventDefault();
        $('button.navbar-toggle').trigger('click');
    }
}).keyup(function (e) {
    if (e.keyCode == 27 && $('body').hasClass('out')) {
        $('button.navbar-toggle').trigger('click');
    }
});
//微信弹出菜单效果
$(function(){
	//menu float
	var menufloatclicknumber=0;
	function menufloatin(){
		$(".menu-c").removeClass("out");
		$("#menufloat").addClass("show")
		$(".mask_menu").fadeIn();
		$("#menufloat-c").show();
		$(".menu-c-inner").removeClass("outer");
		$(".menu-c-inner").addClass("in")
		$(".menu-c-inner a").show();
		menufloatclicknumber=1;
	}
	function menufloatout(){
		$("#menufloat").removeClass("show")
		$(".mask_menu").fadeOut();
		$(".menu-c-inner").removeClass("in")
		$(".menu-c-inner").addClass("outer")
		$(".menu-c-inner a").hide();
		$(".menu-c").addClass("out");
		menufloatclicknumber=0;		
	}
	$("#menufloat").click(function(){
		if(menufloatclicknumber==0){ menufloatin(); }
		else { menufloatout();}			 	
	})
	$(".mask_menu").click(function(){
		menufloatout(); 
	})
});
$("#userC").addClass("weui-bar__item_on");
</script>
</asp:Content>
