package com.baizhi.service;

import com.baizhi.entity.Admin;

import javax.servlet.http.HttpServletRequest;

public interface AdminService {
    void login(Admin admin, String code, HttpServletRequest request) throws Exception;
}
