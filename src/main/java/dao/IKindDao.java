package dao;

import java.util.List;

import pojo.dto.Page;
import pojo.po.Kind;

public interface IKindDao {

	List<Kind> selectAll();

    Long countItemsByCondition(Page pages, Kind kind);

    List<Kind> listItemsByPage(Page pages, Kind kind);

    boolean insert(Kind kind);

    int batchUpdate(List<String> ids);
}
