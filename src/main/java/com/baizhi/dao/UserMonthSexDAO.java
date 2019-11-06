package com.baizhi.dao;


import com.baizhi.entity.UserMonthSex;

import java.util.List;

public interface UserMonthSexDAO{
     List<UserMonthSex> selectCountByMonthSex(String sex);
}
