package com.baizhi;

import com.baizhi.dao.*;
import com.baizhi.entity.*;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
class CmfzApplicationTests {
    @Autowired
    private StarDAO starDAO;
    @Autowired
    private UserMonthSexDAO userMonthSexDAO;
    @Autowired
    private ChapterDAO chapterDAO;

    @Test
    void text() {
        List<UserMonthSex> userMonthSexes = userMonthSexDAO.selectCountByMonthSex("女");
        for (UserMonthSex userMonthSex : userMonthSexes) {
            System.out.println(userMonthSex);
        }
    }



}

