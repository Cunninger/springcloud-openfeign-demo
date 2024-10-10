package cn.yam.order.service.Impl;

import cn.yam.order.client.UserClient;
import cn.yam.order.domain.Order;
import cn.yam.order.domain.OrderVo;
import cn.yam.order.mapper.OrderMapper;
import cn.yam.order.service.OrderService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

@Service
public class OrderServiceImpl extends ServiceImpl<OrderMapper, Order> implements OrderService {
    @Autowired
    private UserClient userClient;


    @Override
    public OrderVo getApiById(Long id) {
        Order order = getById(id);
        if (order == null) {
            throw new IllegalArgumentException("Order not found for id: " + id);
        }
        OrderVo orderVo = new OrderVo();
        BeanUtils.copyProperties(order, orderVo);
        orderVo.setUser(userClient.getUserById(orderVo.getUserId()));
        return orderVo;
    }

}
