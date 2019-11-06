package com.baizhi.controller;

import com.baizhi.entity.Album;
import com.baizhi.service.AlbumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("album")
public class AlbumController {
    @Autowired
    private AlbumService albumService;
    @RequestMapping("findAll")
    public Map<String,Object> findAll(Integer page,Integer rows,String starId){
        return albumService.findAll(page,rows,starId);
    }
    @RequestMapping("edit")
    public Map<String,Object> edit(Album album,String oper,HttpServletRequest request){
        Map<String, Object> map = new HashMap<>();

        try {
            if ("add".equals(oper)) {
                String id = albumService.add(album);
                map.put("message", id);
            }
            if ("edit".equals(oper)){
                albumService.modify(album);
            }
            if ("del".equals(oper)){
                albumService.remove(album.getId(),request);
            }
            map.put("status",true);
        }catch (Exception e){
            map.put("status",false);
            map.put("message",e.getMessage());
        }
        return map;
    }
    @RequestMapping("upload")
    public Map<String,Object> upload(HttpServletRequest request, MultipartFile cover,String id){
        Map<String, Object> map = new HashMap<>();
        try {
            File file = new File(request.getServletContext().getRealPath("/back/img/album/"), cover.getOriginalFilename());
            cover.transferTo(file);
            Album album = new Album();
            album.setId(id).setCover(cover.getOriginalFilename());
            albumService.modify(album);
            map.put("status",true);
        } catch (IOException e) {
            e.printStackTrace();
            map.put("status",false);
        }
        return map;
    }
}
