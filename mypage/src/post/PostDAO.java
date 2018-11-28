package post;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import db.DBClose;
import db.DBOpen;

public class PostDAO {

	//create
	public boolean create(PostDTO dto) {
		boolean flag=false;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		StringBuffer sql=new StringBuffer();
		sql.append(" insert into post(postno,pname,title,content,passwd,wdate, ");
		sql.append(" 					grpno,filename) ");
		sql.append(" values((select nvl(max(postno),0)+1 as postno from post), ");
		sql.append(" 					?,?,?,?,sysdate, ");
		sql.append(" (select nvl(max(grpno),0)+1 as postno from post),?) ");
		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setString(1, dto.getPname());
			ps.setString(2, dto.getTitle());
			ps.setString(3, dto.getContent());
			ps.setString(4, dto.getPasswd());
			ps.setString(5, dto.getFilename());
			
			int cnt=ps.executeUpdate();
			if(cnt>0)flag=true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(ps, con);
		}
		return flag;
	}
	
	
	//update
	public boolean update(PostDTO dto) { 
		boolean flag=false;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		StringBuffer sql=new StringBuffer();
		sql.append(" update post ");
		sql.append(" set pname=?, ");
		sql.append(" 	 title=?, ");
		sql.append("     content=? ");
		if(dto.getFilesize()>0) {
			sql.append(" ,filename=?, ");
			sql.append(" filesize=? ");
		}
		sql.append(" where postno=? ");
		
		try {
			int i=0; 
			
			ps=con.prepareStatement(sql.toString());
			ps.setString(++i, dto.getPname());
			ps.setString(++i, dto.getTitle());
			ps.setString(++i, dto.getContent());
			if(dto.getFilesize()>0) {
				ps.setString(++i, dto.getFilename());
				ps.setInt(++i, dto.getFilesize());
			}
			ps.setInt(++i, dto.getPostno());
			
			int cnt=ps.executeUpdate();
			if(cnt>0)flag=true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(ps, con);
		}
		
		return flag;
	}


	//list
	public List<PostDTO> list(Map map){
		List<PostDTO> list=new ArrayList<PostDTO>();
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		String col=(String)map.get("col");
		String word=(String)map.get("word");
		int sno=(Integer)map.get("sno");
		int eno=(Integer)map.get("eno");
		
		StringBuffer sql=new StringBuffer();	
		sql.append(" select postno,pname,title,viewcnt,wdate, ");
		sql.append(" 	   indent,filename,r ");
		sql.append(" from( ");
		sql.append(" 	select postno,pname,title,viewcnt,wdate, ");
		sql.append(" 		   indent,filename,rownum as r ");
		sql.append(" 	from( ");
		sql.append(" 		select postno,pname,title,viewcnt,to_char(wdate,'yyyy-mm-dd')as wdate, ");
		sql.append(" 		indent,filename ");
		sql.append(" 		from post ");
		if(word.trim().length()>0)
			sql.append(" where " +col+ " like '%'||?||'%'  ");
		sql.append(" 		order by grpno desc, ansnum ");
		sql.append(" 	) ");
		sql.append(" )where r>=? and r<=? ");
		int i=0;
		
		try {
			ps=con.prepareStatement(sql.toString());
			if(word.trim().length()>0)
				ps.setString(++i, word);
				ps.setInt(++i, sno);
				ps.setInt(++i, eno);
			rs=ps.executeQuery();
			
			while(rs.next()) {
				PostDTO dto=new PostDTO();
				dto.setPostno(rs.getInt("postno"));
				dto.setPname(rs.getString("pname"));
				dto.setTitle(rs.getString("title"));
				dto.setViewent(rs.getInt("viewcnt"));
				dto.setWdate(rs.getString("wdate"));
				dto.setIndent(rs.getInt("indent"));
				dto.setFilename(rs.getString("filename"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(rs, ps, con);
		}
		
		
		return list;
	}

	
	//total()
	public int total(Map map) {
		int total=0;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		String col=(String)map.get("col");
		String word=(String)map.get("word");
		
		StringBuffer sql=new StringBuffer();
		sql.append(" select count(*) from post ");
		if(word.trim().length()>0)
			sql.append(" where "+col+" like  '%'||?||'%' ");
		
		try {
			ps=con.prepareStatement(sql.toString());
			if(word.trim().length()>0)
				ps.setString(1, word);
			rs=ps.executeQuery();
			rs.next();
			total=rs.getInt(1);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(rs, ps, con);
		}
		
		return total;
	}
	
	
	//read
	public PostDTO read(int postno) {
		PostDTO dto=new PostDTO();
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		StringBuffer sql=new StringBuffer();
		sql.append(" select postno,pname,title,content,viewcnt,filename,filesize, ");
		sql.append(" to_char(wdate, 'yyyy-mm-dd') as wdate,grpno,indent,ansnum ");
		sql.append(" from post ");
		sql.append(" where postno=? ");

		try {
			ps=con.prepareStatement(sql.toString());
			ps.setInt(1, postno);
			rs=ps.executeQuery();
			
			if(rs.next()) {
				dto=new PostDTO();
				dto.setPostno(rs.getInt("postno"));
				dto.setPname(rs.getString("pname"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setViewent(rs.getInt("viewcnt"));
				dto.setWdate(rs.getString("wdate"));
				dto.setFilename(rs.getString("filename"));
				dto.setFilesize(rs.getInt("filesize"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(rs, ps, con);
		}
		
		return dto;
	}

	
	//upViewcnt 조회수(read.jsp 처리)
	public void upViewcnt(int postno) {
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		
		StringBuffer sql=new StringBuffer();
		sql.append(" update post ");
		sql.append(" set viewcnt=viewcnt+1 ");
		sql.append(" where postno=? ");
		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setInt(1, postno);
			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(ps, con);
		}
	}
	
		
	//passwd 체크
	public boolean passwdCheck(Map map) {
		boolean flag=false;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		int postno=(Integer) map.get("postno");
		String passwd=(String) map.get("passwd");
		//System.out.print(postno);
	    //System.out.println(passwd);
		
		StringBuffer sql=new StringBuffer();
		sql.append(" select count(postno) as cnt ");
		sql.append(" from post ");
		sql.append(" where postno=? and passwd=? ");
		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setInt(1, postno);
			ps.setString(2, passwd);
			
			rs=ps.executeQuery();
			rs.next();
			int cnt=rs.getInt("cnt");
			
			if(cnt>0)flag=true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(rs, ps, con);
		}
		return flag;	
	}


	//delete
	public boolean delete(int no) {
		boolean flag=false;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		StringBuffer sql=new StringBuffer();
		sql.append(" delete from post ");
		sql.append(" where postno=? ");
		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setInt(1, no);
			
			int cnt=ps.executeUpdate();
			if(cnt>0) flag=true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(ps, con);
		}
		
		return flag;
	}
	
	
	//답변추가
	public boolean replyCreate(PostDTO dto) {
		boolean flag=false;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		StringBuffer sql=new StringBuffer();
		sql.append(" insert into post(postno, pname, title, content,  ");
		sql.append(" 		passwd, wdate,grpno,indent,ansnum,refnum) ");
		sql.append(" values((select nvl(max(postno),0)+1 as postno from post), ");
		sql.append(" ?,?,?,?, sysdate,?,?,?,? ) ");

		try {
			ps=con.prepareStatement(sql.toString());
			ps.setString(1, dto.getPname());
			ps.setString(2, dto.getTitle());
			ps.setString(3, dto.getContent());
			ps.setString(4, dto.getPasswd());
			ps.setInt(5, dto.getGrpno());
			ps.setInt(6, dto.getIndent()+1);
			ps.setInt(7, dto.getAnsnum()+1);
			ps.setInt(8, dto.getPostno());
			
			int cnt=ps.executeUpdate();
			if(cnt>0) flag=true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(ps, con);
		}
		
		return flag;
	}

	
	//답변읽기
	public PostDTO replyRead(int postno) {
		PostDTO dto=null;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		StringBuffer sql=new StringBuffer();
		sql.append(" select postno,title,grpno,indent,ansnum ");
		sql.append(" from post ");
		sql.append(" where postno=? ");
		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setInt(1, postno);
			rs=ps.executeQuery();
			
			if(rs.next()) {
				dto=new PostDTO();
				dto.setPostno(rs.getInt("postno"));
				dto.setTitle(rs.getString("title"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(rs, ps, con);
		}
		
		return dto;
	}


	//답변 번호(ansnum)
	public void upAnsnum(Map map) {
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		int grpno=(Integer)map.get("grpno");
		int ansnum=(Integer)map.get("ansnum");
		
		StringBuffer sql=new StringBuffer();
		sql.append(" update post  ");
		sql.append(" set ansnum=ansnum+1  ");
		sql.append(" where grpno= ?  ");
		sql.append(" and ansnum > ?  ");
		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setInt(1, grpno);
			ps.setInt(2, ansnum);
			
			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(ps, con);
		}

	}

	//삭제 답글있으면 삭제 방지
	public boolean checkRefnum(int postno) {
		boolean flag=false;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		StringBuffer sql=new StringBuffer();
		sql.append(" select count(refnum) ");
		sql.append(" from post ");
		sql.append(" where refnum=? ");
		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setInt(1, postno);
			rs=ps.executeQuery();
			rs.next();
			
			int cnt=rs.getInt(1);
			if(cnt>0) flag=true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(rs, ps, con);
		}
		
		return flag;
	}
}
	

