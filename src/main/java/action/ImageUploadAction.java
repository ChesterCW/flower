package action;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class ImageUploadAction {

    final String FILE_PATH = "/files/commodityImages/";

    /**
     * 多文件上传，方式一：利用MultipartFile[]作为方法的参数接收传入的文件
     *  用 transferTo方法来保存图片，保存到本地磁盘。
     * @author chunlynn
     */
    @RequestMapping("upload")
    public String upload(@RequestParam("file") MultipartFile[] files, HttpServletRequest request, Model model) {

        List<String> fileUrlList = new ArrayList<String>(); //用来保存文件路径，用于jsp页面回显用
        String path = "";

        // 先判断文件files不为空
        if (files != null && files.length > 0) {
            for (MultipartFile file : files) { //循环遍历，取出单个文件，下面的操作和单个文件就一样了

                if (!file.isEmpty()) {//这个判断必须加上

                    // 获得原始文件名
                    String fileName = file.getOriginalFilename();
                    String newfileName = new Date().getTime() + String.valueOf(fileName);
                    //获得物理路径webapp所在路径
                    String pathRoot = request.getSession().getServletContext().getRealPath("");
                    // 项目下相对路径

                    path = FILE_PATH + newfileName;
                    // 创建文件实例
                    File tempFile = new File(pathRoot + path); //文件保存路径为pathRoot + path
                    if (!tempFile.getParentFile().exists()) { //这个判断必须加上
                        tempFile.getParentFile().mkdir();
                    }
                    if (!tempFile.exists()) {
                        tempFile.mkdir();
                    }
                    try {
                        // Transfer the received file to the given destination file.
                        file.transferTo(tempFile);
                    } catch (IllegalStateException e) {
                        e.printStackTrace();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }

                    fileUrlList.add(path);
                }
            }
            // 方法一：model属性保存图片路径也行
            model.addAttribute("fileUrlList", fileUrlList); //保存路径，用于jsp页面回显
        }

        return "add-commodity";
    }

}
