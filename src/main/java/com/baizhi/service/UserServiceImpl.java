package com.baizhi.service;

import com.baizhi.dao.UserDAO;
import com.baizhi.entity.User;
import com.baizhi.entity.UserMonthSex;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.SQLOutput;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
@Transactional
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDAO userDAO;
    @Override
    public Map<String, Object> findAllByStarId(Integer page, Integer rows, String starId) {
        User user = new User();
        user.setStarId(starId);
        RowBounds rowBounds = new RowBounds((page-1)*rows,rows);
        List<User> users = userDAO.selectByRowBounds(user, rowBounds);
        int records = userDAO.selectCount(user);
        int total = records%rows==0?records/rows:records/rows+1;
        Map<String, Object> map = new HashMap<>();
        map.put("rows",users);
        map.put("page",page);
        map.put("total",total);
        map.put("records",records);
        return map;
    }

    @Override
    public List<User> findAll() {
        return userDAO.selectAll();
    }


}
