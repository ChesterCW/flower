package service.impl;

import dao.ICommentDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pojo.dto.Page;
import pojo.dto.Result;
import pojo.po.Comment;
import service.CommentService;
import util.IDUtils;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(isolation= Isolation.READ_COMMITTED,propagation= Propagation.REQUIRED)
public class CommentServiceImpl implements CommentService {
    @Autowired
    ICommentDao commentDao;

    @Override
    public Result<Comment> listCommodityByPage(String commId, Page pages) {
        Result<Comment> result = new Result<>();
        try {
            //构建一个Map用来传递参数给DAO
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("page", pages);
            map.put("commId", commId);

            Long total = commentDao.countItemsByCondition(map);
            List<Comment> list = commentDao.listItemsByPage(map);
            //商品总数
            result.setTotal(total);
            //指定页码的商品集合
            result.setRows(list);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public Integer addComment(Comment comment) {
        comment.setCreatetime(new Date());
        comment.setId(IDUtils.getItemId()+"");
        commentDao.insert(comment);
        return null;
    }
}
