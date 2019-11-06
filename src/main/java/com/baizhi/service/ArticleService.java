package com.baizhi.service;


import com.baizhi.entity.Article;

import java.util.Map;

public interface ArticleService {

    void modify(Article article);

    Map<String, Object> findAll(Integer page, Integer rows);

    String save(Article article);
}
