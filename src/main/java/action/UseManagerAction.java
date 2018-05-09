package action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pojo.dto.Page;
import pojo.dto.Result;
import pojo.po.Materials;
import pojo.po.Use;
import service.UseService;
import service.UserService;

import java.util.List;
import java.util.Map;

@Controller
public class UseManagerAction {

    @Autowired
    UseService useService;

    //根据用途查询商品
    @ResponseBody
    @RequestMapping("/commodityByUseId/{useId}")
    public Result<Map<String,Object>> commodityByUseId(@PathVariable(value = "useId") String useId, Page page){
        Result<Map<String,Object>> result = useService.getCommodityByUseId(useId,page);
        return result;
    }

    //添加用途
    @RequestMapping(value = "/addUse",method = RequestMethod.POST)
    public String addUse(Use use) {
        boolean flag = useService.addUse(use);
        //添加成功
        return "useManager";
    }

    //删除用途
    @ResponseBody
    @RequestMapping(value = "/deleteUse")
    public Integer deleteUse(@RequestParam("ids[]") List<String> ids) {
        int i = useService.deleteUse(ids);
        return i;
    }

    //修改商品用途
    @RequestMapping("/modifyUse")
    public String modifyUse(Use use) {
        int i = useService.modifyUse(use);
        return "useManager";
    }

    //跳转到修改用途页面
    @RequestMapping(value = "/modifyUse/{id}")
    public String toModifyUseJsp(@PathVariable("id")String id, Model model){
        Use use = useService.getUseById(id);
        model.addAttribute("use",use);
        return "modifyUse";
    }

    //用途列表
    @ResponseBody
    @RequestMapping(value = "/useList", method = RequestMethod.GET)
    public Result<Use> listItems(Page pages, Use use) {
        Result<Use> result = null;
        try {
            result = useService.listByPages(pages,use);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    //查询全部用途
    @ResponseBody
    @RequestMapping("/searchUse")
    public List<Use> searchUse() {
        List<Use> useList = useService.getAllUse();
        return useList;
    }
}
