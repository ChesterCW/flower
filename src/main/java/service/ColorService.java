package service;

import pojo.dto.Page;
import pojo.dto.Result;
import pojo.po.Color;

import java.util.List;

public interface ColorService {

    List<Color> getAll();

    Result<Color> listByPages(Page pages, Color color);

    boolean addColor(Color color);

    int deleteColor(List<String> ids);
}
