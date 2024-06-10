package com.mf;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.mf.mapper")
public class MoodyFitApplication {

	public static void main(String[] args) {
		SpringApplication.run(MoodyFitApplication.class, args);
	}

}
