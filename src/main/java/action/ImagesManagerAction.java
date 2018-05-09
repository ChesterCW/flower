package action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.po.Images;
import service.ImagesService;

import java.util.List;

@Controller
public class ImagesManagerAction {
    @Autowired
    ImagesService imagesService;

    @ResponseBody
    @RequestMapping(value = "loadImagesByCommId/{commId}")
    public List<Images> loadImagesByCommId(@PathVariable(value = "commId") String commId){
        List<Images> imageList = imagesService.loadImagesByCommId(commId);
        return imageList;
    }
}
