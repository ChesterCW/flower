package action;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class RedirectToJsp {

    //携带种类ID跳转
    @RequestMapping("/toUseCommodity/{useId}")
    public String toUseCommodity(@PathVariable(value = "useId") String useId,Model model){
        model.addAttribute("useId",useId);
        return "useCommodity";
    }

    //携带材料ID跳转
    @RequestMapping("/toMateCommodity/{mateId}")
    public String toMateCommodity(@PathVariable(value = "mateId") String mateId,Model model){
        model.addAttribute("mateId",mateId);
        return "mateCommodity";
    }

    //携带种类ID跳转
    @RequestMapping("/toKindCommodity/{kindId}")
    public String toKindCommodity(@PathVariable(value = "kindId") String kindId,Model model){
        model.addAttribute("kindId",kindId);
        return "kindCommodity";
    }

    //转发到jsp页面
    @RequestMapping(value="/{jspName}",method = RequestMethod.GET)
    public String toJsp(@PathVariable("jspName") String jspName){
        return jspName;
    }
}
