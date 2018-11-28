<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
	
<script type="text/javascript">
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

function passwdcheck(passwd){
	if(passwd==""){
		alert("비밀번호를 입력해주세요.");
		document.frm.passwd.focus();
	}else{
		var url="passwd_jquery.jsp";
		$.ajax({
			url:url,
			dataType:'text',
			data:{"passwd":passwd},
			success:function(data){
				$("#passwdCheck").text(data.trim()).css
			}
		})
	}
}
</script>

</head> 

<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
<br><br><br> 
<DIV class="title">비밀번호 확인</DIV>
 
<FORM name='frm' method='POST' action='./'>
  <TABLE>
    <TR>
      <TH>비밀번호</TH>
      <TD><input type="password" name="passwd"></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value=''>
    <input type='button' value='확인' onclick="passwdcheck(document.frm.passwd.value)">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 

