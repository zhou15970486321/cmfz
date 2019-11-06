package com.baizhi.service;

import com.baizhi.entity.Star;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface StarService {
    Map<String, Object> findAll(Integer page, Integer rows);

    String save(Star star);

    void modify(Star star);

    void remove(String id, HttpServletRequest request);

    List<Star> queryAllStars();
}
