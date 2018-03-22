package com.platform.tool.data;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.platform.main.CodeMeachine;
import com.platform.tool.db.DbService;
import com.platform.tool.db.DbServiceImpl;

public class DataServiceImpl implements DataService{
	
	/**根据表名获取其他模板要用的Map型数据
	 * (无需操作数据库,不含有列信息)
	 * @param tableName
	 * @return
	 */
	public Map<String, Object> getTemplateDataWithOutDb(String tableName,String packageName,String classPre){
		
		Map<String, Object> templateData = new HashMap<String, Object>();
		templateData.put("tableName", tableName);
		templateData.put("package", packageName);
		templateData.put("classPre", classPre);
		return templateData;
		
	}
	
	/**根据表名获取模板要用的Map型数据
	 * (带有列信息)
	 * @param tableName
	 * @param exclusiveFiled
	 * @return
	 * @throws SQLException 
	 */
	public Map<String, Object> getDbTemplateData(String tableName, String packageName, String className, List<String> exclusiveFiled) throws SQLException{
		DbService dbService = new DbServiceImpl();
		Map<String, Object> templateData = new HashMap<String, Object>();
		templateData.put("tableName", tableName);
		//templateData.put("properties", dbService.getAllColums(tableName, "", "mysql"));
//		List<FieldBean> properties = dbService.getAllColums(tableName, "jk", "oracle");

		templateData.put("properties", dbService.getAllColums(tableName, "jk", "oracle",exclusiveFiled));
		//templateData.put("className", classPre+"VO");
		templateData.put("className", className);
		templateData.put("package", packageName);
		templateData.put("rootPath", CodeMeachine.rootPath);
		templateData.put("entityRemark", CodeMeachine.entityRemark);
		return templateData;
	}
	
	


}
