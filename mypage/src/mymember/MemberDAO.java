package mymember;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import db.DBClose;
import db.DBOpen;
import mymember.MemberDTO;

public class MemberDAO {
	
	//회원등록
	public boolean create(MemberDTO dto) {
		boolean flag=false;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		StringBuffer sql=new StringBuffer();
		sql.append(" insert into mymember(id,passwd,mname,tel,email,address1,address2,mdate,fname) ");
		sql.append(" values(?,?,?,?,?, ");
		sql.append(" 		?,?,sysdate,?) ");
		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setString(1, dto.getId());
			ps.setString(2, dto.getPasswd());
			ps.setString(3, dto.getMname());
			ps.setString(4, dto.getTel());
			ps.setString(5, dto.getEmail());
			ps.setString(6, dto.getAddress1());
			ps.setString(7, dto.getAddress2());
			ps.setString(8, dto.getFname());
			
			int cnt=ps.executeUpdate();
			if(cnt>0)
				flag=true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}DBClose.close(ps, con);
			
		return flag;
	}

	//아이디 중복확인
	public boolean checkId(String id) {
		boolean f=false;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		ResultSet rs=null;
		StringBuffer sql=new StringBuffer();
		sql.append(" select count(id) from mymember ");
		sql.append(" where id=? ");
		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setString(1, id);
			rs=ps.executeQuery();
			if(rs.next()) {
				int cnt=rs.getInt(1);
				if(cnt>0)f=true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return f;
	}
	
	//email 중복확인
	public boolean checkEmail(String email) {
		boolean f=false;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		ResultSet rs=null;
		StringBuffer sql=new StringBuffer();
		sql.append(" select count(email) from mymember ");
		sql.append(" where email=? ");
		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setString(1, email);
			rs=ps.executeQuery();
			
			if(rs.next()) {
				int cnt=rs.getInt(1);
				if(cnt>0)f=true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return f;
	}
	//Login 확인
	public boolean loginCheck(Map map) {
		boolean flag=false;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		ResultSet rs=null;
		StringBuffer sql=new StringBuffer();
		sql.append(" select count(*) from mymember ");
		sql.append(" where id=? ");
		sql.append(" and passwd=? ");
		
		String id=(String)map.get("id");
		String pw=(String)map.get("pw");
		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setString(1,id);
			ps.setString(2,pw);
			rs=ps.executeQuery();
			
			if(rs.next()) {
				int cnt=rs.getInt(1);
				if(cnt>0)flag=true;
			}
					
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(rs, ps, con);
		}
		return flag;
	}
	
	//Login 등급확인
	public String getGrade(String id) {
		String grade=null;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		ResultSet rs=null;
		StringBuffer sql=new StringBuffer();
		sql.append(" select grade from mymember ");
		sql.append(" where id=? ");
		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setString(1, id);
			rs=ps.executeQuery();
			
			if(rs.next()) {
				grade=rs.getString("grade");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(rs, ps, con);
		}
		return grade;
	}
	
	//회원정보 읽기
	public MemberDTO read(String id) {
		MemberDTO dto=new MemberDTO();
		Connection con = DBOpen.open();
		ResultSet rs = null;
		PreparedStatement ps = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select id, passwd, mname, tel, email, ");
		sql.append("  		address1, address2, mdate,fname ,grade ");
		sql.append(" from mymember where id=? ");

		try {
			ps=con.prepareStatement(sql.toString());
			ps.setString(1, id);
			rs=ps.executeQuery();
			
			if(rs.next()) {
				dto=new MemberDTO();
				dto.setId(rs.getString("id"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setMname(rs.getString("mname"));
				dto.setTel(rs.getString("tel"));
				dto.setEmail(rs.getString("email"));
				dto.setAddress1(rs.getString("address1"));
				dto.setAddress2(rs.getString("address2"));
				dto.setMdate(rs.getString("mdate"));
				dto.setFname(rs.getString("fname"));
				dto.setGrade(rs.getString("grade"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(rs, ps, con);
		}
		
		
		return dto;
	}
	
	//회원사진
	public String getFname(String id) {
		String fname=null;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		StringBuffer sql=new StringBuffer();
		sql.append(" select fname from mymember ");
		sql.append(" where id=? ");
		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setString(1, id);
			rs=ps.executeQuery();
			
			if(rs.next()) {
				fname=rs.getString("fname");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(rs, ps, con);
		}
		
		return fname;
	}
	
	//비밀번호 체크(readPw -> checkPaswd 로 바꿈)
	public boolean checkPasswd(Map map) {
		MemberDTO dto=new MemberDTO();
		boolean flag=false;
		Connection con = DBOpen.open();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(id) as cnt  ");
		sql.append(" from mymember   ");
		sql.append(" where id=? and password=?");
		
		String oldpasswd=(String)map.get("oldpasswd");
		String id=(String)map.get("id");
		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setString(1, id);
			ps.setString(2, oldpasswd);
			
			rs=ps.executeQuery();
			rs.next();
			int cnt=rs.getInt("cnt");
			if(cnt>0) {
				flag=true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(rs, ps, con);
		}
		
		return flag;
	}
	
	//비밀번호 바꿈
	public boolean updatePasswd(Map map) {
		boolean flag=false;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		
		StringBuffer sql=new StringBuffer();
		sql.append(" update mymember ");
		sql.append(" set passwd=? ");
		sql.append(" where id=? ");
		
		String neww=(String)map.get("neww");
		String id=(String)map.get("id");
		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setString(1, neww);
			ps.setString(2, id);
			
			int cnt=ps.executeUpdate();
			if(cnt>0)flag=true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(ps, con);
		}
		
		return flag;
	}
	
	//파일 업로드
	public boolean updateFile(Map map) {
		boolean flag=false;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		StringBuffer sql=new StringBuffer();
		sql.append(" update mymember ");
		sql.append(" set fname=? ");
		sql.append(" where id=? ");
		
		String fname=(String)map.get("fname");
		String id=(String)map.get("id");
		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setString(1, fname);
			ps.setString(2, id);
			
			int cnt=ps.executeUpdate();
			if(cnt>0)flag=true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(ps, con);
		}
		
		
		return flag;
	}
	
	//정보수정
	public boolean update(MemberDTO dto) {
		boolean flag=false;
		Connection con = DBOpen.open();
		PreparedStatement ps = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" update mymember ");
		sql.append(" set tel=?, ");
		sql.append(" email=?, ");
		sql.append(" address1=?, ");
		sql.append(" address2=? ");
		sql.append(" where id=? ");
		System.out.println(dto.getTel());
		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setString(1, dto.getTel());
			ps.setString(2, dto.getEmail());
			ps.setString(3, dto.getAddress1());
			ps.setString(4, dto.getAddress2());
			ps.setString(5, dto.getId());
			
			int cnt=ps.executeUpdate();
			if(cnt>0)flag=true;
			
			System.out.println(dto.getTel());
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(ps, con);
		}
		
		return flag;
	}
	
	//삭제
	public boolean delete(String id) {
		boolean flag=false;
		Connection con = DBOpen.open();
		PreparedStatement ps = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from mymember  ");
		sql.append(" where id=? ");
		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setString(1, id);
			int cnt=ps.executeUpdate();
			if(cnt>0)flag=true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(ps, con);
		}
		
		return flag;
	}
	
	//목록(list)
	public List<MemberDTO> list(Map map){
		List<MemberDTO> list=new ArrayList<MemberDTO>();
		MemberDTO dto = new MemberDTO();
		Connection con = DBOpen.open();
		ResultSet rs = null;
		PreparedStatement ps = null;

		String col = (String) map.get("col");
		String word = (String) map.get("word");
		int sno = (Integer) map.get("sno");
		int eno = (Integer) map.get("eno");
		
		StringBuffer sql=new StringBuffer();
		sql.append(" select id,mname,tel,email,address1,address2, ");
		sql.append(" fname,r ");
		sql.append(" from( ");
		sql.append(" select id,mname, tel,email,address1,address2, ");
		sql.append(" fname,rownum r ");
		sql.append(" 	from( ");
		sql.append(" 		select id,mname,tel,email,address1,address2,fname ");
		sql.append(" 		from member ");
		if (word.trim().length() > 0)
			sql.append(" 	where " + col + " like '%'||?||'%' ");
		sql.append(" 		order by mdate desc ");
		sql.append(" 	) ");
		sql.append(" )where r>=? and r<=? ");
		
		int i=0;
		
		try {
			ps=con.prepareStatement(sql.toString());
			if(word.trim().length()>0) {
				ps.setString(++i, word);
			}
			ps.setInt(++i, sno);
			ps.setInt(++i, eno);
			rs=ps.executeQuery();
			
			while(rs.next()) {
				dto=new MemberDTO();
				dto.setId(rs.getString("id"));
				dto.setMname(rs.getString("mname"));
				dto.setTel(rs.getString("tel"));
				dto.setEmail(rs.getString("email"));
				dto.setAddress1(rs.getString("address1"));
				dto.setAddress2(rs.getString("address2"));
				dto.setFname(rs.getString("fname"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(rs, ps, con);
		}
		
		return list;
	}
	
	//페이지 설정
	public int total(Map map) {
		int total = 0;
		Connection con = DBOpen.open();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String col = (String) map.get("col");
		String word = (String) map.get("word");

		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*) from mymember ");
		if (word.trim().length() > 0)
			sql.append(" 	where " + col + " like  '%'||?||'%'  ");

		try {
			ps = con.prepareStatement(sql.toString());
			if (word.trim().length() > 0)
				ps.setString(1, word);

			rs = ps.executeQuery();
			rs.next();
			total = rs.getInt(1);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, ps, con);
		}

		return total;
	}
}
