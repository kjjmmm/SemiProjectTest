<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<style>
    div{
        box-sizing: border-box;
    }
    #wrapper{
        margin: auto;
        width: 800px;
        text-align: center;
        margin-top: 50px;
    }
    #board{
        width: 100%;
        height: 50px;
        line-height: 50px;
    }
    #text_no{
        float: left;
        width: 10%;
    }
    #text_title{
        float: left;
        width: 70%;
    }
    #writer{
        float: left;
        width: 10%;
    }
    #date{
        float: left;
        width: 10%;
    }
    #btn1{
        text-align: right;
        margin-bottom: 20px;
        margin-right: 40px;
    }
    .pagination{
    	margin: 0;
    }
    li{
        list-style: none;
    }
    hr{
    	border : thin solid dodgerblue;
        color: dodgerblue;
        margin-bottom: 10px;
        margin-top: 10px;
    }
    #date{
    	width: 85px;
    }
    #search{
        text-align: right;
        width:100%;
    }
</style>
</head>
<body>
	<div id="wrapper" class="container">
        <div id="board" class="row">
            <div class="col-12"><h3><a href="textList.board?currentPage=1">자유게시판</a></h3></div>
        </div>
        <div class="row">
            <div id="search">
            <select id="select" size="1">
                <option>제목</option>
                <option>내용</option>
                <option>작성자</option> 
            </select>
            <input id="keyword" type="text" placeholder="검색어를 입력해주세요.">
            <button id="searchBtn" class="btn btn-sm btn-outline-primary">검색</button>
            </div>
        </div>
        <div id="navi" class="row">
            <div id="text_no" class="col-lg-2 col-md-2 col-sm-3 col-3">글번호</div>
            <div id="text_title" class="col-lg-6 col-md-6 col-sm-9 col-9">제목</div>
            <div id="writer" class="d-none d-md-block mx-1 px-1">작성자</div>
            <div id="date" class="d-none d-md-block px-2 mx-2">작성일</div>
            <div id="viewCount" class="d-none d-md-block">조회수</div>
        </div>
        <hr>
        <c:forEach var="tmp" items="${result}">
	        <div class="row">
	              <div class="col-lg-2 col-md-2 col-sm-3 col-3 p-0">${tmp.textNo}</div>
	              <div class="col-lg-5 col-md-5 col-sm-8 col-8 p-0">
	              <a class="title" href="readingByKeyword.board?option=${option}&keyword=${keyword}&currentPage=${currentPage}&textNo=${tmp.textNo}">${tmp.title}</a></div>
	              <div class="col-lg-2 col-md-2 d-none d-md-block p-1  mx-1 px-1">${tmp.writer}</div>
	              <div id=date class="col-lg-2 col-md-2 d-none d-md-block p-1 mx-1">${tmp.writedate}</div>
	              <div class="col-lg-1 col-md-1 d-none d-md-block p-1 pl-3">${tmp.viewCount}</div>
	        </div>
        </c:forEach>
        
        <div class="row">
            <div class="col-12">
                <nav aria-label="Page navigation example">
                    <ul class="pagination pagination-sm justify-content-center m-2">
                        <c:if test="${pageNavi[0] == 0}">
	                        <li class="page-item"><a class="page-link" href="articleSearch.board?option=${option}&keyword=${keyword}&currentPage=${pageNavi[1]-1}" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
                        </c:if>
                        <c:if test="${currentPage > 1}">
		                    <li class="page-item"><a class="page-link" href="articleSearch.board?option=${option}&keyword=${keyword}&currentPage=${currentPage-1}" aria-label="Previous"><span aria-hidden="true">&lt;</span></a></li>
	                    </c:if>
                        <c:forEach var="navi" items="${pageNavi}" begin="1" end="10">
	                        <c:if test="${navi > 0}">
	                        <li class="page-item"><a class="page-link" href="articleSearch.board?option=${option}&keyword=${keyword}&currentPage=${navi}">${navi}</a></li>
	                        </c:if>
                    	</c:forEach>
                    	<c:if test="${currentPage < pageTotalCount}">
		                        <li class="page-item"><a class="page-link" href="articleSearch.board?option=${option}&keyword=${keyword}&currentPage=${currentPage+1}" aria-label="Previous"><span aria-hidden="true">&gt;</span></a></li>
	                        </c:if>
                        <c:if test="${pageNavi[11] == 0}">
	                        <li class="page-item"><a class="page-link" href="articleSearch.board?option=${option}&keyword=${keyword}&currentPage=${pageNavi[10]+1}" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
                        </c:if>
                    </ul>
                    <div id="btn1"><button id="toMain" type="button" class="btn btn-sm btn-outline-primary">기본페이지로</button>
                    <button id="write" type="button" class="btn btn-sm btn-outline-primary ml-1">글쓰기</button></div>
                </nav>
            </div>
        </div>    
    </div>
    
    <script>
        $("#write").on("click", function(){
            location.href="newArticle.board?&currentPage=${currentPage}";
        })
        $("#toMain").on("click", function(){
        	location.href="welcome.infos";
        })
        $("#searchBtn").on("click", function(){
        	location.href="articleSearch.board?currentPage=${currentPage}&option="+$("#select option:selected").val()+"&keyword="+$("#keyword").val();
        })
        $(".page-link").each(function(i, item){
          if($(item).text()==${currentPage}){
             $(item).css("background-color", "#68b5ff50");
          }
       })
    </script>
</body>
</html>