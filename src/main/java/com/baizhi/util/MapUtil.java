package com.baizhi.util;

import com.baizhi.entity.Album;
import org.apache.ibatis.session.RowBounds;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



public class MapUtil {
    /*public Map<String, Object> findAll(T t,Integer page, Integer rows) {
        T t= new T();
        RowBounds rowBounds = new RowBounds((page-1)*rows,rows);
        List<Album> list = albumDAO.selectByRowBounds(t,rowBounds);
        int records = albumDAO.selectCount(t);
        int total = records%rows==0?records/rows:records/rows+1;
        Map<String, Object> map = new HashMap<>();
        map.put("rows",list);
        map.put("page",page);
        map.put("total",total);
        map.put("records",records);
        return map;
    }*/
}
