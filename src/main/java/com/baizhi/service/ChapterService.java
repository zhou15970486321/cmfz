package com.baizhi.service;

import com.baizhi.entity.Chapter;

import java.util.Map;

public interface ChapterService {
    Map<String,Object> findAllByAlbumId(String albumId, Integer page, Integer rows);

    String save(Chapter chapter);

    void modify(Chapter chapter);
}
