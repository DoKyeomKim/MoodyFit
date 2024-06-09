<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 선택</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<style>
            
            
            .join-box{
              object-fit:cover;     
  			  transform:scale(1.0);        
			  transition: transform .5s; 
            }
            
            .join-box:hover{ 
  				transform:scale(0.95);
  				transition: transform .5s;
			}

            
            
            </style>
</head>
<main>
               <div class="mt-2">
                    <nav class="sj_full_container navbar">
                        <div class="container mt-3" style="display: block; width: 100%; text-align: center;">
                            <a class="navbar-brand fs-2" href="/">
                                <img src="/images/logo.png" width="20%;" height="20%;"
                                    class="d-inline-block align-text-top">
                                    <br>
                            </a>
                        </div>
                    </nav>
                </div>
               
                <div class="container px-4 my-5 w-50 " style="height: 300px;">
                    <div class="d-flex justify-content-between">
                        <div  class="join-box">
                            <a href="/join" style="color: inherit; text-decoration: none;">
                                <div class="card" style="width:320px; height: 400px;">
                                    <div class="d-flex align-items-center justify-content-center ">
                                        <img src="/images/personal.svg" class="card-img-top w-100 h-100">
                                    </div>
                                    <div class="card-body align-self-center mt-2">
                                        <h3>일반 회원가입</h3>
                                    </div>
                                </div>
                            </a>
                        </div>

                        <div class="join-box">
                            <a href="/storeJoin" style="color: inherit; text-decoration: none; ">
                                <div class="card" style="width:320px; height: 400px;">
                                    <div class="d-flex align-items-center justify-content-center">
                                        <img src="/images/company.svg" class="card-img-top w-100 h-100">
                                    </div>
                                    <div class="card-body align-self-center mt-2">
                                        <h3>가맹점 회원가입</h3>
                                    </div>
                                </div>
                            </a>
                        </div>
                        
                    </div>

                </div>

</main>
<script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>