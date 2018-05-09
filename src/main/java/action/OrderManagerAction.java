package action;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.dto.Order;
import pojo.dto.Page;
import pojo.dto.Result;
import pojo.po.Orders;
import pojo.po.User;
import service.CartDetailService;
import service.HotService;
import service.OrderCommodityService;
import service.OrderService;
import util.IDUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class OrderManagerAction {
    @Autowired
    OrderService orderService;
    @Autowired
    CartDetailService cartDetailService;
    @Autowired
    OrderCommodityService orderCommodityService;
    @Autowired
    HotService hotService;


    //跳转到查看订单信息页面
    @RequestMapping(value = "/backOrderDetail/{id}")
    public String backOrderDetail(@PathVariable(value = "id")String id,Model model){
        Map<String,Object> order = orderService.getOrderById(id);
        List<Map<String,Object>> commodityList = orderCommodityService.getCommodityByOrderId(id);
        model.addAttribute("order",order);
        model.addAttribute("commodityList",commodityList);
        return "backOrderDetail";
    }

    //查看后端订单列表
    @ResponseBody
    @RequestMapping(value = "/backOrderList", method = RequestMethod.GET)
    public Result<Map<String,Object>> commodityList(Page pages, Order order, Orders query) {

        Result<Map<String,Object>> result = orderService.listOrderByPage(pages, order, query);
        return result;
    }

    //修改订单状态
    @ResponseBody
    @RequestMapping(value = "/modifyOrder/{id}",method = RequestMethod.POST)
    public Integer modifyOrder(@PathVariable(value = "id") String id,String orderStatus){
        Integer status = Integer.parseInt(orderStatus);
        Integer i = orderService.modifyOrder(id,status);
        return i;
    }

    //获得成功购买的商品订单
    //获取用户准备结算的商品列表
    @ResponseBody
    @RequestMapping(value = "/orderCommodity/{orderId}",method = RequestMethod.POST)
    public Map<String,Object> getCart(@PathVariable(value = "orderId") String orderId){
        Map map = new HashMap();
        List<Map<String,Object>> commodityList = orderCommodityService.getCommodityByOrderId(orderId);
        map.put("commodityList",commodityList);

        return map;
    }



    //付款成功
    @ResponseBody
    @RequestMapping(value = "/pay/{id}")
    public String pay(@PathVariable(value = "id") String id){

        orderService.updateStatus(id);
        return "success";
    }
    

    //跳转到查看订单信息页面
    @RequestMapping(value = "/lookOrder/{id}")
    public String lookOrder(@PathVariable(value = "id")String id,Model model){
        Map<String,Object> order = orderService.getOrderById(id);
        List<Map<String,Object>> commodityList = orderCommodityService.getCommodityByOrderId(id);
        model.addAttribute("order",order);
        model.addAttribute("commodityList",commodityList);
        return "lookOrder";
    }


    //跳转到付款页面
    @RequestMapping(value = "/payment/{id}")
    public String payment(@PathVariable(value = "id") String id, Model model){
        model.addAttribute("id",id);
        return "payment";
    }
    //根据用户查询用户订单列表
    @ResponseBody
    @RequestMapping(value = "/orderList",method = RequestMethod.POST)
    public List<Map<String,Object>> orderList(String orderStatus,HttpSession session){

        User userInfo = (User) session.getAttribute("userInfo");
        List list;

        if (userInfo != null){
            Integer status = Integer.parseInt(orderStatus);
            list = orderService.getOrderListByUserId(status,userInfo.getId());
        }else{
            return null;
        }
        return list;
    }

    //用户生成订单
    @RequestMapping(value = "/addOrder",method = RequestMethod.POST)
    public String addOrder(Orders order, String cartId, HttpSession session,Model model){
        User userInfo = (User) session.getAttribute("userInfo");
        String orderId = IDUtils.getItemId()+"";
        if (userInfo != null){
            List<Map<String,Object>> list = cartDetailService.getBuyCommodity(cartId);
            //生成订单并清除购物车中数据
            cartDetailService.deleteById(cartId);

            orderCommodityService.addCommodity(list,orderId);
            order.setUserId(userInfo.getId());
            order.setId(orderId);
            orderService.addOrder(order);
            //增加商品卖出数量
            hotService.addHotCommodity(list);
        }
        model.addAttribute("id",orderId);
        return "payment";
    }
}
