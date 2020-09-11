package egovframework.example.users.service.impl;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.example.users.service.UserService;
import egovframework.example.users.service.UserVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("UserService")
public class UserServiceImpl extends EgovAbstractServiceImpl implements UserService{

	private static final Logger LOGGER = LoggerFactory.getLogger(UserServiceImpl.class);
	
	@Resource(name="UserMapper")
	private UserMapper userDAO;

	@Override
	public void insertUser(UserVO uvo) throws Exception {
		userDAO.insertUser(uvo);
	}
	
	
}
