package egovframework.example.users.web;

import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.RSAPublicKeySpec;

import javax.crypto.Cipher;

public class RSA {

	 private String publicKeyModulus = "";
	 private String publicKeyExponent = "";
	 private PrivateKey privateKey = null;
	 
	 public static RSA getEncKey() { //공개키와 비공개키의 페어를 생성하기 위해 사용
	      KeyPairGenerator generator; //RSA키 제네레이터 생성
	      try {
	         generator = KeyPairGenerator.getInstance("RSA");
	      } catch (NoSuchAlgorithmException e) { //암호 알고리즘이 요구되었음에도 불구하고, 현재의 환경에서 사용 가능하지 않은 경우에 예외를 발생
	         e.printStackTrace();
	         return null;
	      } //RSA키 제네레이터 생성
	      generator.initialize(1024); //키 사이즈 지정
	      
	      
	      KeyPair keyPair = generator.genKeyPair(); //키페어 생성
	      KeyFactory keyFactory;
	      try {
	         keyFactory = KeyFactory.getInstance("RSA");
	      } catch (NoSuchAlgorithmException e) { //암호 알고리즘이 요구되었음에도 불구하고, 현재의 환경에서 사용 가능하지 않은 경우에 예외를 발생
	         e.printStackTrace();
	         return null;
	      }
	      
	      
	      PublicKey publicKey = keyPair.getPublic(); //공개키
	      PrivateKey privateKey = keyPair.getPrivate(); //개인키
	      RSAPublicKeySpec publicSpec; //RSA 공개키를 지정
	      try {
	         publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class); //공개키를 문자열료 변환하여 javaScript RSA 라이브러리 넘겨준다
	      } catch (InvalidKeySpecException e) { //시큐리티 시스템의 클래스와 인터페이스를 제공 //세부 정보 메시지가 없는 InvalidKeySpecException을 생성
	         e.printStackTrace();
	         return null;
	      }
	      
	      String publicKeyModulus = publicSpec.getModulus().toString(16);
	      String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
	       
	      RSA rsa = new RSA();
	      rsa.setPrivateKey(privateKey);
	      rsa.setPublicKeyExponent(publicKeyExponent);
	      rsa.setPublicKeyModulus(publicKeyModulus);
	       
	       return rsa;
	   }
	 
	 
	 public static boolean dec(PrivateKey privateKey, String encString) throws Exception{
	      boolean result = false;
	      
	      if (privateKey == null) {
	            throw new RuntimeException("암호화 비밀키 정보를 찾을 수 없습니다.");
	        }
	      try {
	         decryptRsa(privateKey, encString);
	         result = true;
	      } catch (Exception e) {
	         e.printStackTrace();
	         result = false;
	      }
	        
	      return result;
	   }
	   
	 //복호
	   public static String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception {
	        //System.out.println("will decrypt : " + securedValue);
	        Cipher cipher = Cipher.getInstance("RSA");
	        byte[] encryptedBytes = hexToByteArray(securedValue);
	        cipher.init(Cipher.DECRYPT_MODE, privateKey);
	        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
	        String decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의
	        return decryptedValue;
	    }
	   
	   //16진 문자열을 byte 배열로 변환
	   public static byte[] hexToByteArray(String hex) {
	        if (hex == null || hex.length() % 2 != 0) {
	            return new byte[]{};
	        }

	        byte[] bytes = new byte[hex.length() / 2];
	        for (int i = 0; i < hex.length(); i += 2) {
	            byte value = (byte)Integer.parseInt(hex.substring(i, i + 2), 16);
	            bytes[(int) Math.floor(i / 2)] = value;
	        }
	        return bytes;
	    }


	   public String getPublicKeyModulus() {
			return publicKeyModulus;
		}
	
	   public void setPublicKeyModulus(String publicKeyModulus) {
			this.publicKeyModulus = publicKeyModulus;
		}
	
	   public String getPublicKeyExponent() {
			return publicKeyExponent;
		}
	
	   public void setPublicKeyExponent(String publicKeyExponent) {
			this.publicKeyExponent = publicKeyExponent;
		}
	
	   public PrivateKey getPrivateKey() {
			return privateKey;
		}
	
	   public void setPrivateKey(PrivateKey privateKey) {
			this.privateKey = privateKey;
		}
}
