package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PaymentRequest {
	
    private String imp_uid;
    private String merchant_uid;
    private String impKey;
    private String impSecret;
    
    

   
}
