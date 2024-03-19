-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th1 19, 2024 lúc 05:43 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- Mối Liên Hệ

    -- 1. Bảng lưu trữ thông tin người dùng:
          -- user: Chứa thông tin cơ bản về người dùng như tên, email, số điện thoại, mật khẩu, loại tài khoản (người dùng thông thường hay quản trị viên), trạng thái hoạt động và khu vực sinh sống.
          -- address: Chứa các địa chỉ giao hàng của người dùng, bao gồm tên người nhận, địa chỉ cụ thể, thành phố, tỉnh/thành phố, mã bưu điện, loại địa chỉ (nhà riêng, công ty, v.v.) và trạng thái mặc định.

    -- 2. Bảng lưu trữ thông tin sản phẩm:
          -- product: Chứa thông tin chi tiết về sản phẩm như tên sản phẩm, mô tả, giá cả, đơn vị tính, danh mục, thương hiệu và loại sản phẩm.
          -- image: Lưu trữ các hình ảnh liên quan đến sản phẩm.
          -- nutrition: Chứa thông tin dinh dưỡng của sản phẩm, bao gồm tên thành phần và giá trị dinh dưỡng tương ứng.
          -- offer: Lưu trữ thông tin về các chương trình giảm giá cho sản phẩm, bao gồm giá khuyến mãi, thời gian bắt đầu và kết thúc.
          -- review: Chứa các đánh giá của người dùng về sản phẩm, bao gồm điểm đánh giá và nội dung đánh giá.
          -- storage: Chưa số lượng sản phẩm đã nhập, số lượng sản phẩm đã bán

    -- 3. Bảng quản lý danh mục và thương hiệu:
          -- category: Chứa thông tin về các danh mục sản phẩm, bao gồm tên danh mục, hình ảnh đại diện và màu sắc.
          -- brand: Chứa thông tin về các thương hiệu sản phẩm, bao gồm tên thương hiệu và trạng thái hoạt động.

    -- 4. Bảng hỗ trợ việc mua hàng và thanh toán:
          -- cart: Lưu trữ thông tin giỏ hàng của người dùng, bao gồm sản phẩm đã chọn và số lượng.
          -- order: Lưu trữ thông tin đơn hàng, bao gồm sản phẩm đã đặt, người dùng đặt hàng, địa chỉ giao hàng, mã giảm giá sử dụng (nếu có), giá trị đơn hàng, phí giao hàng, tổng giá trị thanh toán, hình thức giao hàng, hình thức thanh toán, trạng thái thanh toán và trạng thái đơn hàng.
          -- order_payment: Lưu trữ thông tin thanh toán của đơn hàng, bao gồm mã giao dịch và trạng thái thanh toán.
          -- payment: Lưu trữ thông tin thẻ thanh toán của người dùng (nếu có).
          -- promo_code: Chứa thông tin về các mã giảm giá, bao gồm mã giảm giá, tiêu đề, mô tả, loại giảm giá (phần trăm hoặc giá trị cố định), giá trị giảm giá, thời gian hiệu lực và trạng thái hoạt động.
          
    -- 5. Bảng quản lý khu vực và địa bàn:
          -- area: Chứa thông tin về các khu vực/địa bàn, bao gồm tên khu vực 1, tên khu vực 2 và trạng thái hoạt động.
          -- zone: Chứa thông tin về các vùng/khu vực lớn hơn bao gồm các khu vực nhỏ hơn.


--
-- Cơ sở dữ liệu: `grocerygo`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `address`
--

CREATE TABLE `address` (
  `address_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `a_name` varchar(150) NOT NULL DEFAULT '',
  `a_phone` varchar(20) NOT NULL DEFAULT '',
  `a_address` varchar(200) NOT NULL DEFAULT '',
  `a_city` varchar(200) NOT NULL DEFAULT '',
  `a_state` varchar(100) NOT NULL DEFAULT '',
  `a_type_name` varchar(50) NOT NULL DEFAULT '',
  `a_postal_code` varchar(20) NOT NULL DEFAULT '',
  `a_is_default` int(1) NOT NULL DEFAULT 0,
  `a_status` int(1) NOT NULL DEFAULT 1 COMMENT '1: active, 2: deleted',
  `a_created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `a_modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `area`
--

-- Khu vực: Xã Bình Nghĩa, Huyện Bình Lục
CREATE TABLE `area` (
  `area_id` int(11) NOT NULL,
  `zone_id` int(11) NOT NULL DEFAULT 0,
  `ar_name_1` varchar(100) NOT NULL DEFAULT '',
  `ar_name_2` varchar(100) NOT NULL DEFAULT '',
  `ar_status` int(1) NOT NULL DEFAULT 1,
  `ar_created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `brand`
--

CREATE TABLE `brand` (
  `brand_id` int(11) NOT NULL,
  `b_name` varchar(150) NOT NULL DEFAULT '',
  `b_status` int(1) NOT NULL DEFAULT 1 COMMENT '1: active, 2: deleted',
  `b_created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `b_modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `brand`
--

INSERT INTO `brand` (`brand_id`, `b_name`, `b_status`, `b_created_date`, `b_modify_date`) VALUES
(1, 'bigs', 2, '2024-01-13 12:36:25', '2024-01-13 12:43:51'),
(2, 'bigs', 1, '2024-01-13 12:44:17', '2024-01-14 13:14:12');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `c_quantity` int(11) NOT NULL DEFAULT 0,
  `c_status` int(1) NOT NULL DEFAULT 1 COMMENT '1: active, 2: deleted',
  `c_created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `c_modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `category`
--

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `ca_name` varchar(100) NOT NULL,
  `ca_image` varchar(200) NOT NULL,
  `ca_color` varchar(10) NOT NULL,
  `ca_status` int(1) NOT NULL DEFAULT 1 COMMENT '1: active, 2: deleted',
  `ca_created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `ca_modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `category`
--

INSERT INTO `category` (`category_id`, `ca_name`, `ca_image`, `ca_color`, `ca_status`, `ca_created_date`, `ca_modify_date`) VALUES
(1, 'Zenglish', 'category/2024011416020828O2LMlnjZyq.jpg', 'FFFFFF', 1, '2024-01-14 15:38:31', '2024-01-14 16:08:24');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `favorite`
--

CREATE TABLE `favorite` (
  `favorite_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `f_status` int(1) NOT NULL DEFAULT 1 COMMENT '1: active, 2: deleted',
  `f_created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `f_modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `image`
--

CREATE TABLE `image` (
  `image_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `i_image` varchar(200) NOT NULL,
  `i_status` int(1) NOT NULL DEFAULT 1 COMMENT '1: active, 2: deleted',
  `i_created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `i_modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `notification`
--

CREATE TABLE `notification` (
  `notification_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `ref_id` int(11) NOT NULL DEFAULT 0,
  `no_title` varchar(100) NOT NULL DEFAULT '',
  `no_message` varchar(500) NOT NULL DEFAULT '',
  `no_notification_type` int(1) NOT NULL DEFAULT 1,
  `no_is_read` int(1) NOT NULL DEFAULT 1 COMMENT '1: new, 2: read',
  `no_status` int(1) NOT NULL DEFAULT 1 COMMENT '1: active, 2: deleted',
  `no_created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `no_modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nutrition`
--

CREATE TABLE `nutrition` (
  `nutrition_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `n_calo` int(20) NOT NULL DEFAULT 0,
  `n_protid` int(20) NOT NULL DEFAULT 0,
  `n_lipid` int(20) NOT NULL DEFAULT 0,
  `n_fiber` int(20) NOT NULL DEFAULT 0,
  `n_glucid` int(20) NOT NULL DEFAULT 0,
  `n_status` int(1) NOT NULL DEFAULT 1 COMMENT '1: active, 2: deleted',
  `n_created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `n_modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `offer`
--

CREATE TABLE `offer` (
  `offer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `of_price` double NOT NULL DEFAULT 0,
  `of_start_date` datetime NOT NULL DEFAULT current_timestamp(),
  `of_end_date` datetime NOT NULL DEFAULT current_timestamp(),
  `of_status` int(1) NOT NULL DEFAULT 1 COMMENT '1: active, 2: deleted',
  `of_created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `of_modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order`
--

CREATE TABLE `order` (
  `order_id` int(11) NOT NULL,
  `product_id` varchar(100) NOT NULL DEFAULT '' COMMENT '1, 2, 3, 4, 5,..',
  `user_id` int(11) NOT NULL DEFAULT 0,
  `address_id` int(11) NOT NULL DEFAULT 0,
  `promocode_id` varchar(50) NOT NULL DEFAULT '''0''' COMMENT '1, 2, 3, ..',
  `o_user_pay_price` double NOT NULL DEFAULT 0,
  `o_discount_price` double NOT NULL DEFAULT 0,
  `o_deliver_price` double NOT NULL DEFAULT 0,
  `o_total_price` double NOT NULL DEFAULT 0,
  `o_deliver_type` int(1) NOT NULL COMMENT '1: deliver, 2: collection',
  `o_payment_type` int(1) NOT NULL COMMENT '1: COD, 2: online card',
  `o_payment_status` int(1) NOT NULL COMMENT '1: waiting, 2: done, 3: fail, 4: refund',
  `order_status` int(1) NOT NULL DEFAULT 1 COMMENT '1: new, 2: order accept, 3: order delivered, 4: cancel, 5: order declined',
  `o_status` int(1) NOT NULL DEFAULT 1 COMMENT '1: active, 2: deleted',
  `o_created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `o_modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_payment`
--

CREATE TABLE `order_payment` (
  `transaction_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL DEFAULT 0,
  `transaction_payload` varchar(5000) NOT NULL DEFAULT '',
  `payment_transaction` varchar(100) NOT NULL DEFAULT '''''',
  `p_status` int(1) NOT NULL DEFAULT 1 COMMENT '1: active, 2: deleted',
  `p_created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `p_modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `pa_name` varchar(100) NOT NULL DEFAULT '',
  `pa_card_number` varchar(50) NOT NULL DEFAULT '',
  `pa_card_month` varchar(3) NOT NULL DEFAULT '',
  `pa_pa_card_year` varchar(5) NOT NULL DEFAULT '',
  `status` int(1) NOT NULL DEFAULT 1,
  `pa_created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `pa_modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL DEFAULT 0,
  `brand_id` int(11) NOT NULL DEFAULT 0,
  `type_id` int(11) NOT NULL DEFAULT 0,
  `p_name` varchar(200) NOT NULL DEFAULT '',
  `p_detail` varchar(5000) NOT NULL DEFAULT '',
  `p_unit_name` varchar(100) NOT NULL DEFAULT '',
  `p_unit_value` varchar(50) NOT NULL DEFAULT '',
  `p_price` double NOT NULL DEFAULT 0,
  `p_status` int(1) NOT NULL DEFAULT 1 COMMENT '1: active, 2: deleted',
  `p_created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `p_modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `promo_code`
--

CREATE TABLE `promo_code` (
  `promocode_id` int(11) NOT NULL,
  `pr_code` varchar(20) NOT NULL DEFAULT '',
  `pr_title` varchar(200) NOT NULL DEFAULT '',
  `pr_description` varchar(5000) NOT NULL DEFAULT '',
  `pr_type` int(1) NOT NULL DEFAULT 1 COMMENT '1 = Per% , 2 = Fix Amount',
  `pr_min_order_amount` double NOT NULL DEFAULT 0,
  `pr_max_discount_amount` double NOT NULL DEFAULT 500,
  `pr_offer_price` decimal(10,0) NOT NULL DEFAULT 0,
  `pr_start_date` datetime NOT NULL DEFAULT current_timestamp(),
  `pr_end_date` datetime NOT NULL DEFAULT current_timestamp(),
  `pr_status` int(1) NOT NULL DEFAULT 1,
  `pr_created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `pr_modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `review`
--

CREATE TABLE `review` (
  `review_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `r_rate` varchar(5) NOT NULL DEFAULT '',
  `r_message` varchar(1000) NOT NULL DEFAULT '',
  `r_status` int(1) NOT NULL DEFAULT 1 COMMENT '1: active, 2: deleted',
  `r_created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `r_modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `storage`
--

CREATE TABLE `storage` (
  `storage_id` int(11) NOT NULL,
  `s_total` int(100) NOT NULL DEFAULT 0,
  `s_sold` int(100) NOT NULL DEFAULT 0,
  `s_status` int(1) NOT NULL DEFAULT 1 COMMENT '1: active, 2: deleted',
  `s_created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `s_modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL DEFAULT 0,
  `user_name` varchar(75) NOT NULL DEFAULT '',
  `u_type` int(1) NOT NULL DEFAULT 1 COMMENT '1: user, 2: admin',
  `u_name` varchar(100) NOT NULL DEFAULT '',
  `u_email` varchar(100) NOT NULL DEFAULT '',
  `u_mobile` varchar(15) NOT NULL DEFAULT '',
  `u_mobile_code` varchar(6) NOT NULL DEFAULT '',
  `u_password` varchar(100) NOT NULL DEFAULT '',
  `u_auth_token` varchar(100) NOT NULL DEFAULT '',
  `u_dervice_token` varchar(150) NOT NULL,
  `u_reset_code` varchar(6) NOT NULL DEFAULT '0000',
  `u_status` int(1) NOT NULL DEFAULT 1 COMMENT '1: active, 2: deleted',
  `u_created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `u_modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `user`
--

INSERT INTO `user` (`user_id`, `area_id`, `user_name`, `u_type`, `u_name`, `u_email`, `u_mobile`, `u_mobile_code`, `u_password`, `u_auth_token`, `u_dervice_token`, `u_reset_code`, `u_status`, `u_created_date`, `u_modify_date`) VALUES
(1, 0, 'admin', 2, 'admin', 'admin@admin.com', '', '', '', 'ZeRicpoT7f9dM49vDJ0I', '', '0000', 1, '2024-01-13 11:53:32', '2024-01-13 11:53:32'),
(2, 0, 'Tran Truong', 1, 'Trần Văn Trường', 'tranvantruong2002@gmail.com', '0984677725', '', 'truong2002', '4waJNOhlzFtmNYvrVTCZ', '', '0000', 1, '2024-01-09 15:22:10', '2024-01-17 01:05:22'),
(3, 0, 'Nguyen Thi Anh Thu', 1, '', 'anhthu2003@gmail.com', '', '', 'anhthu2003', 'PlriHtPD2yDjXT9WojAB', '0984677725', '0000', 1, '2024-01-13 11:42:38', '2024-01-15 12:50:48');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `zone`
--

CREATE TABLE `zone` (
  `zone_id` int(11) NOT NULL,
  `z_name` varchar(50) NOT NULL DEFAULT '',
  `z_status` int(1) NOT NULL DEFAULT 1,
  `z_created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `z_modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`address_id`);

--
-- Chỉ mục cho bảng `area`
--
ALTER TABLE `area`
  ADD PRIMARY KEY (`area_id`);

--
-- Chỉ mục cho bảng `brand`
--
ALTER TABLE `brand`
  ADD PRIMARY KEY (`brand_id`);

--
-- Chỉ mục cho bảng `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`);

--
-- Chỉ mục cho bảng `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- Chỉ mục cho bảng `favorite`
--
ALTER TABLE `favorite`
  ADD PRIMARY KEY (`favorite_id`);

--
-- Chỉ mục cho bảng `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`image_id`);

--
-- Chỉ mục cho bảng `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`notification_id`);

--
-- Chỉ mục cho bảng `nutrition`
--
ALTER TABLE `nutrition`
  ADD PRIMARY KEY (`nutrition_id`);

--
-- Chỉ mục cho bảng `offer`
--
ALTER TABLE `offer`
  ADD PRIMARY KEY (`offer_id`);

--
-- Chỉ mục cho bảng `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`order_id`);

--
-- Chỉ mục cho bảng `order_payment`
--
ALTER TABLE `order_payment`
  ADD PRIMARY KEY (`transaction_id`);

--
-- Chỉ mục cho bảng `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`);

--
-- Chỉ mục cho bảng `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`);

--
-- Chỉ mục cho bảng `promo_code`
--
ALTER TABLE `promo_code`
  ADD PRIMARY KEY (`promocode_id`);

--
-- Chỉ mục cho bảng `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`review_id`);

--
-- Chỉ mục cho bảng `type`
--
ALTER TABLE `storage`
  ADD PRIMARY KEY (`storage`);

--
-- Chỉ mục cho bảng `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- Chỉ mục cho bảng `zone`
--
ALTER TABLE `zone`
  ADD PRIMARY KEY (`zone_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `address`
--
ALTER TABLE `address`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `area`
--
ALTER TABLE `area`
  MODIFY `area_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `brand`
--
ALTER TABLE `brand`
  MODIFY `brand_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `favorite`
--
ALTER TABLE `favorite`
  MODIFY `favorite_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `image`
--
ALTER TABLE `image`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `notification`
--
ALTER TABLE `notification`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `nutrition`
--
ALTER TABLE `nutrition`
  MODIFY `nutrition_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `offer`
--
ALTER TABLE `offer`
  MODIFY `offer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `order`
--
ALTER TABLE `order`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `order_payment`
--
ALTER TABLE `order_payment`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `promo_code`
--
ALTER TABLE `promo_code`
  MODIFY `promocode_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `review`
--
ALTER TABLE `review`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `type`
--
ALTER TABLE `storage`
  MODIFY `storage_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `zone`
--
ALTER TABLE `zone`
  MODIFY `zone_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
