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
import service.KindService;

import java.util.List;

@Controller
public class KindManagerAction {
    @Autowired
    KindService kindService;

    //添加种类
    @RequestMapping(value = "/addKind",method = RequestMethod.POST)
    public String addKind(Kind kind) {
        boolean flag = kindService.addKind(kind);
        //添加成功
        return "kindManager";
    }

    //删除颜色
    @ResponseBody
    @RequestMapping(value = "/deleteKind")
    public Integer deleteColor(@RequestParam("ids[]") List<String> ids) {
        int i = kindService.deleteKind(ids);
        return i;
    }

    //商品种类列表
    @ResponseBody
    @RequestMapping(value = "/kindList", method = RequestMethod.GET)
    public Result<Kind> listItems(Page pages, Kind kind) {
        Result<Kind> result = null;
        try {
            result = kindService.listByPages(pages,kind);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    //查询全部种类
    @ResponseBody
    @RequestMapping(value = "/loadKind")
    public List<Kind> findAllKind(){
        List<Kind> kindList = kindService.getAll();
        return kindList;
    }
}
