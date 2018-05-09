package pojo.dto;

import java.util.ArrayList;
import java.util.List;

public class Order {
    private String sort;
    private String order;

    public List<String> getOrderParams() {
        List<String> list = new ArrayList<String>();
        String[] sorts = sort.split(",");
        String[] orders = order.split(",");
        for (int i = 0; i < sorts.length; i++) {
            String tmp = sorts[i] + "  " + orders[i];
            list.add(tmp);
        }
        return list;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order;
    }
}
