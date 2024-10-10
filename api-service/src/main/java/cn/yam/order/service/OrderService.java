package cn.yam.order.service;

import cn.yam.order.domain.Order;
import cn.yam.order.domain.OrderVo;
import com.baomidou.mybatisplus.extension.service.IService;

public interface OrderService extends IService<Order> {

    OrderVo getApiById(Long id);
}
