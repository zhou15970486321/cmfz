package com.baizhi.service;

import com.baizhi.dao.ArticleDAO;
import com.baizhi.entity.Article;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class ArticleServiceImpl implements ArticleService {

    @Autowired
    private ArticleDAO articleDAO;

    @Override
    public Map<String, Object> findAll(Integer page, Integer rows) {
        Article article = new Article();
        RowBounds rowBounds = new RowBounds((page - 1) * rows, rows);
        List<Article> articles = articleDAO.selectByRowBounds(article, rowBounds);
        int records = articleDAO.selectCount(article);
        int total = records%rows==0?records/rows:records/rows+1;
        Map<String, Object> map = new HashMap<>();
        map.put("rows",articles);
        map.put("page",page);
        map.put("total",total);
        map.put("records",records);
        return map;
    }

    @Override
    public void modify(Article article) {
        int i = articleDAO.updateByPrimaryKeySelective(article);
        if (i==0){
            throw new RuntimeException("修改失败");
        }
    }

    @Override
    public String save(Article article) {
        article.setId(UUID.randomUUID().toString());
        article.setCreateDate(LocalDateTime.now());
        int i = articleDAO.insert(article);
        if (i==0){
            throw new RuntimeException("添加失败");
        }
        return article.getId();
    }
}
