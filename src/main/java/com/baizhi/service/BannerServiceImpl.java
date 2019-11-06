package com.baizhi.service;

import com.baizhi.dao.BannerDAO;
import com.baizhi.entity.Banner;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
@Transactional
public class BannerServiceImpl implements BannerService {
    @Autowired
    private BannerDAO bannerDAO;

    @Override
    public Map<String,Object> findAll(Integer page, Integer rows) {
        Banner banner = new Banner();
        RowBounds rowBounds = new RowBounds((page-1)*rows,rows);
        List<Banner> banners = bannerDAO.selectByRowBounds(banner, rowBounds);
        //总记录数
        int records = bannerDAO.selectCount(banner);
        int totalPage = records%rows==0?records/rows:records/rows+1;
        Map<String,Object> map = new HashMap<>();
        map.put("rows",banners);
        map.put("page",page);
        //总页数

        map.put("total",totalPage);
        map.put("records",records);
        return map;
    }

    @Override
    public void remove(String id, HttpServletRequest request) {
        Banner banner = bannerDAO.selectByPrimaryKey(id);
        int i = bannerDAO.deleteByPrimaryKey(id);
        System.out.println(i);
        if (i==0){
            throw new RuntimeException("删除失败");
        }else{
            File file = new File(request.getServletContext().getRealPath("/back/img/banner"), banner.getCover());
            if (!file.exists()){
                boolean b = file.delete();
                if (b==false){
                    throw new RuntimeException("轮播图删除失败");
                }
            }

        }

    }

    @Override
    public String add(Banner banner) {
        banner.setId(UUID.randomUUID().toString());
        banner.setCreateDate(LocalDateTime.now());
        int i = bannerDAO.insert(banner);
        if (i==0){
            throw new RuntimeException("添加失败");
        }
        return banner.getId();
    }

    @Override
    public void modify(Banner banner) {
        if ("".equals(banner.getCover())){
            banner.setCover(null);
        }
        try {
            bannerDAO.updateByPrimaryKeySelective(banner);
        }catch (Exception e){
            throw new RuntimeException("修改失败");
        }
    }
}
