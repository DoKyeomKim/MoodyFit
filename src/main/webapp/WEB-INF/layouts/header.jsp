<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<div class="container-fluid">
    <div class="row align-items-center">
        <div class="col-md-6">
            <div class="logo-img">
                <a href="/"><img src="/images/logo.png" style="height: 200px; width:200px;"></a>
            </div>
        </div>
        <div class="col-md-6">
            <div class="search-box">
                <form class="d-flex">
                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </form>
            </div>
        </div>
    </div>
</div>

	
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	    <div class="collapse navbar-collapse" id="navbarNav">
			<c:forEach var="category" items="${category }">
		      <ul class="navbar-nav">
		        <li class="nav-item">
		          <a class="nav-link active" aria-current="page" href="${category.engName }">${category.name }</a>
		        </li>
		      </ul>
			</c:forEach>
		
			<div>
			<a href="/login">로그인</a>			
			</div>
		    
		 </div>
	</nav>
	
</body>
</html>