package service;

import pojo.dto.Page;
import pojo.dto.Result;
import pojo.po.Comment;

import java.util.List;

public interface CommentService {
    Result<Comment> listCommodityByPage(String commId, Page pages);

    Integer addComment(Comment comment);
}
