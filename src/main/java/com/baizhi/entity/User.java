package com.baizhi.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.afterturn.easypoi.excel.annotation.ExcelIgnore;
import com.alibaba.fastjson.annotation.JSONField;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import javax.persistence.Id;
import java.time.LocalDate;
import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    @Id
    @ExcelIgnore
    private String id;
    @Excel(name="用户名")
    private String username;
    @ExcelIgnore
    private String password;
    @ExcelIgnore
    private String salt;
    @Excel(name = "昵称")
    private String nickname;
    @Excel(name="手机号码")
    private String phone;
    @Excel(name="手机号码")
    private String province;
    @Excel(name="手机号码")
    private String city;
    @Excel(name="手机号码")
    private String sign;
    private String photo;
    @Excel(name="性别")
    private String sex;
    @JSONField(format = "yyyy-MM-dd")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "创建时间",format = "yyyy-MM-dd")
    private LocalDate createDate;
    private String starId;
}