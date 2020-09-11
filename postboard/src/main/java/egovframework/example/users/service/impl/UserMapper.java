package egovframework.example.users.service.impl;

import egovframework.example.users.service.UserVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("UserMapper")
public interface UserMapper {

	/** 회원 가입한다 */
	void insertUser(UserVO uvo) throws Exception;
	
}
