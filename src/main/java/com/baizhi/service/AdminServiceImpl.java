package com.baizhi.service;

import com.baizhi.dao.AdminDAO;
import com.baizhi.entity.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;

@Service
@Transactional
public class AdminServiceImpl implements AdminService {
    @Autowired
    private AdminDAO adminDAO;
    @Override
    @Transactional(propagation = Propagation.SUPPORTS )
    public void login(Admin admin, String code, HttpServletRequest request) throws Exception {
        String sessionCode = (String) request.getSession().getAttribute("code");
        if (sessionCode.equalsIgnoreCase(code)){
            Admin adminDB = adminDAO.selectOne(admin);
            if (admin==null){
                throw new Exception("用户名或密码错误");
            }else{
                request.getSession().setAttribute("admin",adminDB);
            }
        }else{
            throw new Exception("验证码错误");
        }


    }
}
