package com.baizhi.controller;

import com.baizhi.entity.Album;
import com.baizhi.entity.Chapter;
import com.baizhi.service.AlbumService;
import com.baizhi.service.ChapterService;
import it.sauronsoftware.jave.Encoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

@RequestMapping("chapter")
@RestController
public class ChapterController {
    @Autowired
    private ChapterService chapterService;
    @Autowired
    private AlbumService albumService;
    @RequestMapping("findAllByAlbumId")
    public Map<String,Object> findAllByAlbumId(String albumId,Integer page,Integer rows){
        return chapterService.findAllByAlbumId(albumId,page,rows);
    }
    @RequestMapping("edit")
    public Map<String,Object> edit(Chapter chapter,String oper){
        Map<String, Object> map = new HashMap<>();
        try {
            if ("add".equals(oper)) {
                String id = chapterService.save(chapter);
                map.put("message",id);
            }
            map.put("status",true);
        }catch (Exception e){
            map.put("status",false);
        }
        return map;
    }
    @RequestMapping("upload")
    public Map<String,Object> upload(MultipartFile name, String id, String albumId, HttpServletRequest request){
        System.out.println("id"+id);
        Map<String, Object> map = new HashMap<>();
        try {
//        处理文件上传
            File file = new File(request.getServletContext().getRealPath("/back/img/chapter/"), name.getOriginalFilename());
            name.transferTo(file);
//        修改文件名称
            Chapter chapter = new Chapter();
            chapter.setId(id);
            chapter.setName(name.getOriginalFilename());
//            文件大小
            BigDecimal size = new BigDecimal(name.getSize());
            BigDecimal mod = new BigDecimal(1024);
            BigDecimal realSize = size.divide(mod).divide(mod).setScale(2, BigDecimal.ROUND_HALF_UP);
            chapter.setSize(realSize+"MB");

            Encoder encoder = new Encoder();
            long duration = encoder.getInfo(file).getDuration();
            chapter.setDuration(duration/1000/60+":"+duration/1000%60);
            chapterService.modify(chapter);
//        修改专辑中的数量
            Album album = albumService.findOne(albumId);
            album.setCount(album.getCount()+1);
            albumService.modify(album);
            map.put("status",true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("status",false);
        }
        return map;
    }




}
