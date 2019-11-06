package com.baizhi.service;

import com.baizhi.dao.AlbumDAO;
import com.baizhi.dao.StarDAO;
import com.baizhi.entity.Album;
import com.baizhi.entity.Star;
import javafx.fxml.FXMLLoader;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class AlbumServiceImpl implements AlbumService {
    @Autowired
    private AlbumDAO albumDAO;
    @Autowired
    private StarDAO starDAO;
    @Override
    public Map<String, Object> findAll(Integer page,Integer rows,String starId) {
        Album album = new Album();
        RowBounds rowBounds = new RowBounds((page-1)*rows,rows);
        List<Album> albums = albumDAO.selectByRowBounds(album,rowBounds);
        for (Album a : albums) {
            Star star = starDAO.selectByPrimaryKey(a.getStarId());
            a.setStar(star);
        }
        int records = albumDAO.selectCount(album);
        int total = records%rows==0?records/rows:records/rows+1;
        Map<String, Object> map = new HashMap<>();
        map.put("rows",albums);
        map.put("page",page);
        map.put("total",total);
        map.put("records",records);
        return map;
    }

    @Override
    public String add(Album album) {
        album.setId(UUID.randomUUID().toString());
        album.setCount(0);
        album.setCreateDate(LocalDateTime.now());
        int i = albumDAO.insert(album);
        if (i==0){
            throw new RuntimeException("添加失败");
        }
        return album.getId();
    }

    @Override
    public void modify(Album album) {
        if("".equals(album.getCover())){
            album.setCover(null);
        }
        try {
            albumDAO.updateByPrimaryKeySelective(album);
        }catch (Exception e){
            throw new RuntimeException("修改失败");
        }
    }

    @Override
    public void remove(String id, HttpServletRequest request) {
        Album album = albumDAO.selectByPrimaryKey(id);
        int i = albumDAO.deleteByPrimaryKey(id);
        if (i==0){
            throw new RuntimeException("删除专辑失败");
        }else{
            File file = new File(request.getServletContext().getRealPath("/back/img/album"), album.getCover());
            boolean d = file.delete();
            if (d==false){
                throw new RuntimeException("删除专辑图片失败");
            }
        }
    }

    @Override
    public Album findOne(String albumId) {
        return albumDAO.selectByPrimaryKey(albumId);
    }
}
