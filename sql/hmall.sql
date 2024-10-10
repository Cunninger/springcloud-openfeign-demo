# 如果没有hmall 数据库则建立
create database if not exists hmall;
create table if not exists address
(
    id         bigint auto_increment
        primary key,
    user_id    bigint       null comment '用户ID',
    province   varchar(10)  null comment '省',
    city       varchar(10)  null comment '市',
    town       varchar(10)  null comment '县/区',
    mobile     varchar(255) null comment '手机',
    street     varchar(255) null comment '详细地址',
    contact    varchar(255) null comment '联系人',
    is_default varchar(1)   null comment '是否是默认 1默认 0否',
    notes      varchar(255) null comment '备注'
)
    charset = utf8mb3
    row_format = COMPACT;

create index user_id
    on address (user_id);

create table if not exists cart
(
    id          bigint auto_increment comment '购物车条目id '
        primary key,
    user_id     bigint                                 not null comment '用户id',
    item_id     bigint                                 not null comment 'sku商品id',
    num         int          default 1                 not null comment '购买数量',
    name        varchar(256)                           not null comment '商品标题',
    spec        varchar(1024)                          null comment '商品动态属性键值集',
    price       int                                    not null comment '价格,单位：分',
    image       varchar(256) default ''                null comment '商品图片',
    create_time timestamp    default CURRENT_TIMESTAMP null comment '创建时间',
    update_time timestamp    default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment '更新时间'
)
    comment '订单详情表' charset = utf8mb3
                         row_format = COMPACT;

create index key_user_item_id
    on cart (user_id, item_id);

create table if not exists item
(
    id            bigint auto_increment comment '商品id'
        primary key,
    name          varchar(200)                         not null comment 'SKU名称',
    price         int        default 0                 not null comment '价格（分）',
    stock         int                                  not null comment '库存数量',
    image         varchar(200)                         null comment '商品图片',
    category      varchar(200)                         null comment '类目名称',
    brand         varchar(100)                         null comment '品牌名称',
    spec          varchar(200)                         null comment '规格',
    sold          int        default 0                 null comment '销量',
    comment_count int        default 0                 null comment '评论数',
    isAD          tinyint(1) default 0                 null comment '是否是推广广告，true/false',
    status        int        default 2                 null comment '商品状态 1-正常，2-下架，3-删除',
    create_time   datetime   default CURRENT_TIMESTAMP null comment '创建时间',
    update_time   datetime   default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment '更新时间',
    creater       bigint                               null comment '创建人',
    updater       bigint                               null comment '修改人'
)
    comment '商品表' charset = utf8mb3
                     row_format = COMPACT;

create index category
    on item (category);

create index status
    on item (status);

create index updated
    on item (update_time);

create table if not exists `order`
(
    id           bigint                              not null comment '订单id'
        primary key,
    total_fee    int       default 0                 not null comment '总金额，单位为分',
    payment_type tinyint(1) unsigned zerofill        not null comment '支付类型，1、支付宝，2、微信，3、扣减余额',
    user_id      bigint                              not null comment '用户id',
    status       tinyint(1)                          null comment '订单的状态，1、未付款 2、已付款,未发货 3、已发货,未确认 4、确认收货，交易成功 5、交易取消，订单关闭 6、交易结束，已评价',
    create_time  timestamp default CURRENT_TIMESTAMP null comment '创建时间',
    pay_time     timestamp                           null comment '支付时间',
    consign_time timestamp                           null comment '发货时间',
    end_time     timestamp                           null comment '交易完成时间',
    close_time   timestamp                           null comment '交易关闭时间',
    comment_time timestamp                           null comment '评价时间',
    update_time  timestamp default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment '更新时间'
)
    collate = utf8mb3_bin
    row_format = COMPACT;

create index multi_key_status_time
    on `order` (status, create_time);

create table if not exists order_detail
(
    id          bigint auto_increment comment '订单详情id '
        primary key,
    order_id    bigint                                  not null comment '订单id',
    item_id     bigint                                  not null comment 'sku商品id',
    num         int                                     not null comment '购买数量',
    name        varchar(256)                            not null comment '商品标题',
    spec        varchar(1024) default ''                null comment '商品动态属性键值集',
    price       int                                     not null comment '价格,单位：分',
    image       varchar(256)  default ''                null comment '商品图片',
    create_time timestamp     default CURRENT_TIMESTAMP null comment '创建时间',
    update_time timestamp     default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment '更新时间'
)
    comment '订单详情表' charset = utf8mb3
                         row_format = COMPACT;

create index key_order_id
    on order_detail (order_id);

create table if not exists order_logistics
(
    order_id          bigint                                not null comment '订单id，与订单表一对一'
        primary key,
    logistics_number  varchar(18) default ''                null comment '物流单号',
    logistics_company varchar(18) default ''                null comment '物流公司名称',
    contact           varchar(32)                           not null comment '收件人',
    mobile            varchar(11)                           not null comment '收件人手机号码',
    province          varchar(16)                           not null comment '省',
    city              varchar(32)                           not null comment '市',
    town              varchar(32)                           not null comment '区',
    street            varchar(256)                          not null comment '街道',
    create_time       timestamp   default CURRENT_TIMESTAMP null comment '创建时间',
    update_time       timestamp   default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment '更新时间'
)
    charset = utf8mb3
    row_format = COMPACT;

create table if not exists pay_order
(
    id               bigint auto_increment comment 'id'
        primary key,
    biz_order_no     bigint                                  not null comment '业务订单号',
    pay_order_no     bigint        default 0                 not null comment '支付单号',
    biz_user_id      bigint                                  not null comment '支付用户id',
    pay_channel_code varchar(30)   default '0'               not null comment '支付渠道编码',
    amount           int                                     not null comment '支付金额，单位分',
    pay_type         tinyint       default 5                 not null comment '支付类型，1：h5,2:小程序，3：公众号，4：扫码，5：余额支付',
    status           tinyint       default 0                 not null comment '支付状态，0：待提交，1:待支付，2：支付超时或取消，3：支付成功',
    expand_json      varchar(1024) default ''                not null comment '拓展字段，用于传递不同渠道单独处理的字段',
    result_code      varchar(20)   default ''                null comment '第三方返回业务码',
    result_msg       varchar(50)   default ''                null comment '第三方返回提示信息',
    pay_success_time datetime                                null comment '支付成功时间',
    pay_over_time    datetime                                not null comment '支付超时时间',
    qr_code_url      varchar(255)                            null comment '支付二维码链接',
    create_time      datetime      default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time      datetime      default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    creater          bigint        default 0                 not null comment '创建人',
    updater          bigint        default 0                 not null comment '更新人',
    is_delete        bit           default b'0'              not null comment '逻辑删除',
    constraint biz_order_no
        unique (biz_order_no),
    constraint pay_order_no
        unique (pay_order_no)
)
    comment '支付订单' charset = utf8mb3
                       row_format = DYNAMIC;

create table if not exists user
(
    id          bigint auto_increment
        primary key,
    username    varchar(50)   not null comment '用户名',
    password    varchar(128)  not null comment '密码，加密存储',
    phone       varchar(20)   null comment '注册手机号',
    create_time datetime      not null comment '创建时间',
    update_time datetime      not null,
    status      int default 1 null comment '使用状态（1正常 2冻结）',
    balance     int           null comment '账户余额',
    constraint username
        unique (username)
)
    comment '用户表' charset = utf8mb3
                     row_format = COMPACT;

