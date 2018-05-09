package service;

import java.util.List;

import pojo.po.Category;

public interface CateService {

	List<Category> findCateByKindId(String id);

    boolean addCategory(Category category);

    Category getCategoryById(String id);

    int modifyCategory(Category category);

    int deleteCategory(List<String> ids);

    List<Category> getAllUse();
}
