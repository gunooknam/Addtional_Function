<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../include/header.jsp"%>
<script type="text/javascript" src="/resources/js/upload.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<link href="/resources/css/SP.css" rel="stylesheet">


 <div class='popup back' style="display:none;"></div>
 	<div id="popup_front" class='popup front' style="display:none;">
  	<img id="popup_img">
 </div>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">2017000000</h1>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading">Board Read Page</div>
      <!-- /.panel-heading -->
      <div class="panel-body">

          <div class="form-group">
          <label>Bno</label> <input class="form-control" name='bno'
            value='<c:out value="${boardVO.bno }"/>' readonly="readonly">
        </div>

        <div class="form-group">
          <label>Title</label> <input class="form-control" name='title'
            value='<c:out value="${boardVO.title }"/>' readonly="readonly">
        </div>

        <div class="form-group">
          <label>Text area</label>
          <textarea class="form-control" rows="3" name='content'
            readonly="readonly"><c:out value="${boardVO.content}" /></textarea>
        </div>
        <div class="form-group">
          <label>Writer</label> <input class="form-control" name='writer'
            value='<c:out value="${boardVO.writer}"/>' readonly="readonly">
        </div>
        
       <div class="form-group"> <!-- 첨부파일 다운로드 -->
    
         
        <hr>
        
       	 <ul class="mailbox-attachments clearfix uploadedList" style="padding-left:0px;">
		</ul>
        
	  <script id="templateAttach" type="text/x-handlebars-template">
		<li data-src='{{fullName}}'>
  			<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" onerror="this.style.display='none'"></span>
  				<div class="mailbox-attachment-info">
				<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
			</span>
  		</div>
		</li>                
	 </script>  

      </div>
      <hr>
		<button id="ModiBtn" class="btn btn-default">Modify</button>
		<button id="ListBtn" class="btn btn-default" onclick="location.href='/board/list'">List</button>
		<button id="DelBtn" class="btn btn-default">Delete</button>
      </div><!--  end panel-body -->
		<form id="Form" method="post">
			<input type="hidden" name="bno" value="${boardVO.bno}">
		</form>
    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>
<!-- /.row -->
<script>
$(document).ready(function(){
	var Formobj= $("#Form");
	$("#ModiBtn").on("click",function(){
		Formobj.attr("action","/board/modify");
		Formobj.attr("method", "get");
		Formobj.submit();
	});
	$("#ListBtn").on("click", function(){
		self.location ="/board/list";
	});
	$("#DelBtn").on("click", function(){
		Formobj.attr("action","/board/remove");
		Formobj.submit();
	});
	
	var bno = ${boardVO.bno};
	var template = Handlebars.compile($("#templateAttach").html());
	
	$.getJSON("/board/getAttach/"+bno,function(list){
		$(list).each(function(){
			
			var fileInfo = getFileInfo(this);
			var html = template(fileInfo);
			
			 $(".uploadedList").append(html);
			
		});
	});

	$(".uploadedList").on("click", ".mailbox-attachment-info a", function(event){
		
		var fileLink = $(this).attr("href");
		
		if(checkImageType(fileLink)){
			
			event.preventDefault();
					
			var imgTag = $("#popup_img");
			imgTag.attr("src", fileLink);
			
			console.log(imgTag.attr("src"));
					
			$(".popup").show('slow');
			imgTag.addClass("show");		
		}	
	});
	
	$("#popup_img").on("click", function(){
		
		$(".popup").hide('slow');
		
	});	

	
});
</script>
<%@include file="../include/footer.jsp"%>