package service;

import java.util.List;

import pojo.dto.Page;
import pojo.dto.Result;
import pojo.po.Kind;

public interface KindService {

	List<Kind> getAll();

    Result<Kind> listByPages(Page pages, Kind kind);

    boolean addKind(Kind kind);

    int deleteKind(List<String> ids);
}
