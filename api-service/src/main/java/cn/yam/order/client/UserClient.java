package cn.yam.order.client;

import cn.yam.order.domain.User;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(value = "userservice")
public interface UserClient {
    /**
     * 根据用户id查询用户信息
     *
     * @param userId
     * @return
     */
    @GetMapping("/user/{userId}")
    User getUserById(@PathVariable("userId") Long userId);

}
