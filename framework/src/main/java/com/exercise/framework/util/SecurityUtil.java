package com.dt.framework.util;


import java.security.MessageDigest;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;


/**
 * 加密工具
 * @author yuwei
 * @Time 2015-6-16下午12:55:05
 */
public class SecurityUtil {
	private final static String SECURITY_KEY = "sfdfyu8**((^$$$SDSDSDDsdsvcx234ex,,,cjv.xckv...";
	private final static char HEX_DIGIT[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
	
	public final static String getMD5(String s) {
		return getSecurityByAlgor("MD5", s);
	}
	
	public final static String getSha1(String s) {
		return getSecurityByAlgor("SHA-1", s);
	}
	
	private static String getSecurityByAlgor(String algor, String s) {
		try {
			byte[] strTemp = s.getBytes();
			MessageDigest mdTemp = MessageDigest.getInstance(algor);
			mdTemp.update(strTemp);
			byte[] md = mdTemp.digest();
			int j = md.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = md[i];
				str[k++] = HEX_DIGIT[byte0 >>> 4 & 0xf];
				str[k++] = HEX_DIGIT[byte0 & 0xf];
			}
			return new String(str).toLowerCase();
		} catch (Exception e) {
			return null;
		}
	}
	
	
	public static String encode(String s) {
		if (s == null) {
			return null;
		}
		s = encrypt(s);
		
		String ori = s + "," + getMD5(SECURITY_KEY);
		String secr = getMD5(ori);
		return encrypt(s + "," + secr);
	}

	public static String decode(String s) {
		if (s == null) {
			return null;
		}
		
		try {
			String str = new String(decrypt(s));
			String[] arr = str.split(",");
			if(arr == null || arr.length != 2) {
				return null;
			}
			if(arr[1].equals(getMD5(arr[0] + "," + getMD5(SECURITY_KEY)))) {
				return new String(decrypt(arr[0]));
			} else {
				return null;
			}
		} catch (Exception e) {
			return null;
		}
	}
	
	private static String encrypt(String word) {
		try {
			Cipher encrypt = Cipher.getInstance("DES");
			encrypt.init(1, buildDESKey(getMD5(SECURITY_KEY)));
			return bytesToHexStr(encrypt.doFinal(word.getBytes()));
		} catch (Exception e) {
			return null;
		}
	}
	
	private static String decrypt(String word) {
		try {
			Cipher decrypt = Cipher.getInstance("DES");
			decrypt.init(2, buildDESKey(getMD5(SECURITY_KEY)));
			return new String(decrypt.doFinal(hexStrToBytes(word)));
		} catch (Exception e) {
			return null;
		}
	}
	
	private static SecretKey buildDESKey(String value) {
		byte[] byteValue = value.getBytes();
		byte[] eight_bit = new byte[8];
		for (int i = 0; (i < eight_bit.length) && (i < byteValue.length); i++) {
			eight_bit[i] = byteValue[i];
		}
		return new SecretKeySpec(eight_bit, "DES");
	}
	
	private static byte[] hexStrToBytes(String value) {
		if (value.length() < 1) {
			return null;
		}
		byte[] result = new byte[value.length()/2];
		for (int i = 0;i< value.length()/2; i++) {
			int high = Integer.parseInt(value.substring(i*2, i*2+1), 16);
			int low = Integer.parseInt(value.substring(i*2+1, i*2+2), 16);
			result[i] = (byte) (high * 16 + low);
		}
		return result;
	}
	
	private static String bytesToHexStr(byte[] value) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < value.length; i++) {
			String hex = Integer.toHexString(value[i] & 0xFF);
			if (hex.length() == 1) {
			hex = '0' + hex;
		}
			sb.append(hex.toLowerCase());
		}
		return sb.toString();
	}
}
