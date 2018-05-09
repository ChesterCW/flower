package dao;

import pojo.dto.Page;
import pojo.po.Color;

import java.util.List;

public interface IColorDao {

    List<Color> selectAll();

    Long countItemsByCondition(Page pages, Color color);

    List<Color> listItemsByPage(Page pages, Color color);

    boolean insert(Color color);

    int batchUpdate(List<String> ids);
}
