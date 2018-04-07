package execute;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.platform.main.CodeMeachine;

public class RunEntrance {
	
	public static void main(String[] args) throws SQLException {
		String tableName = "NOTE";
		
		
		CodeMeachine.setGeneratePath("/users/macbook/workspace/code/");
		CodeMeachine.setPackageName("com.yaorange.jk");
		CodeMeachine.setRootPath("student");
		CodeMeachine.setEntityRemark("笔记");

		List<String> exclusiveFiled =new ArrayList<>();
		//排除字段
		exclusiveFiled.add("roleId");
		exclusiveFiled.add("createBy");
		exclusiveFiled.add("createDept");
		exclusiveFiled.add("createTime");
		exclusiveFiled.add("updateBy");
		exclusiveFiled.add("updateTime");


		CodeMeachine.generateFileWithDb("Entity.ftl", tableName, ".java", null);
		CodeMeachine.generateFileWithDb("mapper.hbm.ftl", tableName, ".hbm.xml",null);
		CodeMeachine.generateFileWithDb("Service.ftl", tableName, "Service.java", null);
		CodeMeachine.generateFileWithDb("ServiceImpl.ftl", tableName, "ServiceImpl.java", null);
		CodeMeachine.generateFileWithDb("Controller.ftl", tableName, "Ctrl.java", null);

	

		CodeMeachine.generateFileWithDb("Crud.vue", tableName, ".vue", exclusiveFiled);
		
		System.out.println("Generate success.");
	}
	
}
