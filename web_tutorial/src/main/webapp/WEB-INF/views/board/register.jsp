<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../include/header.jsp"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script type="text/javascript" src="/resources/js/upload.js"></script>
<link href="/resources/css/SP.css" rel="stylesheet">



<script id="template" type="text/x-handlebars-template">
<li>
  <span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" onerror="this.style.display='none'"></span>
  <div class="mailbox-attachment-info">
	<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
	<a href="{{fullName}}" 
     class="btn btn-default btn-xs pull-right delbtn"><i class="fa fa-fw fa-remove"></i></a>
	</span>
  </div>
</li>                
</script>    

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
    
     <div class="panel-heading">Board Register</div><!-- /.panel-heading -->
     
      <div class="panel-body">
        <form id='registerForm' role="form" action="/board/register" method="post" enctype="multipart/form-data"> 
          <div class="form-group">
            <label>Title</label> <input class="form-control" name='title'>
          </div>
          <div class="form-group">
            <label>Text area</label>
            <textarea class="form-control" rows="3" name='content'></textarea>
          </div>
          <div class="form-group">
            <label>Writer</label> <input class="form-control" name='writer'>
          </div>
          
       
      <div class="form-group"> <!-- 첨부파일 다운로드 -->
       
       	<ul class="mailbox-attachments clearfix uploadedList" style="padding-left:0px;">
			</ul>
      </div>
          
         <div class="form-group">
			<label for="exampleInputEmail1">File DROP Here</label>
			<div class="fileDrop"></div>
		</div>
          
         <hr>
          <button id="SubmitBtn" type="submit" class="btn btn-default">Submit Button</button>
          
          <button type="reset" class="btn btn-default">Reset Button</button>
          
          <button id="ListBtn" class="btn btn-default">List</button>
        </form>
      </div> <!--  end panel-body -->
    </div> <!--  end panel-body -->
  </div> <!-- end panel -->
</div> <!-- /.row -->
<script>

$(document).ready(function(){
	
	var template = Handlebars.compile($("#template").html());
	
	$(".fileDrop").on("dragenter dragover", function(event){
		event.preventDefault();
	});
	
	
	$(".fileDrop").on("drop", function(event){
		event.preventDefault();
		var files = event.originalEvent.dataTransfer.files;
		
		var file =files[0];
		
		var formData = new FormData();
		
		formData.append("file", file);
		
		$.ajax({
			url: '/uploadAjax',
			data: formData,
			dataType:'text',
			processData: false,
			contentType: false,
			type:'POST',
			success: function(data){
				var fileInfo = getFileInfo(data);
				
				var html = template(fileInfo);
				
				$(".uploadedList").append(html);
			}
		});
		
	});
	
	$("#registerForm").submit(function(event){
		event.preventDefault();
		var that = $(this);
		var str ="";
		$(".uploadedList .delbtn").each(function(index){
			 str += "<input type='hidden' name='files["+index+"]' value='"+$(this).attr("href") +"'> ";
		});
		that.append(str);
		that.get(0).submit();
	});

	
	$(".uploadedList").on("click",  ".delbtn" ,function(event){

	  event.preventDefault();
		
	  var that = $(this);
	  
	  $.ajax({
		   url:"/deleteFile",
		   type:"post",
		   data: {fileName:$(this).attr("href")},
		   dataType:"text",
		   success:function(result){
			   console.log("RESULT: " + result);
			   if(result == 'deleted'){
				   that.closest("li").remove();
			   }
		   }
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

	var Formobj= $("form[role='form']");
		
	$("#ListBtn").on("click",function(){
		Formobj.attr("action","/board/list");
		Formobj.attr("method", "get");
		Formobj.submit();
	});
	
	$("#SubmitBtn").on("click",function(){
		if($("input[name=title]").val()==""){
			alert("제목을 입력하세요!");
			$("input[name='title']").focus();
			return false;
		}
		if($("input[name=content]").val()==""){
			alert("내용을 입력하세요!");
			$("input[name='content']").focus();
			return false;
		}
		if($("input[name='writer']").val()==""){
			alert("이름을 입력하세요!");
			$("input[name='writer']").focus();
			return false;
		}
	});
});

</script>
<%@include file="../include/footer.jsp"%>