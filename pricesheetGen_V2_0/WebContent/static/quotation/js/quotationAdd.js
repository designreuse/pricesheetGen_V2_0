// excute when elements have been load finished, except non-literal media, such as image
$(document).ready(function() { 

/*	function bindAddProjectAction() {
        var quotationAbout = $.trim($("[name='quotationAbout']").val()); 

	    // 报价关于控制{"报价日期", "结算币种", "付款方式", "销售人员"}  
	    var enableOpr = (0 < quotationAbout.length) ? "": "disabled";
	    $("#quotationDateStr, #settlementType, #payType, #staffId").attr("disabled",enableOpr); 

		var settlementType = $("select[name='settlementType']").find("option:selected").val(); // 结算货币
		var payType = $("select[name='payType']").find("option:selected").val(); // 付款方式		
		var staffId = $("select[name='staffId']").find("option:selected").val(); // 销售人员

		if ("" == enableOpr && 0 < settlementType.length && 0 < payType.length && 0 < staffId.length) {
			$("a[id='mainAdd']").unbind("click");
			$("a[id='mainAdd']").click(function(){ 
				addRow('tab', true, 
                ['项目名称', '计价币种', '税后总额'], 
                ['productType','currency','grpAmount'], ['序号','产品名称','产品描述','单位','数量','单价(人民币)','金额(人民币)'], 
                ['orderNo','productName','productDesc', 'unin', 'amount', 'unitPrice', 'totalAmt']); 
			});
		} else {
		   $("a[id='mainAdd']").unbind("click");
		}
	}

    // 报价关于绑定变更操作
	$("input[name='quotationAbout']").unbind("blur").bind("blur", function() {
	    bindAddProjectAction();
	});

	$("#quotationDateStr, #settlementType, #payType, #staffId").unbind("blur").bind("blur", function() {
        bindAddProjectAction();
	});
	
	// 报价关于初始为空的事件初始化
	bindAddProjectAction();
*/
	
	$(document).ready(function() {
		$("a[id='mainAdd']").click(function(){ 
				var custName = $("#custName").val();
				if( custName ==null || 0 >= custName.length){
					alert("客户不能为空!");
					return;
				}
				
				var quotationAbout = $.trim($("[name='quotationAbout']").val());
				if( quotationAbout == null || 0 >=quotationAbout.length){
					alert("报价关于不能为空!");
					return;
				}
				var settlementType = $("select[name='settlementType']").find("option:selected").val(); // 结算货币
				if( 0 >= settlementType.length){
					alert("结算货币不能为空!");
					return;
				}
				var payType = $("select[name='payType']").find("option:selected").val(); // 付款方式		
				if( 0 >= payType.length){
					alert("付款方式不能为空!");
					return;
				}
				var staffId = $("select[name='staffId']").find("option:selected").val(); // 销售人员
				if( 0 >= staffId.length){
					alert("销售人员不能为空!");
					return;
				}
				
				
				addRow('tab', true, 
		              ['项目名称', '计价币种', '税后总额'], 
		              ['productType','currency','grpAmount'], ['序号','产品名称','产品描述','单位','数量','单价(人民币)','金额(人民币)'], 
		              ['orderNo','productName','productDesc', 'unin', 'amount', 'unitPrice', 'totalAmt']); 
			});
		});

});
