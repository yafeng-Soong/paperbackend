package com.yafeng.paperbackend.entity;

import com.fasterxml.jackson.annotation.JsonFormat;

//import java.util.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Book {
    private Integer bookId;
    private String email;//拥有者邮箱
    private String name;//图书名字
    private String type;//图书类型
    private int state;//图书状态
    private String introduction;//简介
    private Date date;//发布日期
    private String imgPath;
    private String imgPath2;
    private String imgPath3;
    private int good;//喜欢收藏数
    private int bad;//不喜欢数
    private String changer;
    private Integer changeId;
    private Book changeBook;
    //private Timestamp udDate;//修改时间
    private List<String> imgPaths;//web端用，返回多张图书图片

    public Integer getBookId() {
        return bookId;
    }

    public String getEmail() {
        return email;
    }

    public String getName() {
        return name;
    }

    public String getType() {
        return type;
    }

    public int getState() {
        return state;
    }

    public String getIntroduction() {
        return introduction;
    }

    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    public Date getDate() {
        return date;
    }
    public String getImgPath() {
        return imgPath;
    }

    public String getImgPath2() {
        return imgPath2;
    }

    public String getImgPath3() {
        return imgPath3;
    }

    public int getGood() {
        return good;
    }

    public int getBad() {
        return bad;
    }

    public String getChanger() {
        return changer;
    }

    public Integer getChangeId() {
        return changeId;
    }

    public Book getChangeBook() {
        return changeBook;
    }

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setChanger(String changer) {
        this.changer = changer;
    }

    public void setChangeId(Integer changeId) {
        this.changeId = changeId;
    }

    public void setChangeBook(Book changeBook) {
        this.changeBook = changeBook;
    }

    public void addImgPaths(){
        imgPaths = new ArrayList<>() ;
        imgPaths.add(getImgPath());
        if (imgPath2 != null)
            imgPaths.add(imgPath2);
        if (imgPath3 != null)
            imgPaths.add(imgPath3);
    }

    public List<String> getImgPaths(){
        return imgPaths;
    }

    @Override
    public String toString() {
        return "bookName:" + name + "\t" +
                "bookId:" + bookId + "\t" +
                "email:" + email + "\t" +
                "bookState:" + state + "\t" +
                "type:" + type + "\t";
    }
}
