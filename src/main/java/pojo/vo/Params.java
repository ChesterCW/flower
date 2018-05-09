package pojo.vo;

import pojo.dto.Order;
import pojo.dto.Page;
import pojo.dto.Result;

public class Params<T> {

	private Order order;
	private Page page;
	private Result<T> result;
	public Order getOrder() {
		return order;
	}
	public void setOrder(Order order) {
		this.order = order;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	public Result<T> getResult() {
		return result;
	}
	public void setResult(Result<T> result) {
		this.result = result;
	}
	
	
}
