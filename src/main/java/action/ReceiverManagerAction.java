package action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.po.Receiver;
import pojo.po.User;
import service.ReceiverService;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class ReceiverManagerAction {
    @Autowired
    ReceiverService receiverService;

    //删除收货人
    @ResponseBody
    @RequestMapping("/deleteReceiver/{id}")
    public String deleteReceiver(@PathVariable(value = "id")String id,HttpSession session){
        User userInfo = (User) session.getAttribute("userInfo");
        boolean flag = receiverService.deleteReceiver(id);
        if (flag){
            return "success";
        }
        return "fail";
    }
    //跳转到修改收货人页面
    @ResponseBody
    @RequestMapping("/setDefault/{id}")
    public String setDefault(@PathVariable(value = "id")String id,HttpSession session){
        User userInfo = (User) session.getAttribute("userInfo");
        boolean flag = receiverService.modifyStatus(id,userInfo.getId());
        if (flag){
            return "success";
        }
        return "fail";
    }

    //修改收货人
    @RequestMapping(value = "modifyReceiver",method = RequestMethod.POST)
    public String updateReceiver(Receiver receiver){
        receiverService.updateReceiver(receiver);
        return "managerReceiver";
    }

    //跳转到修改收货人页面
    @RequestMapping("/toModifyReceiver/{id}")
    public String toModifyReceiver(@PathVariable(value = "id")String id, Model model){
        model.addAttribute("receiver",receiverService.getReceiverById(id));
        return "modifyReceiver";
    }

    //添加收货人
    @RequestMapping(value = "/addReceiver",method = RequestMethod.POST)
    public String addReceiver(Receiver receiver, HttpSession session){
        User userInfo = (User) session.getAttribute("userInfo");
        receiver.setUserId(userInfo.getId());
        receiverService.addReceiver(receiver);
        return "redirect:/sendInfo";
    }
    //根据用户信息加载收货人列表
    @ResponseBody
    @RequestMapping(value = "/loadReceiver/{userId}")
    public List<Receiver> loadReceiver(@PathVariable(value = "userId")String userId){
        List<Receiver> list = receiverService.getReceiverByUserId(userId);
        return list;
    }
}
