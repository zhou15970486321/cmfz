package com.baizhi.service;

import com.baizhi.dao.StarDAO;
import com.baizhi.entity.Star;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class StarServiceImpl implements StarService {
    @Autowired
    private StarDAO starDAO;

    @Override
    public Map<String, Object> findAll(Integer page, Integer rows) {
        Star star = new Star();
        RowBounds rowBounds = new RowBounds((page-1)*rows,rows);
        List<Star> stars = starDAO.selectByRowBounds(star, rowBounds);
        int records = starDAO.selectCount(star);
        int total = records%rows==0?records/rows:records/rows+1;
        Map<String, Object> map = new HashMap<>();
        map.put("rows",stars);
        map.put("page",page);
        map.put("total",total);
        map.put("records",records);
        return map;
    }

    @Override
    public String save(Star star) {
        star.setId(UUID.randomUUID().toString());
        System.out.println(star.getId());
        int i = starDAO.insert(star);
        if (i==0){
            throw new RuntimeException("添加失败");
        }
        return star.getId();
    }

    @Override
    public void modify(Star star) {
        if("".equals(star.getPhoto())){
            star.setPhoto(null);
        }
        try {
            starDAO.updateByPrimaryKeySelective(star);
        }catch (Exception e){
            throw new RuntimeException("修改失败");
        }
    }

    @Override
    public void remove(String id, HttpServletRequest request) {
        Star star = starDAO.selectByPrimaryKey(id);
        int i = starDAO.deleteByPrimaryKey(id);
        if (i==0){
            throw new RuntimeException("删除失败");
        }else{
            File file = new File(request.getServletContext().getRealPath("/back/img/star"), star.getPhoto());
            boolean b = file.delete();
            if (b==false){
                throw new RuntimeException("删除图片失败");
            }
        }
    }

    @Override
    public List<Star> queryAllStars() {
        List<Star> stars = starDAO.selectAll();
        return stars;
    }
}
