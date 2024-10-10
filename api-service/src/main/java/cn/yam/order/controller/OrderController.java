package cn.yam.order.controller;

import cn.yam.order.domain.Order;
import cn.yam.order.domain.OrderVo;
import cn.yam.order.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 功能：
 * 日期：2024/10/10 上午11:15
 */
@RestController
@RequestMapping("/order")
public class OrderController {
    @Autowired
    private OrderService orderService;

    @GetMapping("/{orderId}")
    public OrderVo getApiById(@PathVariable Long orderId) {
        OrderVo orderVo = orderService.getApiById(orderId);
        return orderVo;
    }
}