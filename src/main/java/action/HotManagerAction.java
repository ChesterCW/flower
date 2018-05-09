package action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import service.HotService;

import java.util.List;
import java.util.Map;

@Controller
public class HotManagerAction {
    @Autowired
    HotService hotService;

    //获得热销商品列表，默认6个
    @ResponseBody
    @RequestMapping(value = "/loadHot")
    public List<Map<String,Object>> loadHot(){
        List<Map<String, Object>> hotList = hotService.getHotList();
        return hotList;
    }
}
