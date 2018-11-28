<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="post.PostDAO" />
<jsp:useBean id="dto" class="post.PostDTO" />

<%
	String tempDir = application.getRealPath("/post/temp");
	String upDir = application.getRealPath("/post/storage");

	//객체생성
	UploadSave upload = new UploadSave(request, -1, -1, tempDir);

	dto.setPname(UploadSave.encode(upload.getParameter("pname")));
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	dto.setPasswd(upload.getParameter("passwd"));

	//서버참조
	FileItem fileItem = upload.getFileItem("filename");

	//파일 storage넣자!!!!
	int filesize = (int) fileItem.getSize();
	String filename = null;
	if (filesize > 0)
		filename = UploadSave.saveFile(fileItem, upDir);

	dto.setFilename(filename);
	dto.setFilesize(filesize);

	boolean flag = dao.create(dto);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css"> 
.title { /*클래스 슬렉터*/
	font-size: 28px;
	text-align: center;
	border-style: solid; /* 실선 */
	border-width: 1px; /* 선 두께 */
	border-color: #AAAAAA; /* 선 색깔 */
	color: #000000; /* 글자 색깔 */
	width: 30%; /* 화면의 30% */
	padding: 10px; /* 위 오른쪽 아래 왼쪽: 시간 방향 적용 */
	/* padding: 50px 10px;  50px: 위 아래, 10px: 좌우 */
	/* padding-top: 30px;  상단만 간격을 30px 지정   */
	margin: 20px auto; /* 가운데 정렬 기능, 20px: 위 아래, auto: 오른쪽 왼쪽*/
}

.content {
	font-size: 24px;
	text-align: center;
	width: 100%;
	padding: 10px; /* 위 오른쪽 아래 왼쪽 */
	margin: 0 auto; /* 가운데 정렬 */
}

.bottom {
	margin: 20px auto;
	text-align: center;
	width: 100%;
	padding: 10px; /* 위 오른쪽 아래 왼쪽 */
}

 
</style> 

<script type="text/javascript">
function plist(){
	var url="list.jsp";
	location.href=url;    
}
</script>
</head>

<body>
<jsp:include page="/menu/top.jsp" flush="false" />
<!-- *********************************************** -->
<br><br><br>

<DIV class="title">결과</DIV>
<div class="content">
	<%
	if(flag){
		out.print("글이 등록되었습니다.");
	}else{
		out.print("등록에 실패했습니다.");
	}
	
	%>
	<br>
</div>
<br>
	<DIV class='bottom'>
		<input type='button' value='목록' onclick="plist()"> 
		<input type='button' value='글등록' onclick="location.href='./createForm.jsp'">
	</DIV>
<br><br>

	<!-- *********************************************** -->
	<jsp:include page="/menu/bottom.jsp" flush="false" />
</body>

</html>

