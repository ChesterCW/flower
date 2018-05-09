package dao;

import pojo.po.Comment;

import java.util.List;
import java.util.Map;

public interface ICommentDao {

    Long countItemsByCondition(Map<String, Object> map);

    List<Comment> listItemsByPage(Map<String, Object> map);

    Integer insert(Comment comment);
}
