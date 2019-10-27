package com.yafeng.paperbackend.utils;

import lombok.NonNull;
import lombok.extern.slf4j.Slf4j;
import org.apache.catalina.connector.ClientAbortException;
import org.springframework.lang.Nullable;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * FileUtils
 *
 * @author liugaoyang
 * @version 1.0
 * @description
 * @date 2019/6/17 15:31
 **/
@Slf4j
public class FileUtils {

    private static final String RANGE_SEPARATOR = "-";
    private static final String RANGE_CONTAINS = "bytes=";
    private static final int RANGE_BYTES_ALL = 2;
    private static final int RANGE_BYTES_ONE = 1;
    /**
     * NameUtils
     * @description 构造函数
     * @author liugaoyang
     * @date 2019/5/29 11:18
     * @version 1.0.0
     */
    private FileUtils() {

    }

    /**
     * isFileExists
     * @description 判断临时文件是否存在 若存在则删除
     * @param filePath 文件路径
     * @return void
     * @author liugaoyang
     * @date 2019/5/29 16:35
     * @version 1.0.0
     */
    public static void isFileExists(String filePath){
        File file = new File(filePath);
        if (file.exists()) {
            if (file.delete()) {
                log.info("删除" + filePath + "成功!");
            } else {
                log.info("删除" + filePath + "失败!");
            }
        }
    }

    /**运行
     * getCorrectFilePath
     * @description 在指定路径生成正确文件
     * @param filename 文件名称
     * @return void
     * @author liugaoyang
     * @date 2019/6/13 11:06
     * @version 1.0.0
     */
    public static String getFilePath(String filename){
        String filePath = System.getProperty("user.dir") +
                System.getProperty("file.separator") + filename;
        log.info("生成的临时文件路径:" + filePath);
        return filePath;
    }

    /**
     * getExtensionName
     * @description 获取文件的扩展名
     * @param file 上传来的文件
     * @return {@link String}文件扩展名
     * @author liugaoyang
     * @date 2019/10/25 21:17
     * @version 1.0.0
     */
    public static String getExtensionName(MultipartFile file) {
        String originalFilename = file.getOriginalFilename();
        String extensionName = "";
        if (originalFilename != null) {
            int i = originalFilename.lastIndexOf(".");
            if (i != -1) {
                extensionName = file.getOriginalFilename().substring(i);
            }
        }
        return extensionName;
    }

    /**
     * 断点续传下载文件
     * @param file        所需要下载的文件
     * @param contentType MIME类型
     * @param range       请求头
     * @param response    {@link HttpServletResponse}
     * @author liugaoyang
     * @date 2019/10/25 21.17
     * @version 1.0.0
     */
    public static void breakpointResume(@NonNull File file,
                                        @NonNull final String downFileName,
                                        @NonNull final String contentType,
                                        @Nullable String range,
                                        @NonNull HttpServletResponse response){
        long startByte = 0;
        long endByte = file.length() - 1;
        if (range != null && range.contains(RANGE_CONTAINS) && range.contains(RANGE_SEPARATOR)) {
            range = range.substring(range.lastIndexOf("=") + 1).trim();
            String[] ranges = range.split(RANGE_SEPARATOR);
            try {
                //判断range的类型
                if (ranges.length == RANGE_BYTES_ONE) {
                    if (range.startsWith(RANGE_SEPARATOR)) {
                        //类型一：bytes=-2343
                        endByte = Long.parseLong(ranges[0]);
                    } else if (range.endsWith(RANGE_SEPARATOR)) {
                        //类型二：bytes=2343-
                        startByte = Long.parseLong(ranges[0]);
                    }
                } else if (ranges.length == RANGE_BYTES_ALL) {
                    //类型三：bytes=22-2343
                    startByte = Long.parseLong(ranges[0]);
                    endByte = Long.parseLong(ranges[1]);
                }

            } catch (NumberFormatException e) {
                startByte = 0;
                endByte = file.length() - 1;
            }
        }
        long contentLength = endByte - startByte + 1;
        response.setHeader("Accept-Ranges", "bytes");
        if (range == null) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.setStatus(HttpServletResponse.SC_PARTIAL_CONTENT);
            response.setHeader("Content-Range", "bytes " + startByte + "-" + endByte + "/" + file.length());
        }
        response.setContentType(contentType);
        try {
            response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(downFileName,"UTF-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setHeader("Content-Length", String.valueOf(contentLength));
        long transmitted = 0;
        try (RandomAccessFile randomAccessFile = new RandomAccessFile(file, "r");
             BufferedOutputStream outputStream = new BufferedOutputStream(response.getOutputStream())) {
            byte[] buff = new byte[4096];
            int len = 0;
            randomAccessFile.seek(startByte);
            while ((transmitted + len) <= contentLength && (len = randomAccessFile.read(buff)) != -1) {
                outputStream.write(buff, 0, len);
                transmitted += len;
            }
            if (transmitted < contentLength) {
                len = randomAccessFile.read(buff, 0, (int) (contentLength - transmitted));
                outputStream.write(buff, 0, len);
                transmitted += len;
            }
            outputStream.flush();
            response.flushBuffer();
            randomAccessFile.close();
            log.debug("下载完毕：{}-{}: {}", startByte, endByte, transmitted);
        } catch (ClientAbortException e) {
            log.debug("用户停止下载：{}-{}: {}", startByte, endByte, transmitted);
        } catch (IOException e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    /**
     * getContentTypeByExtensionName
     * @description 根据文件扩展名获取MIME类型
     * @param extensionName 文件扩展名
     * @return {@link String}
     * @author liugaoyang
     * @date 2019/10/25 21:23
     * @version 1.0.0
     */
    public static String getContentTypeByExtensionName(String extensionName) {
        switch (extensionName) {
            case "text":
                return "text/plain";
            case "docx":
                return "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
            case "doc":
                return "application/msword";
            case "xls":
                return "application/vnd.ms-excel";
            case "xlsx":
                return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            case "ppt":
                return "application/vnd.ms-powerpoint";
            case "pptx":
                return "application/vnd.openxmlformats-officedocument.presentationml.presentation";
            case "pdf":
                return "application/pdf";
            default:
                return "multipart/form-data";
        }
    }

}
