<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GET AND POST</title>
</head>
<body>
	<h1>GET and POST TEST</h1>
	
		<form method="POST" action= ./urlF>
			<table>
				 <tr>
				 	<td><label>학번</label></td>
					<td><input type="text" name="StudentID" ></td>
				</tr>
				 
				 <tr>
				 	<td><label>이름</label></td>
					<td><input type="text" name="name" ></td>
				</tr>	
			</table>
			<input type="submit" value="전송">
		</form>
</body>
</html>