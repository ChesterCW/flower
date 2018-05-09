package action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.po.Cart;
import pojo.vo.CartCommodity;
import pojo.po.User;
import service.CartDetailService;
import service.CartService;
import util.IDUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CartManagerAction {
    @Autowired
    CartService cartService;
    @Autowired
    CartDetailService cartDetailService;

    //删除购物车中商品
    @ResponseBody
    @RequestMapping(value = "/deleteCart/{commId}",method = RequestMethod.POST)
    public Integer deleteCart(@PathVariable(value = "commId")String commId, HttpSession session,HttpServletRequest request){
        String cartId = getCartId(request);
        if (isLogin(session)){
            User userInfo = (User) session.getAttribute("userInfo");
            cartId = cartService.getCartByUserId(userInfo.getId()).getId();
        }
        if (cartId != null){
            cartDetailService.deleteCommodity(cartId,commId);
        }
        return 0;
    }

    //获取用户准备结算的商品列表
    @ResponseBody
    @RequestMapping(value = "/getCart",method = RequestMethod.POST)
    public Map<String,Object> getCart(HttpSession session, HttpServletRequest request){
        Map map = new HashMap();
        User userInfo = (User) session.getAttribute("userInfo");
        List<Map<String,Object>> list;
        if (userInfo != null){

            Cart cart = cartService.getCartByUserId(userInfo.getId());

            list = cartDetailService.getBuyCommodity(cart.getId());
            map.put("cartId",cart.getId());
            map.put("list",list);

        }else{
            return null;
        }

        return map;
    }

    //购物车列表
    @ResponseBody
    @RequestMapping(value = "/cartList",method = RequestMethod.POST)
    public List cartList(HttpSession session, HttpServletRequest request){
        String cartId = getCartId(request);

        User userInfo = (User) session.getAttribute("userInfo");
        List<CartCommodity> list;
        if (userInfo != null){
            Cart cart = cartService.getCartByUserId(userInfo.getId());
            list = cartDetailService.getCommodity(cart.getId());
        }else{
            if (cartId != null){
                list = cartDetailService.getCommodity(cartId);
            }else {
                return null;
            }
        }

        return list;
    }
    //添加商品进入购物车
    @RequestMapping("/addToCart/{commId}")
    public String addToCart(@PathVariable(value = "commId")String commId,
                            HttpSession session, HttpServletRequest request, HttpServletResponse response){
        Cookie[] cookies = request.getCookies();
        String cartId = IDUtils.getItemId()+"";

        if (cookies != null) {
            for(Cookie cookie : cookies){
                //迭代时如果发现与指定cookieName相同的cookie，就修改相关数据
                if(cookie.getName().equals("cartId")){
                    cartId = cookie.getValue();
                    break;
                }
            }
        }
        User userInfo = (User) session.getAttribute("userInfo");
        if (userInfo != null){
            cartService.addCart(userInfo.getId(),cartId,commId);

            session.setAttribute("cartId",cartId);
        }else {
            cartDetailService.addCartDetail(cartId,commId);
            Cookie cookie = new Cookie("cartId", cartId);
            cookie.setMaxAge(30 * 60);// 设置存在时间为5分钟
            cookie.setPath("/");//设置作用域

            response.addCookie(cookie);

            session.setAttribute("cartId",cartId);

        }
        return "redirect:/cart";
    }
    //添加购物车数量
    @ResponseBody
    @RequestMapping(value = "/addCount",method = RequestMethod.POST)
    public Integer addCount(String count,String commId,HttpSession session, HttpServletRequest request){
        Integer counts = Integer.parseInt(count);
        Integer result;
        String cartId = getCartId(request);
        result = cartDetailService.addCount(cartId, commId, counts);
        return result;
    }

    //获取购物车ID
    public String getCartId(HttpServletRequest request){
        //判断用户是否登录
        HttpSession session = request.getSession();

        String cartId = "";
        if (isLogin(session)){
            User userInfo = (User) session.getAttribute("userInfo");
            Cart cart = cartService.getCartByUserId(userInfo.getId());
            cartId = cart.getId();
            return cartId;
        }
        Cookie[] cookies = request.getCookies();
        for(Cookie cookie : cookies){
            //迭代时如果发现与指定cookieName相同的cookie，就修改相关数据
            if(cookie.getName().equals("cartId")){
                cartId = cookie.getValue();
                break;
            }
        }
        return cartId;
    }
    //判断用户是否登录
    public boolean isLogin(HttpSession session){
        User userInfo = (User) session.getAttribute("userInfo");
        if (userInfo != null){
            return true;
        }
        return false;
    }
}
