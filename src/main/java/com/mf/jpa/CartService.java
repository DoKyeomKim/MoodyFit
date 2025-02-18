package com.mf.jpa;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mf.mapper.OrderMapper;
import com.mf.service.MyPageService;

@Service
public class CartService {

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private ProductInfoRepository productInfoRepository;

    @Autowired
    private ProductQuantityRepository productQuantityRepository;

    @Autowired
    private OrderCartRepository orderCartRepository;

    private final OrdersRepository ordersRepository;

    @Autowired
    public CartService(OrdersRepository ordersRepository, 
                       CartRepository cartRepository,
                       ProductInfoRepository productInfoRepository,
                       ProductQuantityRepository productQuantityRepository,
                       MyPageService myPageService) {
        this.ordersRepository = ordersRepository;
        this.cartRepository = cartRepository;
        this.productInfoRepository = productInfoRepository;
        this.productQuantityRepository = productQuantityRepository;
        this.myPageService = myPageService;
    }

    @Autowired
    private MyPageService myPageService;

    @Transactional
    public void updateCartAndCreateOrder(List<Long> selectedItems, Map<String, String> allParams, Long personIdx) throws Exception {
        // 1. 장바구니 항목 업데이트
        for (Long cartIdx : selectedItems) {
            int quantity = Integer.parseInt(allParams.get("quantity_" + cartIdx));
            String updateCartSql = "UPDATE cart SET quantity = ?, state = '결제중' WHERE cart_idx = ?";
            jdbcTemplate.update(updateCartSql, quantity, cartIdx);
        }

        // 2. 재고 확인 및 재고 차감
        for (Long cartIdx : selectedItems) {
            String stockCheckSql = "SELECT c.quantity AS cartQuantity, q.quantity AS stockQuantity " +
                                   "FROM cart c " +
                                   "JOIN product_info p ON p.product_info_idx = c.product_info_idx " +
                                   "JOIN product_quantity q ON q.product_info_idx = p.product_info_idx " +
                                   "WHERE c.cart_idx = ?";
            Map<String, Object> stockResult = jdbcTemplate.queryForMap(stockCheckSql, cartIdx);

            int cartQuantity = ((Number) stockResult.get("cartQuantity")).intValue();
            int stockQuantity = ((Number) stockResult.get("stockQuantity")).intValue();

            if (cartQuantity > stockQuantity) {
                throw new Exception("재고가 부족합니다");
            }

            String updateStockSql = "UPDATE product_quantity SET quantity = quantity - ? WHERE product_info_idx = (SELECT product_info_idx FROM cart WHERE cart_idx = ?)";
            jdbcTemplate.update(updateStockSql, cartQuantity, cartIdx);
        }
    }

    @Transactional
    public boolean processOrder(Map<String, Object> basketData1) {
        try {
            // Update cart quantities and product stock
            if (!updateCartQuantity(basketData1)) {
                throw new Exception("Failed to update cart quantity or product stock.");
            }

            // Insert order
            if (!insertOrder(basketData1)) {
                throw new Exception("Failed to insert order.");
            }

            // Update person level
            Long personIdx = Long.valueOf(basketData1.get("personIdx").toString());
            updatePersonLevel(personIdx);

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Transactional
    public boolean updateCartQuantity(Map<String, Object> basketData1) {
        try {
            List<Integer> cartIdxArray = (List<Integer>) basketData1.get("cartIdxArray");

            for (Integer cartIdx : cartIdxArray) {
                Cart cart = cartRepository.findById(cartIdx)
                        .orElseThrow(() -> new Exception("Cart item not found"));

                ProductInfo productInfo = cart.getProductInfo();
                ProductQuantity productQuantity = productQuantityRepository.findByProductInfo(productInfo)
                        .orElseThrow(() -> new Exception("Product quantity not found"));

                int cartQuantity = cart.getQuantity();
                int stockQuantity = productQuantity.getQuantity();

                if (cartQuantity > stockQuantity) {
                    throw new Exception("재고가 부족합니다");
                }

                productQuantity.setQuantity(stockQuantity - cartQuantity);
                productQuantityRepository.save(productQuantity);
            }

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Transactional
    public boolean insertOrder(Map<String, Object> basketData1) {
        try {
            int price = (int) basketData1.get("price");
            int quantity = (int) basketData1.get("quantity");
            int deliveryPrice = (int) basketData1.get("deliveryPrice");
            Long personIdx = Long.valueOf(basketData1.get("personIdx").toString());
            Long deliveryIdx = Long.valueOf(basketData1.get("deliveryIdx").toString());

            int totalPrice = price + deliveryPrice;

            Long orderIdx = ordersRepository.getNextOrderIdx();
            String merchantUid = ordersRepository.generateMerchantUid();

            Orders order = new Orders(
                orderIdx,
                price,
                quantity,
                merchantUid,
                deliveryPrice,
                totalPrice,
                LocalDateTime.now(),
                personIdx,
                "결제중",
                "1",
                deliveryIdx
            );

            ordersRepository.save(order);
            List<Integer> cartIdxArray = (List<Integer>) basketData1.get("cartIdxArray");
            for (Integer cartIdx : cartIdxArray) {
                orderCartRepository.insertOrderCart(orderIdx, cartIdx);
            }

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Transactional
    public void updatePersonLevel(Long personIdx) {
        orderMapper.changePersonLevel(personIdx);
    }
}
