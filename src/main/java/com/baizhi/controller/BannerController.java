package com.baizhi.controller;

import com.baizhi.entity.Banner;
import com.baizhi.service.BannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.HashMap;
import java.util.Map;

@RequestMapping("banner")
@RestController
public class BannerController {
    @Autowired
    private BannerService bannerService;

    @RequestMapping("findAll")
    public Map<String,Object> findAll(Integer page,Integer rows){

        return bannerService.findAll(page,rows);
    }
    @RequestMapping("edit")
    public Map<String,Object> edit(Banner banner,String oper,HttpServletRequest request){
        Map<String, Object> map = new HashMap<>();
        try {
            if ("add".equals(oper)) {
                String id = bannerService.add(banner);
                map.put("message",id);
            }
            if ("del".equals(oper)) {
                bannerService.remove(banner.getId(),request);
            }
            if ("edit".equals(oper)) {
                bannerService.modify(banner);
            }
            map.put("status",true);
        }catch (Exception e){
            map.put("status",false);
            map.put("message",e.getMessage());
        }
        return map;
    }
    @RequestMapping("upload")
    public Map<String,Object> upload(MultipartFile cover, String id, HttpServletRequest request){
        Map<String, Object> map = new HashMap<>();
        try {
            File file = new File(request.getServletContext().getRealPath("/back/img/banner"), cover.getOriginalFilename());
            cover.transferTo(file);
            Banner banner = new Banner();
            banner.setId(id).setCover(cover.getOriginalFilename());
            bannerService.modify(banner);
            map.put("status",true);
        }catch (Exception e){
            map.put("status",false);
        }
        return map;
    }



}
