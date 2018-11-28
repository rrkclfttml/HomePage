<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="mymember.MemberDAO" />
<jsp:useBean id="dto" class="mymember.MemberDTO" />

<%
	String upDir = "/member/stroage";
	String tempDir = "/member/temp";
	upDir = application.getRealPath(upDir);
	tempDir = application.getRealPath(tempDir);

	UploadSave upload = (UploadSave) request.getAttribute("upload");

	//데이터값을 dto를 통해 가져온다.
	dto.setId(upload.getParameter("id"));
	dto.setPasswd(upload.getParameter("passwd"));
	dto.setMname(UploadSave.encode(upload.getParameter("mname")));
	dto.setTel(upload.getParameter("tel"));
	dto.setEmail(upload.getParameter("email"));
	dto.setAddress1(UploadSave.encode(upload.getParameter("address1")));
	dto.setAddress2(UploadSave.encode(upload.getParameter("address2")));

	FileItem fileItem = upload.getFileItem("fname");
	int size = (int) fileItem.getSize();

	String fname = "";
	if (size > 0) {//size>0 이면 사진을 등록한 것
		fname = UploadSave.saveFile(fileItem, upDir);
	} else {
		fname = "member.jpg";
	}

	//DB에는 파일 저장
	//실제 데이터는 서버에 저장
	dto.setFname(fname);
	boolean flag = dao.create(dto);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
.title {
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

TABLE { /*태그 슬렉터*/
	margin: 0 auto; /* 테이블 가운데 정렬 */
	border-color: #AAAAAA; /* 테이블 외곽선 색깔 */
	border-width: 3px; /* 테이블 외곽선 두께 */
	border-style: solid; /* 테이블 외곽선 스타일 */
	border-collapse: collapse; /* 컬럼의 외곽선을 하나로 결합 */
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
</head>

<body>
	<jsp:include page="/menu/top.jsp" flush="false" />
	<!-- *********************************************** -->
	<br>
	<br>
	<br>

	<DIV class="title">회원가입 처리</DIV>
	<div class="content">
		<%
			if (flag) {
				out.print("회원가입이 성공했습니다.");
			} else {
				out.print("실패했습니다.");
			}
		%>

	</div>
	<br>
	<%
		if (flag) {
	%>
	<div class='bottom'>
		<input type='button' value='로그인'
			onclick="location.href='loginForm.jsp'"> <input type='button'
			value='홈' onclick="location.href='../menu/index.jsp'">
	</div>
	<%
		} else {
	%>
	<div class='bottom'>
		<input type='button' value='다시시도' onclick="history.back()"> <input
			type='button' value='홈' onclick="location.href='../menu/index.jsp'">
	</div>

	<%
		}
	%>
	<br>
	<br>
	<br>



	<!-- *********************************************** -->
	<jsp:include page="/menu/bottom.jsp" flush="false" />
</body>

</html>

