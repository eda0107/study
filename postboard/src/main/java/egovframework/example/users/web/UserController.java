package egovframework.example.users.web;

import java.math.BigInteger;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.RSAPublicKeySpec;
import java.util.Base64;

import javax.annotation.Resource;
import javax.crypto.Cipher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.example.users.service.UserService;
import egovframework.example.users.service.UserVO;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class UserController {
	
	private static String RSA_WEB_KEY = "_RSA_WEB_KEY_"; //개인키
	private static String RSA_INSTANCE = "RSA";
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	/** 회원 서비스 */
	@Resource(name="UserService")
	private UserService userService;

	
	/** 로그인 화면 */
	@RequestMapping(value="/login.do")
	public String login(UserVO uvo) throws Exception{
		return "users/login";
	}

	
	/**회원가입 화면 */
	@RequestMapping(value="/regUserView.do")
	public String regUserView(UserVO uvo, Model model, HttpServletRequest request) throws Exception{
		initRsa(model, request); //암호화 실행
		return "users/join";
	}
	
	/**회원가입 */
	@RequestMapping(value="/regUser.do")
	public String regUser(@ModelAttribute("UserVO") UserVO uvo, BindingResult bindingResult, Model model, HttpServletRequest request) throws Exception{
		HttpSession session = request.getSession();
		
		String userId = uvo.getUserId();
		String userPw = uvo.getUserPw();
		
		PrivateKey privateKey = (PrivateKey)session.getAttribute(UserController.RSA_WEB_KEY); 
		
		//복호화
		userId = decryptRsa(privateKey, userId);
		userPw = decryptRsa(privateKey, userPw);

		//sha-512 암호화 (+salt)
		
		String desPw = userPw; //암호화에 사용할 값
		MessageDigest md = MessageDigest.getInstance("SHA-512"); //sha-512 알고리즘 사용
		md.reset(); //인스턴스 초기화
		md.update(desPw.getBytes("utf8")); //암호화에 사용할 값을 바이트 코드로 변환해서 인스턴스에 업데이터
		
		desPw = String.format("%0128x", new BigInteger(1, md.digest())); //128비트로 들어감
		uvo.setUserPw(desPw);
		
		userService.insertUser(uvo);
		return "jsonView";
		
	}
	
	/** 복호화 
	 * 	
	 * @param privateKey
	 * @param securedValue
	 * @return
	 * @throws Exception
	 */
	private String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception{
		 Cipher cipher = Cipher.getInstance(UserController.RSA_INSTANCE);
		 if(privateKey == null) { 
			 throw new RuntimeException("암호화 비밀키 정보가 없습니다.");
		 	}
		 
		 byte[] encrypteBytes = hexToByteArray(securedValue);
		 cipher.init(Cipher.DECRYPT_MODE, privateKey);
		 byte[] decrypteBytes = cipher.doFinal(encrypteBytes);
		 String decrypedStr = new String(decrypteBytes, "UTF-8");
		 return decrypedStr;
		
	}
	
	/** 16진 문자열을 byte 배열로 변환
	 * 
	 * @param hex
	 * @return
	 */
	public static byte[] hexToByteArray(String hex) {
		if(hex == null || hex.length() % 2 != 0) {
			return new byte[]{};
		}
		byte[] bytes = new byte[hex.length()/2];
		for (int i = 0; i < hex.length(); i += 2) {
            byte value = (byte)Integer.parseInt(hex.substring(i, i + 2), 16);
            bytes[(int) Math.floor(i / 2)] = value;
        }
        return bytes;
	}
	
	/** RSA 공개키, 개인키 생성
	 * 
	 * @param model
	 * @param request
	 */
	public void initRsa(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		KeyPairGenerator generator = null; //RSA키 제네레이터 생성
		try {
			generator = KeyPairGenerator.getInstance(UserController.RSA_INSTANCE);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
		generator.initialize(2048); //키 사이즈 지정 *1024는 오류 발생 가능성이 있으므로 2048로 지정
		
		KeyPair keyPair = generator.genKeyPair(); //키페어 생성
	    KeyFactory keyFactory = null;
		try {
			keyFactory = KeyFactory.getInstance(UserController.RSA_INSTANCE);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    PublicKey publicKey = keyPair.getPublic(); //공개키
		PrivateKey privateKey = keyPair.getPrivate(); //개인키
		
		session.setAttribute(UserController.RSA_WEB_KEY, privateKey); //세션에 RAS개인키 주입
		RSAPublicKeySpec publicSpec = null;
		try {
			publicSpec = (RSAPublicKeySpec)keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
		} catch (InvalidKeySpecException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} //공개키를 문자열료 변환하여 javaScript RSA 라이브러리 넘겨준다
		String publicKeyModulus = publicSpec.getModulus().toString(16);
		String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
		
		request.setAttribute("RSAModulus", publicKeyModulus);
		//model.addAttribute("RSAModulus", publicKeyModulus);
		request.setAttribute("RSAExponent", publicKeyExponent);
		//model.addAttribute("RSAExponent", publicKeyExponent);
	}
			
				
}