<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../include/header.jsp"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>

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
		 <button id="ModiBtn" class="btn btn-default">Modify</button>
		 <button id="ListBtn" class="btn btn-default">List</button>
		 <button id="DelBtn"  class="btn btn-default">Delete</button>
      </div><!--  end panel-body -->
		<form id="Form" method="post">
			<input type="hidden" name="bno" value="${boardVO.bno}">
			<input type="hidden" name="page" value="${cri.page}">
			<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
			<input type="hidden" name="searchType" value="${cri.searchType}">
			<input type="hidden" name="keyword" value="${cri.keyword}">	
		</form>
    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12" id="replies">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> REPLY
				<button id='addReplyBtn' class='btn btn-default btn-xs pull-right'>New Reply</button>
			</div> <!-- ./panel-heading -->
			
			<!-- The time line -->
			<ul class="timeline" style="padding-left:20px; padding-right:20px">
				<!-- timeline time label -->
				<li class="time-label" id="repliesDiv"></li>
			</ul>

			<div class='text-center'>
				<ul id="pagination" class="pagination pagination-sm no-margin ">

				</ul>
			</div>
				
				
			</div>			
		</div>		
	</div>

<!--ADD Modal -->
      <div class="modal fade" id="AddModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal"
                aria-hidden="true">&times;</button>
              <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
            </div>
            <div class="modal-body">
              <div class="form-group">
                <label>Reply</label> 
                <input class="form-control" name='replytext' id='reply'  placeholder='New Reply!!!!'>
              </div>      
              <div class="form-group">
                <label>Replyer</label> 
                <input class="form-control" name='replyer' id='replyer' placeholder='replyer'>
              </div>
            </div>
			 <div class="modal-footer">
		        <button id='modalRegisterBtn' type="button" class="btn btn-default">Register</button>
		        <button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
	     	 </div>          
     	 </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
      <!-- /.modal -->


<!-- Modify Modal -->
      <div class="modal fade" id="modifyModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal"
                aria-hidden="true">&times;</button>
              <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
            </div>
            <div class="modal-body">
              <div class="form-group">
                <label>Reply</label> 
                <input class="form-control" id='Modreply' placeholder='New Reply!!!!'>
              </div>      
              <div class="form-group">
                <label>Replyer</label> 
                <input class="form-control" id='Modreplyer' placeholder='replyer' readonly>
              </div>
              <div class="form-group">
                <label>Reply Date</label> 
                <input class="form-control" id='ModreplyDate' placeholder='2018-01-01 13:13' readonly>
              </div>
      
            </div>
			 <div class="modal-footer">                    
		        <button type="button" class="btn btn-default" id="replyModBtn">Modify</button>
       			<button type="button" class="btn btn-default" id="replyDelBtn">DELETE</button>
        		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	     	 </div>          
     	 </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
      <!-- /.modal -->

<%@include file="../include/footer.jsp"%>

<script id="template" type="text/x-handlebars-template">
		{{#each .}}
		<li class="replyLi" data-rno={{rno}} style="list-style:none">
 		<div class="timeline-item" >
  		<span class="time pull-right">
    		<i class="fa fa-clock-o" ></i>{{prettifyDate regdate}}
  		</span>
  		<h3 class="timeline-header" style="margin-top:10px" >{{replyer}}</h3>
  		<div class="timeline-body">{{replytext}} </div>
    		<div class="timeline-footer">
     		<a class="btn btn-default btn-xs" 
	    		data-toggle="modal" data-target="#modifyModal">Modify</a>
    		</div>
			<hr>
  		</div>			
		</li>
		{{/each}}
</script>

<script>
Handlebars.registerHelper("prettifyDate", function(timeValue){
	var dateObj = new Date(timeValue);
	var year = dateObj.getFullYear();
	var month = dateObj.getMonth() + 1;
	var date = dateObj.getDate();
	var hour = dateObj.getHours();
	var min = dateObj.getMinutes();
	return year+"/"+month+"/"+date+"/"+hour+":"+min;
});

var bno= ${boardVO.bno};
var replyPage=1;
getPage("/replies/"+bno+"/"+replyPage);

var printData = function(replyArr, target, templateObject){
	var template =Handlebars.compile(templateObject.html()); //html까지 넣는다. 
	
	var html = template(replyArr);
	$(".replyLi").remove();
	target.after(html);
}

function getPage(pageInfo){
	
	$.getJSON(pageInfo, function(data){
		
		printData(data.list, $("#repliesDiv"), $('#template'));	
		printPaging(data.pageMaker, $(".pagination"));
		
		$("#AddModal").modal('hide');	
		$("#modifyModal").modal('hide');	
		
	});
}

function printPaging(pageMaker, target){
	var str="";
	if(pageMaker.prev){
		str += "<li><a href='"+(pageMaker.startPage-1)+"'> << </a></li>";
	}
	for(var i=pageMaker.startPage, len=pageMaker.endPage; i<=len; i++){
		var strClass=pageMaker.cri.page == i?'class=active':'';
		str+="<li "+strClass+"><a href='"+i+"'>"+i+"</a></li>";
	}
	if(pageMaker.next){
		alert("Hello");
		str += "<li><a href='"+(pageMaker.endPage + 1)+"'> >> </a></li>";
	}
	$('.pagination').html(str);
}
</script>


<script>
$(document).ready(function(){
	var Formobj= $("#Form");
	$("#ModiBtn").on("click",function(){
		Formobj.attr("action","/board/modify");
		Formobj.attr("method", "get");
		Formobj.submit();
	});
	
	$("#ListBtn").on("click", function(){
		Formobj.attr("method","get");
		Formobj.attr("action","/board/list"); //뒤에 파라미터가 붙어서 날아간다. 
		Formobj.submit();
	});
	
	$("#DelBtn").on("click", function(){
		Formobj.attr("action","/board/remove");
		Formobj.submit();
	});
	
	$("#repliesDiv").on("click",function(){
		
		if($(".timeline li").size() > 1){
			returnl
		}
		getPage("/replies/" + bno + "/1");
		
	});
	
	$(".pagination").on("click","li a", function(event){
		
		event.preventDefault();
		
		replyPage = $(this).attr("href");
		
		getPage("/replies/"+bno+"/"+replyPage);
	});
	
	
	$("#addReplyBtn").on("click",function(){
	
		$("#AddModal").modal('show');	
		
	});
	
	
	$(".timeline").on("click", ".replyLi", function(event){
		
		var reply = $(this);
		
		$("#replytext").val(reply.find('.timeline-body').text());
		$(".modal-title").html(reply.attr("data-rno"));
		
		var replycontent=reply.find(".timeline-body").text();
		var user=reply.find(".timeline-header").text();
		var time=reply.find(".time").text();
		
		var reply =$("#Modreply").attr("placeholder", replycontent);
		var replyer=$("#Modreplyer").attr("placeholder", user);
		var replyDate=$("#ModreplyDate").attr("placeholder",time.trim());
		
	});
	
	
	$("#modalCloseBtn").on("click", function(){
		$("#AddModal").modal("hide");
	}); 
	
	$('#modalRegisterBtn').on("click", function(){
		
		var replyer = $("#replyer").val();
		var replytext = $("#reply").val();
		
		$.ajax({
			type : 'post',
			url : '/replies',
			headers : {
				"Content-Type":"application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType : 'text', //여기다 제이슨으로 하면 제이슨 형태로오고, xml로 하면 xml형태로 온다.
			data : JSON.stringify({
				bno : bno,
				replyer : replyer,
				replytext : replytext
			}),
			success : function(result) {
				if (result == 'SUCCESS'){
					alert("등록되었습니다.");
					replyPage=1;
					getPage("/replies/" +bno+ "/" + replyPage );
					$("#replyer").val("");
					$("#replytext").val("");
				}
			}});
	});
	
	$("#replyModBtn").on("click",function(){
		 var rno = $(".modal-title").html();
		 var replytext = $("#Modreply").val();

		 
		 $.ajax({
				type:'put',
				url:'/replies/'+rno,
				headers: { 
				      "Content-Type": "application/json",
				      "X-HTTP-Method-Override": "PUT" },
				data:JSON.stringify({replytext:replytext}), 
				dataType:'text', 
				success:function(result){
					console.log("result: " + result);
					if(result == 'SUCCESS'){
						alert("수정 되었습니다.");
						getPage("/replies/"+bno+"/"+replyPage );
					}
			}});
	});
	
	
	$("#replyDelBtn").on("click",function(){
		  var rno = $(".modal-title").html();
		  var replytext = $("#replytext").val();
		  
		  $.ajax({
				type:'delete',
				url:'/replies/'+rno,
				headers: { 
				      "Content-Type": "application/json",
				      "X-HTTP-Method-Override": "DELETE" },
				dataType:'text', 
				success:function(result){
					console.log("result: " + result);
					if(result == 'SUCCESS'){
						alert("삭제 되었습니다.");
						getPage("/replies/"+bno+"/"+replyPage );
					}
			}});
	});
	
});
</script>
