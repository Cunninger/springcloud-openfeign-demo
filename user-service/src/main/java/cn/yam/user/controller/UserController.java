package cn.yam.user.controller;

import cn.yam.user.domain.User;
import cn.yam.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 功能：
 * 日期：2024/10/10 下午4:35
 */
@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @GetMapping("/{userId}")
    public User getUserById(@PathVariable Long userId) {
        User user = userService.getById(userId);
        return user;
    }
}