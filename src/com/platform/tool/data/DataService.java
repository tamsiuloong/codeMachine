package com.platform.tool.data;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface DataService {
	
	/**根据表名获取其他模板要用的Map型数据
	 * (无需操作数据库)
	 * @param tableName
	 * @return
	 */
	public Map<String, Object> getTemplateDataWithOutDb(String tableName,String packageName,String classPre);
	
	/**根据表名获取Vo模板要用的Map型数据
	 * @param tableName
	 * @param exclusiveFiled
	 * @return
	 * @throws SQLException 
	 */
	public Map<String, Object> getDbTemplateData(String tableName, String packageName, String classPre, List<String> exclusiveFiled) throws SQLException;
	
}
