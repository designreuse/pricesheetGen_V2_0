package com.sapling.common.utils;


import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sapling.common.config.Global;

public class HttpURLConnectionUtil {
	
	public Logger logger = LoggerFactory.getLogger(getClass());
	
	private URL url;
	private HttpURLConnection conn;
	private String boundary = "--------httppost123";
	private Map<String, String> textParams = new HashMap<String, String>();
	private Map<String, File> fileparams = new HashMap<String, File>();
	private DataOutputStream ds;

	public HttpURLConnectionUtil(String url) throws Exception {
		this.url = new URL(url);
	}
    //重新设置要请求的服务器地址，即上传文件的地址。
	public void setUrl(String url) throws Exception {
		this.url = new URL(url);
	}
    //增加一个普通字符串数据到form表单数据中
	public void addTextParameter(String name, String value) {
		textParams.put(name, value);
	}
    //增加一个文件到form表单数据中
	public void addFileParameter(String name, File value) {
		fileparams.put(name, value);
	}
    // 清空所有已添加的form表单数据
	public void clearAllParameters() {
		textParams.clear();
		fileparams.clear();
	}
    // 发送数据到服务器，返回一个字节包含服务器的返回结果的数组
	public byte[] send() throws Exception {
		initPostConnection();
		try {
			conn.connect();
		} catch (SocketTimeoutException e) {
			// something
			throw new RuntimeException();
		}
		ds = new DataOutputStream(conn.getOutputStream());
		writeFileParams();
		writeStringParams();
		paramsEnd();
		InputStream in = conn.getInputStream();
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		int b;
		while ((b = in.read()) != -1) {
			out.write(b);
		}
		conn.disconnect();
		return out.toByteArray();
	}
    //文件上传的connection的一些必须设置
	private void initPostConnection() throws Exception {
		conn = (HttpURLConnection) this.url.openConnection();
		conn.setDoOutput(true);
		conn.setUseCaches(false);
		conn.setConnectTimeout(10000); //连接超时为10秒
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-Type",
				"multipart/form-data; boundary=" + boundary);
	}
    //普通字符串数据
	private void writeStringParams() throws Exception {
		Set<String> keySet = textParams.keySet();
		for (Iterator<String> it = keySet.iterator(); it.hasNext();) {
			String name = it.next();
			String value = textParams.get(name);
			ds.writeBytes("--" + boundary + "\r\n");
			ds.writeBytes("Content-Disposition: form-data; name=\"" + name
					+ "\"\r\n");
			ds.writeBytes("\r\n");
			ds.writeBytes(encode(value) + "\r\n");
		}
	}
    //文件数据
	private void writeFileParams() throws Exception {
		Set<String> keySet = fileparams.keySet();
		for (Iterator<String> it = keySet.iterator(); it.hasNext();) {
			String name = it.next();
			File value = fileparams.get(name);
			ds.writeBytes("--" + boundary + "\r\n");
			ds.writeBytes("Content-Disposition: form-data; name=\"" + name
					+ "\"; filename=\"" + encode(value.getName()) + "\"\r\n");
			ds.writeBytes("Content-Type: " + getContentType(value) + "\r\n");
			ds.writeBytes("\r\n");
			ds.write(getBytes(value));
			ds.writeBytes("\r\n");
		}
	}
    //获取文件的上传类型，图片格式为image/png,image/jpg等。非图片为application/octet-stream
	private String getContentType(File f) throws Exception {
		
//		return "application/octet-stream";  // 此行不再细分是否为图片，全部作为application/octet-stream 类型
		ImageInputStream imagein = ImageIO.createImageInputStream(f);
		if (imagein == null) {
			return "application/octet-stream";
		}
		Iterator<ImageReader> it = ImageIO.getImageReaders(imagein);
		if (!it.hasNext()) {
			imagein.close();
			return "application/octet-stream";
		}
		imagein.close();
		return "image/" + it.next().getFormatName().toLowerCase();//将FormatName返回的值转换成小写，默认为大写

	}
    //把文件转换成字节数组
	private byte[] getBytes(File f) throws Exception {
		FileInputStream in = new FileInputStream(f);
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		byte[] b = new byte[1024];
		int n;
		while ((n = in.read(b)) != -1) {
			out.write(b, 0, n);
		}
		in.close();
		return out.toByteArray();
	}
	//添加结尾数据
	private void paramsEnd() throws Exception {
		ds.writeBytes("--" + boundary + "--" + "\r\n");
		ds.writeBytes("\r\n");
	}
	// 对包含中文的字符串进行转码，此为UTF-8。服务器那边要进行一次解码
    private String encode(String value) throws Exception{
    	return URLEncoder.encode(value, "UTF-8");
    }
    
    /**
     * 本地发送文件至另一台服务器
     * @param url
     * @param localFile
     * @param fileExtends
     * @return
     * @throws Exception
     */
    public static Object sandFile(String url,String localFile,String fileExtends) throws Exception{
    	HttpURLConnectionUtil u = new HttpURLConnectionUtil(url);
    	u.addFileParameter(fileExtends, new File(localFile));
		u.addTextParameter("text", "中文");
		byte[] b = u.send();
		String result = new String(b);
		System.out.println(result);
    	return b;
    }
    
    /**
     * 触发Get请求调用internal Url
     * @param propertisKey
     * @param paramers
     * @return
     * @throws Exception
     */
    public static Object targerNetUrl(String propertisKey,Map<String, String> paramers) throws Exception{
    	StringBuffer _url = new StringBuffer(215);
    	_url.append(Global.getPropertiesItem(propertisKey));
    	if(paramers!=null){
    		_url.append("?");
    		for(Map.Entry<String, String> entry:paramers.entrySet()){    
    			_url.append(entry.getKey()).append("=").append(entry.getValue()).append("&"); 
    		}   
    	} 
    	HttpURLConnectionUtil u = new HttpURLConnectionUtil(_url.toString());
    	u.logger.info("请求Url"+_url);
		u.addTextParameter("text", "中文");
		byte[] b = u.send();
		String result = new String(b);
		System.out.println(result);
		
		if(u.conn.getResponseCode()==HttpURLConnection.HTTP_OK){
			u.logger.info("请求Url状态："+HttpURLConnection.HTTP_OK);
		}
    	return b;
    }
    
	public static void main(String[] args) throws Exception {
		HttpURLConnectionUtil u = new HttpURLConnectionUtil("http://192.168.30.20:8080/pricesheetGen/fileReceive?quotationCode=12345678");
		u.addFileParameter("img", new File(
				"D:/oopdf111.pdf"));
		u.addTextParameter("text", "中文");
		byte[] b = u.send();
		String result = new String(b);
		System.out.println(result);

	}

}
