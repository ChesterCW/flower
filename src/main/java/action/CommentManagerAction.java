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
import pojo.po.Comment;
import pojo.po.Commodity;
import pojo.po.User;
import pojo.vo.CommodityQuery;
import service.CommentService;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class CommentManagerAction {
    @Autowired
    CommentService commentService;



    //后台评论列表
    @ResponseBody
    @RequestMapping(value = "/commentList",method = RequestMethod.GET)
    public Result<Comment> commentByCommId(Page pages,Comment comment){

        Result<Comment> result = commentService.listCommodityByPage(comment.getCommId(),pages);
        return result;
    }


    //用户添加评论
    @ResponseBody
    @RequestMapping(value = "/addComment",method = RequestMethod.POST)
    public String addComment(Comment comment, HttpSession session){
        User userInfo = (User) session.getAttribute("userInfo");
        if (userInfo == null){
            return "fail";
        }else {
            comment.setUserId(userInfo.getId());
            commentService.addComment(comment);
        }
        return "success";
    }

    //跳转到评价商品页面
    @RequestMapping(value = "/userComment/{id}")
    public String toUserComment(@PathVariable(value = "id") String id, Model model){
        model.addAttribute("orderId",id);
        return "userComment";
    }

    //获取用户评价
    @ResponseBody
    @RequestMapping(value = "/commentByCommId/{commId}",method = RequestMethod.GET)
    public Result<Comment> commentByCommId(@PathVariable(value = "commId") String commId, Page pages){
        Result<Comment> result = commentService.listCommodityByPage(commId,pages);
        return result;
    }
}
