package com.sapling.modules.sys.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.Date;

import net.sf.json.JSONObject;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.github.qcloudsms.SmsSingleSender;
import com.github.qcloudsms.SmsSingleSenderResult;

public class HttpRequest {
	private static final Logger logger = LoggerFactory.getLogger(HttpRequest.class);
	private static final  int appid = 1400066864;
	private static final  String appkey = "c817e67b09ae2e0d1f62dd6f513277ef";
	
    public static int sendMsg(String phone,String code){
    	try {
         	SmsSingleSender sender = new   SmsSingleSender(appid, appkey);
         	SmsSingleSenderResult result = sender.send(0, "86", phone, "您的登录验证码为："+code+"，请及时登录。如非本人操作，请忽略。", "", "123");
         	if(result.result==0){
         		return 1;
         	}
    	} catch (Exception e) {
         	e.printStackTrace();
         	return 0;
         }
    	
    	return 0;
    }
    
    public static void main(String[] args) {
         String phoneNumber1 = "15000570851";
        
         try {
         	SmsSingleSender sender = new   SmsSingleSender(appid, appkey);
         	SmsSingleSenderResult result = sender.send(0, "86", phoneNumber1, "您的登录验证码为：4987，请及时登录。如非本人操作，请忽略。", "", "");
         	  System.err.println(result);
         } catch (Exception e) {
         	e.printStackTrace();
         	}
	}
    
}
