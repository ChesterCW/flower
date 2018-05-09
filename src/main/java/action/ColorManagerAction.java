package action;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.dto.Page;
import pojo.dto.Result;
import pojo.po.Color;
import pojo.po.Kind;
import pojo.po.Materials;
import service.ColorService;
import service.KindService;

import java.util.List;

@Controller
public class ColorManagerAction {
    @Autowired
    ColorService colorService;

    //添加颜色
    @RequestMapping(value = "/addColor",method = RequestMethod.POST)
    public String addColor(Color color) {
        boolean flag = colorService.addColor(color);
        //添加成功
        return "colorManager";
    }

    //删除颜色
    @ResponseBody
    @RequestMapping(value = "/deleteColor")
    public Integer deleteColor(@RequestParam("ids[]") List<String> ids) {
        int i = colorService.deleteColor(ids);
        return i;
    }

    //商品材料列表
    @ResponseBody
    @RequestMapping(value = "/colorList", method = RequestMethod.GET)
    public Result<Color> listItems(Page pages, Color color) {
        Result<Color> result = null;
        try {
            result = colorService.listByPages(pages,color);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    //查询全部种类
    @ResponseBody
    @RequestMapping(value = "/loadColor")
    public List<Color> findAllKind(){
        List<Color> colorList = colorService.getAll();
        return colorList;
    }
}
