package com.baizhi.service;

import com.baizhi.entity.Album;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public interface AlbumService {
    Map<String, Object> findAll(Integer page,Integer rows,String starId);

    String add(Album album);

    void modify(Album album);

    void remove(String id, HttpServletRequest request);

    Album findOne(String albumId);
}
