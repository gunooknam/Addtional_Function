<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<%@include file="../include/header.jsp"%>
<link href="/resources/css/SP.css" rel="stylesheet">
       <script type="text/javascript" src="/resources/js/upload.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
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

      <div class="panel-heading">Board Modify Page</div>
      <!-- /.panel-heading -->
      <div class="panel-body">

		 <form id="form1" role="form" method="post" action="/board/modify" enctype="multipart/form-data" >
          <div class="form-group">
          <label>Bno</label> <input class="form-control" name='bno'
            value="${boardVO.bno }" readonly="readonly"/>
        </div>
        <div class="form-group">
          <label>Title</label> <input class="form-control" name='title'
            value="${boardVO.title}" >
        </div>
     	  <div class="form-group">
	          <label>Text area</label>
	          <textarea class="form-control" rows="3" name='content'
	           ><c:out value="${boardVO.content}" /></textarea>
       	  </div>
        <div class="form-group">
          <label>Writer</label> <input class="form-control" name='writer'
            value="${boardVO.writer }" readonly="readonly">
        </div>
          
         <div>
			<hr>
		</div>
	  <div class="form-group"> <!-- 첨부파일 다운로드 -->
		<ul class="mailbox-attachments clearfix uploadedList" style="padding-left:0px;"></ul>
      </div>
      <div class="form-group">
       <label for="exampleInputEmail1">File DROP Here</label>
       <div class="fileDrop"></div>
      </div> 
  
      <hr>   
		<button id="ModiBtn" class="btn btn-default">Modify</button>
		<button id="ListBtn" class="btn btn-default">List</button>
		</form>
      </div>
      <!--  end panel-body -->

    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>
<!-- /.row -->

<script>
$(document).ready(function(){
	
	 var formobj = $("form[role='form']");
	    
	  formobj.submit(function(event){
	   event.preventDefault();
	     
	   var that = $(this);
	     
	   var str ="";
	   $(".uploadedList .delbtn").each(function(index){
	       str += "<input type='hidden' name='files["+index+"]' value='"+$(this).attr("href") +"'> ";
	   });
	     
	   that.append(str);
	   
	   console.log(str);
	     
	   that.get(0).submit();
	 });

	
	 $("#ListBtn").on("click",function(){
		formobj.attr("action","/board/list");
		formobj.attr("method","get");
		formobj.submit();
	 }); 
	 $("#ModiBtn").on("click",function(){
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
	 }); 
	 
	 var template = Handlebars.compile($("#template").html());


	 $(".fileDrop").on("dragenter dragover", function(event){
	 	event.preventDefault();
	 });


	 $(".fileDrop").on("drop", function(event){
	 	event.preventDefault();
	 	
	 	var files = event.originalEvent.dataTransfer.files;
	 	
	 	var file = files[0];

	 	//console.log(file);
	 	
	 	var formData = new FormData();
	 	
	 	formData.append("file", file);	
	 	
	 	$.ajax({
	 		  url: '/uploadAjax',
	 		  data: formData,
	 		  dataType:'text',
	 		  processData: false,
	 		  contentType: false,
	 		  type: 'POST',
	 		  success: function(data){
	 			  
	 			  var fileInfo = getFileInfo(data);
	 			  
	 			  var html = template(fileInfo);
	 			  
	 			  $(".uploadedList").append(html);
	 		  }
	 		});	
	 });


	 $(".uploadedList").on("click", ".delbtn", function(event){
	 	
	 	event.preventDefault();
	 	
	 	var that = $(this);
	 	 
	 	$.ajax({
	 	   url:"/deleteFile",
	 	   type:"post",
	 	   data: {fileName:$(this).attr("href")},
	 	   dataType:"text",
	 	   success:function(result){
	 		   if(result == 'deleted'){
	 			   that.closest("li").remove();
	 		   }
	 	   }
	    });
	 });


	 var bno = ${boardVO.bno};
	 var template = Handlebars.compile($("#template").html());

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