package com.dt.tarmag.test.unionpay;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import com.unionpay.acp.sdk.SDKConfig;


public class FrontPay extends DemoBase {
	public static void main(String[] args) {

		/**
		 * 初始化证书
		 */
	/**
		 * 参数初始化
		 * 在java main 方式运行时必须每次都执行加载
		 * 如果是在web应用开发里,这个方写在可使用监听的方式写入缓存,无须在这出现
		 */
		SDKConfig.getConfig().loadPropertiesFromSrc();// 从classpath加载acp_sdk.properties文件
		/**
		 * 交易请求url 从配置文件读取
		 */
		String requestFrontUrl = SDKConfig.getConfig()
				.getFrontRequestUrl();
		/**
		 * 组装请求报文
		 */
		Map<String, Object> contentData = new HashMap<String, Object>();
		// 固定填写
		contentData.put("version", version);// M

		// 默认取值：UTF-8
		contentData.put("encoding", encoding);// M

		

		// 01RSA02 MD5 (暂不支持)
		contentData.put("signMethod", "01");// M

		// 取值：11
		contentData.put("txnType", "11");// M

		// 默认：00
		contentData.put("txnSubType", "00");// M

		contentData.put("bizType", "000501");// M//000501 代收

		contentData.put("channelType", "07");// M

		//交易前台返回商户结果时使用，前台类交易需上送
		contentData.put("frontUrl", frontUrl);//C

		// 交易后台返回商户结果时使用，如上送，则发送商户后台交易结果通知
		// contentData.put("backUrl", backUrl);// M

		// 0：普通商户直连接入2：平台类商户接入
		contentData.put("accessType", "0");// M

		// 商户代码
		contentData.put("merId", "802290049000180");// M
		//
		//商户类型为平台类商户接入时必须上送
		contentData.put("subMerId", "");//C
		//
		//商户类型为平台类商户接入时必须上送
		contentData.put("subMerName", "");//C
		//
		//商户类型为平台类商户接入时必须上送
		contentData.put("subMerAbbr", "");//C

		// 交易订单号
		contentData.put("orderId", getOrderId());//M

		// 交易时间
		contentData.put("txnTime", getCurrentTime());// M

		//　
		// contentData.put("accType", "0");//O
		// 0：商户直连接入
		// 1：收单机构接入
		// 2：平台商户接入

		// 非绑定类交易时需上送卡号
		contentData.put("accNo", "6216261000000000018");// M

		// 　
		contentData.put("txnAmt", "1");// M

		// 默认为156交易，填写参考公参
		contentData.put("currencyCode", "156");// M

		//　
		// contentData.put("customerInfo", getCustomer(encoding));//O
		//
		//用于唯一标识绑定关系
		// contentData.put("bindId", bindId);//O
		//
		//参看数据元说明
		// contentData.put("billType", billType);//O
		//
		//账单查询/支付类交易中填写具体账单号码用法一：账单查询/支付类交易中网上缴税用法，填写纳税人编码用法二：账单查询/支付类交易中信用卡还款用法，填写信用卡卡号
		// contentData.put("billNo", billNo);//O
		//
		//前台交易，有IP防钓鱼要求的商户上送
		// contentData.put("customerIp", customerIp);//C
		//
		//格式为：yyyyMMdd-yyyyMMdd
		// contentData.put("billPeriod", billPeriod);//O
		//
		//商户自定义保留域，交易应答时会原样返回
		contentData.put("reqReserved", "");//O
		//
		//格式如下：{子域名1=值&子域名2=值&子域名3=值} 移动支付参考消费
		contentData.put("reserved", "");//O
		//
		//格式如下：{子域名1=值&子域名2=值&子域名3=值}有风险级别要求的商户必填 风险级别 {riskLevel=XX}
		contentData.put("riskRateInfo", "");//O
		//
		//当使用银联公钥加密密码等信息时，需上送加密证书的CertID
		contentData.put("encryptCertId", "");//C
		//
		//存折交易时必填
		contentData.put("issInsCode", "");//C
		//
		//　
		contentData.put("termId", "");//O
		//
		//有卡交易必填
		// contentData.put("cardTransData", cardTransData);//C

		Map<String, String> submitFromData = signData(contentData);
		
		//构造HTTP POST交易表单的方法示例
		String html = createHtml(requestFrontUrl, submitFromData);

		System.out.println(html);
		
//		submitUrl(submitFromData, requestUrl)


	}

	/**
	 * 构造HTTP POST交易表单的方法示例
	 * 
	 * @param action
	 *            表单提交地址
	 * @param hiddens
	 *            以MAP形式存储的表单键值
	 * @return 构造好的HTTP POST交易表单
	 */
	public static String createHtml(String action, Map<String, String> hiddens) {
		StringBuffer sf = new StringBuffer();
		sf.append("<html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"/></head><body>");
		sf.append("<form id = \"pay_form\" action=\"" + action
				+ "\" method=\"post\">");
		if (null != hiddens && 0 != hiddens.size()) {
			Set<Entry<String, String>> set = hiddens.entrySet();
			Iterator<Entry<String, String>> it = set.iterator();
			while (it.hasNext()) {
				Entry<String, String> ey = it.next();
				String key = ey.getKey();
				String value = ey.getValue();
				sf.append("<input type=\"hidden\" name=\"" + key + "\" id=\""
						+ key + "\" value=\"" + value + "\"/>");
			}
		}
		sf.append("</form>");
		sf.append("</body>");
		sf.append("<script type=\"text/javascript\">");
		sf.append("document.all.pay_form.submit();");
		sf.append("</script>");
		sf.append("</html>");
		return sf.toString();
	}

}
