package com.mf.dto;

import java.util.List;


// ProductOptionDto를 감쌈
public class ProductInfoList {
	private List<ProductOptionDto> productInfos;
	public List<ProductOptionDto> getProductInfos() {
        return productInfos;
    }
	public void setProductInfos(List<ProductOptionDto> productInfos) {
        this.productInfos = productInfos;
    }
}
