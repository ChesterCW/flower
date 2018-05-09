package action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import org.springframework.web.multipart.MultipartFile;
import pojo.dto.Order;
import pojo.dto.Page;
import pojo.dto.Result;
import pojo.po.Commodity;
import pojo.po.Use;
import pojo.vo.CommodityLink;
import pojo.vo.CommodityQuery;
import service.CommUseService;
import service.CommodityService;
import service.ImagesService;
import util.IDUtils;

import java.util.List;
import java.util.Map;

@Controller
public class CommodityManagerAction{

	@Autowired
	CommodityService commodityService;
	@Autowired
	CommUseService commUseService;
	@Autowired
	ImagesService imagesService;

	//商品详情
	@RequestMapping("/commodityDetail/{id}")
	public String commodityDetail(@PathVariable(value = "id") String id,Model model){
		Map<String,Object> commodity = commodityService.getCommodityById(id);
		model.addAttribute("commodity",commodity);
		return "commodityDetail";
	}

	//根据种类查询商品
	@ResponseBody
	@RequestMapping("/commodityByKindId/{kindId}")
	public Result<Map<String,Object>> commodityByKindId(@PathVariable(value = "kindId") String kindId,Page page){
		Result<Map<String,Object>> result = commodityService.getCommodityByKindId(kindId,page);
		return result;
	}

	//添加商品
	@RequestMapping("/addCommodity")
	public String addCommodity(@RequestParam(required=false) List<String> commUse,@RequestParam(required=false) List<String> images , Commodity commodity) {
		commodity.setId(IDUtils.getItemId()+"");
		if ( commUse.size() > 0 ){
			commUseService.addCommUse(commUse, commodity.getId());
		}
		if ( images.size() > 0 ){
			imagesService.addImages(images,commodity.getId());
		}
		int i = commodityService.addCommodity(commodity);
		//添加成功
		return "managerCommodity";
	}

	//删除商品
	@ResponseBody
	@RequestMapping(value = "/deleteCommodity")
	public Integer deleteCommodity(@RequestParam("ids[]") List<String> ids) {
		commUseService.deleteByCommId(ids);
		int i = commodityService.deleteCommodity(ids);
		//System.out.println(ids.get(0).toString());
		return i;
	}

	//修改商品
	@RequestMapping("/modifyCommodity")
	public String modifyCommodity(@RequestParam("commUse") List<String> commUse, Commodity commodity) {
		if (commUse.size() > 0) {
			commUseService.addCommUse(commUse, commodity.getId());
		}
		int i = commodityService.modifyCommodity(commodity);
		return "managerCommodity";
	}

	//跳转到查看商品页面
	@RequestMapping(value = "/lookCommodity/{id}")
	public String lookCommodity(@PathVariable("id")String id,Model model){
		Map<String,Object> commodity = commodityService.getCommodityById(id);
		List<Use> useList = commUseService.getUseByCommId(id);
		model.addAttribute("useList",useList);
		model.addAttribute("commodity",commodity);
		return "lookCommodity";
	}

	//查看后端商品列表
	@ResponseBody
    @RequestMapping(value = "/backCommodityList", method = RequestMethod.GET)
    public Result<Map<String,Object>> commodityList(Page pages, Order order, CommodityQuery query) {
        Result<Map<String,Object>> result = commodityService.listCommodityByPage(pages, order, query);
        return result;
    }

	//跳转到修改商品页面
	@RequestMapping(value = "/modifyCommodity/{id}")
	public String toModifyCommodityJsp(@PathVariable("id")String id,Model model){
		Map<String,Object> commodity = commodityService.getCommodityById(id);
		List<Use> useList = commUseService.getUseByCommId(id);
		model.addAttribute("useList",useList);
		model.addAttribute("commodity",commodity);
		return "modifyCommodity";
	}

}
