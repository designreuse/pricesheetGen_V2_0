package com.sapling.common.servlet;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ckfinder.connector.ServletContextFactory;
import com.sapling.common.config.Global;

/**
 * Servlet implementation class FileReceiveServlet
 */
public class FileReceiveServlet extends HttpServlet {
	/**
	 * Logger for this class
	 */
	private Logger logger = LoggerFactory.getLogger(getClass());
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		super.init();
		String _file;
		try {
			String _bfir = ServletContextFactory.getServletContext().getRealPath("/")+ Global.USERFILES_BASE_URL.replace("/", "").toString();
			File fir =  new File(_bfir);
			if(!fir.exists()){
				fir.mkdir();    
			}
			_file = _bfir + "/temp/";
			File file =new File(_file);    
			if  (!file .exists()  && !file .isDirectory())      
			{       
				logger.info("创建临时文件夹"+_file);  
				file.mkdir();    
			} 
			Global.USERFILES_BASE_TEMP_URL = _file;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//如果文件夹不存在则创建    
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		fileReceive(req,resp);
	}

	private void fileReceive(HttpServletRequest req, HttpServletResponse resp) {
		logger.info("接收文件+++++++++++++++++++"+req.getParameter("id") + ".pdf");
		try {
			req.setCharacterEncoding("UTF-8");
			String fileName = Global.USERFILES_BASE_TEMP_URL + req.getParameter("id") + ".pdf";
			File nf = new File(fileName);// 原本准备上传文件名
			if (!nf.exists()) {
				nf.createNewFile();
			}
			BufferedOutputStream bof = new BufferedOutputStream(new FileOutputStream(nf));
			ServletInputStream up = req.getInputStream();// 获取ServletInputStream

			try {
				int i = up.read();
				while (i != -1) {
					bof.write(i);
					i = up.read();
				}
				bof.close();
			} catch (Exception e) {
				bof.close();
				nf.delete();// 上传失败的删掉改文件
				nf = null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("接收文件"+req.getParameter("id") + ".pdf出现异常状况！", e); 
		}

	}

}
