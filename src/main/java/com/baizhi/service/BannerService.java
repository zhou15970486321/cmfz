package com.baizhi.service;

import com.baizhi.entity.Banner;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public interface BannerService {

    Map<String,Object> findAll(Integer page, Integer rows);
    void remove(String id, HttpServletRequest request);

    String add(Banner banner);

    void modify(Banner banner);
}
