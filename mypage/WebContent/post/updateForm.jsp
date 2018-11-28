<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="post.PostDAO"/>

<%
	int postno=Integer.parseInt(request.getParameter("postno"));
	PostDTO dto=dao.read(postno);
%>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
 
<script type="text/javascript">
function incheck(f){
	if(f.title.value==""){
		alert("제목을 입력하세요");
		f.title.focus();
		return;
	}
	if(f.content.value==""){
		alert("내용을 입력하세요");
		f.content.focus();
		return;
	}
	if(f.passwd.value==""){
		alert("비밀번호를 입력하세요");
		f.passwd.focus();
		return;
	}
		f.submit();
}
$.ajaxSetup({
    error: function(jqXHR, exception) {
        if (jqXHR.status === 0) {
            alert('Not connect.\n Verify Network.');
        }
        else if (jqXHR.status == 400) {
            alert('Server understood the request, but request content was invalid. [400]');
        }
        else if (jqXHR.status == 401) {
            alert('Unauthorized access. [401]');
        }
        else if (jqXHR.status == 403) {
            alert('Forbidden resource can not be accessed. [403]');
        }
        else if (jqXHR.status == 404) {
            alert('Requested page not found. [404]');
        }
        else if (jqXHR.status == 500) {
            alert('Internal server error. [500]');
        }
        else if (jqXHR.status == 503) {
            alert('Service unavailable. [503]');
        }
        else if (exception === 'parsererror') {
            alert('Requested JSON parse failed. [Failed]');
        }
        else if (exception === 'timeout') {
            alert('Time out error. [Timeout]');
        }
        else if (exception === 'abort') {
            alert('Ajax request aborted. [Aborted]');
        }
        else {
            alert('Uncaught Error.n' + jqXHR.responseText);
        }
    }
});


function passwdCheck(f){
	if(f.passwd.value==""){
		alert("비밀번호를 입력해주세요.");
		document.frm.passwd.focus();
	}else{
		var f=document.frm;
		var passwd=f.passwd.value;
		var postno=f.postno.value;
		var url="passwd_jquery.jsp";
		
		$.ajax({
			url:url,
			dataType:'text',
			data:{"passwd":passwd, "postno":postno},
			success:function(data){
				$("#passwdCheck").text(data.trim()).css("color","red");
			}
		});
	}
}

</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
 
<script type="text/JavaScript">
  window.onload=function(){
   CKEDITOR.replace('content');
  };
  
  </script>
</head> 

<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
 
<br><br><br> 
<DIV class="title">수 정</DIV>
 
<FORM name='frm' method='POST' action='./updateProc.jsp'
		enctype="multipart/form-data">
<input type="hidden" name="postno" value="<%=dto.getPostno()%>"/>
<input type="hidden" name="col" value="<%=request.getParameter("col")%>"/>
<input type="hidden" name="word" value="<%=request.getParameter("word")%>"/>
<input type="hidden" name="nowpage" value="<%=request.getParameter("nowpage")%>"/>
<input type="hidden" name="oldfile" value="<%=dto.getFilename()%>"/>

		
  <TABLE>
    <TR>
      <TH>제목</TH>
      <TD><input type="text" name="title" value="<%=dto.getTitle()%>"></TD>
    </TR>
    <TR>
      <TH>성명</TH>
      <TD><input type="text" name="pname" value="<%=dto.getPname() %>"></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD><textarea rows="10" cols="45" name="content"><%=dto.getContent() %></textarea></TD>
    </TR>
    <TR>
      <TH>비밀번호</TH>
      <TD><input type="password" name="passwd">
      	  <input type='button' value="PW확인" onclick="passwdCheck(this.form)">&nbsp;
      	   <span id="passwdCheck"></span>
      	  
      </TD>
    </TR>
    <TR>
      <TH>파일</TH>
      <TD>
      	<%if(dto.getFilesize()>0) out.print(dto.getFilename());%>
      	<input type="file" name="filename">
      </TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='button' value='수정' onclick="incheck(this.form)">
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 

