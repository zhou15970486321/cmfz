package com.baizhi.controller;

import com.baizhi.service.UserMOnthSexService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("userMonthSex")
public class UserMonthSexController {
    @Autowired
    private UserMOnthSexService userMOnthSexService;

    @RequestMapping("findAll")
    public Map<String,Object> findAll(){
        return userMOnthSexService.findAll();
    }


}
