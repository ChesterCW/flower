package action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pojo.po.Category;
import service.CateService;

import java.util.List;

@Controller
public class CategoryManagerAction {
    @Autowired
    CateService cateService;

    //删除类别
    @ResponseBody
    @RequestMapping(value = "/deleteCategory")
    public Integer deleteCategory(@RequestParam("ids[]") List<String> ids) {
        int i = cateService.deleteCategory(ids);
        return i;
    }

    //修改商品类别
    @RequestMapping("/modifyCategory")
    public String modifyUse(Category category) {
        int i = cateService.modifyCategory(category);
        return "categoryManager";
    }

    //跳转到修改类别页面
    @RequestMapping(value = "/modifyCategory/{id}")
    public String toModifyCategoryJsp(@PathVariable("id")String id, Model model){
        Category category = cateService.getCategoryById(id);
        model.addAttribute("category",category);
        return "modifyCategory";
    }

    //添加类别
    @RequestMapping(value = "/addCategory",method = RequestMethod.POST)
    public String addCategory(Category category) {
        boolean flag = cateService.addCategory(category);
        //添加成功
        return "categoryManager";
    }

    //根据种类Id加载类别列表
    @ResponseBody
    @RequestMapping("/loadCates/{kindId}")
    public List<Category> loadCateByKindId(@PathVariable(value = "kindId")String kindId){
        List<Category> categoryList = cateService.findCateByKindId(kindId);
        return categoryList;
    }

    //查询全部类别
    @ResponseBody
    @RequestMapping("/searchCategory")
    public List<Category> searchCategory() {
        List<Category> categoryList = cateService.getAllUse();
        return categoryList.subList(0,10);
    }
}
