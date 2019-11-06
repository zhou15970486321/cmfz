package com.baizhi.controller;

import com.baizhi.entity.Star;
import com.baizhi.service.StarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("star")
public class StarController {
    @Autowired
    private StarService starService;
    @RequestMapping("findAll")
    public Map<String,Object> findAll(Integer page,Integer rows){
        return starService.findAll(page,rows);
    }
    @RequestMapping("edit")
    public Map<String,Object> edit(Star star, String oper, HttpServletRequest request){
        Map<String, Object> map = new HashMap<>();
        try {
            if ("add".equals(oper)){
                String id = starService.save(star);
                map.put("message",id);
            }
            if ("edit".equals(oper)){
                starService.modify(star);
            }
            if ("del".equals(oper)){
                starService.remove(star.getId(),request);
            }
            map.put("status",true);
        }catch (Exception e){
            map.put("message",e.getMessage());
            map.put("status",false);
        }
        return map;
    }
    @RequestMapping("upload")
    public Map<String,Object> upload(MultipartFile photo,String id, HttpServletRequest request){
        System.out.println("1111111111111");
        Map<String, Object> map = new HashMap<>();
        System.out.println(id);
        System.out.println(photo.getOriginalFilename());
        try {
            File file = new File(request.getServletContext().getRealPath("/back/img/star/"), photo.getOriginalFilename());
            photo.transferTo(file);
            Star star = new Star();
            star.setId(id).setPhoto(photo.getOriginalFilename());
            System.out.println(star.getPhoto());
            starService.modify(star);
            map.put("status",true);
        } catch (IOException e) {
            map.put("status",false);
        }
        return map;
    }

    @RequestMapping("queryAllStats")
    public void queryAllStats(HttpServletResponse response) throws IOException {
        List<Star> stars=starService.queryAllStars();
        String str ="<select>";
        for (Star star:stars){
            str+="<option value="+star.getId()+">"+star.getName()+"</option>";
        }
        str+="</select>";
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().print(str);
    }

}
