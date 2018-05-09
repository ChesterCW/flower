package dao;

import java.util.List;

import pojo.po.Category;

public interface ICategoryDao {

	List<Category> selectCateByKindId(String id);

    boolean insert(Category category);

    Category selectCateById(String id);

    int update(Category category);

    int batchUpdate(List<String> ids);

    List<Category> selectAll();
}
