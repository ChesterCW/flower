package action;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pojo.dto.Page;
import pojo.dto.Result;
import pojo.po.User;
import service.UserService;

import javax.servlet.http.HttpSession;
import java.util.List;


/**
 * 用户控制器
 */
@Controller
public class UserAction {
    @Autowired
    private UserService userService;


    //根据用户邮箱查询，判断是否能注册
    @ResponseBody
    @RequestMapping(value = "/userExist")
    public boolean userExist(String email){
        return userService.getUserByEmail(email);
    }
    //用户登录
    @ResponseBody
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public boolean login(User user, HttpSession session) {
        user = userService.login(user);
        if(user != null){
            session.setAttribute("userInfo",user);
            return  true;
        }
        return false;
    }

    //用户注册
    @ResponseBody
    @RequestMapping(value="/register",method = RequestMethod.POST)
    public String register(User user){
        if (user.getLevel() == null){
            user.setLevel(3);
        }
        boolean flag = userService.addUser(user);
        if(!flag){
            return "false";
        }
        return "true";
    }

    //用户退出
    @ResponseBody
    @RequestMapping(value = "/logOut", method = RequestMethod.POST)
    public String logOut(HttpSession session){
        if(session.getAttribute("userInfo") != null){
            session.removeAttribute("userInfo");
        }
        return "success";
    }
    //根据主键查询
    @RequestMapping(value = "/user/{id}", method = RequestMethod.GET)
    public String getById(@PathVariable("id") String id,Model model) {
        User user = userService.getById(id);
        model.addAttribute("user",user);
        return "userInfo";
    }

    //后端用户列表
    @ResponseBody
    @RequestMapping(value = "/backUserList", method = RequestMethod.GET)
    public Result<User> users(Page pages,User user) {
        Result<User> result = userService.listItemsByPage(pages, user);
        return result;
    }

    //用户更新
    @ResponseBody
    @RequestMapping(value = "/batchUpdateUser", method = RequestMethod.POST)
    public int batchUpdate(@RequestParam("ids[]") List<String> ids) {
        int i = 0;
        i = userService.batchUpdate(ids);
        return i;
    }

    //修改用户信息
    @RequestMapping(value = "/modifyUser", method = RequestMethod.POST)
    public String modifyUser(User user){
        boolean flag = userService.modifyUser(user);
        if(!flag){
            return "error";
        }
        return "managerUser";
    }

    //跳转到修改用户页面
    @RequestMapping(value = "/modifyUser/{id}", method = RequestMethod.GET)
    public String toModifyJsp(@PathVariable(value = "id")String id, Model model){
        User user = userService.getById(id);
        model.addAttribute("user",user);
        return "modifyUser";
    }
}



