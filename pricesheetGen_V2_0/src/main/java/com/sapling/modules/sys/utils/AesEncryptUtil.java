package com.sapling.modules.sys.utils;

import java.security.Key;
import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

import com.sapling.common.mapper.JsonMapper;
import com.sapling.common.utils.StringUtils;
import com.sapling.modules.sys.entity.User;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;  
  
/**  
 * des加密解密  
 *   
 * @author  
 *   
 */  
public class AesEncryptUtil {  

   static Key key;  
   
   private static AesEncryptUtil desEncryptAES = null;
   
   private final static String KEYSTR = "6Ta4OaHZdpA=";
   
   private static AesEncryptUtil getInstance(){
	   if(desEncryptAES==null){
		   desEncryptAES =  new AesEncryptUtil();
	   }
	   desEncryptAES =  new AesEncryptUtil();
	   setKey(KEYSTR);// 生成密匙  
	   return desEncryptAES;
   }
   
   private static AesEncryptUtil getInstance(String key){
	   if(StringUtils.isBlank(key) || key.length()%4!=0){
		   key =  KEYSTR ;// 生成密匙  
	   } 
	   if(desEncryptAES==null){
		   desEncryptAES =  new AesEncryptUtil();
	   }
	   setKey(key);// 生成密匙  
	   return desEncryptAES;
   }
 
   public AesEncryptUtil() {   
	   
   }  
 
 
  
   /**  
    * 根据参数生成KEY  
    */  
   private static void setKey(String strKey) {  
       try {  
           SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");  
           key  = keyFactory.generateSecret(new DESKeySpec(strKey.getBytes("UTF8")));  
       } catch (Exception e) {  
           throw new RuntimeException(  
                   "Error initializing SqlMap class. Cause: " + e);  
       }  
   }  
 
   /**
    * 加密String明文输入,String密文输出
    * @param strMing 明文
    * @param key 字符偏移KEY
    * @return
    */
   public static String encrypt(String strMing,String key) {  
	   getInstance(key);
	   byte[] byteMi = null;  
       byte[] byteMing = null;  
       String strMi = "";  
       BASE64Encoder base64en = new BASE64Encoder();  
       try {  
           byteMing = strMing.getBytes("UTF8");  
           byteMi = getEncCode(byteMing);  
           strMi = base64en.encode(byteMi);  
       } catch (Exception e) {  
           throw new RuntimeException(  
                   "Error initializing SqlMap class. Cause: " + e);  
       } finally {  
           base64en = null;  
           byteMing = null;  
           byteMi = null;  
       }  
       return strMi;  
   }
     
   /**
    * 加密String明文输入,String密文输出  
    * @param strMing  明文
    * @return
    */
   public static String encrypt(String strMing) {  
	   getInstance();
       byte[] byteMi = null;  
       byte[] byteMing = null;  
       String strMi = "";  
       BASE64Encoder base64en = new BASE64Encoder();  
       try {  
           byteMing = strMing.getBytes("UTF8");  
           byteMi = getEncCode(byteMing);  
           strMi = base64en.encode(byteMi);  
       } catch (Exception e) {  
           throw new RuntimeException(  
                   "Error initializing SqlMap class. Cause: " + e);  
       } finally {  
           base64en = null;  
           byteMing = null;  
           byteMi = null;  
       }  
       return strMi;  
   }  
   
   /**
    * 解密 以String密文输入,String明文输出  
    * @param strMi 密文
    * @param Key 字符偏移KEY
    * @return
    */
   public static String decrypt(String strMi,String Key) {  
	   getInstance(Key);
	   BASE64Decoder base64De = new BASE64Decoder();  
       byte[] byteMing = null;  
       byte[] byteMi = null;  
       String strMing = "";  
       try {  
           byteMi = base64De.decodeBuffer(strMi);  
           byteMing = getDesCode(byteMi);  
           strMing = new String(byteMing, "UTF8");  
       } catch (Exception e) {  
           throw new RuntimeException(  
                   "Error initializing SqlMap class. Cause: " + e);  
       } finally {  
           base64De = null;  
           byteMing = null;  
           byteMi = null;  
       }  
       return strMing;  
   }
 
   /**
    * 解密 以String密文输入,String明文输出  
    * @param strMi 密文 
    * @return
    */
   public static String decrypt(String strMi) {  
	   getInstance();
       BASE64Decoder base64De = new BASE64Decoder();  
       byte[] byteMing = null;  
       byte[] byteMi = null;  
       String strMing = "";  
       try {  
           byteMi = base64De.decodeBuffer(strMi);  
           byteMing = getDesCode(byteMi);  
           strMing = new String(byteMing, "UTF8");  
       } catch (Exception e) {  
           throw new RuntimeException(  
                   "Error initializing SqlMap class. Cause: " + e);  
       } finally {  
           base64De = null;  
           byteMing = null;  
           byteMi = null;  
       }  
       return strMing;  
   }  
 
   /**  
    * 加密以byte[]明文输入,byte[]密文输出  
    *   
     * @param byteS  
     * @return  
     */  
    private static byte[] getEncCode(byte[] byteS) {  
        byte[] byteFina = null;  
        Cipher cipher;  
        try {  
            cipher = Cipher.getInstance("DES");  
            cipher.init(Cipher.ENCRYPT_MODE, key,SecureRandom.getInstance("SHA1PRNG"));  
            byteFina = cipher.doFinal(byteS);  
        } catch (Exception e) {  
            throw new RuntimeException(  
                    "Error initializing SqlMap class. Cause: " + e);  
        } finally {  
            cipher = null;  
        }  
        return byteFina;  
    }  
  
    /**  
     * 解密以byte[]密文输入,以byte[]明文输出  
     *   
     * @param byteD  
     * @return  
     */  
    private static byte[] getDesCode(byte[] byteD) {  
        Cipher cipher;  
        byte[] byteFina = null;  
        try {  
            cipher = Cipher.getInstance("DES");  
            cipher.init(Cipher.DECRYPT_MODE, key,SecureRandom.getInstance("SHA1PRNG"));  
            byteFina = cipher.doFinal(byteD);  
        } catch (Exception e) {  
            throw new RuntimeException(  
                    "Error initializing SqlMap class. Cause: " + e);  
        } finally {  
            cipher = null;  
        }  
        return byteFina;  
    }  
  
      
  
    public static void main(String args[])  {  
    	AesEncryptUtil des = new AesEncryptUtil();  
  
        String str1 = "哈哈哈哈";  
        // DES加密  
        String str2 = des.encrypt(str1);  
//        String deStr = des1.decrypt("7BJvK8J4lUAEaEeyAD0yo6KOH4ivcSZ4");  
        System.out.println("密文:" + str2);  
        // DES解密  
//        System.out.println("明文:" + deStr);  
        System.out.println("明文:" + des.decrypt(str2));  
//        String string="yJACjhauHLkdKc1yz3jVhGkOhE/RxnwmUN/ObyzopFVAXKJ2m5CrO3LQ9zJ2vuejt9ajRYmmmQJLCICpzbNnSrdpaimz2LGXvhlxg25ei4n7WEh5EuwR5siFnZB/pchwl7j3LiH0a52/fU9C7nHr/H98bLzEBJyJIeF/tWHbdiCLSpGQh+pPzgHleCxvISPgssEINtermQqV1UQoVa2oR4RF576kjGz33wjb6MnMnhN01tkeiOKzD3Bahlze5y2x+HtU3RR15SiBn3CT/V9mZ3TW2R6I4rMPCXjXk1nyi4fBdZrT169ScYY1hw4SD0CtI6q137qPxwtgyL5tVNA0Fa4vjnxe3zzcyIWdkH+lyHCOuI0D8Kd1OPrsXugF0aC688R+gKrnZh0q0xlO/w/QM03fw1oO0yBUCOc41M/yiosc4eE+ItCAwZfwKrEn1L3BSwiAqc2zZ0oOgFgN5Ni4EJ9dUEuAOayS6MVSSR3MevbVtwm0RHr2AVXMtORZOyBVxgL0Xl4ISJI=";
//        System.out.println("明文:" + des.decrypt("string")); 
        User u = new User();
        u.setId("abcd");
        u.setLoginFlag("cccc");
        
        String bbb = JsonMapper.getInstance().toJson(u);
        System.out.println(bbb);
        System.out.println(des.encrypt(bbb));
        System.out.println(AesEncryptUtil.decrypt(des.encrypt(bbb))); 
    	
    }  
  
}  
