package cn.yam.user.service.impl;

import cn.yam.user.domain.User;
import cn.yam.user.mapper.UserMapper;
import cn.yam.user.service.UserService;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

}
