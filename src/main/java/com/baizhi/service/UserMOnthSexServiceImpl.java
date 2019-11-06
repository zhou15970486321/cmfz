package com.baizhi.service;

import com.baizhi.dao.UserMonthSexDAO;
import com.baizhi.entity.UserMonthSex;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserMOnthSexServiceImpl implements UserMOnthSexService {
    @Autowired
    private UserMonthSexDAO userMonthSexDAO;

    public Map<String,Object> findAll(){
        List<UserMonthSex> manDB = userMonthSexDAO.selectCountByMonthSex("男");
        List<UserMonthSex> womanDB = userMonthSexDAO.selectCountByMonthSex("女");
        String[] month = new String[6];
        int[] man = new int[6];
        int[] woman = new int[6];
        int i =0;
        for (int j = 0; j <6 ; j++) {
            month[j]= (j+1)+"月";
        }
        for (UserMonthSex userMonthSex : manDB) {
            for (int j = 0; j <6 ; j++) {
                if ((((j+1)+"月").equals(userMonthSex.getMonth()+"月"))){
                    man[j] = userMonthSex.getCount();

                }
            }
            i++;
        }
        i=0;
        for (UserMonthSex userMonthSex : womanDB) {
            for (int j = 0; j <6 ; j++) {
                if (((j+1)+"月").equals(userMonthSex.getMonth()+"月")){
                    woman[j]=userMonthSex.getCount();
                }
            }
            i++;
        }
        Map<String, Object> map = new HashMap<>();
        map.put("month",month);
        map.put("man",man);
        map.put("woman",woman);
        return map;
    }
}
