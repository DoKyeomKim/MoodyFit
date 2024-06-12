<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>



    <title>카테고리 작성</title>

 <style>
       /* 전체 페이지 스타일 */
body {
    font-family: '맑은 고딕', 'Nanum Gothic', Verdana, Dotum, AppleGothic, sans-serif;
}
main {
    width: 90%;
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    padding: 20px;
    font-size : 15px;
  
}

.table td {
        padding: 30px; /* 셀 내부 여백 조정 */
        margin: 30px; /* 셀 외부 여백 조정 */
    }
.container {
    display: flex;
    flex-wrap: wrap;
}

.container > * {
    flex: 1;
    margin-right: 30px; /* Adjust as needed */
}

.container > *:last-child {
    margin-right: 0;
}

/* Adjust column widths as needed */
.col-main {
    flex: 3; /* Main content width */
}

.col-sidebar {
    flex: 1; /* Sidebar content width */
    margin-top:30px;
}
form {
    margin-top: 20px;
}
table td {
	height: 50px;
    padding: 10px 0;
    border-bottom: 1px solid #e5e5e5;
    width:50%;
}
table td:first-child {
    width: 150px;
    font-weight: bold;
}
input[type="text"],
select {
    width: 50%;
    height: 40px;
    padding: 8px 12px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 15px;
}
input[type="text"]
{
height:30px;
width:300px;
}

input[type="submit"],
input[type="button"] {
    background-color: #111111;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    margin-left:89%;
}

input[type="button"] {
    background-color: #f4f4f4;
    color: #333;
}
    </style>
</head>
<body>
  <%@include file="/WEB-INF/layouts/adminheader.jsp"%> 
   <div class="col-sidebar">
                <%@include file="/WEB-INF/layouts/adminsidebar.jsp"%>
            </div>
<main>
    <h2>카테고리 등록</h2>
    <form action="/admin/adminCategoryWrite" method="Post">
        <table>
            <tr>
                <td>카테고리 소속</td>
                <td>
                    <select name="category">
                        <option value="category">상위 카테고리</option>
                        <option value="sub_category">하위 카테고리</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>카테고리 한글명</td>
                <td><input type="text" name="korName" /></td>
            </tr>
            <tr>
                <td>카테고리 영문명</td>
                <td><input type="text" name="engName" /></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="저장" />
 
                </td>
            </tr>
        </table>
    </form>
</main>

<script>
document.getElementById('categoryType').addEventListener('change', function() {
    var categoryType = this.value;
    var categoryFields = document.getElementById('categoryFields');
    var subCategoryFields = document.getElementById('subCategoryFields');

    if (categoryType === 'category') {
        categoryFields.style.display = 'block';
        subCategoryFields.style.display = 'none';
    } else if (categoryType === 'subcategory') {
        categoryFields.style.display = 'none';
        subCategoryFields.style.display = 'block';
    }
});
</script>

</body>
</html>