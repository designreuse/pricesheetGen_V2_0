package com.sapling.modules.quotation.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;

import com.itextpdf.text.Image;
import com.itextpdf.text.pdf.PdfArray;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfDictionary;
import com.itextpdf.text.pdf.PdfName;
import com.itextpdf.text.pdf.PdfObject;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;
import com.itextpdf.text.pdf.parser.ImageRenderInfo;
import com.itextpdf.text.pdf.parser.PdfReaderContentParser;
import com.itextpdf.text.pdf.parser.RenderListener;
import com.itextpdf.text.pdf.parser.TextRenderInfo;
import com.sapling.common.config.Global;
import com.sapling.common.utils.ExchangeMail;

/** 
 * @ClassName: HtmlToPdf 
 * @Description: TODO() 
 * @author xsw
 * @date 2016-12-8 上午10:14:54 
 *  
 */

public class HtmlToPdf {
    //wkhtmltopdf在系统中的路径
    private static final String toPdfTool = "E:\\tool\\wkhtmltopdf\\bin\\wkhtmltopdf.exe";

	private static float fy = 0;
	private static float fx = 0;
	
	 // 定义关键字
    private static String KEY_WORD = "";
    // 定义返回值
    private static float[] resu = null;
   // 定义返回页码
    private static int i = 0;
	
    /**
     * html转pdf
     * @param srcPath html路径，可以是硬盘上的路径，也可以是网络路径
     * @param destPath pdf保存路径
     * @return 转换成功返回true
     */
    public static boolean convert(String srcPath, String destPath){
        File file = new File(destPath);
        File parent = file.getParentFile();
        //如果pdf保存路径不存在，则创建路径
        if(!parent.exists()){
            parent.mkdirs();
        }
        
        StringBuilder cmd = new StringBuilder();
        cmd.append(toPdfTool);
        cmd.append(" ");
        cmd.append("  --header-line");//页眉下面的线
        cmd.append("  --header-center 这里是页眉这里是页眉这里是页眉这里是页眉 ");//页眉中间内容
        //cmd.append("  --margin-top 30mm ");//设置页面上边距 (default 10mm) 
        cmd.append(" --header-spacing 10 ");//    (设置页眉和内容的距离,默认0)
        cmd.append(srcPath);
        cmd.append(" ");
        cmd.append(destPath);
        
        boolean result = true;
        try{
            Process proc = Runtime.getRuntime().exec(cmd.toString());
            HtmlToPdfInterceptor error = new HtmlToPdfInterceptor(proc.getErrorStream());
            HtmlToPdfInterceptor output = new HtmlToPdfInterceptor(proc.getInputStream());
            error.start();
            output.start();
            proc.waitFor();
        }catch(Exception e){
            result = false;
            e.printStackTrace();
        }
        
        return result;
    }
    

	/**
	 * 盖章
	 * @param sourcePdfPath		待盖章PDF路径
	 * @param saveAsPdfPath		盖章后的PDF保存路径
	 * @param esealPath			印章路径
	 * @throws Exception 
	 */
	public static boolean signPdf(String sourcePdfPath, String saveAsPdfPath, String esealPath) {
		boolean signSuc = true;
		// 创建一个pdf读入流
		PdfReader reader = null;
		// 根据一个pdfreader创建一个pdfStamper.用来生成新的pdf.
		PdfStamper stamper = null;

		try {
			// 删除原有文件
			deletePdf(saveAsPdfPath);
			
			reader = new PdfReader(sourcePdfPath);
			stamper = new PdfStamper(reader, new FileOutputStream(saveAsPdfPath));
			
			// 获取pdf页
			int pages = reader.getNumberOfPages();

			// 根据关键字查找坐标
			final String key = "盖";
			PdfReaderContentParser pdfReaderContentParser = new PdfReaderContentParser(reader);
			pdfReaderContentParser.processContent(pages, new RenderListener() {
				@Override
				public void renderText(TextRenderInfo textRenderInfo) {
					String text = textRenderInfo.getText();
					if (null != text && text.contains(key)) {
						com.itextpdf.awt.geom.Rectangle2D.Float boundingRectange = textRenderInfo.getBaseline()
								.getBoundingRectange();
						fy = boundingRectange.y;
						fx = boundingRectange.x;
					}
				}

				@Override
				public void renderImage(ImageRenderInfo arg0) {
					// TODO Auto-generated method stub

				}

				@Override
				public void endTextBlock() {
					// TODO Auto-generated method stub

				}

				@Override
				public void beginTextBlock() {
					// TODO Auto-generated method stub

				}
			});

			// 编辑最后一页
			PdfContentByte over = stamper.getOverContent(pages);

			// 用pdfreader获得当前页字典对象.包含了该页的一些数据.比如该页的坐标轴信息
			PdfDictionary p = reader.getPageN(pages);

			// 拿到mediaBox 里面放着该页pdf的大小信息
			PdfObject po = p.get(new PdfName("MediaBox"));

			// po是一个数组对象.里面包含了该页pdf的坐标轴范围
			PdfArray pa = (PdfArray) po;

			// float fy = pa.getAsNumber(pa.size()-1).floatValue()-800;
			// float fx = pa.getAsNumber(pa.size()-2).floatValue()-200;

			Image image = Image.getInstance(esealPath);
//			image.setAbsolutePosition(fx - 60, fy - 30);
			//此处精度要求不高
			if(image.getWidth() > 80)
				image.scaleAbsolute(80, 75);
			image.setAbsolutePosition(fx-35,fy-30);
			over.addImage(image);
		} catch (Exception e) {
			signSuc = false;
			e.printStackTrace();
		} finally {
			try {
				if (stamper != null)
					stamper.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (reader != null)
				reader.close();
		}
		return signSuc;
	}
	
	/**
	 * 删除原有pdf
	 * @param pdfPath
	 */
	private static void deletePdf(String pdfPath) {  
        File pdfFile = new File(pdfPath);  
        if (pdfFile.exists()) {  
            pdfFile.delete();  
        }  
    }
    
    
    public static void main(String[] args) {
    	System.err.println(Global.getConfig("wkhtmltopdfUrl"));
		String subject="上海小数信息技术有限公司报价单";
		List<String> to = new ArrayList<String>();
		to.add("718713192@qq.com");
		String bodyText="本邮件由上海小数信息技术有限公司商务指定邮件发出；";
		String fileName = "D:\\wkhtmltopdf.pdf";

		try {
			ExchangeMail.doSend(subject,to,null,bodyText,fileName);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

//        HtmlToPdf.convert("http://localhost:8080/pricesheetGen/static/quotation/quotationOrder/show?id=1ce524e8d5014bd9aa4ec1af8073762a", "d:/wkhtmltopdf.pdf");
    }
}