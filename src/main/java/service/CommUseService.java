package service;

import pojo.po.Use;

import java.util.List;

public interface CommUseService {
    boolean addCommUse(List<String> commUse, String id);

    List<Use> getUseByCommId(String id);

    Integer deleteByCommId(List<String> ids);
}
