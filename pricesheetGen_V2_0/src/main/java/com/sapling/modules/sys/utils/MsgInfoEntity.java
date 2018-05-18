package com.sapling.modules.sys.utils;

import java.util.Map;

public class MsgInfoEntity {
	  private Map<Object, Object> data;
	  private String status;
	  private String msgInf;
	public Map<Object, Object> getData() {
		return data;
	}

	public void setData(Map<Object, Object> data) {
		this.data = data;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMsgInf() {
		return msgInf;
	}

	public void setMsgInf(String msgInf) {
		this.msgInf = msgInf;
	}
	  
}
