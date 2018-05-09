package action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pojo.dto.Page;
import pojo.dto.Result;
import pojo.po.Commodity;
import pojo.po.Materials;
import pojo.po.User;
import service.MateService;
import util.IDUtils;

import java.util.List;
import java.util.Map;

@Controller
public class MaterialManagerAction {
    @Autowired
    MateService mateService;

    //根据材料查询商品
    @ResponseBody
    @RequestMapping("/commodityByMateId/{mateId}")
    public Result<Map<String,Object>> commodityByMateId(@PathVariable(value = "mateId") String mateId, Page page){
        Result<Map<String,Object>> result = mateService.getCommodityByMateId(mateId,page);
        return result;
    }

    //添加材料
    @RequestMapping(value = "/addMaterial",method = RequestMethod.POST)
    public String addMaterial(Materials materials) {
        boolean flag = mateService.addMaterial(materials);
        //添加成功
        return "materialsManager";
    }

    //删除材料
    @ResponseBody
    @RequestMapping(value = "/deleteMaterial")
    public Integer deleteMaterial(@RequestParam("ids[]") List<String> ids) {
        int i = mateService.deleteMaterial(ids);
        return i;
    }

    //修改商品材料
    @RequestMapping("/modifyMaterial")
    public String modifyMaterial(Materials materials) {
        int i = mateService.modifyMaterials(materials);
        return "materialsManager";
    }

    //跳转到查看商品材料页面
    @RequestMapping(value = "/lookMaterial/{id}")
    public String lookMaterial(@PathVariable("id")String id,Model model){
        Materials material = mateService.getMaterialById(id);
        model.addAttribute("material",material);
        return "lookMaterial";
    }

    //跳转到修改材料页面
    @RequestMapping(value = "/modifyMaterial/{id}")
    public String toModifyMaterialJsp(@PathVariable("id")String id,Model model){
        Materials material = mateService.getMaterialById(id);
        model.addAttribute("material",material);
        return "modifyMaterial";
    }

    //根据种类Id查询材料列表
    @ResponseBody
    @RequestMapping("/loadMates/{kindId}")
    public List<Materials> listMaterialsByKindId(@PathVariable("kindId")String kindId){
        List<Materials> matesList = mateService.findMateByKindId(kindId);
        return matesList;
    }

    //商品材料列表
    @ResponseBody
    @RequestMapping(value = "/materialsList", method = RequestMethod.GET)
    public Result<Materials> listItems(Page pages, Materials materials) {
        Result<Materials> result = null;
        try {
            result = mateService.listByPages(pages,materials);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    //查询全部用途
    @ResponseBody
    @RequestMapping("/searchMaterials")
    public List<Materials> searchUse() {
        List<Materials> mateList = mateService.getAllUse();
        return mateList;
    }

}
