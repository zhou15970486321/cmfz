package com.baizhi.service;

import com.baizhi.dao.ChapterDAO;
import com.baizhi.entity.Chapter;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
@Transactional
public class ChapterServiceImpl implements ChapterService {
    @Autowired
    private ChapterDAO chapterDAO;
    @Override
    public Map<String, Object> findAllByAlbumId(String albumId, Integer page, Integer rows) {
        Chapter chapter = new Chapter();
        chapter.setAlbumId(albumId);
        RowBounds rowBounds = new RowBounds((page - 1) * rows, rows);
        List<Chapter> chapters = chapterDAO.selectByRowBounds(chapter,rowBounds);
        int records = chapterDAO.selectCount(chapter);
        int total = records%rows==0?records/rows:records/rows+1;
        Map<String, Object> map = new HashMap<>();
        map.put("rows",chapters);
        map.put("page",page);
        map.put("total",total);
        map.put("records",records);
        return map;
    }

    @Override
    public String save(Chapter chapter) {
        chapter.setId(UUID.randomUUID().toString());
        chapter.setCreateDate(LocalDateTime.now());
        int i = chapterDAO.insert(chapter);
        if (i==0){
            throw new RuntimeException("添加失败");
        }
        return chapter.getId();
    }

    public void modify(Chapter chapter){
        int i = chapterDAO.updateByPrimaryKeySelective(chapter);
        if (i==0){
            throw new RuntimeException("修改失败");
        }
    }




}
